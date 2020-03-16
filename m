Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59335C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D61D20409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLEuIfOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgCPSQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:16:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34266 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732194AbgCPSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:16:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so18847562otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AytcRsQb8rnc1tl9ddb2MP4tgLvFwGB2+hxhfru9Cws=;
        b=oLEuIfOTUjg8X+ZOjbmvIjKtzMDs//2tPcvihxea4bsn98fOVWn0AxXjAmcl84ESO0
         0KB9aOBcCAdhZIWiSRfl1DiUb25XuH5iTSJLLQLQEMDTMz4oaPxTNCew5Uthg5f0jIMO
         BBCvZc4a/gkbWPqUxZ2hkDUEx6AUXBBBSlYg7tcLF6yzQqpPNgaPf5DqE/q+WropkeEi
         FBkXNIpCSSjYxWEwMdw7SSnp+QVpg6SryYBjVI9wvjN6eF9bSi9RPgDFLc7BT+T83ExU
         Iy3QjjEHrPhs5izEtzX8O6jPTsfL/uDkr+0zPWr3sU1p8TYJ2v2zLWMcVafbkeRYbaII
         azpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AytcRsQb8rnc1tl9ddb2MP4tgLvFwGB2+hxhfru9Cws=;
        b=mnRRBgGPg2HYyZeRfa0ta9Uqb09bX4epXb8AsVRVDcT3K0tt1PmNVwMneBN5Oq+T3J
         vV0vxo8AYRFW8wonoyHzLtD+Hm+Fr7DMlaKRywKdxXtM025G//OLAiLJK+oy0J/Sdj+d
         tvgBmlD+OlvxADzY4/PNq8xDAGuopp5XyPehcEUhPWUSItv1XpnlOFlBU8r8HgibG3IK
         CHRtWWSEJm4pwNSGnGHJrX2siiKPy3DNXsg5O+SeF/5Smo9n8IoAaevIvS6e+GJWdkPP
         FmNg4tTpTJ0sD9xocmyivQ/j6UjfGuadM4kGgDSz4BvZD/U/0Aj3FOyMDgPazwErZhUO
         tweA==
X-Gm-Message-State: ANhLgQ1zPeQx1/d50sT1hY+b4V1mOnoxnT3peLf4Vp7U9wacIfDObP7r
        JvSfSkHHts9KqM+0H9Ve6U+AsrKYownlmODmLBSowg==
X-Google-Smtp-Source: ADFU+vs+CDTEDD/dMiiLalF1gofIsXSEm1H+NkYNI/ASvxqUQqvo8uiHyCmz0h9AZd7BU/LBHr1J5ovLnsgzUG7sthw=
X-Received: by 2002:a9d:1eea:: with SMTP id n97mr439851otn.139.1584382581256;
 Mon, 16 Mar 2020 11:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
 <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
 <CAGETcx_Y7TroxBGsD0ssG8X+iZawoMVnqVPbEOJwR2Wmv=0Kxw@mail.gmail.com>
 <814e5b06-dde9-f59a-735a-39d7e41efc67@linaro.org> <CAGETcx9Nq7OQPNv5sha3Yy_QmPzP-32jjMVqaczbE4NkjdmWXA@mail.gmail.com>
 <897866cb-f059-d15f-62f5-9ee2688dded0@linaro.org> <CAGETcx-i5ows0bh_gRao5jV7GZtsNJ+0u8tC+w8E0YLxd7U94w@mail.gmail.com>
 <73509a5b-7bb2-fae5-9bd1-cb809a5b67e8@linaro.org>
In-Reply-To: <73509a5b-7bb2-fae5-9bd1-cb809a5b67e8@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 16 Mar 2020 11:15:45 -0700
Message-ID: <CAGETcx-UAjWhtDMoTaLX-2HwXWq-3aAi9FcwszEJ1-YKcekqmQ@mail.gmail.com>
Subject: Re: [PATCH v1] clocksource: Avoid creating dead devices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:07 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 16/03/2020 18:49, Saravana Kannan wrote:
> > On Mon, Mar 16, 2020 at 7:57 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 08/03/2020 06:53, Saravana Kannan wrote:
> >>> On Wed, Mar 4, 2020 at 11:56 AM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 04/03/2020 20:30, Saravana Kannan wrote:
> >>>>> On Thu, Feb 27, 2020 at 1:22 PM Saravana Kannan <saravanak@google.c=
om> wrote:
> >>>>>>
> >>>>>> On Thu, Feb 27, 2020 at 1:06 AM Daniel Lezcano
> >>>>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>>>
> >>>>>>> On 11/01/2020 06:21, Saravana Kannan wrote:
> >>>>>>>> Timer initialization is done during early boot way before the dr=
iver
> >>>>>>>> core starts processing devices and drivers. Timers initialized d=
uring
> >>>>>>>> this early boot period don't really need or use a struct device.
> >>>>>>>>
> >>>>>>>> However, for timers represented as device tree nodes, the struct=
 devices
