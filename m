Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCCDC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfDk6GWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgCPRug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:50:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42242 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbgCPRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:50:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id 66so18751133otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukLdVJZhrkVH2j7+lwZVunJ+EzybKlA+GIqbEvUlCGg=;
        b=GfDk6GWjirANKlv6Goprvz7UWL3dqfcQ9D3iIeepgSifkNTvDgeUbp1t43T+bcU8RN
         aw9E6J69VltCwpEmmfKmQFAxDTdPp0N+h3tQRcWGbYpW+oRXRwHJ9n/XNIIhJJuFLnpC
         96ngLVLZpSY7nx1RXm5NwpLzY7ahS9+2Hld5TTuIUZJLSYOwXoQeF9cyPH1nM/I+HFC+
         6umAzRo11T4QGATytvAUxmtuNTKbTZWXwaZ0lrTWdMNJn0blMO2RwyN5K4v2cDaDJjn4
         r0NsQr2lbSP4WkbOqbhm7faBr3TPu+4ZYksjILfO35TWH+o7KjOCmCtS5dCZMniQV4U+
         g+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukLdVJZhrkVH2j7+lwZVunJ+EzybKlA+GIqbEvUlCGg=;
        b=UQNotX0EROP7hWqcmsBnzCVDLtMvfphzCtnj9JQBgICp3Qb7TqgZvqT+yJ4ZmNKTNc
         OzGHubRLua1oLvuj+LSu8lGhEz5OFEjR30ZnZPaKD9+yxzZgl0qgRVI5FqowoZDhdxOU
         PCb6fqwRc+zB2nk1vNqkUp1hhlD48OE0YBjVSm2yWzkgC/0M36EhUWU1cMQQW/gdAIT0
         HGatZbkEKJuOLy5lQCkRaEysYhwIOJsmWPUQvhtaRTiH5wv+5DvDHUhuSZRj5JPTcr7T
         /z14ShDUrhYtFyMtIf+RehgCaOUWXhN1Td9oDwSZzyIWPnXB+mg70H1pFm3Rnt+eKqAe
         eK7g==
X-Gm-Message-State: ANhLgQ3X+CFesHtpytTvfigD2cKCFW7zS8f4yvSH2OcUDEOWDASR+bKd
        measPyNrsX+I4b29keZsutu7qGRisP7TAMHwd0I1iA==
X-Google-Smtp-Source: ADFU+vsyICO8/Z0+2VdCwIxzl2M4Ky1e8pZ1VEi9ff9iuJfBU5V6iMcwCMbBcz69T5ndn0gR30VqKXpJMvRWCzDnIzU=
X-Received: by 2002:a9d:3b09:: with SMTP id z9mr335805otb.195.1584381034252;
 Mon, 16 Mar 2020 10:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
 <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
 <CAGETcx_Y7TroxBGsD0ssG8X+iZawoMVnqVPbEOJwR2Wmv=0Kxw@mail.gmail.com>
 <814e5b06-dde9-f59a-735a-39d7e41efc67@linaro.org> <CAGETcx9Nq7OQPNv5sha3Yy_QmPzP-32jjMVqaczbE4NkjdmWXA@mail.gmail.com>
 <897866cb-f059-d15f-62f5-9ee2688dded0@linaro.org>
In-Reply-To: <897866cb-f059-d15f-62f5-9ee2688dded0@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 16 Mar 2020 10:49:58 -0700
Message-ID: <CAGETcx-i5ows0bh_gRao5jV7GZtsNJ+0u8tC+w8E0YLxd7U94w@mail.gmail.com>
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

On Mon, Mar 16, 2020 at 7:57 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 08/03/2020 06:53, Saravana Kannan wrote:
> > On Wed, Mar 4, 2020 at 11:56 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 04/03/2020 20:30, Saravana Kannan wrote:
> >>> On Thu, Feb 27, 2020 at 1:22 PM Saravana Kannan <saravanak@google.com> wrote:
> >>>>
> >>>> On Thu, Feb 27, 2020 at 1:06 AM Daniel Lezcano
> >>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>
> >>>>> On 11/01/2020 06:21, Saravana Kannan wrote:
> >>>>>> Timer initialization is done during early boot way before the driver
> >>>>>> core starts processing devices and drivers. Timers initialized during
> >>>>>> this early boot period don't really need or use a struct device.
> >>>>>>
> >>>>>> However, for timers represented as device tree nodes, the struct devices
> >>>>>> are still created and sit around unused and wasting memory. This change
> >>>>>> avoid this by marking the device tree nodes as "populated" if the
> >>>>>> corresponding timer is successfully initialized.
> >>
> >> TBH, I'm missing the rational with the explanation and the code. Can you
> >> elaborate or rephrase it?
> >
> > Ok, let me start from the top.
> >
> > When the kernel boots, timer_probe() is called (via time_init()) way
> > before any of the initcalls are called in do_initcalls().
> >
> > In systems with CONFIG_OF, of_platform_default_populate_init() gets
> > called at arch_initcall_sync() level.
> > of_platform_default_populate_init() is what kicks off creating
> > platform devices from device nodes in DT. However, if the struct
> > device_node that corresponds to a device node in DT has OF_POPULATED
> > flag set, a platform device is NOT created for it (because it's
> > considered already "populated"/taken care of).
> >
> > When a timer driver registers using TIMER_OF_DECLARE(), the driver's
> > init code is called from timer_probe() on the struct device_node that
> > corresponds to the timer device node. At this point the timer is
> > already "probed". If you don't mark this device node with
> > OF_POPULATED, at arch_initcall_sync() it's going to have a pointless
> > struct platform_device created that's just using up memory and
> > pointless.
> >
> > So my patch sets the OF_POPULATED flag for all timer device_node's
> > that are successfully probed from timer_probe().
> >
> > If a timer driver doesn't use TIMER_OF_DECLARE() and just registers as
> > a platform device, the driver init function won't be called from
> > timer_probe() and it's corresponding devices won't have OF_POPULATED
> > set in their device_node. So platform_devices will be created for them
> > and they'll probe as normal platform devices. This is why my change
> > doesn't break drivers/clocksource/ingenic-timer.c.
> >
> > Btw, this is no different from what irqchip does with IRQCHIP_DECLARE.
> >
> > Hope that clears it up.
>
> Yes, thanks for the explanation.
>
> Why not just set the OF_POPULATED if the probe succeeds?
>
> Like:
>
> diff --git a/drivers/clocksource/timer-probe.c
> b/drivers/clocksource/timer-probe.c
> index ee9574da53c0..f290639ff824 100644
> --- a/drivers/clocksource/timer-probe.c
> +++ b/drivers/clocksource/timer-probe.c
> @@ -35,6 +35,7 @@ void __init timer_probe(void)
>                         continue;
>                 }
>
> +               of_node_set_flag(np, OF_POPULATED);
>                 timers++;
>         }
>
> instead of setting the flag and clearing it in case of failure?

Looking at IRQ framework which first did it the way you suggested and
then changed it to the way I did it, it looks like it allows for
drivers that need to split the initialization between early init (not
just error out, but init partly) and later driver probe. See [1].

Also, most of the other frameworks that set OF_POPULATED, set it
before calling the initialization function for the device. Maybe it's
to make sure the device node data "looks the same" whether a device is
initialized during early init or during normal device probe (since the
OF_POPULATED is set before the probe is called) -- i.e. have
OF_POPULATED  set before the device initialization code is actually
run?

Honestly I don't have a strong opinion either way, but I lean towards
following what IRQ does.

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/1470752332-14185-1-git-send-email-p.zabel@pengutronix.de/#t
