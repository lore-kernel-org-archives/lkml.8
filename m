Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D136C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F662078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxsmC/2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgFIDRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFIDRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:17:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F63C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 20:17:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 69so15475883otv.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbaClnYh/AuWsCVi6ZzvtMwXuIrDEWonOaC7w0MO6oA=;
        b=mxsmC/2rEsY0gMc11oLf31FSWGrKxByL7PUL1o2xfKtiCKjPKBYKWu3JKHQmKjubbX
         7iDVSYniNCRsTMufNM5S89IvhWMCixXa7QWpGZt8Vf4CbSrBbb35LbpTCVUiTmmydsN9
         04BvSNOczxOrIcUiALAZlOjqmv5F35wO5zO5LlCXFvSj+lDy/HQ51pEIdm7yyxm5c6uu
         nk2E9yscIIOnIsUASMKR8nUzpcPI5W9b6w6rMz/JLsrWHUaKfy3H8+hA/NJxA4t2Fxni
         FrJyxl17+N2ByHc2syP/q09STembYZWT3diW9auBc9ODhPmP+5znQIv1rAGfm41qu4Qs
         WDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbaClnYh/AuWsCVi6ZzvtMwXuIrDEWonOaC7w0MO6oA=;
        b=eQ5/QGB/TIs1/glJaeL8tm813ASqiUkBBYw8H3J9Jxq2avomg1+OrJcWobjmwpOCGe
         XpjiWmuguQ8gjHS7gBfqi/hjs0K5FouTsJuYVYaqbAA+/d7jJ2kQBH0tIOXx9gtcbs9q
         0ZZg7I9MZlJv6YHYJg/HMFX6rfDZAuXubjRDFnayTUAT3Iszdv/I3QR+nWUkeiahKcGE
         oNIkB3/gzQogfeHcCOg3iCY8L/I/BsoIOMHAC1hJQbegmF7TgRuBTnvtj7biPNAA6kbz
         kkwKgb+uO2cesThPyEpQeZXa2QODLueBC63cQkBqG0ixoP6h28ciRey+opHO4m5oi0ws
         PLnA==
X-Gm-Message-State: AOAM533nBk5m0jocrGCYVol6NsBIscSR2nkjqj80AgNuPQvSV/TQs+7L
        5AcvyT1UGG2yPz9C783vmj1D0ABh6PiwVWczyqq0Xgh7NKE=
X-Google-Smtp-Source: ABdhPJyjsZS95ZIEozNOls6HYn+wFBGrs3EeT7nQneDTySSUfiM5e+ASx+reJiMh/IsT/eYjtK0tDiUbNA8nA9QlMF0=
X-Received: by 2002:a9d:2253:: with SMTP id o77mr19810930ota.236.1591672640272;
 Mon, 08 Jun 2020 20:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200528190610.179984-1-saravanak@google.com> <20200528190610.179984-3-saravanak@google.com>
 <20200529130012.GJ4610@sirena.org.uk> <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
 <20200601172323.GE45647@sirena.org.uk>
In-Reply-To: <20200601172323.GE45647@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 8 Jun 2020 20:16:44 -0700
Message-ID: <CAGETcx-T=NstJDV2S8gKmqpOv1r2-fTRs1pwOtSQ6rJumhVGBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 10:23 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 07:39:33PM -0700, Saravana Kannan wrote:
> > On Fri, May 29, 2020 at 6:00 AM Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, May 28, 2020 at 12:06:10PM -0700, Saravana Kannan wrote:
>
> > > > especially important for regulators that might be powering more than one
> > > > consumer. Otherwise, when the first consumer probes, enables and then
> > > > disables the "boot on" regulator, it'd turn off the power to rest of the
> > > > consumers of the "boot on" regulator.
>
> > > Which is a problem because...?
>
> > Those consumers that haven't probed can be powered on and active and
> > can crash the system if the power is pulled under their feet.
>
> This is I think the first time anyone has suggested that this is likely
> to be an issue - the previous concerns have all been about screens
> glitching.

