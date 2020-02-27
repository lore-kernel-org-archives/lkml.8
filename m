Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF0C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E685246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajr39xau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgB0VWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:22:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38644 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0VWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:22:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so614528oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSzBosJ2jECtQLptDHrVs0XcQVa7YuC2vUon7qm+Kbs=;
        b=ajr39xauztgS+hpOCpoFbqgrt1KfRm5qMyVy1aN0iJtobtaaNY7UXmccgUOSYZ7S82
         bVOKNBuZHLcRdy9DsQWsU4GTlH4/gKcz2AzLYSOHkCZWswWS/6EKne3dfGgFqeQ3uIlb
         XaWKrM/X7vx/8MmRToZoWWs1jr7nmpMNYkndQ2mVEppgCB67XczjPGzlq7VL5vZ+XvXG
         JEp82adKDEBY2jS1OaaXcThy3gfiYp7Fg+yWmr/X1KsPi8OSTkz0aQaMGfXnqMk0YzVF
         qdscMPm5grBtNHFwwnxJYpWTKiW+A7LGZtv9Ar+lHrxSfJYLSaUgPzFj99KQflSSZT2C
         zZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSzBosJ2jECtQLptDHrVs0XcQVa7YuC2vUon7qm+Kbs=;
        b=OLkTrCp6Bpw70D5xeOkWuIC448pIBxkAr/o+YLKIngR/JIDngVK658TawMm6SefjDW
         /zHFXW1uWATg16rmMW6HpODTIadt+e04FpjsjUT9lGsncphu5WFJO5U4IK6/tpJ1BxXy
         156Gj63ovUDsLt6/ynhdJ7dHOMh3DFuAsj9CmXEaAE5E45vmOddPvLk5LnRF910OGuuf
         Wnp3uqwd5Z4yz+qItx5/HF4tI7iNZUx6hCw9ZJbPkEl8ilD6XknwXcXs3lZf3TLpWnGR
         EcrV8XVSU2q3AWeN2tr0dHXBJtMdWa6liy3IsfFXDJyZsOo8w6A8U1nyIFwiqrnp8KFo
         2Y/w==
X-Gm-Message-State: APjAAAXezPsByahhLLs/X5fqlLVuMciBHL0WPBDMA31N74Ce/jQSNuRQ
        jDVygm6XsNPWOg6LSwoXpm5Mh+ezpBto575s5TN1kA==
X-Google-Smtp-Source: APXvYqwQH6cvc0zJ40Q8xmCoRJ2s4dCLye2zm7MT1Vw8CD8tNXmuhBZnoS/WqN2NA1k2HrH4VTBcnR9XtoaXjJ/twhE=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr729353otq.231.1582838569643;
 Thu, 27 Feb 2020 13:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
In-Reply-To: <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 27 Feb 2020 13:22:13 -0800
Message-ID: <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
Subject: Re: [PATCH v1] clocksource: Avoid creating dead devices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 1:06 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/01/2020 06:21, Saravana Kannan wrote:
> > Timer initialization is done during early boot way before the driver
> > core starts processing devices and drivers. Timers initialized during
> > this early boot period don't really need or use a struct device.
> >
> > However, for timers represented as device tree nodes, the struct devices
> > are still created and sit around unused and wasting memory. This change
> > avoid this by marking the device tree nodes as "populated" if the
> > corresponding timer is successfully initialized.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/clocksource/timer-probe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> > index ee9574da53c0..a10f28d750a9 100644
> > --- a/drivers/clocksource/timer-probe.c
> > +++ b/drivers/clocksource/timer-probe.c
> > @@ -27,8 +27,10 @@ void __init timer_probe(void)
> >
> >               init_func_ret = match->data;
> >
> > +             of_node_set_flag(np, OF_POPULATED);
> >               ret = init_func_ret(np);
> >               if (ret) {
> > +                     of_node_clear_flag(np, OF_POPULATED);
>
> Isn't it in conflict with:
>
> drivers/clocksource/ingenic-timer.c
>
> ?

No, it won't interfere with that driver because:
1. This flag is getting set only if the driver already registered a
timer init function using TIMER_OF_DECLARE.
2. And if the function fails, we clear the flag.

So in the case of ingenic-timer, the device will still be there and be
probed by the driver.

My next step was going to be sending patches that'll actually allow
compiling timer drivers as modules.

Thanks,
Saravana
