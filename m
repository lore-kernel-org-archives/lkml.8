Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5771C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B650520729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCNSHs5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgGUDWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgGUDWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:22:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:22:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so799338pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cc7Ot+FnncELYX5IBa4tpuiDXhk23chU2Cj5I4oJqRE=;
        b=RCNSHs5Rlrs0eVPTeWPXyCHmrP9oYNhsyzsOAO7caF/a7I8bDObK+2dt74t7lWc9mY
         WjAdQa2MQAS8zWBfAR5Yh4da7p0ZK040yUfvbi9gSvV6MMQ3X0XIaeg5p2Y5M6D3s8rO
         LEJq+46c91wuSLmdr4hVEKCHNKx/+BP27tTZqzL9WgdUFqwpBAboKBQ7FcEoEqYaf5ys
         op6mmOvUKR1malfKXUD6FMRd/O6pPND1t6798u48Wvmcb/0FQjNWr/NbY4LHzMxv1jvi
         lj6Bz3H98HhoFupdr3zKvsEogkv8usTh8U3ChgCL8s8fJCd9UCOe19ZlnxTkuEgCg7Ms
         u2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc7Ot+FnncELYX5IBa4tpuiDXhk23chU2Cj5I4oJqRE=;
        b=ONYkoWG6vLtpUTDR3wuNM5r0zshJxO06JGdTZXNb+UKJ45DUSMpnwBU2oOQoigg4Z8
         DwS5zCxc5ReKXAZ4vnnooTceJJJDvu2hNrrOHr5o9l2CY1MH0IaxDri8mwAx8bklOGHz
         MoNX+T5y+plfgfixropOJSObu6IVc7HSJxKwJM1QceWbRoNEZJ5JZRVolZJHNTuYhQE3
         RNZY7gL5OdKsz4Jyjr4QJi5rDqCqxM+YZ4Rht1cTjTD7iOJvvlLdg97IbKAfpiM+2QD1
         BumehUuFjlqicATcS//6T14/BT35So1BqPQLjvCPEBd54QciF9O01MMRUtJddqxFCdKc
         Ay9w==
X-Gm-Message-State: AOAM533smaMwqJJetLgLgHd0bUXvpeZqi3MKAzcwJqm7Iudw8d31b5h0
        Bh2M+ID4VdCAYM7ljqy0pg8oeOFxVYb2+W913nRhWI0ftC8=
X-Google-Smtp-Source: ABdhPJy8pfL0zZx4WKPsX4iTqxWyiM2MLyTMj8Fllc3bnKxBMDejFqRA1q2QkfJM7ejkAaFNjTz8MLwLMUK2KI+KsDE=
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr20762961plp.67.1595301771167;
 Mon, 20 Jul 2020 20:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200716042053.1927676-4-saravanak@google.com> <20200720142753.GF4601@sirena.org.uk>
In-Reply-To: <20200720142753.GF4601@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 20 Jul 2020 20:22:15 -0700
Message-ID: <CAGETcx96AuV=1rcyMAv5QGpGp0BqfWa40Fq-DShrBeY5Q61zkQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] regulator: core: Add basic enable/disable support
 for sync_state() callbacks
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 7:28 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 15, 2020 at 09:20:52PM -0700, Saravana Kannan wrote:
>
> > There are Android devices that exhibit the issue in the example where
> > regulator-X is an LDO, device-A is a camera device and device-B and
> > device-C are UFS and USB. To avoid this, they have their own downstream
> > changes to the regulator framework.
>
> Can you provide any references to these bodges?

This is the best I could dig up. The site is slow as molasses. I don't
want to focus or critique any specific vendor's downstream code
though. Providing these links just to prove that this is a real issue.

Search for "proxy" here. You'll notice how that will also need changes
to regulator header files, etc. The 4.9 kernel is the latest publicly
available version AFAIK.
https://source.codeaurora.org/quic/la/kernel/msm-4.9/plain/drivers/regulator/core.c?h=msm-4.9

As for the specific example of those devices, I'm not sure how much of
that stuff is publicly available and I don't want to deal with finding
that out.

> > 1. When a regulator is registered,
> >    a. The sync_state() callback for the regulator's device is set to
> >       regulator_sync_state(). The sync_state() callback is called when
> >       all the consumers of the regulator's device have probed
> >       successfully.
>
> As I indicated on my previous review this doesn't seem OK, given that a
> huge proportion of the regulators on most systems are part of a single
> PMIC this means that devices won't be able to fully control regulators
> for the majority of the boot process, possibly quite a long time after
> userspace has started in systems where not all devices have drivers.

By default regulator_cleanup_timeout is set to 30s. So by default,
it's not going to be "possibly quite a long time". So, at worst, for
the first 30 seconds voltages can't be lowered below boot level and
regulators can't be turned off if they were left on by the boot
loader. If a consumer is not an exclusive consumer, then none of this
should break functional correctness for them and just be 30 seconds of
suboptimal power. And exclusive consumers won't have this issue.

