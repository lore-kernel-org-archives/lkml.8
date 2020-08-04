Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC582075A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596575476;
	bh=TusTN9GIHtSbsKZgK9o0Nw+e8pHn9+dxJXcyan3QDEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AcZEwq0J4r+4EjIlPQBjCl3HbkSN83zFGWWjTwGnYUGZSV64KKirs+I0EIYlP2CQl
	 H5Kz7civeP0FsGvLJjG6PpQ19JIePza3yvVMi0Hy8JsZFkPJ5EvJJKTbm9vTNnVaLC
	 aRSYeYGPAm98WGOnhBm7U0m96rLsuBMpOOx0pO1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgHDVLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgHDVLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:11:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B9F2075A;
        Tue,  4 Aug 2020 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596575471;
        bh=TusTN9GIHtSbsKZgK9o0Nw+e8pHn9+dxJXcyan3QDEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSHyUvmpb+h5vlQ2HqqKJAbYRLKnVmKfuNYE35+EUtm9dlKIEzSh62EDCH8VTCzqa
         W6XW595GK2/r4HsQEGS5YCKHxwf2m7AC6lNqlehn/mnyzksA9m64oj0DR8sMHk0Cs3
         KNAeuoPOM4wVP0leVeM1GBUROcpZO7NAMcs7seU4=
Date:   Tue, 4 Aug 2020 22:10:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/4] regulator: core: Add basic enable/disable support
 for sync_state() callbacks
Message-ID: <20200804211049.GC5249@sirena.org.uk>
References: <20200716042053.1927676-4-saravanak@google.com>
 <20200720142753.GF4601@sirena.org.uk>
 <CAGETcx96AuV=1rcyMAv5QGpGp0BqfWa40Fq-DShrBeY5Q61zkQ@mail.gmail.com>
 <20200721201808.GD4845@sirena.org.uk>
 <CAGETcx9+DUXyLnu0Rjom6oMpJvsdewbzvz=uW6xYOUjPD_Z=9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <CAGETcx9+DUXyLnu0Rjom6oMpJvsdewbzvz=uW6xYOUjPD_Z=9A@mail.gmail.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 02:14:52PM -0700, Saravana Kannan wrote:
> On Tue, Jul 21, 2020 at 1:18 PM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 20, 2020 at 08:22:15PM -0700, Saravana Kannan wrote:

Copying in Stephen having done a bunch of mailing list archive trawling
on the fw_devlink stuff since I'm re-raising some stuff he raised before
as he happened to see that stuff before it got merged - most of that
stuff is a way down in the second half of this far too long e-mail.

> > Even with this version I have difficulty telling from the
> > changelog that the change doesn't restrict things based on the consumers
> > of a given regulator but rather based on the PMIC and I don't see why
> > this is being done.

> Happy to copy-paste any commit text suggestions that make this clearer.

Well, like I keep saying I don't know how to explain the implementation
decisions here.  Simply openly stating that you do this would be a
start, things like being explicit about which devices you are talking
about for example - if you mean "the MFD associated with the regulator"
say that, when you talk about the "regulator's device" that could easily
be assumed to mean the struct device for the specific regulator.

> > I don't follow what you're saying here at all, sorry.  What does the
> > depth of the dependency graph have to do with how late we action
> > anything?

> You keep raising the point "why not just add another initcall level"
> to solve the problem of "sync the suppliers after all the consumers
> are ready". Or you say that my patch series is just a roundabout way
> of adding another initcall level. I'm explaining why adding just
> another initcall level won't work.

I am saying that this winds up being roughly the same thing in effect
just with less clarity and more complexity so therefore consider
applying the same workarounds for problems here as we do for your
current code.  Wait for devices to bind like your current code does, use
a timer in case some of them don't bind like your current code does.

> > Run the initcall when all devices in the system have a driver bound

> And how is this going to work in systems where some devices don't have
> drivers? Even with one missing driver, none of the devices/drivers are
> going to get this initcall that you suggest. So it makes the
> granularity issue worse.