Looks like we got at least one concrete example now in [1].

>
> > > > The sync_state() callback that's been added to drivers is meant for
> > > > situations like this. It gets called when all the consumers of a device
> > > > have probed successfully. To ease the transition to sync_state()
> > > > callbacks, it is never called before late_initcall_sync().
>
> > > This is not terribly useful for regulators where adding any of these
> > > delays is going to create surprises.  Frankly I can't really see why
> > > deferring things until late_initcall() would help anything.
>
> > Is this different from what's done already?
>
> At the minute we implement any requested changes immediately.
>
> >                                              Not having this delay is
> > easy -- but will have to be at a global level across
> > devices/resources.
>
> That seems fine given that there appears to be no reason to introduce a
> delay.
>
> > > > +static void regulator_set_minimum_state(struct regulator_dev *rdev)
> > > > +{
>
> > > I find this name very confusing.  If anything it's doing the opposite of
> > > setting a minimum state, it's trying to prevent that happening.
>
> > I agree. I renamed it to try and make it better, but I can see how
> > it's more confusing once you called it out. Suggestions?
>
> > regulator_set_boot_limits? regulator_set_boot_constraints?
>
> ignore_consumer_requests()?

But it doesn't really ignore consumer requests though. In response to
all your comments above, I haven't done a good job of explaining the
issues and the solution. I'll try to redo that part again when I send
v3 and hopefully I can do better.

> > > > +     /*
> > > > +      * Wait for parent supply to be ready before trying to keep this
> > > > +      * regulator on.
> > > > +      */
> > > > +     if (rdev->supply_name && !rdev->supply)
> > > > +             return;
>
> > > I can't make sense of this.  This stuff only limits disabling, not
> > > enabling, regulators, we're keeping things on here anyway and why would
> > > we care about the supply for disabling?
>
> > We want to wait till supply is set up before we try to put the
> > "enable" vote on a regulator. Otherwise, it won't be propagated
> > properly? I do know that regulator_resolve_supply() takes care of
> > propagating the use count, but we could delete that code if we just
> > till the supply is resolved before "enabling" the regulator. The usual
> > clients can't "get" the regulator anyway without the supply being
> > resolved. Long story short, doing it this way can allow us to delete
> > some functionally duplicative code.
>
> So this is to support some future change that you either haven't
> written or haven't sent out yet.  Please don't do stuff like this, it
> makes everything more confusing.  Send out isolated, coherent changes
> that do a single thing per patch, if there's things you're thinking of
> for future work then save them for when you actually do that future
> work.  That makes everything clearer and easier to follow.

Ok. Thinking more about it, when I try to add voltage handling, I'll
need to call regulator_get_voltage_rdev(). So I might still need to
wait till supply is set up. However, if I don't really need it, I'll
make sure to drop any "future improvements" related changes.

> > > I've just realised that this is even more restrictive than the
> > > descriptions have suggested - it's not just preventing any changes until
> > > all potential consumers of a given regulator have instantiated, it's
> > > preventing changes until all potential consumers of all resources
> > > provided by a given device have instantiated.  Given that many systems
> > > have a single PMIC which may also be providing other things like GPIOs
> > > that would mean that any consumer that doesn't instantiate would prevent
> > > any device getting turned off which seems even more concerning.
>
> > Your understanding is correct. I'll try to clarify the commit text as
> > best as I can. Your concerns are why this is not the default behavior.
>
> My concern is that introducing extra delays is likely to make things
> more fragile and complex.  As far as I can see this is just making
> things even worse by adding spurious dependencies and delaying things
> further.

I wouldn't call it delaying any requests. This is just an additional
constraint like any other consumer. This definitely makes things more
stable in cases where all the devices probe and even in cases where
some of those devices might never probe (example I gave in [2]).

> > For Android phones that are actually shipped, ensuring every enabled
> > consumer actually probes is trivial and desired.
>
> Other users exist and need to be considered.  People need to be able to
> run upstream kernels, they need to be able to run distros and other
> systems that aren't vertically integrated like yours where people aren't
> developing the DT and kernel together.

Agreed. Which is why the timeout will be enabled by default and the
default behavior won't change. And I'm not making or asking for DT
changes. So it shouldn't break existing users.

> > > > +     if (IS_ERR_OR_NULL(rdev->sync_supply))
> > > > +             return 0;
> > > > +
> > > > +     regulator_disable(rdev->sync_supply);
>
> > > I think sync_supply needs a better name, it's a consumer rather than a
> > > supply any sync doesn't really fit with what it's doing either - getting
> > > rid of it might be syncing but it's not syncing anything.
>
> > Agree about the naming. Maybe boot_limits?
>
> Possibly.
>
> > > > +     /*
> > > > +      * I'm not too enthusiastic about this. I'd rather just go set
> > > > +      * .sync_state() in all the regulator drivers. But let's get the rest
> > > > +      * of the patch sorted out first.
> > > > +      */
> > > > +     if (dev_set_drv_sync_state(rdev->dev.parent, regulator_sync_state))
> > > > +             dev_dbg(&rdev->dev, "parent sync_state() already set\n");
> > > > +     regulator_set_minimum_state(rdev);
>
> > > If you don't want this to be configurable per driver then why do you
> > > want to force it to be configured per driver?  I also think that is a
> > > bad idea, it's just make work as far as I can see.
>
> > I think the last line is a typo?
>
> No, it's not a typo - "make work" is busy work for the sake of it.  I'm
> saying that this is just requiring a mechanical update in all drivers
> both now and going forwards which is exactly the sort of thing we should
> be factoring out of drivers.
>
> > As to why this is configurable per driver, we discussed this in the v1
> > thread. sync_state() isn't specific to the regulator framework (which
> > I'm sure you understand) -- so it needs to be flexible.
> > Devices/drivers like MFDs, PMICs with GPIOs, power domains with reset
> > control, etc might want to call into multiple frameworks when they get
> > their sync state. Some devices/drivers might want to do more stuff
> > specific to their device/system when they get the sync state callback
> > -- they can spin their own sync_state() callback, do their stuff and
> > then call regulator_sync_state() or whatever other framework they
> > want. That's why it's configurable per device/driver.
>
> To repeat what I said at the time a device that's in multiple frameworks
> like this is most likely a MFD with a bunch of broadly unrelated things
> in it, where things are related we need to track those dependencies
> anyway.

MFDs are just one example. In any case, we can stick with how I did it
in v2 where the regulator framework can set up the sync_state()
callback for the driver if it hasn't already set one up.

> At best this is working around a problem that has been
> introduced by the decision to do everything at far too broad a level,
> it feels like it's defeating the point of trying to track dependencies
> at all.  The whole performance seems completely redundant if we're
> trying to aggregate things so aggressively, we end up needing pretty
> much every device in the system to come up before we can do anything.

This is definitely not true on real Android phones. Keep in mind all
of this only applies to resources actually left on by the bootloader.
So, that drastically cuts down what all devices are affected by this.
So, if a PMIC has 5 regulators and only 1 is left on by the
bootloader, then this patch series would be a NOP for the 4
regulators.

> Together with the late_initcall() stuff this is sounding like what it's
> really doing is going a very long way around introducing a new initcall
> that gets triggered after all modules are loaded (which *was* one of the
> earlier suggestions).

That's definitely not the case. sync_state() callbacks will come way
before all the modules are loaded. Again, going by testing it on real
hardware.

-Saravana

[1] - https://lore.kernel.org/lkml/20200605063724.9030-1-m.szyprowski@samsung.com/#t
[2] - https://lore.kernel.org/lkml/CAGETcx8asyFRz5LmU4LSMJuPWvcWdvi1GHAhQ85AWdd6jcmdiA@mail.gmail.com/
