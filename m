Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7D2C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EB420768
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDMxgktV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgG1VPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1VP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:15:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61049C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:15:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so5352204plz.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwUGsarabHI4X09wgNfzqdINlTrxyybInAeXBkRDQe8=;
        b=QDMxgktV3Y3TbvlMkusPNnuEQrjQ1VXX/BEQTk8yY0uSF6TEUngmeJGGv2FjeTKQ9Y
         DqoZK3VZ+Y6IaJqn/Ri0mOR6HJbFZ+iEkW9sbpNnwG18iFve8YRIeGFzjLbDw8L3o8iq
         GBXomurEkOymDaH2RKnzSjtvi8RkiHHQjzVToQq0LvfO8BUHY6sMv2J3fiA1w3UqQn4A
         xN71Vd4uFOQX3kgN1YbO0ZTahWEPbfah+6jLIf3xXjomduGJU6CEmU6XTT28cUOWB2lC
         gz+LuBy8RfMgSIV9Je1dfD7zN3m/zjzt7ojKFUMxwjtpbtVOdT+qNHviGinkAo2xqYDz
         /VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwUGsarabHI4X09wgNfzqdINlTrxyybInAeXBkRDQe8=;
        b=CWT2kQJj6EhzLwNG0IZbhA/4CmS2ND4O9Pn52egoYQvmP4PuCPjFFsYvMZFXIvcF7D
         QDJ4pT97+P43kwlxM9jv896xEwpqO7LUkepiK7NxnH1YeS8bpljf1RvWvYSWMdkJoCPt
         Y5+63JYvxB2wppP470RZB8tflSWdZ+CCPZU2VWVa5AK+xNeRxrKOa3l5TYMGPHJBgbCL
         UN+K7X5cAg/T+DnPcKsAzvjTBWmJ6L/hc09DLbkd7dScW6fs7UqIKGO69zfh3L3qmMGH
         I4z1WmOVX/aPIQOpfQX8ABr9g6k6vCDn5isuum3AexRj5I0W8UxoV3SnorfoMjJl0tyU
         2zsg==
X-Gm-Message-State: AOAM532qWQT0HpqiD14jGABZkhLI4JwN1BVXcP+jZ60gVNhvq3ZuCR0l
        2MjZNTDqsMizAWYm537o/B2+qWMDiN0n6zhRJoGgtw==
X-Google-Smtp-Source: ABdhPJwj0FKEIfCqImHzTKIbr0pyH+MK2RuyKP2UkEH5Q43p+/DwcPBt+E0uP/aftOG94Ydosu+GdoKe6FnAJhvCmio=
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr24717061pls.244.1595970928381;
 Tue, 28 Jul 2020 14:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200716042053.1927676-4-saravanak@google.com>
 <20200720142753.GF4601@sirena.org.uk> <CAGETcx96AuV=1rcyMAv5QGpGp0BqfWa40Fq-DShrBeY5Q61zkQ@mail.gmail.com>
 <20200721201808.GD4845@sirena.org.uk>
In-Reply-To: <20200721201808.GD4845@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 28 Jul 2020 14:14:52 -0700
Message-ID: <CAGETcx9+DUXyLnu0Rjom6oMpJvsdewbzvz=uW6xYOUjPD_Z=9A@mail.gmail.com>
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

On Tue, Jul 21, 2020 at 1:18 PM Mark Brown <broonie@kernel.org> wrote:
>
Hi Mark,

It *might* be easier if you jump to the bottom and read the reasoning
for the current design. The stuff in between is just me trying to
clarify some misunderstandings.

> On Mon, Jul 20, 2020 at 08:22:15PM -0700, Saravana Kannan wrote:
> > On Mon, Jul 20, 2020 at 7:28 AM Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, Jul 15, 2020 at 09:20:52PM -0700, Saravana Kannan wrote:
>
> > > > There are Android devices that exhibit the issue in the example where
> > > > regulator-X is an LDO, device-A is a camera device and device-B and
> > > > device-C are UFS and USB. To avoid this, they have their own downstream
> > > > changes to the regulator framework.
>
> > > Can you provide any references to these bodges?
>
> > This is the best I could dig up. The site is slow as molasses. I don't
> > want to focus or critique any specific vendor's downstream code
> > though. Providing these links just to prove that this is a real issue.
>
> The issue is not that I can't see that there might be a problem.  The
> issue I have is that you seem to be starting from the point of a
> specific solution that happens to work for your systems and then working
> back from that rather than reasoning forwards from the problem to come
> to a solution with the result that I can't explain the design you're
> proposing.

