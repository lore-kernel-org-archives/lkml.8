Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA09D206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595362704;
	bh=OY450JsWEMouLOtcNo/f7fTbwq8tEHg2Qt1FrJW7EEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zTgdBzN0DX/Bepfw5Xn38JeSs/KByFxgpz2/GwN4zPPim8Ox9qneTEpoqkfh+KQFJ
	 vvJWgKMi8IMZoqaya9R00i99tPbq2pcpb303GDUaH8kBP4wP39xiC05yHwdMJw/dAW
	 GfgIii2go8k1TZzNuD5xkH1rL2VorZYTmUSlK9do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgGUUSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgGUUSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:18:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 322A1206E3;
        Tue, 21 Jul 2020 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595362701;
        bh=OY450JsWEMouLOtcNo/f7fTbwq8tEHg2Qt1FrJW7EEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPx8brmVFPGCuppqJynYALP8ovJBGd4N07oAnoH24EtnUC++1xg4OIpgRFt+fvHly
         gJQAoIPzCTFJzEjoZtBwI57N/8Tfblf6aIQxX7vSMWSEwk4V56aCW+EWK7EpLUU6/H
         DLKvrMcwUKXlRRqBPQwMze9qU9dC4ce+y3wB2D78=
Date:   Tue, 21 Jul 2020 21:18:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 3/4] regulator: core: Add basic enable/disable support
 for sync_state() callbacks
Message-ID: <20200721201808.GD4845@sirena.org.uk>
References: <20200716042053.1927676-4-saravanak@google.com>
 <20200720142753.GF4601@sirena.org.uk>
 <CAGETcx96AuV=1rcyMAv5QGpGp0BqfWa40Fq-DShrBeY5Q61zkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <CAGETcx96AuV=1rcyMAv5QGpGp0BqfWa40Fq-DShrBeY5Q61zkQ@mail.gmail.com>
X-Cookie: I'm also against BODY-SURFING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2020 at 08:22:15PM -0700, Saravana Kannan wrote:
> On Mon, Jul 20, 2020 at 7:28 AM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jul 15, 2020 at 09:20:52PM -0700, Saravana Kannan wrote:

> > > There are Android devices that exhibit the issue in the example where
> > > regulator-X is an LDO, device-A is a camera device and device-B and
> > > device-C are UFS and USB. To avoid this, they have their own downstream
> > > changes to the regulator framework.

> > Can you provide any references to these bodges?

> This is the best I could dig up. The site is slow as molasses. I don't
> want to focus or critique any specific vendor's downstream code
> though. Providing these links just to prove that this is a real issue.

The issue is not that I can't see that there might be a problem.  The
issue I have is that you seem to be starting from the point of a
specific solution that happens to work for your systems and then working
back from that rather than reasoning forwards from the problem to come
to a solution with the result that I can't explain the design you're
proposing.  Even with this version I have difficulty telling from the
changelog that the change doesn't restrict things based on the consumers
of a given regulator but rather based on the PMIC and I don't see why
this is being done.

> Search for "proxy" here. You'll notice how that will also need changes
> to regulator header files, etc. The 4.9 kernel is the latest publicly
> available version AFAIK.
> https://source.codeaurora.org/quic/la/kernel/msm-4.9/plain/drivers/regulator/core.c?h=msm-4.9

Oh, the Qualcomm stuff - which looks a lot like what you've got here.

> > As I indicated on my previous review this doesn't seem OK, given that a
> > huge proportion of the regulators on most systems are part of a single
> > PMIC this means that devices won't be able to fully control regulators
> > for the majority of the boot process, possibly quite a long time after
> > userspace has started in systems where not all devices have drivers.

...

> I think the default behavior should be for functional correctness
> (example in the commit text) and then go for optimization (being able
> to power off regulators before 30s into boot). Even with the timeout
> set, this series makes it much easier for driver developers to ensure
> functional correctness instead of playing initcall chicken between the
> supplier and the N consumers.

I don't see how any of this stuff about initcall chicken or whatever is
relevant here.  You're replying to my concern that your change isn't
just waiting for all the consumers of a given regulator, it's waiting
for every other consumer of any other regulator or random other feature
that happens to be supplied by the same PMIC but only that PMIC.  That
is not init ordering, it just seems like an arbitrary delay even once
all the consumers are ready and I can't see any particular logic behind
it.  It's not just waiting for all the users of the individual resource
to be active but it's also not waiting for the system as a whole,
instead it's waiting for some effectively random grouping of devices
spread over the whole system to appear.  I can't articulate a reason why
we'd do that, it seems to be combining the worst aspects of the two
approaches.

Please engage with this issue, it is crucial but you keep on sending the
same thing without explaining why so I'm left guessing and I really
can't come up with anything.

> Actually on systems without all the drivers, I'd argue the correct
> behavior is this patch series + regulator_cleanup_timeout=-1. This
> patch series will prevent system instability/unusability (Eg: missing
> display backlight driver) at the cost of power optimization. However,
> to allow turning off boot on regulators in systems without all the
> drivers where it happens to not cause functional correctness issues,
> we have the timeout default to 30s.

It's also preventing turning off regulators that don't have any
consumers at all, not even potential ones.  Those are the main target
for the cleanup of idle regulators.

> > I don't understand the motivation for doing things this way.  Like I
> > said last time it really feels like this turns the whole mechanism into
> > a very complicated way of implementing a new initcall.

