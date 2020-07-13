Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB657C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB5D2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3ojp220"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgGMMDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgGMMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:03:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:03:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y18so8844376lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5KMHDUl0dP2/yxULAu5/b1d01e8D1X8yaqLPXL7OeY=;
        b=H3ojp220B2LkylmsATbkDKYAr9c9hzVaK8lhZCLxcDV3QcBMkL80V2xjQUHeAQu4ky
         PWfn+Md+nsxFTihVKzDV8rTq5f4ormyVJW+rU7RAeuJyAv4Hnn43qqztrTig1KEl7h7I
         pnpNN1yXLQsl+bXWAageYi1x2LeAIYT5Lo7aoYzJCC998Y/kA4Rgo1rLKWhI2XC/fAX8
         tbLdXDwe90hvOvzyPZnqkCra7xZR3M5Os1BimwS6Zh1XxeESLNXjAD3Zb8ftjXmr7l6c
         XOob7orM0tvlEoox2rDKGz20MBGTwumQ20xbUuqy5oMduu/LjxfdJUMNQouwAETRxG6V
         nI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5KMHDUl0dP2/yxULAu5/b1d01e8D1X8yaqLPXL7OeY=;
        b=sWynaTBS6+M0rKKdEFMkrV1YVIRIxAwQKIcPNT7v4bkn5Vc9FBLWwBoDAckQSJtCTt
         gly5kmFNpoGYxtbaHM11xnic/K00DupyJi4EZY1w/NbiQDHAshlRpXk2zi2BhcQlhZKW
         MjJx1eT3Q7rVKz9DbnXzz/6PExjfjJaG2bekRD7XQ6dMgeIf9yM3SXmXMbGqZNdz+VC2
         x0EfZALM8b9uBdLySZfuEOmM+SesBWqK4gxN3/NFOP2EWAcmN/XrXltnjOj6j1Z6lVLG
         HRoDzHlhtD608N6tpQHCGbP0skJA0D2iqnmmEGo3I5r1FqmBkvrOTrOO5bhYKHavGq1p
         q//Q==
X-Gm-Message-State: AOAM533+iTOqrFNwC/tbU5DFmSWUD7ytSU5aaSGpdClJRKRWUO88iTOz
        onNmDmh8O7wEVN7Al1lBYSqDa23VlVkbrHc6g22sTg==
X-Google-Smtp-Source: ABdhPJxeeTVOBjzNfFPpHLHGDWpCLW18lUobuuQt7/W9ElRbsNZuZOxfCtntGelZjeemcLqJCveTFhKFSh5BaKmul5M=
X-Received: by 2002:a19:7d84:: with SMTP id y126mr53124241lfc.149.1594641798626;
 Mon, 13 Jul 2020 05:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200712165917.9168-1-valentin.schneider@arm.com>
In-Reply-To: <20200712165917.9168-1-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 13 Jul 2020 14:03:06 +0200
Message-ID: <CAKfTPtCWEb=Dh12GSyYSG6nsqSciyDmcev62ntexXuFDtO_+ng@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] sched, arch_topology: Thermal pressure
 configuration cleanup
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jul 2020 at 18:59, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi folks,
>
> This stems from this thread [1] on the list. TL;DR: the thermal pressure config
> has no helpful documentation, and figuring out if the right dependencies are in
> place is not easy for a regular user.
>
> The current landscape also paints an odd picture: arch_set_thermal_pressure() is
> hardcoded in sched/core.c, and is *not* architecture-definable, while
> arch_get_thermal_pressure() is. Patch 1 is tackling this, the rest is Kconfig
> stuff.
>
> Cheers,
> Valentin
>
> [1]: https://lkml.kernel.org/r/20200603173150.GB1551@shell.armlinux.org.uk
>
> Revisions
> =========
>
> v1 -> v2
> --------
>
> o Remove cpufreq_cooling.c weak function; use #define stub in sched/topology.h
>   (Vincent)

Looks good to me.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> o Hinge arm SCHED_THERMAL_PRESSURE selection on ARM_CPU_TOPOLOGY
>
> Valentin Schneider (3):
>   arch_topology, sched/core: Cleanup thermal pressure definition
>   sched: Cleanup SCHED_THERMAL_PRESSURE kconfig entry
>   arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE
>
>  arch/arm/Kconfig                  |  1 +
>  arch/arm/include/asm/topology.h   |  3 ++-
>  arch/arm64/Kconfig                |  1 +
>  arch/arm64/include/asm/topology.h |  3 ++-
>  drivers/base/arch_topology.c      | 11 +++++++++++
>  include/linux/arch_topology.h     |  4 ++--
>  include/linux/sched/topology.h    |  7 +++++++
>  init/Kconfig                      | 15 ++++++++++++++-
>  kernel/sched/core.c               | 11 -----------
>  9 files changed, 40 insertions(+), 16 deletions(-)
>
> --
> 2.27.0
>