I'm sorry it comes across that way. That's certainly not my intention.
Hopefully, we can walk through this together and I'll make more sense.

> Even with this version I have difficulty telling from the
> changelog that the change doesn't restrict things based on the consumers
> of a given regulator but rather based on the PMIC and I don't see why
> this is being done.

Happy to copy-paste any commit text suggestions that make this clearer.

> > Search for "proxy" here. You'll notice how that will also need changes
> > to regulator header files, etc. The 4.9 kernel is the latest publicly
> > available version AFAIK.
> > https://source.codeaurora.org/quic/la/kernel/msm-4.9/plain/drivers/regulator/core.c?h=msm-4.9
>
> Oh, the Qualcomm stuff - which looks a lot like what you've got here.

Eh... I would disagree. The similarity stops at "both solutions use a
regulator consumer to set the limits". The implementation you see
there is based on QC specific DT entries, is based on late_initcall to
"ensure" all consumers have probed, doesn't work for modules, etc.

> > > As I indicated on my previous review this doesn't seem OK, given that a
> > > huge proportion of the regulators on most systems are part of a single
> > > PMIC this means that devices won't be able to fully control regulators
> > > for the majority of the boot process, possibly quite a long time after
> > > userspace has started in systems where not all devices have drivers.
>
> ...
>
> > I think the default behavior should be for functional correctness
> > (example in the commit text) and then go for optimization (being able
> > to power off regulators before 30s into boot). Even with the timeout
> > set, this series makes it much easier for driver developers to ensure
> > functional correctness instead of playing initcall chicken between the
> > supplier and the N consumers.
>
> I don't see how any of this stuff about initcall chicken or whatever is
> relevant here.  You're replying to my concern that your change isn't
> just waiting for all the consumers of a given regulator, it's waiting
> for every other consumer of any other regulator or random other feature
> that happens to be supplied by the same PMIC but only that PMIC.  That
> is not init ordering, it just seems like an arbitrary delay even once
> all the consumers are ready and I can't see any particular logic behind
> it.  It's not just waiting for all the users of the individual resource
> to be active but it's also not waiting for the system as a whole,
> instead it's waiting for some effectively random grouping of devices
> spread over the whole system to appear.  I can't articulate a reason why
> we'd do that, it seems to be combining the worst aspects of the two
> approaches.
>
> Please engage with this issue, it is crucial but you keep on sending the
> same thing without explaining why so I'm left guessing and I really
> can't come up with anything.

Ok, at the end of the email, I'll start from a high level and then dig
into more details at each step. Hopefully that'll clarify the reasoning.

[...]

> > > I don't understand the motivation for doing things this way.  Like I
> > > said last time it really feels like this turns the whole mechanism into
> > > a very complicated way of implementing a new initcall.
>
> > Treating this as a "LATER_initcall()" has several issues.
> > 1. initcall levels set a max limit on the depth of device dependency.
> > Since DT devices are added at arch initcall level, that gives us about
> > 5 levels if you ignore the _sync ones. Adding more isn't going to
> > scale or solve the problem because in reality, the dependencies are
> > much deeper.
>
> I don't follow what you're saying here at all, sorry.  What does the
> depth of the dependency graph have to do with how late we action
> anything?

You keep raising the point "why not just add another initcall level"
to solve the problem of "sync the suppliers after all the consumers
are ready". Or you say that my patch series is just a roundabout way
of adding another initcall level. I'm explaining why adding just
another initcall level won't work.

> A lot of what you're saying here seems to be based on jumping
> to abandoning deferred probe which is a bit of a leap here.

Again, definitely misunderstanding my point. I'm saying exactly the
opposite. We need to take deferred probe into account and deferred
probe completely invalidates any attempts to guarantee ordering based
on initcall levels. I even mentioned this in point 5 in my earlier
email.

> > 6. If the answer is, "have userspace tell us when all modules are
> > loaded" -- then we are depending on userspace for functional
> > correctness AND for turning off regulators. Which IMHO is worse than
> > this patch series.
>
> > 7. If we somehow manage to add a "LATER_initcall" that doesn't have
> > the issues above, it has to work for all frameworks. So, it has to
> > come after ALL the devices in the system have probed. Not just "all
> > devices of a supplier". So, again, it's worse than this patch series,
> > at least for systems where all the drivers are present.
>
> Run the initcall when all devices in the system have a driver bound

