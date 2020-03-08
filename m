Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC57C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276542072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 05:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHHUOnk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCHFyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 00:54:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34370 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgCHFyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 00:54:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id g6so6950860oiy.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 21:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9ON8bmBXCZPKPTRh41bNu9X5oSSEnKTuQ+AobW+P9o=;
        b=CHHUOnk5XzDePrB9oRPSqVmFi6d6ZEBioPf/iIkUxIIx5Qjm0tMl0yOVACKdMpo85s
         MwlLjKWLzlfDP7fzvtBafwHNDPLg4GpywQbbhm7aWZ/BSDfQpQa4VAI1n/OwQLSN8oVi
         SQJx59CRy2waJmvk397yLR/Gdz+Ym4dtmjTQOXhfEtL7UcdFZQeVsUe6nc2qDK+7QQPk
         +LRIS7DsIgQBO8Rh5yUJOoZSPmgZwsOuT+GPzCFNATkcwsNdh6+R6fRhZt4N5+cSk2vs
         xLo6xJcBOhWBuBl+wpnUoRkRIe1VU3rlQTxmVCSIkugQbTA4qj3u+urZdOnNmV/Qu/rH
         Te+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9ON8bmBXCZPKPTRh41bNu9X5oSSEnKTuQ+AobW+P9o=;
        b=XU+/AwkzoJLuvMyQnotVa57mA8jxj1lPZLMQF1bGmUBB/sI8SUyEMyc0uBSpnLXHii
         UCrtLdl2jRJLHeDWT+Idv8/Wb6EfqbIwDAqaTg62bLR7EVi2aM1D7cVN/YMQfxZcTWme
         neG42mk6zyeonmlvuj208/zYneXdMOF2nJULaJhwu3qcarKQgDB85v+GUT+hSAT6+CA6
         PdZ4C2ow7HJE01txzuOiaZDG50oD0/0b/X1wpWptm3DwG4kwd/txorW7kFdBKnMvoJCZ
         wZzci2eJ5MfiWufDuH/Oj4z7rTzFKx/25XwYaeouhsIHJ7dDJHVd2Y1xblIGCeiLgCxP
         2d3Q==
X-Gm-Message-State: ANhLgQ0zoWqxHAeHT8MYDY/8kHRfw/FAcJaKL4JiMfMCHt3jdnII6bFQ
        gwzaeH/op+sxWKPEZVuMfTWbhTCbN2+TJqkYNlVVpw==
X-Google-Smtp-Source: ADFU+vsSiPrgXUzi3BjsgPrFI4SlZs/1moyBdtWqpmMCDIbB3ym7Nc4FQwFKOPCzML0m+c8vV68avX0FDgoCWpa2Eus=
X-Received: by 2002:aca:5205:: with SMTP id g5mr7423044oib.43.1583646862859;
 Sat, 07 Mar 2020 21:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
 <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
 <CAGETcx_Y7TroxBGsD0ssG8X+iZawoMVnqVPbEOJwR2Wmv=0Kxw@mail.gmail.com> <814e5b06-dde9-f59a-735a-39d7e41efc67@linaro.org>
In-Reply-To: <814e5b06-dde9-f59a-735a-39d7e41efc67@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 7 Mar 2020 21:53:46 -0800
Message-ID: <CAGETcx9Nq7OQPNv5sha3Yy_QmPzP-32jjMVqaczbE4NkjdmWXA@mail.gmail.com>
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

On Wed, Mar 4, 2020 at 11:56 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 04/03/2020 20:30, Saravana Kannan wrote:
> > On Thu, Feb 27, 2020 at 1:22 PM Saravana Kannan <saravanak@google.com> wrote:
> >>
> >> On Thu, Feb 27, 2020 at 1:06 AM Daniel Lezcano
> >> <daniel.lezcano@linaro.org> wrote:
> >>>
> >>> On 11/01/2020 06:21, Saravana Kannan wrote:
> >>>> Timer initialization is done during early boot way before the driver
> >>>> core starts processing devices and drivers. Timers initialized during
> >>>> this early boot period don't really need or use a struct device.
> >>>>
> >>>> However, for timers represented as device tree nodes, the struct devices
> >>>> are still created and sit around unused and wasting memory. This change
> >>>> avoid this by marking the device tree nodes as "populated" if the
> >>>> corresponding timer is successfully initialized.
>
> TBH, I'm missing the rational with the explanation and the code. Can you
> elaborate or rephrase it?

Ok, let me start from the top.

When the kernel boots, timer_probe() is called (via time_init()) way
before any of the initcalls are called in do_initcalls().

In systems with CONFIG_OF, of_platform_default_populate_init() gets
called at arch_initcall_sync() level.
of_platform_default_populate_init() is what kicks off creating
platform devices from device nodes in DT. However, if the struct
device_node that corresponds to a device node in DT has OF_POPULATED
flag set, a platform device is NOT created for it (because it's
considered already "populated"/taken care of).

When a timer driver registers using TIMER_OF_DECLARE(), the driver's
init code is called from timer_probe() on the struct device_node that
corresponds to the timer device node. At this point the timer is
already "probed". If you don't mark this device node with
OF_POPULATED, at arch_initcall_sync() it's going to have a pointless
struct platform_device created that's just using up memory and
pointless.

So my patch sets the OF_POPULATED flag for all timer device_node's
that are successfully probed from timer_probe().

If a timer driver doesn't use TIMER_OF_DECLARE() and just registers as
a platform device, the driver init function won't be called from
timer_probe() and it's corresponding devices won't have OF_POPULATED
set in their device_node. So platform_devices will be created for them
and they'll probe as normal platform devices. This is why my change
doesn't break drivers/clocksource/ingenic-timer.c.

Btw, this is no different from what irqchip does with IRQCHIP_DECLARE.

Hope that clears it up.

Thanks,
Saravana
