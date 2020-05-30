Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94541C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56260206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZmaz5vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgE3CkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgE3CkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:40:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FDCC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:40:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g25so3476115otp.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egIbX2f1XuswrLqo2MswrNZ7vHIJk8Ch56AqLs7orVQ=;
        b=IZmaz5vEEKiNdKZhXaWKF5yswdO8/jRIMIGVNeqQXzzzM1XrzBm6mdFB8fPlwAylIX
         B9pldtrvZKdgmAiWti2Is1ZBUMXHBT8u2+3ffLpV+xRveTXIujG/6AB5duVQzR11jfxb
         XUd8b0VWhooig4ZOh3MMD6lKzUDXeDZFYRw/GhrZYpBdT2nbYcC0kN+MPZTDS0mMi6T8
         ahjjfLoUA9wxYSdbUVrWffsp7LWDukhMnE38/NuPKY4xkp83I5Tux8iVnMdLNCLRgTGF
         d/+bmU2AU1QKU1egxVrsIES6B7Qro/So7sixY6k//LPRuqYqKGatiDeU9SThPxkQTei8
         GFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egIbX2f1XuswrLqo2MswrNZ7vHIJk8Ch56AqLs7orVQ=;
        b=CZAzlzug+mh2NJYnyB5qY42L6wcITnuwVlZgEmbN031dIJ28brRf+XmJOGMNKWyISt
         odFHo/tG4Wf9JC6p7SgsAU2K55LDn76nfSgsxF9bWehpJfu0vs705vlEcnnIHpNyqcse
         On6LSdL6EVKmcZ/upllOYXvs+EmKsQp13xBtfrWR07Ll7uo6HGBBHzOqGDOcSKVs7BJS
         P1NeWn6VAEhTQNFnitWb60MyCxr1XnPuiWXWdIVF+p4DTrKFcfJpa9zeQnnaZkFRiwfz
         smBWBI/E/XOoKIRDWOMcshGV9nNpW/lxvAJUjkeOTDwadnMkmty8AXSd2Gd8unU6ClxY
         P0tQ==
X-Gm-Message-State: AOAM530v3G8hdmUJJY4lR4gzg0Ro2R73tc7DbO4QCfuHmkrtDvKMCJYe
        pkLpb9OoGi0LMnuxJrZwImT6DhAGcamZk5SvK/FDJA==
X-Google-Smtp-Source: ABdhPJzY7u0Conf+5NWD48+2265rnLxNkmC+DHGy9aQ4SAd1IsVzhbM4e45TlwBEEcguQDUfDXQAlrtZSlilaHq0PGE=
X-Received: by 2002:a05:6830:18ec:: with SMTP id d12mr9047680otf.139.1590806409542;
 Fri, 29 May 2020 19:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200528190610.179984-1-saravanak@google.com> <20200528190610.179984-3-saravanak@google.com>
 <20200529130012.GJ4610@sirena.org.uk>
In-Reply-To: <20200529130012.GJ4610@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 29 May 2020 19:39:33 -0700
Message-ID: <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
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