And how is this going to work in systems where some devices don't have
drivers? Even with one missing driver, none of the devices/drivers are
going to get this initcall that you suggest. So it makes the
granularity issue worse.

> which as far as I can tell seems to be what the end result of this
> series is intended to be anyway, just implemented with much more
> complexity.

No, with sync_state(), only suppliers to devices without drivers
wouldn't get the callback. Rest of the suppliers will get the callback
and can sync their state.

>  That doesn't need any involvement from userspace, though I
> can't see why we'd want to do that rather than just work per regulator.
>
> > > >    b. If the regulator is ON at boot, a BOOT-LIMITS consumer is created
> > > >       for the regulator and an enable vote is made.
>
> > > If something was left partially set up by the bootloader this means that
> > > drivers are no longer able to remove power from the device as part of
> > > getting it into a known good state even if they are the only consumer.
>
> > If they really NEED to turn power off to get to a known good state,
> > then they really need to be exclusive consumers.
>
> There's *need* to and there's can do on systems that can support the
> thing, the same driver will often be able to handle both situations.
> This also goes to a risk of regressions, it's a fairly major
> transformation to be doing.  These issues would be massively mitigated
> if this were per regulator as I have repeatedly suggested.

Even if you do per-regulator tracking, you can have one regulator
shared by many consumers and you'll still hit this issue. So, going to
a regulator level tracking doesn't solve this.

[ ... ]

> > To be clear, I understand the cases you are mentioning and I'm not
> > discounting them. But compared to the 30 seconds of additional "on
> > time", the functional correctness issues are more important. I'm not
> > saying this series is the perfect solution, but it's certainly better
> > than what we have now and we have the default behavior to be as least
> > disruptive as possible to systems that work fine without this series.
> > And if I find incremental improvements in the future, I'll send
> > patches for that. But I'd hate to see perfect be the enemy of the
> > good.
>
> Having the requests from drivers be acted on promptly is also a
> potential correctness and robustness issue.  You seem very focused on
> the disabling of unused regulators for power reasons case

The correctness issue I care about is not power consumption. It's
about not pulling the plug on or under volting an active device before
the driver can take control of it.

> but that's
> really not the only thing going on here, there's also just the need to
> control things as part of what the device is supposed to be doing.
> Systems aren't always built to let us do all the things we're really
> supposed to do with hardware so it's often advantageous to have drivers
> that will do these things but cope gracefully, this means that it
> doesn't always make sense to use exclusive gets even where you really
> actually want things to happen as requested if they can.  Often the
> devices are in practice robust enough most of the time things are fine
> if the requests get ignored which is why systems can be built that way
> but strictly we're not supposed to do that so where we can we should
> avoid it.  Forcing consumers to be exclusive means that we need to add a
> call that lets these consumers figure out which kind of get to use and
> then have the consumer have multiple code paths for that (or more
> realistically factor that out into the core, but then we could even more
> easily just not have the system wide restrictions).

This paragraph seems to be self contradictory to me. I don't
understand how you can claim the drivers handle it gracefully without
exclusive_get(), but then still say they can't handle a regulator
being on when they request for it to be off. They just need to handle
it gracefully for the first 30s of boot with my patch series. Only
when regulator_cleanup_timeout=-1 is set is there a potential for the
regulator to be kept on forever.

> There's also issues around being able to reason about what the system is
> supposed to do and why, hence my concerns about waiting for all devices
> on the PMIC to appear.  Like I said above this is absolutely crucial.

Ok, I'll try to explain the reasoning from the top.

Firstly, the problem being solved is not specific to regulators. It's
a general issue that needs to be solved for many frameworks/suppliers.
We want a mechanism for a supplier driver to know when all the
consumers are up and managing their resources so that the supplier
driver can do a clean handoff from bootloader to the kernel.

However, we don't want each framework doing very similar but slightly
different things. That creates inconsistencies across frameworks, code
repetition, maintenance headache, etc. In addition to that, it's also
very inefficient for every framework to be trying to figure out the
dependencies from firmware and tracking them separately.

