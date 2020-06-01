Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00922206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591032209;
	bh=EIXGTIU3vmBz28YTv8XpjnShtIbF6A8KbmMp+gRWH9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pu0x1khclXuio0ldiC2l3P+rwKIOOhebzsEsZGtejIE5LbU8OWhjSlaF3I/c5u74F
	 HUgGkDiWd1qHkY43diK+3cDs/vHccYKl1xKC10zhq5WJD/yebnf3qJVGpVbOOehc32
	 1OdOy+gvDsspK1juPF9UruMmPS90a/eGzoGm3yFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFARX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFARX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:23:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA79206A4;
        Mon,  1 Jun 2020 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591032206;
        bh=EIXGTIU3vmBz28YTv8XpjnShtIbF6A8KbmMp+gRWH9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpyccTbYU3vT9aBh1WgqbxCjmVAuDLrVHpPawhE9E3hPtWEgItrkwMFagXZRX5vU2
         Vw8CLvaq/VfIl6XfnB4vV7YRSgH9ZkSsXwEzOOYGNO5EwWlkVr7DgmnY9C9gmwH7pv
         E45qWVKjPLiQ7iLOQ6jQo7R0XqausnmkLU0zwd+0=
Date:   Mon, 1 Jun 2020 18:23:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
Message-ID: <20200601172323.GE45647@sirena.org.uk>
References: <20200528190610.179984-1-saravanak@google.com>
 <20200528190610.179984-3-saravanak@google.com>
 <20200529130012.GJ4610@sirena.org.uk>
 <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 07:39:33PM -0700, Saravana Kannan wrote:
> On Fri, May 29, 2020 at 6:00 AM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, May 28, 2020 at 12:06:10PM -0700, Saravana Kannan wrote:

> > > especially important for regulators that might be powering more than one
> > > consumer. Otherwise, when the first consumer probes, enables and then
> > > disables the "boot on" regulator, it'd turn off the power to rest of the
> > > consumers of the "boot on" regulator.

> > Which is a problem because...?

> Those consumers that haven't probed can be powered on and active and
> can crash the system if the power is pulled under their feet.

This is I think the first time anyone has suggested that this is likely
to be an issue - the previous concerns have all been about screens
glitching.

> > > The sync_state() callback that's been added to drivers is meant for
> > > situations like this. It gets called when all the consumers of a device
> > > have probed successfully. To ease the transition to sync_state()
> > > callbacks, it is never called before late_initcall_sync().

> > This is not terribly useful for regulators where adding any of these
> > delays is going to create surprises.  Frankly I can't really see why
> > deferring things until late_initcall() would help anything.

> Is this different from what's done already?

At the minute we implement any requested changes immediately.

>                                              Not having this delay is
> easy -- but will have to be at a global level across
> devices/resources.

That seems fine given that there appears to be no reason to introduce a
delay.