I don't think either of these things is a particularly great idea, it's
just that doing things per system doesn't have materially different
effects for regulators on most systems and I can at least explain when
things happen more clearly and there'd be less random variation in
behaviour in the less common cases.

> > which as far as I can tell seems to be what the end result of this
> > series is intended to be anyway, just implemented with much more
> > complexity.

> No, with sync_state(), only suppliers to devices without drivers
> wouldn't get the callback. Rest of the suppliers will get the callback
> and can sync their state.

But with the timeout which we would need to have by default everything
will get the callback anyway.

> > > If they really NEED to turn power off to get to a known good state,
> > > then they really need to be exclusive consumers.

> > There's *need* to and there's can do on systems that can support the
> > thing, the same driver will often be able to handle both situations.
> > This also goes to a risk of regressions, it's a fairly major
> > transformation to be doing.  These issues would be massively mitigated
> > if this were per regulator as I have repeatedly suggested.

> Even if you do per-regulator tracking, you can have one regulator
> shared by many consumers and you'll still hit this issue. So, going to
> a regulator level tracking doesn't solve this.

It solves it for supplies that aren't actually shared without requiring
consumers to have separate code paths that figure out if they're using
shared supplies or not which if nothing else is effort for existing
drivers.  This would be a much less surprising implementation decision
in general, and much more likely to do what people want in a system.

> > Having the requests from drivers be acted on promptly is also a
> > potential correctness and robustness issue.  You seem very focused on
> > the disabling of unused regulators for power reasons case

> The correctness issue I care about is not power consumption. It's
> about not pulling the plug on or under volting an active device before
> the driver can take control of it.

Your comments suggest that you seem to think this is why devices would
be controlling regulators.

> > avoid it.  Forcing consumers to be exclusive means that we need to add a
> > call that lets these consumers figure out which kind of get to use and
> > then have the consumer have multiple code paths for that (or more
> > realistically factor that out into the core, but then we could even more
> > easily just not have the system wide restrictions).

> This paragraph seems to be self contradictory to me. I don't
> understand how you can claim the drivers handle it gracefully without
> exclusive_get(), but then still say they can't handle a regulator
> being on when they request for it to be off. They just need to handle
> it gracefully for the first 30s of boot with my patch series. Only
> when regulator_cleanup_timeout=3D-1 is set is there a potential for the
> regulator to be kept on forever.

Remember that the same device and driver can be used in different
systems with different configurations and integrations.  While some
systems might be set up so that the regulator is unshared, can be freely
controlled and even rely on that happening there may be other systems
that not have software controllable regulators at all and are instead
set up so the regulators don't need to be controlled.  Also think about
all the times you see software doing things that happen to work but
probably aren't robust or a good idea, and how we sometimes have to put
support code in there to keep them working when they do break.
Electrical engineering and general system design can be like that too. =20

As a really simple example a hardware designer might decide they can
save a GPIO by not wiring up a reset signal since the device has a
dedicated power supply and software can just turn that off and on to
trigger a power on reset instead.  Other systems with the same device
might give software control of the reset GPIO but not the power and
assume that it will assert reset that way.

> > There's also issues around being able to reason about what the system is
> > supposed to do and why, hence my concerns about waiting for all devices
> > on the PMIC to appear.  Like I said above this is absolutely crucial.

> Ok, I'll try to explain the reasoning from the top.

> Firstly, the problem being solved is not specific to regulators. It's
> a general issue that needs to be solved for many frameworks/suppliers.
> We want a mechanism for a supplier driver to know when all the
> consumers are up and managing their resources so that the supplier
> driver can do a clean handoff from bootloader to the kernel.

> However, we don't want each framework doing very similar but slightly
> different things. That creates inconsistencies across frameworks, code
> repetition, maintenance headache, etc. In addition to that, it's also
> very inefficient for every framework to be trying to figure out the
> dependencies from firmware and tracking them separately.