I think the default behavior should be for functional correctness
(example in the commit text) and then go for optimization (being able
to power off regulators before 30s into boot). Even with the timeout
set, this series makes it much easier for driver developers to ensure
functional correctness instead of playing initcall chicken between the
supplier and the N consumers.

Actually on systems without all the drivers, I'd argue the correct
behavior is this patch series + regulator_cleanup_timeout=-1. This
patch series will prevent system instability/unusability (Eg: missing
display backlight driver) at the cost of power optimization. However,
to allow turning off boot on regulators in systems without all the
drivers where it happens to not cause functional correctness issues,
we have the timeout default to 30s.

> That seems unreasonably restrictive, it seems like this is shifting the
> problem around so we have this new very late init phase where we
> actually implement changes that devices asked for. Devices can work
> around it by using _get_exclusive() but that makes things more complex
> if they can also support non-exclusive use.

I agree, hacking around any issues using _get_exclusive() when they
don't really need exclusive access is not a solution.

> I don't understand the motivation for doing things this way.  Like I
> said last time it really feels like this turns the whole mechanism into
> a very complicated way of implementing a new initcall.

Treating this as a "LATER_initcall()" has several issues.
1. initcall levels set a max limit on the depth of device dependency.
Since DT devices are added at arch initcall level, that gives us about
5 levels if you ignore the _sync ones. Adding more isn't going to
scale or solve the problem because in reality, the dependencies are
much deeper.
2. Also, initcall call ordering also depends on Makefile/link
ordering. Which is fragile and error prone.
3. I know Greg hates playing initcall chicken.
4. "initcall levels" don't work for modules. The kernel initcall
levels are done by the time modules are loaded.
5. "initcall levels" don't work with deferred probing.
6. If the answer is, "have userspace tell us when all modules are
loaded" -- then we are depending on userspace for functional
correctness AND for turning off regulators. Which IMHO is worse than
this patch series.
7. If we somehow manage to add a "LATER_initcall" that doesn't have
the issues above, it has to work for all frameworks. So, it has to
come after ALL the devices in the system have probed. Not just "all
devices of a supplier". So, again, it's worse than this patch series,
at least for systems where all the drivers are present.

> >    b. If the regulator is ON at boot, a BOOT-LIMITS consumer is created
> >       for the regulator and an enable vote is made.
>
> If something was left partially set up by the bootloader this means that
> drivers are no longer able to remove power from the device as part of
> getting it into a known good state even if they are the only consumer.

If they really NEED to turn power off to get to a known good state,
then they really need to be exclusive consumers.

> Having to tune things in the bootloader isn't great for some development
> flows.

I'm not sure I fully understand what you'd need to tune in the
bootloader. But independent of that, by default we still have the 30s
timeout, so there's no boot loader tuning necessary. Just a 30s delay
before being able to "optimize power" during development flow.

I think this patch series actually helps a lot during the development
phase (especially with regulator_cleanup_timeout=-1):
1. It will allow adding/enabling new drivers without worrying about
the system crashing due to the example scenario mentioned in the
commit text.
2. In my development flow, I had to do some stuff manually and then
load some modules. Without this series, when some of the regulator
drivers were built in, the regulators would get turned off after the
30s timeout before I could do my manual stuff. That would kill the
system. Or if I start off the boot and walk away to get coffee, I'd
come back to a dead device. It was super annoying to deal with this.
3. When the regulator drivers are loaded as modules (after 30s
timeout), some of the boot on regulators are never turned off until
one of their consumers starts making requests. For example, if a
regulator that supplies some camera component is left on by the
bootloader, it would never get turned off unless you open the camera
app. With this series, the regulator would get turned off after the
camera driver probes.

To be clear, I understand the cases you are mentioning and I'm not
discounting them. But compared to the 30 seconds of additional "on
time", the functional correctness issues are more important. I'm not
saying this series is the perfect solution, but it's certainly better
than what we have now and we have the default behavior to be as least
disruptive as possible to systems that work fine without this series.
And if I find incremental improvements in the future, I'll send
patches for that. But I'd hate to see perfect be the enemy of the
good.

> > +     /*
> > +      * If regulator_cleanup_timeout is set to a non-zero value, it probably
> > +      * means some of the consumers will never probe or the regulators have
> > +      * some restrictions on how long they can stay ON. So, don't wait
> > +      * forever for consumer devices to probe.
> > +      */
> > +     if (regulator_cleanup_timeout)
> > +             class_for_each_device(&regulator_class, NULL, NULL,
> > +                                   regulator_boot_limits_timeout);
>
> It feels like this should be a negative value rather than zero, if the
> timeout is 0 someone might reasonably expect things to happen
> immediately rather than never.

Makes sense. I'll fix this.

-Saravana
