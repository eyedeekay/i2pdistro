# i2pdistro

Re-creating an I2P Linux Distro

[![Build Status](https://travis-ci.org/eyedeekay/i2pdistro.svg?branch=master)](https://travis-ci.org/eyedeekay/i2pdistro)

Mission
=======

Get more people involved in participatory use of the I2P network by expanding
our onboarding options and better supporting our available tooling for sysadmins
and application developers.

This is a "Convenience Product" intended to lower barriers to entry.

Why(s)
------

### Why a distro

For better or worse, I assume that reddit is a guage of what users who are less
familiar with I2P specifically expect of an anonymous network. "Is there an I2P
Linux Distro" or "Is iPredia still alive" or questions about I2P use in Whonix
or TAILS is a very frequently asked question on reddit, my take on this is that
people want something, and my guess is that they want a turn-key way to take
advantage of the features the I2P network provides.

### Why another distro

I actually hate the term distro. Most distros are substantially just PPA's, and
PPA's are just package repositories. Crunchbang and it's descendants are good
examples of this, they're so close to Debian you can literally run a ~15 line
script that will turn Debian into Crunchbang. What we're really creating when
we create a distro is a package repository, package list, and pre-configured
install media, sometimes with a bootable system installed(LiveCD).

I2P can make better use of these capabilities than most distros because of it's
use as a network for hosting hidden services. Where Crunchbang uses it's
repositories to do basically one-time tweaks to user's desktop environment, we
can use these facilities to automatically configure many existing internet
applications to work with I2P, reducing the installation of most services to
a single command and zero configuration.

Even for non-sysadmins, this will function as a turnkey, minimalist desktop
distribution for users of I2P. I2P will be pre-installed and pre-configured, as
will I2P browser. Vanilla Firefox via the package manager will also be
pre-configured to work with I2P in a manner corresponding to the I2P Profile
Bundle. I2P applications will be intgrated into the desktop, it will use Snark
as a default torrent client.

As the design study noted, most people never make it to IRC. Mattermost was
almost a solution but hasn't panned out. For the distro I think something
simpler is possible. Pick a pretty, user-friendly IRC client and package an I2P
based configuration for it. Put it on the user's desktop as "I2P Chat".

### Why not TAILS or Whonix

While we love TAILS and no one is ruling out working with TAILS, the goal of
this project is different and inherently conflicts with TAILS. When using TAILS
your identity is supposed to be un-recoverable from the system when the system
powers down. This is suitable for many, many threat models but it is not ideal
for long-term participants in a hidden service network. It can be done, but
TAILS may not be the correct tool for the job and our needs are somewhat, but
not quite entirely, mutually exclusive. That said, there is at least one thing
that TAILS and this distro will both need, and solving this problem will get us
closer to inclusion in TAILS.

Official inclusion in Whonix is dependent on inclusion in Debian, but we may be
able to generate VM Images of the style used for Qubes-Whonix independently
while working on that problem. Currently regarding this as a major stretch goal
but I might be able to get some help on it.

### What about applications?

We'll do those too, in fact, making an effort to deliver Bote as a Debian
package in a standalone, non-plugin way way will probably help me understand
more about how to un-bundle and deliver the default I2P applications normally
delivered with the router today.

Besides that, having a Unix platform with self-configuring I2P packages lets us do
things like let non-Java, non-JVM, or otherwise un-bundleable applications
depend on Debian packages that exist solely to ensure that specific API's are
enabled. Retroshare could make sure that it has installed ```meta-i2p-bob```,
SAM libraries can ensure that they have ```meta-i2p-sam``` installed.

Roadmap
=======