On Fri, May 29, 2020 at 6:00 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, May 28, 2020 at 12:06:10PM -0700, Saravana Kannan wrote:
> > When a regulator is left on by the bootloader or anything else before
> > the kernel starts (let's call this a "boot on" regulator), we need to
> > keep it on till all the consumers of the regulator have probed. This is
>
> We we don't in general have a requirement that any of the consumers of a
> regulator will ever probe.  As I thought I'd already made clear that
> case really needs to be handled.

Sorry, in the eagerness to address all your concerns, I had forgotten
to update the commit text in v2. I'll reword it to clarify this'll
happen only when there's no timeout set.

> > especially important for regulators that might be powering more than one
> > consumer. Otherwise, when the first consumer probes, enables and then
> > disables the "boot on" regulator, it'd turn off the power to rest of the
> > consumers of the "boot on" regulator.
>
> Which is a problem because...?

Those consumers that haven't probed can be powered on and active and
can crash the system if the power is pulled under their feet.

> > The sync_state() callback that's been added to drivers is meant for
> > situations like this. It gets called when all the consumers of a device
> > have probed successfully. To ease the transition to sync_state()
> > callbacks, it is never called before late_initcall_sync().
>
> This is not terribly useful for regulators where adding any of these
> delays is going to create surprises.  Frankly I can't really see why
> deferring things until late_initcall() would help anything.

Is this different from what's done already? Not having this delay is
easy -- but will have to be at a global level across
devices/resources.

> > sync_state() callbacks become even more useful when combined with
> > fw_devlink.  If fw_devlink is off, sync_state() is called at
> > late_initcall_sync() or the regulator device probing successfully --
> > whichever is later. This is because, with fw_devlink off, there would be
> > no consumers to the regulator device when it probes.
>
> This breaks the case where no driver ever instantiates for a device.
>
> Oh, actually now I get to the very end of the patch I see there is
> actually a timeout in here which wasn't mentioned in the changelog at
> all.  I very nearly didn't read the actual code as according to the
> changelog this issue hadn't been addressed.

Again, sorry I didn't update the commit text. I'll skip replying to
rest of your comments on the commit text, because all of them are due
to stale commit text.

> > This commit adds a regulator_sync_state() helper function that takes
> > care of all the "boot on" regulator clean up for any regulator driver.
> > All one needs to do is add the following line to the driver struct.
> >
> > .sync_state = regulator_sync_state,
>
> Exactly the same issues as before apply here, why are devices getting
> involved here?
>
> > +static void regulator_set_minimum_state(struct regulator_dev *rdev)
> > +{
>
> I find this name very confusing.  If anything it's doing the opposite of
> setting a minimum state, it's trying to prevent that happening.

I agree. I renamed it to try and make it better, but I can see how
it's more confusing once you called it out. Suggestions?

regulator_set_boot_limits? regulator_set_boot_constraints?

> > +     /*
> > +      * Wait for parent supply to be ready before trying to keep this
> > +      * regulator on.
> > +      */
> > +     if (rdev->supply_name && !rdev->supply)
> > +             return;
>
> I can't make sense of this.  This stuff only limits disabling, not
> enabling, regulators, we're keeping things on here anyway and why would
> we care about the supply for disabling?

We want to wait till supply is set up before we try to put the
"enable" vote on a regulator. Otherwise, it won't be propagated
properly? I do know that regulator_resolve_supply() takes care of
propagating the use count, but we could delete that code if we just
till the supply is resolved before "enabling" the regulator. The usual
clients can't "get" the regulator anyway without the supply being
resolved. Long story short, doing it this way can allow us to delete
some functionally duplicative code.

> > +static int regulator_rel_minimum_state(struct device *dev, void *data)
> > +{
> > +     struct regulator_dev *rdev = dev_to_rdev(dev);
> > +
> > +     if (dev->parent != data)
> > +             return 0;
>
> I've just realised that this is even more restrictive than the
> descriptions have suggested - it's not just preventing any changes until
> all potential consumers of a given regulator have instantiated, it's
> preventing changes until all potential consumers of all resources
> provided by a given device have instantiated.  Given that many systems
> have a single PMIC which may also be providing other things like GPIOs
> that would mean that any consumer that doesn't instantiate would prevent
> any device getting turned off which seems even more concerning.

Your understanding is correct. I'll try to clarify the commit text as
best as I can. Your concerns are why this is not the default behavior.
For Android phones that are actually shipped, ensuring every enabled
consumer actually probes is trivial and desired.

> > +     if (IS_ERR_OR_NULL(rdev->sync_supply))
> > +             return 0;
> > +
> > +     regulator_disable(rdev->sync_supply);
>
> I think sync_supply needs a better name, it's a consumer rather than a
> supply any sync doesn't really fit with what it's doing either - getting
> rid of it might be syncing but it's not syncing anything.

Agree about the naming. Maybe boot_limits?

> The other thing here is that we're doing this silently which is going to
> make problems harder to debug, if something gets turned off that wasn't
> supposed to be turned off and the system collapses users are going to
> have fun working out what happened - this is why the current code to
> tidy up idle regulators prints something before it disables things.

Agreed. I'll add a log similar to the existing clean up path.

> > @@ -5188,6 +5272,15 @@ regulator_register(const struct regulator_desc *regulator_desc,
> >           !rdev->desc->fixed_uV)
> >               rdev->is_switch = true;
> >
> > +     /*
> > +      * I'm not too enthusiastic about this. I'd rather just go set
> > +      * .sync_state() in all the regulator drivers. But let's get the rest
> > +      * of the patch sorted out first.
> > +      */
> > +     if (dev_set_drv_sync_state(rdev->dev.parent, regulator_sync_state))
> > +             dev_dbg(&rdev->dev, "parent sync_state() already set\n");
> > +     regulator_set_minimum_state(rdev);
>
> If you don't want this to be configurable per driver then why do you
> want to force it to be configured per driver?  I also think that is a
> bad idea, it's just make work as far as I can see.

I think the last line is a typo?

Anyway, I just have the dev_set_drv_sync_state() call here instead of
spending time on a patch that sets .sync_state() for 100s of regulator
drivers before we can actually agree on the bigger picture/idea. Once
the patch becomes acceptable, I'd like to go set this for every
regulator driver and delete the call to dev_set_drv_sync_state().

As to why this is configurable per driver, we discussed this in the v1
thread. sync_state() isn't specific to the regulator framework (which
I'm sure you understand) -- so it needs to be flexible.
Devices/drivers like MFDs, PMICs with GPIOs, power domains with reset
control, etc might want to call into multiple frameworks when they get
their sync state. Some devices/drivers might want to do more stuff
specific to their device/system when they get the sync state callback
-- they can spin their own sync_state() callback, do their stuff and
then call regulator_sync_state() or whatever other framework they
want. That's why it's configurable per device/driver.

> > +     /*
> > +      * If regulator_cleanup_timeout is set to a non-zero value, it probably
> > +      * means some of the consumers will never probe or the regulators have
> > +      * some restrictions on how long they can stay ON. So, don't wait
> > +      * forever for consumer devices to probe.
> > +      */
> > +     if (regulator_cleanup_timeout)
> > +             class_for_each_device(&regulator_class, NULL, NULL,
> > +                                   regulator_minimum_state_cleanup);
> > +
>
> This is not a timeout, it is a boolean flag - nothing ever actually sets
> a delay or timeout based on this number.  I really think this should
> just be a separate patch adding configurability for the existing delay
> before finalization not something that randomly only affects this new
> magic stuff as that makes things more complex and confusing.

Sorry, this is a dumb mistake. I forgot to replace the 30000ms that's
a few lines below with regulator_cleanup_timeout.

I'm also reaching out to vendors/partners to try and gather some
examples. There are plenty of real world examples but the ones I know
are mostly in downstream kernels that are shipped in Android phones.
So trying to find ones in upstream or get vendors to speak up about
how often this is an issue downstream. This is also kind of a catch
22. Vendors hack up their regulator driver and the regulator framework
to get this "boot on" regulator handling working, but they can't
obviously upstream their drivers because the hacks aren't acceptable.
I don't want to debate that can of worms right now -- I'm trying to
find upstream examples first (which I hope isn't hard).

I'll send out v3 addressing your comments once I get a better handle
on the examples. Thanks for the reviews and being open to finding a
solution that works for everyone.

-Saravana