Even if you just try to answer "are all the consumers ready?" at a
resource level (eg: at a regulator level), can't depend on get()/put()
APIs provided by frameworks. Some of the reasons:
1. A consumer might do "get()" and then end up deferring further down
the probe function. If that get() was the last get() you needed to
decide "all consumers are ready", and you remove the boot limits, then
the system could crash because the last consumer isn't actually ready.
2. Not all consumers do the "get()" in their probe functions. They
might do it later for multiple reasons.
3. Not all properties in the firmware are actually used/supported by
the driver. So, you can't assume all consumers referring to the
resource will actually call get() on it.

So, even if you track at a resource level, you need to check for the
consumer readiness by looking at the device bound state. fw_devlink
adds all the supplier-consumer dependencies by creating device links
(currently only DT is supported). So, tracking consumer device
readiness is easier.

So, say you have a callback that you get for every single consumer
binding successfully. What can you do there? For every consumer, you
have to parse their firmware (Eg: DT node) to see what all resources
they use (Eg: all the -supply properties) and increment the "consumer
ref count" for those resources (Eg: regulators). And this needs to be
done by every framework that manages suppliers.

Ok, now you have a "number of consumers ready" refcount per resource.
But to know if all the consumers of a resource are ready, you'll also
need the total number of consumers per resource. How do you find that
out?

Whatever scheme you use to count the total number of consumers, you
need to make sure you also take into account consumer devices that
have not been added yet. As in device_add() hasn't been done. For
example, child devices in DT that haven't been added yet because their
parent hasn't probed.

fw_devlink again helps avoid parsing the entire DT. It creates "proxy"
device links between a supplier device and the parent device of a
consumer if the consumer hasn't been added yet.

So, when the "a consumer has probed" callback comes, apart from what
you have to do already (tracking "number of consumers ready" at a
resource level), you also need to parse all the descendant nodes (not
just direct children) of that consumer's firmware node to check and
potentially increment the "total consumers" at a per resource (Eg:
regulator) level. Again, this will need to be done for every
framework.

And we still haven't dealt with the case where a consumer binds and
unbinds. Say a resource (Eg: regulator) has N consumers. Say, only M
(< N) consumers are ready/bound so far. Then one of the M consumers
unbinds and then binds again. So, your "consumers ready" refcount per
resource becomes M + 1 when only M consumers are ready. So, at a per
resource level you have to now also track "already seen" devices or
track device unbinding. And those "devices" themselves might vanish
and come back again (Eg: DT overlays, the dwc driver that adds/removes
child devices during probe, etc). I'm not even going to try and expand
on how each framework would handle this  -- it becomes very messy.

Also, even if we do resource level tracking, it doesn't solve the
problem of a consumer that expects regulator_disable() to turn off the
regulator even when it's not using get_exclusive(). For example, the
same regulator can have more than one consumer but the consumer that
needs exclusive behavior just happens to probe first and has full
control of the regulator. With boot limits applied at a regulator
level, it'll still prevent the regulator from being turned off.

So, long story short, tracking at a resource level:
1. Will be way more complicated than tracking at a consumer device level.
2. Will use a lot more memory.
3. Will use be a lot less efficient due to all the repeated parsing
and tracking you'll have to do.
4. Doesn't really solve the "need exclusive but doesn't use
get_exclusive()" consumer problem.

But then why not just do a "boot done" initcall/callback instead of
doing it based on supplier-consumers device level dependencies?

"boot done" can be done in a couple of ways:
1. Have userspace tell that it's done loading all the modules. This is
pretty much a no go as the kernel now depends on userspace for proper
functionality.
2. Timer, but this is a configuration nightmare and doesn't work reliably.
3. Wait till every single device has been bound to a driver. The
problem with this is that even if a single device is not bound to a
driver, the entire system would be stuck in a "boot not done yet"
mode. So any device left on by the boot loader would be permanently
stuck on and can't go to states that are incompatible with their state
at boot.

So this is basically a cost (complexity) vs benefit (system vs device
vs resource level removing of boot limits) problem.

Device level granularity provides the best bang for the buck.
Hopefully that clarifies the reasoning.

Would you consider this series if the boot limit is only set when
regulator_cleanup_timeout=-1 (as opposed to always)? Then the default
behavior will stay identical to before this series and only when
regulator_cleanup_timeout=-1 will any of this code kick in.

-Saravana
