Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E29BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F98220768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/VMdU+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbgFXJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbgFXJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:00:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64266C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:00:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so1737434lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEq8aoWf7DDgO6yWt+tqmsLUbeY8nM58bRX+rO+CdzU=;
        b=M/VMdU+/Rwv6tpDepjVbdIbBpTq9QQDMbSHjVa1lOlkkglEW6NWrYNDEeOt9UWfop7
         /OvWaOLZjvJvTEuEOdIOMQBJcCGNq6BOs8AVCpjl84aeBTiSrNP350e9UTCPa43+C0Z8
         Lu7KS0nWmQTb9yawScRbIQl/0yb25FjWGhA+jg4MOkC1JRsq1ksQO69DM9cTnai9yp0U
         jN8URtdNssz562PIg4VG3ADMqJ59HXXanPFeqbXFd84/QSmzJXDq7BSel15Th0AIHXXz
         88y8Z19BbVWw4gG6r454wTH5gyVVy5Svfj+xFO7oZn+LM8IE/DWspWc7b3CrTdvbMKid
         kFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEq8aoWf7DDgO6yWt+tqmsLUbeY8nM58bRX+rO+CdzU=;
        b=mYMF6lYMo0285xzaaRXAB+Vyyvvq/WNAW69W9oA1MAncRhYU44RWhAbaHYeI+WM9a+
         shtzdLc+CwIo9CAE7nt0GUVMHoF2+zLohXKqC3Gxdxfkd5JvJ0QXOV8kVbh934u6W67D
         QwpyQW0n4H/+8G9hp8NXeE68pPPL2QBfavv9A0gfkKThrxWQ0jA3W3LuuUboNbm2bgse
         unBPZstYd7HZLAecE3Lw1VJHDbFCF+65KJa5i5ELj7nUkVqwxKP43t/BqQt5IdeuuEXi
         yh43oCRE32VrZmEd8MesM7huDw/zO/8w2y9cA+J9kLFBCUqaj/DF1QyFjiKv17ixkZGO
         GeWw==
X-Gm-Message-State: AOAM530q794IST8/pzRH4cFCyWM2Hoe/mudliP6iRDll/fgyrztN9krt
        qcyxk2eZIZ2vWhqN87zNCqz9attQ/NODy53J4TOCog==
X-Google-Smtp-Source: ABdhPJwEjSQsdLSGPIUG69d3EmaZG4MOJKHJMEGYJK8XrgLZPA22eRuqQCd9nkS0WncngUQkIvm1CM5G/g+bmdyvXsM=
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr14254641ljp.226.1592989217706;
 Wed, 24 Jun 2020 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200619172011.5810-1-qais.yousef@arm.com> <6c1a6003-8f51-dadc-53e4-a2fa034dbe36@arm.com>