> > > +static void regulator_set_minimum_state(struct regulator_dev *rdev)
> > > +{

> > I find this name very confusing.  If anything it's doing the opposite of
> > setting a minimum state, it's trying to prevent that happening.

> I agree. I renamed it to try and make it better, but I can see how
> it's more confusing once you called it out. Suggestions?

> regulator_set_boot_limits? regulator_set_boot_constraints?

ignore_consumer_requests()?

> > > +     /*
> > > +      * Wait for parent supply to be ready before trying to keep this
> > > +      * regulator on.
> > > +      */
> > > +     if (rdev->supply_name && !rdev->supply)
> > > +             return;

> > I can't make sense of this.  This stuff only limits disabling, not
> > enabling, regulators, we're keeping things on here anyway and why would
> > we care about the supply for disabling?

> We want to wait till supply is set up before we try to put the
> "enable" vote on a regulator. Otherwise, it won't be propagated
> properly? I do know that regulator_resolve_supply() takes care of
> propagating the use count, but we could delete that code if we just
> till the supply is resolved before "enabling" the regulator. The usual
> clients can't "get" the regulator anyway without the supply being
> resolved. Long story short, doing it this way can allow us to delete
> some functionally duplicative code.

So this is to support some future change that you either haven't
written or haven't sent out yet.  Please don't do stuff like this, it
makes everything more confusing.  Send out isolated, coherent changes
that do a single thing per patch, if there's things you're thinking of
for future work then save them for when you actually do that future
work.  That makes everything clearer and easier to follow.

> > I've just realised that this is even more restrictive than the
> > descriptions have suggested - it's not just preventing any changes until
> > all potential consumers of a given regulator have instantiated, it's
> > preventing changes until all potential consumers of all resources
> > provided by a given device have instantiated.  Given that many systems
> > have a single PMIC which may also be providing other things like GPIOs
> > that would mean that any consumer that doesn't instantiate would prevent
> > any device getting turned off which seems even more concerning.

> Your understanding is correct. I'll try to clarify the commit text as
> best as I can. Your concerns are why this is not the default behavior.

My concern is that introducing extra delays is likely to make things
more fragile and complex.  As far as I can see this is just making
things even worse by adding spurious dependencies and delaying things
further.

> For Android phones that are actually shipped, ensuring every enabled
> consumer actually probes is trivial and desired.

Other users exist and need to be considered.  People need to be able to
run upstream kernels, they need to be able to run distros and other
systems that aren't vertically integrated like yours where people aren't
developing the DT and kernel together.

> > > +     if (IS_ERR_OR_NULL(rdev->sync_supply))
> > > +             return 0;
> > > +
> > > +     regulator_disable(rdev->sync_supply);

> > I think sync_supply needs a better name, it's a consumer rather than a
> > supply any sync doesn't really fit with what it's doing either - getting
> > rid of it might be syncing but it's not syncing anything.

> Agree about the naming. Maybe boot_limits?

Possibly.

> > > +     /*
> > > +      * I'm not too enthusiastic about this. I'd rather just go set
> > > +      * .sync_state() in all the regulator drivers. But let's get the rest
> > > +      * of the patch sorted out first.
> > > +      */
> > > +     if (dev_set_drv_sync_state(rdev->dev.parent, regulator_sync_state))
> > > +             dev_dbg(&rdev->dev, "parent sync_state() already set\n");
> > > +     regulator_set_minimum_state(rdev);

> > If you don't want this to be configurable per driver then why do you
> > want to force it to be configured per driver?  I also think that is a
> > bad idea, it's just make work as far as I can see.

> I think the last line is a typo?

No, it's not a typo - "make work" is busy work for the sake of it.  I'm
saying that this is just requiring a mechanical update in all drivers
both now and going forwards which is exactly the sort of thing we should
be factoring out of drivers.

> As to why this is configurable per driver, we discussed this in the v1
> thread. sync_state() isn't specific to the regulator framework (which
> I'm sure you understand) -- so it needs to be flexible.
> Devices/drivers like MFDs, PMICs with GPIOs, power domains with reset
> control, etc might want to call into multiple frameworks when they get
> their sync state. Some devices/drivers might want to do more stuff
> specific to their device/system when they get the sync state callback
> -- they can spin their own sync_state() callback, do their stuff and
> then call regulator_sync_state() or whatever other framework they
> want. That's why it's configurable per device/driver.

To repeat what I said at the time a device that's in multiple frameworks
like this is most likely a MFD with a bunch of broadly unrelated things
in it, where things are related we need to track those dependencies
anyway.  At best this is working around a problem that has been
introduced by the decision to do everything at far too broad a level,
it feels like it's defeating the point of trying to track dependencies
at all.  The whole performance seems completely redundant if we're
trying to aggregate things so aggressively, we end up needing pretty
much every device in the system to come up before we can do anything.
Together with the late_initcall() stuff this is sounding like what it's
really doing is going a very long way around introducing a new initcall
that gets triggered after all modules are loaded (which *was* one of the
earlier suggestions).

I really think this would be a lot simpler and easier for all concerned
if it operated per regulator like the changelog originally seemed to
suggest.

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7VOYsACgkQJNaLcl1U
h9Ac6Qf/eAo5vdTzPmqHCk8XaznS7SPwyZlPoT76Rsi/zBPYEyab08MK0QezlEvd
bOLzrB9OmmRv7/TUjEX782ICQH/YWfYdKShqxxW3GkN1iqsImGvoZiVNrs52f2em
ctYBVlHXibT18gZw3pdAk3s33CtjnObzlFXXPywyyEEEtRBx3cG1XrdZbcCJsf1f
btxMwf+dzIvNuyKP3GjdMliFe7vZICWi2z0u7F2GFyCjgsY3dYM1pWTpaqDgg1t6
KHtun7SuSBn+KgHxhUwZ10EjxLQ3v2JC8PcLcP7I9uDlmztl3Ryko9KNWmqGCdPx
SmUZ5Dt5PNZmB7I/O5ulazMRENKUJw==
=cXZi
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
