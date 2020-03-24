Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E5EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628162076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tu1JdwQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCXSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:35:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39763 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgCXSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:34:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id d63so19449850oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+Hf8XQxqxY4UfHSF//33kZkuadjj3xwWyydBPLRU5U=;
        b=Tu1JdwQ2ug4UNUaYvLMTsqfF50ZqUF2Zq21MBnDvVPiDVLZJxDPWTdZlxQOUSPhoh9
         6Jw0aHVgkxitN+wWRfKODDessLeaOPzM0DD25QjBUWzD21RjrogHgfJO+JKATvLKXWCd
         wnXnAnWkSm/mzGj8V/e7sefJdZH0s42WUgG5iYRtr/2Nr1eu3FWJe55K3RYa0Tj+g8pZ
         jPG4xFi+O4kWv+4DWaSR5fTt80JcniMoXc73MgQwUp03aDhrM34OMeeA+Yolcl8ca2w/
         Y167PfUD7DM+Nou1MBAfs3W9p1KUtVkExWkaYigxvz3rnvn7ZMEKdFC0B2FD7YMWJqmw
         +7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+Hf8XQxqxY4UfHSF//33kZkuadjj3xwWyydBPLRU5U=;
        b=p3hM9ivb9awo5mDdelw8U0QJOixj+DC9NHtHWUYB7IiG7FO3RJVWOoV55lyP1uPsM/
         /PY4cO2wDQg1cW0DVJiXZSRz0O/r/NnPhMVRlc1gmVUjTGynhyaPAidcXerivGYJXDXk
         1jhkoQg4lHWlsvT+ZUivV936nZXOf0erQ8PciyIJgc1gPC6nuTwVke7uid/9IL8emA0s
         O1G7PrrRsmM1bauznGE+ikG1Nyhr6FCpfy/0CS7i/SXImVlLiKaTj+32Wpg+tnKijEaw
         YyjhcVNRaDcT8cko4p/aH1K5me9cQGxCwKHmKIpWVZTGFD/3rWr6JQ7XFOfbWlJI7OHe
         hSag==
X-Gm-Message-State: ANhLgQ3e65hTJQnLfRtul/2XpjvFuFRAqfSyF5lLAZcVaXypez4w8bYH
        3qsuJ+gXNP1Pj/l3/7CyUaWp26CKM5Dtl8tn2ju7/A==
X-Google-Smtp-Source: ADFU+vt6tmJQI0f/riGMP7yFFDAaiOxqgRHsZVGg2HbVdrRbhCCg32XOxx+h+nAXwGT1IB5KqZ0CXoNIS6alpG1HzgI=
X-Received: by 2002:aca:682:: with SMTP id 124mr4539925oig.69.1585074896515;
 Tue, 24 Mar 2020 11:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com>
In-Reply-To: <20200324175955.GA16972@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Mar 2020 11:34:20 -0700
Message-ID: <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:00 AM Ionela Voinescu
<ionela.voinescu@arm.com> wrote:
>
> Hi guys,
>
> On Thursday 19 Mar 2020 at 08:47:46 (-0000), tip-bot2 for Saravana Kannan wrote:
> > The following commit has been merged into the timers/core branch of tip:
> >
> > Commit-ID:     4f41fe386a94639cd9a1831298d4f85db5662f1e
> > Gitweb:        https://git.kernel.org/tip/4f41fe386a94639cd9a1831298d4f85db5662f1e
> > Author:        Saravana Kannan <saravanak@google.com>
> > AuthorDate:    Fri, 10 Jan 2020 21:21:25 -08:00
> > Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
> > CommitterDate: Tue, 17 Mar 2020 13:10:07 +01:00
> >
> > clocksource/drivers/timer-probe: Avoid creating dead devices
> >
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
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Link: https://lore.kernel.org/r/20200111052125.238212-1-saravanak@google.com
> > ---
> >  drivers/clocksource/timer-probe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> > index ee9574d..a10f28d 100644
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
> >                       if (ret != -EPROBE_DEFER)
> >                               pr_err("Failed to initialize '%pOF': %d\n", np,
> >                                      ret);
> >
>
> This patch is creating problems on some vexpress platforms - ones that
> are using CLKSRC_VERSATILE (drivers/clocksource/timer-versatile.c).
> I noticed issues on TC2 and FVPs (fixed virtual platforms) starting with
> next-20200318 and still reproducible with next-20200323.
>
> It seems the issue this patch causes on TC2 and FVP is related to the
> vexpress-sysreg node being used early for sched_clock_init
> (timer_versatile.c: versatile_sched_clock_init). At this point (at
> time_init) the node will be marked as OF_POPULATED, which flags that a
> device is already created for it, but it is not, in this case.
>
> Later at sysreg_init (vexpress-sysreg.c) a device will fail to be created
> for it, as one already exists. This will result in a failure to create a
> bridge and a system controller for a bunch of devices (mostly clocks and
> regulators).
>
> I think on the FVP it does not cause many issues as clocks are fixed and
> regulator settings are probably nops so it boots fine and throws only
> some warnings. On TC2 on the other hand it fails to boot and it hangs at
> starting the kernel.
>
> In my opinion the idea of the patch is not bad, but I'm not an expert on
> this so the most I can offer for now is the basic understanding of the
> issue. I've Cc-ed a few folks to potentially suggest alternatives/fixes.
>
> For now, reverting this patch solves the problems on both platforms.
> I tested this on next-20200318 which introduced the problem.

I'll reply later today after I take a closer look. But will something
like what timer-ingenic.c did work for you? You can clear the flag
inside your early init.

-Saravana


>
> Hope it helps,
> Ionela.
