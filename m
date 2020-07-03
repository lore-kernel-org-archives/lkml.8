Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A90207D4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBKr8hR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGCMJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCMJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:09:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4284C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 05:09:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k15so18311499lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDWkT4OfDje0f0et6JWDE0B79Oq1t0eeba0qwfgusSk=;
        b=TBKr8hR9IsqEl/xMLoCv8bJqGWCEefjz14LZF3PT3TGDB7LnhGeuna1XWv+tM9j74F
         tlZU0x/io9vDE1vP+d829LTnIQdg7ZO4IwDpRlSd8AIlWYOUfAoTZRuslX4T5FeGCjQP
         AJ1uAk7OtSeLnt2SX+HWeWBIHgHzZUlwiewiBtDiQquVE/FDf06trsKdKuv0AW65SzoT
         OnuOOBMLhTNQdWNGSKJqaEvmhPPxVCijgT8iN5qZdJINFzQIsFynLFe8YN+ZewhTrlDL
         pnDFppCVOegachLfsVZgQhb3a6nD/Y497/J50PCLLqNzRaLMp5dNKVqAaWMo5kxSq5TV
         FC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDWkT4OfDje0f0et6JWDE0B79Oq1t0eeba0qwfgusSk=;
        b=R7BKAX7VzL3d/1Hxb3wA43Zj/1BqBGRGBvppEvM13tv+gm5t+CjY66J98/5ZfNouJz
         Y/CvO3xf7NEOcqHIfvmQF0Hae4YWaCjnjYRX3aeWTQ7RB7FKorhcbGsQsTC7yKysGDcj
         REpbSj8cNTaN/AI8OJMVoEzNaJq6iAjeQKP2IIX9UVLH/3RFoXqY9x4EEClOALDoLO7J
         zuYCdPKVjOXXhMMTvc74j5fRs7fb9kQkWkUG87HJ1BA96IJ41BpbZuskBKwE91GXwzX1
         dsgIR4BedUhSlc8aGrpJnz4pzp6FRoIDmqFN9sXSWySU/IFmbAxBB/rlQ6XfEJyS0l4O
         uWoQ==
X-Gm-Message-State: AOAM532oMs+2CKIPuffcKxGuHsl3PhrhIqGKJ0hENJ+fll1g1t3liX9L
        8Lt3K4VQ/pCL97MdQOqtAnVDsmcPkBWETfcMwJ1XEQ==
X-Google-Smtp-Source: ABdhPJz3WNr+QomC+bUXO8nUvibpPoQkGAdy4UThJr63lcDhss6vFTGfj5DDea4B6n0mZxs2v1Pe2d+VsSSMTkbodmE=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr4757286lfe.184.1593778153369;
 Fri, 03 Jul 2020 05:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200630112123.12076-1-qais.yousef@arm.com>
In-Reply-To: <20200630112123.12076-1-qais.yousef@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 3 Jul 2020 14:09:02 +0200
Message-ID: <CAKfTPtCjTCBbGN0gN_=7MJdiY3N-PPy0ApZWH5xd7KDQ9=0yMg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] sched: Optionally skip uclamp logic in fast path
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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

On Tue, 30 Jun 2020 at 13:22, Qais Yousef <qais.yousef@arm.com> wrote:
>
> This series attempts to address the report that uclamp logic could be expensive
> sometimes and shows a regression in netperf UDP_STREAM under certain
> conditions.
>
> The first patch is a fix for how struct uclamp_rq is initialized which is
> required by the 2nd patch which contains the real 'fix'.
>
> Worth noting that the root cause of the overhead is believed to be system
> specific or related to potential certain code/data layout issues, leading to
> worse I/D $ performance.
>
> Different systems exhibited different behaviors and the regression did
> disappear in certain kernel version while attempting to reporoduce.
>
> More info can be found here:
>
> https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/
>
> Having the static key seemed the best thing to do to ensure the effect of
> uclamp is minimized for kernels that compile it in but don't have a userspace
> that uses it, which will allow distros to distribute uclamp capable kernels by
> default without having to compromise on performance for some systems that could
> be affected.
>
> Changes in v6:
>         * s/uclamp_is_enabled/uclamp_is_used/ + add comment
>         * Improve the bailout condition for the case where we could end up with
>           unbalanced call of uclamp_rq_dec_id()
>         * Clarify some comments.
>
> Changes in v5:
>         * Fix a race that could happen when order of enqueue/dequeue of tasks
>           A and B is not done in order, and sched_uclamp_used is enabled in
>           between.
>         * Add more comments explaining the race and the behavior of
>           uclamp_rq_util_with() which is now protected with a static key to be
>           a NOP. When no uclamp aggregation at rq level is done, this function
>           can't do much.
>
> Changes in v4:
>         * Fix broken boosting of RT tasks when static key is disabled.
>
> Changes in v3:
>         * Avoid double negatives and rename the static key to uclamp_used
>         * Unconditionally enable the static key through any of the paths where
>           the user can modify the default uclamp value.
>         * Use C99 named struct initializer for struct uclamp_rq which is easier
>           to read than the memset().
>
> Changes in v2:
>         * Add more info in the commit message about the result of perf diff to
>           demonstrate that the activate/deactivate_task pressure is reduced in
>           the fast path.
>
>         * Fix sparse warning reported by the test robot.
>
>         * Add an extra commit about using static_branch_likely() instead of
>           static_branch_unlikely().
>
> Thanks
>
> --
> Qais Yousef
>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> Cc: Chris Redpath <chris.redpath@arm.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-kernel@vger.kernel.org
>
>
> Qais Yousef (2):
>   sched/uclamp: Fix initialization of struct uclamp_rq
>   sched/uclamp: Protect uclamp fast path code with static key

I have run the perf bench sched pipe that have have already run
previously with this v6 and the results are similar to my previous
tests:
The impact is -1.61% similarly to v2 which is better compared the
original -3.66% without your patch

>
>  kernel/sched/core.c              | 95 ++++++++++++++++++++++++++++++--
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/sched.h             | 47 +++++++++++++++-
>  3 files changed, 135 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>
