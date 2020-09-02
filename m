Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F93AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6478B20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jRf1QYgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIBU1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:27:11 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F524C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:27:11 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g11so123566ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWmT3vjuUdEMwfMnHyc0cmixYDNJqjLfuguq9ClY04A=;
        b=jRf1QYgPssAdK8qvMPyz7cGcLZLm0H52IGhklGJ/oOQX0v8KeriqnhG7iMWKxfQJiI
         J8D2ybRBqAEE+l7UvtWWTT2v+uW/KX0KgQM4EC2SktkyifkCdR6cwCjnJZMcx79NgIL7
         2rpLGx7B2Ib+gGjBx6G0Oxy+G2rENauHvqSkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWmT3vjuUdEMwfMnHyc0cmixYDNJqjLfuguq9ClY04A=;
        b=qJcWlNs4ZZ/HgJhLbvkjrAi/e8GRE+yd0AdpFVJSa2eKJOs1cPK6AULtRFJvnv6V7H
         OqZBEnsVvGEaFCAmwCpi3idhRNoomiVjwQ8O79NWzkfTUBWP+hpa77YQqBx/Jrx8IvkF
         VWn5PU3UPXgFV1UBI0hdYKsTyT7aKTvBAvDNqd8qdIyUFxDgB5JgH1GqGGITqxjfUVac
         D+uTCTrLznVT3+2qP72SgRF+Eq0aBavm9D2GaoNVVbexiwerML/sw+tB/9+FciIwqsN+
         l47Il1kOaJoM3D2kG1Fc60C2bdAdV9zqTGJf4XkEIQt2Q2OzV3DbgQQu4KEdpgZ4PNnQ
         2Nmg==
X-Gm-Message-State: AOAM5327u/t+G5kSHoRUeoU+T+Tzglf5zKMkFv3oDgYLGLt2TNFvQ2Mf
        OScLVkt2HRRtxjJM4OCOoSgGEVJpZ8yfLA==
X-Google-Smtp-Source: ABdhPJwZGgH4CNPkI7T1AwOMTwu6eRwnEjY9hMRL1BQSP6pwf7stNIrpjoQn9/gKO5kBh7xNx9nNNA==
X-Received: by 2002:a9f:26a5:: with SMTP id 34mr137313uay.67.1599078430044;
        Wed, 02 Sep 2020 13:27:10 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id d193sm80037vsc.30.2020.09.02.13.27.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 13:27:08 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id b123so434093vsd.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:27:08 -0700 (PDT)
X-Received: by 2002:a67:2ec9:: with SMTP id u192mr84624vsu.188.1599078427919;
 Wed, 02 Sep 2020 13:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org>
 <1598113021-4149-4-git-send-email-mkshah@codeaurora.org> <159835036999.334488.14725849347753031927@swboyd.mtv.corp.google.com>
 <874koqxv6t.fsf@nanos.tec.linutronix.de> <8763521f-b121-877a-1d59-5f969dd75e51@codeaurora.org>
 <87y2m1vhkm.fsf@nanos.tec.linutronix.de> <CAD=FV=XXf3_tjqK14WdMuKygJptMTS+bKhH_ceiUE3wyYoCnxg@mail.gmail.com>
 <877dtdj042.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877dtdj042.fsf@nanos.tec.linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Sep 2020 13:26:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ua7fLGw6JiG1rnCKpAdO1nXX4A4x1Why-LE9L_FBFe8Q@mail.gmail.com>
Message-ID: <CAD=FV=Ua7fLGw6JiG1rnCKpAdO1nXX4A4x1Why-LE9L_FBFe8Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] genirq/PM: Introduce IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND
 flag
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        LinusW <linus.walleij@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 1, 2020 at 2:51 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Aug 31 2020 at 08:12, Doug Anderson wrote:
> > On Wed, Aug 26, 2020 at 3:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> There are two reasonable choices here:
> >>
> >> 1) Do the symmetric thing
> >>
> >> 2) Let the drivers call a new function disable_wakeup_irq_for_suspend()
> >>    which marks the interrupt to be enabled from the core on suspend and
> >>    remove the enable call on the resume callback of the driver.
> >>
> >>    Then you don't need the resume part in the core and state still is
> >>    consistent.
> >>
> >> I'm leaning towards #2 because that makes a lot of sense.
> >
> > IIUC, #2 requires that we change existing drivers that are currently
> > using disable_irq() + enable_irq_wake(), right?  Presumably, if we're
> > going to do #2, we should declare that what drivers used to do is now
> > considered illegal, right?  Perhaps we could detect that and throw a
> > warning so that they know that they need to change to use the new
> > disable_wakeup_irq_for_suspend() API.  Otherwise these drivers will
> > work fine on some systems (like they always have) but will fail in
> > weird corner cases for systems that are relying on drivers to call
> > disable_wakeup_irq_for_suspend().  That doesn't sound super great to
> > me...
>
> Hmm. With disable_irq() + enable_irq_wake() in the driver suspend path
> the driver already makes an implicit assumption about the underlying irq
> chip functionality, i.e. it expects that even with the interrupt
> disabled the irq chip can wake up the system.
>
> Now with the new flag magic and #1 we are just working around the driver
> assumptions at the interrupt chip level.
>
> That's inconsistent at best.