> >>>>>>>> are still created and sit around unused and wasting memory. This=
 change
> >>>>>>>> avoid this by marking the device tree nodes as "populated" if th=
e
> >>>>>>>> corresponding timer is successfully initialized.
> >>>>
> >>>> TBH, I'm missing the rational with the explanation and the code. Can=
 you
> >>>> elaborate or rephrase it?
> >>>
> >>> Ok, let me start from the top.
> >>>
> >>> When the kernel boots, timer_probe() is called (via time_init()) way
> >>> before any of the initcalls are called in do_initcalls().
> >>>
> >>> In systems with CONFIG_OF, of_platform_default_populate_init() gets
> >>> called at arch_initcall_sync() level.
> >>> of_platform_default_populate_init() is what kicks off creating
> >>> platform devices from device nodes in DT. However, if the struct
> >>> device_node that corresponds to a device node in DT has OF_POPULATED
> >>> flag set, a platform device is NOT created for it (because it's
> >>> considered already "populated"/taken care of).
> >>>
> >>> When a timer driver registers using TIMER_OF_DECLARE(), the driver's
> >>> init code is called from timer_probe() on the struct device_node that
> >>> corresponds to the timer device node. At this point the timer is
> >>> already "probed". If you don't mark this device node with
> >>> OF_POPULATED, at arch_initcall_sync() it's going to have a pointless
> >>> struct platform_device created that's just using up memory and
> >>> pointless.
> >>>
> >>> So my patch sets the OF_POPULATED flag for all timer device_node's
> >>> that are successfully probed from timer_probe().
> >>>
> >>> If a timer driver doesn't use TIMER_OF_DECLARE() and just registers a=
s
> >>> a platform device, the driver init function won't be called from
> >>> timer_probe() and it's corresponding devices won't have OF_POPULATED
> >>> set in their device_node. So platform_devices will be created for the=
m
> >>> and they'll probe as normal platform devices. This is why my change
> >>> doesn't break drivers/clocksource/ingenic-timer.c.
> >>>
> >>> Btw, this is no different from what irqchip does with IRQCHIP_DECLARE=
.
> >>>
> >>> Hope that clears it up.
> >>
> >> Yes, thanks for the explanation.
> >>
> >> Why not just set the OF_POPULATED if the probe succeeds?
> >>
> >> Like:
> >>
> >> diff --git a/drivers/clocksource/timer-probe.c
> >> b/drivers/clocksource/timer-probe.c
> >> index ee9574da53c0..f290639ff824 100644
> >> --- a/drivers/clocksource/timer-probe.c
> >> +++ b/drivers/clocksource/timer-probe.c
> >> @@ -35,6 +35,7 @@ void __init timer_probe(void)
> >>                         continue;
> >>                 }
> >>
> >> +               of_node_set_flag(np, OF_POPULATED);
> >>                 timers++;
> >>         }
> >>
> >> instead of setting the flag and clearing it in case of failure?
> >
> > Looking at IRQ framework which first did it the way you suggested and
> > then changed it to the way I did it, it looks like it allows for
> > drivers that need to split the initialization between early init (not
> > just error out, but init partly) and later driver probe. See [1].
> >
> > Also, most of the other frameworks that set OF_POPULATED, set it
> > before calling the initialization function for the device. Maybe it's
> > to make sure the device node data "looks the same" whether a device is
> > initialized during early init or during normal device probe (since the
> > OF_POPULATED is set before the probe is called) -- i.e. have
> > OF_POPULATED  set before the device initialization code is actually
> > run?
> >
> > Honestly I don't have a strong opinion either way, but I lean towards
> > following what IRQ does.
>
> Thanks for the pointer. Indeed it is to catch situation where the driver
> is clearing the flag like:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clocksource/ingenic-timer.c#n245
>
> But I'm not able to figure out why it is cleared here :/

I think I know what's going on. He wants to implement PM support for
this timer. But PM support is tied to devices. So, clearing out the
flag allows creating the device which then hooks into PM ops.

Although, it looks like the driver assumes the timer framework was
setting the OF_POPULATED flag.

-Saravana

>
> Paul?
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