In-Reply-To: <6c1a6003-8f51-dadc-53e4-a2fa034dbe36@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Jun 2020 11:00:06 +0200
Message-ID: <CAKfTPtDh+D9AdzcsjYuv8LmtWag2MaHx7Ysrxb7JQittKa_K0A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sched: Optionally skip uclamp logic in fast path
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 19:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 19/06/2020 19:20, Qais Yousef wrote> This series attempts to address the report that uclamp logic could be expensive
> > sometimes and shows a regression in netperf UDP_STREAM under certain
> > conditions.
> >
> > The first patch is a fix for how struct uclamp_rq is initialized which is
> > required by the 2nd patch which contains the real 'fix'.
> >
> > Worth noting that the root cause of the overhead is believed to be system
> > specific or related to potential certain code/data layout issues, leading to
> > worse I/D $ performance.
> >
> > Different systems exhibited different behaviors and the regression did
> > disappear in certain kernel version while attempting to reporoduce.
> >
> > More info can be found here:
> >
> > https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/
> >
> > Having the static key seemed the best thing to do to ensure the effect of
> > uclamp is minimized for kernels that compile it in but don't have a userspace
> > that uses it, which will allow distros to distribute uclamp capable kernels by
> > default without having to compromise on performance for some systems that could
> > be affected.
>
> My test data indicates that the static key w/o any uclamp users (3)
> brings the performance number for the 'perf bench sched pipe'
> workload back (i.e. from w/ !CONFIG_UCLAMP_TASK) (1).
>
> platform:
>
>     Arm64 Hikey960 (only little CPUs [0-3]), no CPUidle,
>     performance CPUfreq governor
>
> workload:
>
>     perf stat -n -r 20 -- perf bench sched pipe -T -l 100000
>
>
> (A) *** Performance results ***
>
> (1) tip/sched/core
>     # CONFIG_UCLAMP_TASK is not set
>
>     *1.39285* +- 0.00191 seconds time elapsed  ( +-  0.14% )
>
> (2) tip/sched/core
>     CONFIG_UCLAMP_TASK=y
>
>     *1.42877* +- 0.00181 seconds time elapsed  ( +-  0.13% )
>
> (3) tip/sched/core + opt_skip_uclamp_v2
>     CONFIG_UCLAMP_TASK=y
>
>     *1.38833* +- 0.00291 seconds time elapsed  ( +-  0.21% )
>
> (4) tip/sched/core + opt_skip_uclamp_v2
>     CONFIG_UCLAMP_TASK=y
>     echo 512 > /proc/sys/kernel/sched_util_clamp_min (enable uclamp)
>
>     *1.42062* +- 0.00238 seconds time elapsed  ( +-  0.17% )
>
>
> (B) *** Profiling on CPU0 and CPU1  ***
>
>     (further hp'ing out CPU2 and CPU3 to get consistent hit numbers)
>
> (1)
>
> CPU0:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1997346    2207642 us      *1.105* us      0.033 us
>        activate_task    1997391    1840057 us      *0.921* us      0.054 us
>
> CPU1:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1997455    2225960 us      1.114 us        0.034 us
>        activate_task    1997410    1842603 us      0.922 us        0.052 us
>
> (2)
>
> CPU0:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1998538    2419719 us      *1.210* us      0.061 us
>        activate_task    1997119    1960401 us      *0.981* us      0.034 us
>
> CPU1:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1996597    2400760 us      1.202 us        0.059 us
>        activate_task    1998016    1985013 us      0.993 us        0.028 us
>
> (3)
>
> CPU0:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1997525    2155416 us      *1.079* us      0.020 us
>        activate_task    1997874    1899002 us      *0.950* us      0.044 us
>
> CPU1:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1997935    2118648 us      1.060 us        0.017 us
>        activate_task    1997586    1895162 us      0.948 us        0.044 us
>
> (4)
>
> CPU0:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1998246    2428121 us      *1.215* us      0.062 us
>        activate_task    1998252    2132141 us      *1.067* us      0.020 us
>
> CPU1:  Function             Hit    Time            Avg             s^2
>        --------             ---    ----            ---             ---
>        deactivate_task  1996154    2414194 us      1.209 us        0.060 us
>        activate_task    1996148    2140667 us      1.072 us        0.021 us

I have rerun the tests that I ran previously on my octo core arm64 (hikey):
20 iteration of perf bench sched pipe -T -l 50000
tip stands for tip/sched/core
uclamp enabled means both uclamp task and uclamp cgroup
the stdev is around 0.25% for all tests

                           root           level 1       level 2       level 3

tip uclamp disabled        50653          47188         44568         41925
tip uclamp enabled         48800(-3.66%)  45600(-3.37%) 42822(-3.92%)
40257(-3.98%)
/w patch uclamp disabled   50615(-0.08%)  47198(+0.02%) 44609(+0.09%)
41735(-0.45%)
/w patch uclamp enabled    49661(-1.96%)  46611(-1.22%) 43803(-1.72%)
41243(-1.63%)

Results are better with your patch