There seem to be some very substantial assumptions in here.  The biggest
is that we can't share code if there's any subsystem knowledge of what's
going on, this is already impacting every affected subsystem with your
current implementation anyway so it's not like it's transparent to them
but you're still managing to share code.  It's also not 100% clear to me
that we want every framework to behave in exactly the same way -
resources obviously aren't completely fungible.  For example while it's
very common for regulators to be shared that's not the case for GPIOs
and that has an impact on what drivers should be expected to handle.
Consistency is obviously good but it's not the only thing to consider.

To me this doesn't explain why we would want the system to behave in
this way, it explains how some implementation details flow from other
implementation details.  At a very high level there seems to be an
unstated assumption in here about existing code outside the regulator
framework (mainly fw_devlink I think) being unmodifiable which really
should not be the case.

> Even if you just try to answer "are all the consumers ready?" at a
> resource level (eg: at a regulator level), can't depend on get()/put()
> APIs provided by frameworks. Some of the reasons:

Why would we need to or even want to depend on or use get() and put()
here?  That doesn't seem at all obvious to me.  We clearly have the
ability to relate individual resources to their consumer devices for
every subsystem that's affected here and clearly also already have the
ability to make links between consumer and supplier devices prior to
them probing.  It shouldn't be impossible to take these two things and
combine them in a way that keeps the tracking and notification code
shared.