> Treating this as a "LATER_initcall()" has several issues.
> 1. initcall levels set a max limit on the depth of device dependency.
> Since DT devices are added at arch initcall level, that gives us about
> 5 levels if you ignore the _sync ones. Adding more isn't going to
> scale or solve the problem because in reality, the dependencies are
> much deeper.

I don't follow what you're saying here at all, sorry.  What does the
depth of the dependency graph have to do with how late we action
anything?  A lot of what you're saying here seems to be based on jumping
to abandoning deferred probe which is a bit of a leap here.

> 6. If the answer is, "have userspace tell us when all modules are
> loaded" -- then we are depending on userspace for functional
> correctness AND for turning off regulators. Which IMHO is worse than
> this patch series.

> 7. If we somehow manage to add a "LATER_initcall" that doesn't have
> the issues above, it has to work for all frameworks. So, it has to
> come after ALL the devices in the system have probed. Not just "all
> devices of a supplier". So, again, it's worse than this patch series,
> at least for systems where all the drivers are present.

Run the initcall when all devices in the system have a driver bound
which as far as I can tell seems to be what the end result of this
series is intended to be anyway, just implemented with much more
complexity.  That doesn't need any involvement from userspace, though I
can't see why we'd want to do that rather than just work per regulator.

> > >    b. If the regulator is ON at boot, a BOOT-LIMITS consumer is created
> > >       for the regulator and an enable vote is made.

> > If something was left partially set up by the bootloader this means that
> > drivers are no longer able to remove power from the device as part of
> > getting it into a known good state even if they are the only consumer.

> If they really NEED to turn power off to get to a known good state,
> then they really need to be exclusive consumers.

There's *need* to and there's can do on systems that can support the
thing, the same driver will often be able to handle both situations.
This also goes to a risk of regressions, it's a fairly major
transformation to be doing.  These issues would be massively mitigated
if this were per regulator as I have repeatedly suggested.

> 1. It will allow adding/enabling new drivers without worrying about
> the system crashing due to the example scenario mentioned in the
> commit text.

Or just don't set constraints which alow things to be changed until
you're ready...

> 2. In my development flow, I had to do some stuff manually and then
> load some modules. Without this series, when some of the regulator
> drivers were built in, the regulators would get turned off after the
> 30s timeout before I could do my manual stuff. That would kill the
> system. Or if I start off the boot and walk away to get coffee, I'd
> come back to a dead device. It was super annoying to deal with this.

That's a new one, the normal thing would've been to let the driver load
and then remove it to load whatever test stuff.  I'm not sure that's
super practical to be honest, taking advantage of it really does seem to
require a vertically integrated system where the DT exactly matches what
you want at runtime.

> 3. When the regulator drivers are loaded as modules (after 30s
> timeout), some of the boot on regulators are never turned off until
> one of their consumers starts making requests. For example, if a
> regulator that supplies some camera component is left on by the
> bootloader, it would never get turned off unless you open the camera
> app. With this series, the regulator would get turned off after the
> camera driver probes.

Right, that's an issue but there seem to be less invasive solutions.

> To be clear, I understand the cases you are mentioning and I'm not
> discounting them. But compared to the 30 seconds of additional "on
> time", the functional correctness issues are more important. I'm not
> saying this series is the perfect solution, but it's certainly better
> than what we have now and we have the default behavior to be as least
> disruptive as possible to systems that work fine without this series.
> And if I find incremental improvements in the future, I'll send
> patches for that. But I'd hate to see perfect be the enemy of the
> good.

Having the requests from drivers be acted on promptly is also a
potential correctness and robustness issue.  You seem very focused on
the disabling of unused regulators for power reasons case but that's
really not the only thing going on here, there's also just the need to
control things as part of what the device is supposed to be doing.
Systems aren't always built to let us do all the things we're really
supposed to do with hardware so it's often advantageous to have drivers
that will do these things but cope gracefully, this means that it
doesn't always make sense to use exclusive gets even where you really
actually want things to happen as requested if they can.  Often the
devices are in practice robust enough most of the time things are fine
if the requests get ignored which is why systems can be built that way
but strictly we're not supposed to do that so where we can we should
avoid it.  Forcing consumers to be exclusive means that we need to add a
call that lets these consumers figure out which kind of get to use and
then have the consumer have multiple code paths for that (or more
realistically factor that out into the core, but then we could even more
easily just not have the system wide restrictions).

There's also issues around being able to reason about what the system is
supposed to do and why, hence my concerns about waiting for all devices
on the PMIC to appear.  Like I said above this is absolutely crucial.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8XTX8ACgkQJNaLcl1U
h9BwBgf9GCfH3wrF/PfTimmk0w5ExnjtaC6Ow1CwlVmWo/3cpVfWPcOjaE6J3mjy
DUEvEO+6fYt2xK7mRE3rOHVMVX6smJOGB1yS8u10QTZpSOt/udHGTgUjnTVloqsi
IA9+NEpHoOFAG39o98OQzHaQ44RPCgPYTycyCGqk0SIVSrFh34w7vP2lPsnsGpQZ
dCkLn2b4XheiwmDCEIDkbT87ZAByvcklngj16ZAn4+UQjD2LsrQ/IOU+aYn6bvj/
JINPhWkcaQFQjkA8UBN/GHRBfqcEpPkeBOPEeII4wGcNe4MjnsVGbIoiiLXyqu92
B57oAiJtvybNbdW6KroJgy8rnytKfQ==
=n2he
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
