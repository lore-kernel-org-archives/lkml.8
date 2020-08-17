Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F393E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTv9uMmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHQITT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgHQITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:19:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02670C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:19:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g6so16440054ljn.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kb+WB6cxbXGASa1Z0Djt+5EpB4RsvAhrI2bCYvlv0Cg=;
        b=RTv9uMmMNydE7Xt7PNMfQJedSXhU5NBZ9mD406ib+5ZRsErO9PVET+SYSdtdaHfsJX
         9qJ7I6UToW7NqZdDwhG54X9tLHt40oiuUvqJPobzzfF9CRVwsXyi1zXG8QQIYmWj+Abh
         R2kDAMEXUdQY4oB9NSxN+MY5ny358H3yp3k5vEmK5GXUz8sYQHpCmR3WpPXRm+js1zun
         VmCHSARtCw2ddjZNigehY0i21/HyUjQrGh24hTVAR/SnDTICdQBpZWViHwSV640lBhBr
         wEoRYpNLAB+u50Bl0+7+iPz7JPu8Ojamn/TVNfMYIdh7AsLstA1Ac7sxkhkbjBc+S5dk
         EhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kb+WB6cxbXGASa1Z0Djt+5EpB4RsvAhrI2bCYvlv0Cg=;
        b=LyeHaC6+BFrJcAUDryrlMw/1XoxxBPPfnoz3i228OzaZJDc7pLIV6Jqukfy1klZH3G
         FS5w8dwH1yrYW2NPY2Uk6bugE05veZrRyKRBC9vBZWcd1bKXszW/tdxJ3LH3SFCY6Az7
         saCFzzXGMTbOWWSXUzlHZBPfOoF2w28XLI/7KYqqywKpNw3oIXXBChjMR5fQn8ku03Ig
         NwGFe3bKAhgzNKcQ/MCsh+rbTielRfcliLxM1nPlD3kFsJQoGdUz5v7yi26JtPQleR2H
         l7C2R+ikS7zlfYIG3ro7PH+zcwsuOteyjx5QxkvAx7SCjAo/fXOvusw9UOSLRgkypTOW
         nkfA==
X-Gm-Message-State: AOAM532XwxZXt42mXMFK8c5wfKilGqzUW00699RqlpQDQqKGCvsSw5wc
        AWUjAolBjxK32SBWVihWlKVFrHolPZBzSkmoIt5xag==
X-Google-Smtp-Source: ABdhPJxPXH/haxs+9hofM/AFS9b4pMCkPlHNlhjMcD/zdsLgjWAcFlYoOxaAeZ4YVcu5dmM/WmVBuikeqCMuk3a4yFs=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr7374888ljl.69.1597652350333;
 Mon, 17 Aug 2020 01:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200730135423.232776-1-arch0.zheng@gmail.com>
 <20200806144533.GA2123716@gmail.com> <2d271bf3-69c1-e5fd-b7a9-f766ff26ed62@gmail.com>
 <32e6e7dd-38cb-3317-138e-e337093e3173@gmail.com>
In-Reply-To: <32e6e7dd-38cb-3317-138e-e337093e3173@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 17 Aug 2020 10:18:59 +0200
Message-ID: <CAKfTPtBGA8d5zKcTkotxD+NmSmfXNt6yUOG_q8FN0g-rdor8bw@mail.gmail.com>
Subject: Re: [PATCH] sched/core: add unlikely in group_has_capacity()
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 03:49, Qi Zheng <arch0.zheng@gmail.com> wrote:
>
> On 2020/8/7 =E4=B8=8A=E5=8D=8810:47, Qi Zheng wrote:
> > Yeah, because of the following two points, I also think
> > the probability is 0%:
> > a) the sd is protected by rcu lock, and load_balance()
> >     func is between rcu_read_lock() and rcu_read_unlock().
> > b) the sgs is a local variable.
> >
> > So in the group_classify(), the env->sd->imbalance_pct and
> > the sgs will not be changed. May I remove the duplicate check
> > from group_has_capacity() and resubmit a patch?
> >
> > Yours,
> > Qi Zheng
> >
> > On 2020/8/6 =E4=B8=8B=E5=8D=8810:45, Ingo Molnar wrote:
> >>
> >> * Qi Zheng <arch0.zheng@gmail.com> wrote:
> >>
> >>> 1. The group_has_capacity() function is only called in
> >>>     group_classify().
> >>> 2. Before calling the group_has_capacity() function,
> >>>     group_is_overloaded() will first judge the following
> >>>     formula, if it holds, the group_classify() will directly
> >>>     return the group_overloaded.
> >>>
> >>>     (sgs->group_capacity * imbalance_pct) <
> >>>                          (sgs->group_runnable * 100)
> >>>
> >>> Therefore, when the group_has_capacity() is called, the
> >>> probability that the above formalu holds is very small. Hint
> >>> compilers about that.
> >>>
> >>> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> >>> ---
> >>>   kernel/sched/fair.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 2ba8f230feb9..9074fd5e23b2 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -8234,8 +8234,8 @@ group_has_capacity(unsigned int imbalance_pct,
> >>> struct sg_lb_stats *sgs)
> >>>       if (sgs->sum_nr_running < sgs->group_weight)
> >>>           return true;
> >>> -    if ((sgs->group_capacity * imbalance_pct) <
> >>> -            (sgs->group_runnable * 100))
> >>> +    if (unlikely((sgs->group_capacity * imbalance_pct) <
> >>> +            (sgs->group_runnable * 100)))
> >>>           return false;
> >>
> >> Isn't the probability that this second check will match around 0%?
> >>
> >> I.e. wouldn't the right fix be to remove the duplicate check from
> >> group_has_capacity(), because it's already been checked in
> >> group_classify()? Maybe while leaving a comment in place?
> >>
> >> Thanks,
> >>
> >>     Ingo
> >>
>
> Hi,
>
> As Valentin and I discussed in the patch below, simply removing the
> check may not be completely harmless.
>
>         [PATCH]sched/fair: Remove the duplicate check from
>                                         group_has_capacity() :
>         -       if ((sgs->group_capacity * imbalance_pct) <
>         -                       (sgs->group_runnable * 100))
>         -               return false;
>
>
> If sum_nr_running < group_weight, we won't evaluate it.
> If sum_nr_running > group_weight, we either won't call into
>    group_has_capacity() or we'll have checked it already in
>    group_overloaded().
> But in the case of sum_nr_running =3D=3D group_weight, we can
> run to this check.

The case "sum_nr_running =3D=3D group_weight" should not be considered as
a corner case because that's the final state that we are trying to
reach with load balance: 1 task per CPU
And because of task migrations involved to reach this state, we easily
have a temporarly low group_utilization (because of the migration) but
a high group_runnable. This state highlights the fact that some tasks
were competing for CPU cycles before the migration done by the load
balance and the task that remains on the CPU, should fill the spare
capacity. So the test prevents the load balance to immediately put
back another task on the CPU

Removing the condition should not be considered

>
> Although I also think it is unlikely to cause the significant
> capacity pressure at the =3D=3D case, but I'm not sure whether there
> are some special scenarios. such as some cpus in sg->cpumask are
> no longer active, or other scenarios?
>
> So adding the unlikely() in group_has_capacity() may be the safest
> way.

Adding unlikely() is safe and I'm fine to add it but I'd like some
figures that show improvements

Regards,
Vincent

>
> Add Valentin Schneider <valentin.schneider@arm.com>.
>
> Yours,
> Qi Zheng