In the case of the regulator API we already create a struct device and
have an of_node per regulator so it should be even easier to use the
existing device based stuff than with subsystems that don't have that,
it should at most be some extra code to move some links around (or add
new ones if that's easier).  Off the top of my head a call to move any
misdirected links to a given of_node to a new struct device (or add new
ones leaving the old ones in place I guess) should do the trick for
regulators without even modifying the sync_state() callback stuff, just
the link setup.  It seems like the framework is already pretty much
ideally set up for this, you could even make a case that the reason
there's not already per-resource links for regulators is that the
existing code is not doing a good job handling the DT bindings and is
misdirecting links to the wrong struct device.

> So, say you have a callback that you get for every single consumer
> binding successfully. What can you do there? For every consumer, you
> have to parse their firmware (Eg: DT node) to see what all resources
> they use (Eg: all the -supply properties)

Again off the top of my head we could also do this the other way around
and when making a link go and ask the subsystems if it's their link and
they have a better idea about where to put it.  Actually, having found
the code that adds the links we don't even need to ask the subsystems if
it's their link - we already know at the time we're doing the parsing
which subsystem a link relates to!  Perhaps we could do some of this
checking/notification at the time links are connected/satisfied rather
than at parse time, or perhaps when the suppliers register they could
look at outgoing links.

We already have a set of links and we already have the ability to figure
out which resources they're talking about, we just need to join those
two things up which shouldn't be an intractable problem.

>                                           and increment the "consumer
> ref count" for those resources (Eg: regulators).  And this needs to be
> done by every framework that manages suppliers.

With your current code every framework that manages resources that can
be shared already needs to be modified to block actions until there's a
sync_state() callback, modifying frameworks is clearly not an issue
here.  It even turns out that we already have some custom parsing code
(which shares code!) for links for individual subsystems including
regulators, unfortunately I'd not seen the regulator code until today
since while it was merged back in October it's in the of code rather
than the regulator code and was never copied to me (you were asked to do
so at the time to by Stephen Boyd, sadly the code got merged at the
version he was reviewing so there wasn't another post).  Most of that is
data driven but not all.

I also don't see why we'd need to end up open coding reference counting,
if we have code for tracking links and references let's use it,
extending it where we need to.

> fw_devlink again helps avoid parsing the entire DT. It creates "proxy"
> device links between a supplier device and the parent device of a
> consumer if the consumer hasn't been added yet.

fw_devlink is something we can modify and extend, we don't have to
completely discard it to do better than what's currently being done.
It feels like a lot of your analysis here is predicated on not being
able to change anything with that code, but obviously that reasoning
gets a bit circular.  At the minute it definitely seems to have some
assumptions in there about the encoding of the Linux device model into
DT which ought to be addressed, they seem in some fundamental way to be
at the root of my concerns.

> So, long story short, tracking at a resource level:
> 1. Will be way more complicated than tracking at a consumer device level.
> 2. Will use a lot more memory.
> 3. Will use be a lot less efficient due to all the repeated parsing
> and tracking you'll have to do.

I don't think these things need to be the case, I think we can do much
better with code reuse than you are anticipating and achieve similar
performance through that reuse.

> 4. Doesn't really solve the "need exclusive but doesn't use
> get_exclusive()" consumer problem.

It definitely does in for example the case where a regulator is intended
to be actively managed and is as a result unshared in a particular
system.

> But then why not just do a "boot done" initcall/callback instead of
> doing it based on supplier-consumers device level dependencies?

> "boot done" can be done in a couple of ways:
> 1. Have userspace tell that it's done loading all the modules. This is
> pretty much a no go as the kernel now depends on userspace for proper
> functionality.
> 2. Timer, but this is a configuration nightmare and doesn't work reliably.
> 3. Wait till every single device has been bound to a driver. The
> problem with this is that even if a single device is not bound to a
> driver, the entire system would be stuck in a "boot not done yet"
> mode. So any device left on by the boot loader would be permanently
> stuck on and can't go to states that are incompatible with their state
> at boot.

I agree that doing things per system is not great but like I keep saying
at least for regulators doing things based on the MFD is at best very
close to the same thing given that in most systems the vast majority of
controllable supplies are provided by a single PMIC.  This is why I push
for handling things per supply, it's much more what someone would expect
the system to do and much more likely to just do the right thing.  I'm
trying to understand the underlying goal of this design decision and
come up with something that might actually deliver that reliably.

One idea which was mentioned by Stephen was issues with hardware
controlled by multiple devices (eg, a display controller and a GPU) -
that might point towards doing something per system, though perhaps not
since we hopefully only need the display controller in that case until
userspace has come up and started drawing new things and obviously if
that's needed then waiting for drivers to probe isn't particularly
relevant so we'd not be gaining much.

I do think we need a timeout no matter what for something like this,
even with doing things per resource - users can configure them off if
they prefer that but there's definitely people who are going to end up
on systems with devices that don't have drivers instantiate.

> Would you consider this series if the boot limit is only set when
> regulator_cleanup_timeout=3D-1 (as opposed to always)? Then the default
> behavior will stay identical to before this series and only when
> regulator_cleanup_timeout=3D-1 will any of this code kick in.

I'm having a really hard time seeing that as a good idea, merging things
that work for some specific systems but don't scale has lead to ongoing
problems elsewhere and I don't want to repeat that mistake.  If it was a
case where we had a solid, well understood design which needed some
additional work to extend it to cover some cases then that sort of thing
could make sense but currently the basic design is still unclear.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8pztgACgkQJNaLcl1U
h9B5ygf9EGV7HvepzNITt5kp7H8LnpSlccVMU643W9FdbhNev4xMRli4mQxxGT0w
AVY72J11QN00vy/d/dl8+etvfXTT7LGw9YHY1MkUecxzdI8Y+iHd04h59VtRVbfP
SV1u+tsCL54b9u5pdTUJjGw1mR8LnZADRJW3Sr93LPY8vjJgcbac63215HDXYKlx
Ir7J7IyNrf+gPpLutJg1ee+otv6QWHqfsZBIociwIp21dPMZ58gjRSJMhqRWSjpe
wsYyuDOktDbF1jGFRKzyvZ/dl9+J7SJC9ofyr4gQs61sjkXXNe79zfWM5u402Nt8
9Iceh1gOVz4D2JvCE+gw85IN5Ax2Xg==
=xl0A
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
