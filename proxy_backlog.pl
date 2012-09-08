# this script is still experimental, don't expect it to work as expected :)
# see http://wouter.coekaerts.be/site/irssi/proxy_backlog
#
### Swiss's comments
### I figured I could just use lastlog. I think it'll work.
use Irssi;
use Irssi::TextUI;

$VERSION = "0.0.0";
%IRSSI = (
	authors         => "Wouter Coekaets",
	contact         => "coekie@irssi.org",
	name            => "proxy_backlog",
	url             => "http://wouter.coekaerts.be/site/irssi/proxy_backlog",
	description     => "sends backlog from irssi to clients connecting to irssiproxy",
	license         => "GPL",
	changed         => "2004-09-10"
);

sub sendbacklog {
	my ($server) = @_;
#	Irssi::print("Sending backlog to proxy client for " . $server->{'tag'});
#	Irssi::signal_add_first('print text', 'stop_sig');
#	Irssi::signal_emit('server incoming', $server,':proxy NOTICE * :Sending backlog');
	foreach my $channel ($server->channels) {
		my $window = $server->window_find_item($channel->{'name'});
		$window->set_active();
		Irssi::command("lastlog")
#		for (my $line = $window->view->get_lines; defined($line); $line = $line->next) {
#			Irssi::signal_emit('server incoming', $server,':proxy NOTICE ' . $channel->{'name'} .' :' . $line->get_text(0));
#		}
	}
#	Irssi::signal_emit('server incoming', $server,':proxy NOTICE * :End of backlog');
#	Irssi::signal_remove('print text', 'stop_sig');
}

sub stop_sig {
	Irssi::signal_stop();
}

Irssi::signal_add('message irc own_ctcp', sub {
	my ($server, $cmd, $data, $target) = @_;
	print ("cmd:$cmd data:$data target:$target");
	if ($cmd eq 'IRSSIPROXY' && $data eq 'BACKLOG SEND' && $target eq '-proxy-') {
		sendbacklog($server);
	}
});