Sure, though I will say that it works on all Chromebooks we've shipped
over the last ~9 years since the main cros_ec (EC = embedded
controller) driver does this.  Of course, it's easy to just change
that driver.  I just don't want everything else breaking too.


> How many drivers are doing that sequence?

I remember looking this up before but can't find it.  It's gonna be
hard to get an exact count without fancier searching, but we should be
able to find a few...  I'll just do the simple:

git grep -C10 enable_irq_wake | grep -C10 'disable_irq('

That might miss people but it'll catch quite a few.  Ones that are
clearly using something like this:

drivers/input/keyboard/adp5588-keys.c
drivers/input/keyboard/adp5589-keys.c
drivers/input/mouse/elan_i2c_core.c
drivers/input/rmi4/rmi_driver.c
drivers/input/touchscreen/elants_i2c.c
drivers/input/touchscreen/raydium_i2c_ts.c
drivers/mfd/as3722.c
drivers/mfd/max14577.c (*)
drivers/mfd/max77693.c
drivers/mfd/max77843.c
drivers/mfd/sec-core.c (*)
drivers/mfd/twl6030-irq.c
drivers/platform/chrome/cros_ec.c
drivers/power/supply/max17042_battery.c
drivers/rtc/rtc-st-lpc.c

(*) Even has a comment explaining why!

Input is perhaps over-represented but presumably that's because input
is often the thing that wakes devices up.  ;-)


> And the more important
> question is why are they calling disable_irq() in the first place if
> they want to be woken up by that interrupt.

I tried to put my thoughts back in:

https://lore.kernel.org/r/CAD=FV=WN4R1tS47ZzdZa_hsbvLifwnv6rgETVaiea0+QSZmiOw@mail.gmail.com/

...but that was a long thread.  Copied the relevant bits here.
Basically a driver that calls disablre_irq() together with
enable_irq_wake() is trying to say:

* Don't call the interrupt handler for this interrupt until I call
enable_irq() but keep tracking it (either in hardware or in software).
Specifically it's a requirement that if the interrupt fires one or
more times while masked the interrupt handler should be called as soon
as enable_irq() is called.

* If this interrupt fires while the system is suspended then please
wake the system up.

Specifically I think it gets back to the idea that, from a device
driver's point of view, there isn't a separate concept of disabling an
IRQ (turn it off and stop tracking it) and masking an IRQ (keep track
of it but don't call my handler until I unmask).  As I understand it
drivers expect that the disable_irq() call is actually a mask and that
an IRQ is never fully disabled unless released by the driver.  It is a
little unfortunate (IMO) that the function is called disable_irq() but
as far as I understand that's historical.


> The point is that the core suspend code disables all interrupts which
> are not marked as wakeup enabled automatically and reenables them after
> resume. So why would any driver invoke disable_irq() in the suspend
> function at all? Historical raisins?

One case I can imagine: pretend that there are two power rails
controlling a device.  One power rail controls the communication
channel between the CPU and the peripheral and the other power rail
controls whether the peripheral is on.  At suspend time we want to
keep the peripheral on but we can shut down the power to the
communication channel.

One way you could do this is at suspend time:
  disable_irq()
  turn_off_comm_power()
  enable_irq_wake()

You'd do the disable_irq() (AKA mask your interrupt) because you'd
really want to make sure that your handler isn't called after you
turned off the communication power.  You want to leave the interrupt
pending/masked until you are able to turn the communications channel
back on and then you can query why the wakeup happened.

Now, admittedly, you could redesign the above driver to work any
number of different ways.  Maybe you could use the "noirq" suspend to
turn off your comm power or maybe you could come up with another
solution.  However, since the above has always worked and is quite
simple I guess that's what drivers use?


-Doug
