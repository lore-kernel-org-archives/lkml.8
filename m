Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7007C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB510207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOc4tU6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFQOxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgFQOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:53:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0E3C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:53:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i3so3245668ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJE9jML/rs5aHW6KANE9bp+nTXaw2X7TS0VvCJYBPOA=;
        b=kOc4tU6nGLrNB7XuIs8kQ61SoV/HvgPps5eut81gdNsvfp9GRT3OUBTvgQWKKiypxY
         rOvjL20PjDocXOoQsQ3TMX/vHZusaj8j0WmlAg/+EBzb9pXgoXh961f49AZbX//jfidW
         dXbndr0UWgbOEZb4dWkFgzLutVJbVHB6w33/8NULF7Sbofe1WFPKB+uths7yNOWqUt9l
         u04vg+luPdpPu0777HXXQctfvarpOVMhMvuKmagWS9/bo+cXWvm7bclMb2WxTfidEhyX
         lsTN9YvGDZmfNQ9huWnx4s3whwj7b2IgJjL8Ljk4yD9Fvl/P2zGScs+TtzfV6XX3tc7+
         A5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJE9jML/rs5aHW6KANE9bp+nTXaw2X7TS0VvCJYBPOA=;
        b=qSoKMFdLSxuK6QKgDTtnIiWejblWDFS/trxIUsipg5MXiyUe92FsqZ7ejd9uR6ybb4
         +FTaKmxUrBP3J1PqIGbWC2w6RKoPgtFvX0jnodEjqWLjr2h+BM3SI5WfcnXJ1YOA+WIQ
         GRZ8ZaGdxFzN92mzX7aWF7ku6m6GCpNJHhU5Frrd2n1/7iiHc/xZdnKpHkLAaiX/vCDL
         edesMHAiDxqKEI3zY7bbYuKn9xCM8Kpbmu2WzcXn6ZRkvc+nXxqZHbqZaUqc4Isztfcp
         PddxXbvoXiQGsuyj6e8t0gErpWD74ix6+msjjkn3fpIUtLvH3DPf4t64FTvAzp+OYCS8
         1AnQ==
X-Gm-Message-State: AOAM530bdcil0TcrXneYhmRcE8nZ2I37BfMMLXrZ0KiJyZBI2/usuXiU
        +/eKM1LHTZGYFYmGNeYPytbkUQylhZkjycnyZd9UPQ==
X-Google-Smtp-Source: ABdhPJw9GFcL8LP/z+VWE8hrdCQMz8psId0H4FibokHVKz1cYtH1bP9MvxnYZeKl7M7JRkgQCUZclSXpOK7sTlcTz58=
X-Received: by 2002:a2e:9395:: with SMTP id g21mr3833138ljh.58.1592405589547;
 Wed, 17 Jun 2020 07:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200616164801.18644-1-peter.puhov@linaro.org> <jhjo8pidl01.mognet@arm.com>
In-Reply-To: <jhjo8pidl01.mognet@arm.com>
From:   Peter Puhov <peter.puhov@linaro.org>
Date:   Wed, 17 Jun 2020 10:52:58 -0400
Message-ID: <CAMDPZ0iNtaZ7p3bre31-m6E4Rb92EFshxrcsTjj3cm6=yr_ctw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: update_pick_idlest() Select group with lowest
 group_util when idle_cpus are equal
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Peter Puhov <peter.puhov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 at 06:50, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 16/06/20 17:48, peter.puhov@linaro.org wrote:
> > From: Peter Puhov <peter.puhov@linaro.org>
> > We tested this patch with following benchmarks:
> >   perf bench -f simple sched pipe -l 4000000
> >   perf bench -f simple sched messaging -l 30000
> >   perf bench -f simple  mem memset -s 3GB -l 15 -f default
> >   perf bench -f simple futex wake -s -t 640 -w 1
> >   sysbench cpu --threads=8 --cpu-max-prime=10000 run
> >   sysbench memory --memory-access-mode=rnd --threads=8 run
> >   sysbench threads --threads=8 run
> >   sysbench mutex --mutex-num=1 --threads=8 run
> >   hackbench --loops 20000
> >   hackbench --pipe --threads --loops 20000
> >   hackbench --pipe --threads --loops 20000 --datasize 4096
> >
> > and found some performance improvements in:
> >   sysbench threads
> >   sysbench mutex
> >   perf bench futex wake
> > and no regressions in others.
> >
>
> One nitpick for the results of those: condensing them in a table form would
> make them more reader-friendly. Perhaps something like:
>
> | Benchmark        | Metric   | Lower is better? | BASELINE | SERIES | DELTA |
> |------------------+----------+------------------+----------+--------+-------|
> | Sysbench threads | # events | No               |    45526 |  56567 |  +24% |
> | Sysbench mutex   | ...      |                  |          |        |       |
>
> If you want to include more stats for each benchmark, you could have one table
> per (e.g. see [1]) - it'd still be a more readable form (or so I believe).
>
> [1]: https://lore.kernel.org/lkml/20200206191957.12325-1-valentin.schneider@arm.com/
>
Good point.
I will reformat test results.

> > ---
> >  kernel/sched/fair.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..abcbdf80ee75 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8662,8 +8662,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
> >
> >       case group_has_spare:
> >               /* Select group with most idle CPUs */
> > -             if (idlest_sgs->idle_cpus >= sgs->idle_cpus)
> > +             if (idlest_sgs->idle_cpus > sgs->idle_cpus)
> >                       return false;
> > +
> > +             /* Select group with lowest group_util */
> > +             if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
> > +                     idlest_sgs->group_util <= sgs->group_util)
> > +                     return false;
> > +
> >               break;
> >       }
>
> update_sd_pick_busiest() uses the group's nr_running instead. You mention
> in the changelog that using nr_running is a possible alternative, did you
> try benchmarking that and seeing how it compares to using group_util?
>
> I think it would be nice to keep pick_busiest() and pick_idlest() aligned
> wherever possible/sensible.
>
I agree with you.
> Also, there can be cases where one group has a few "big" tasks and another
> has a handful more "small" tasks. Say something like
>
>   sgs_a->group_util = U
>   sgs_a->sum_nr_running = N
>
>   sgs_b->group_util = U*4/3
>   sgs_b->sum_nr_running = N*2/3
>
>   (sgs_b has more util per task, i.e. bigger tasks on average)
>
> Given that we're in the 'group_has_spare' case, I would think picking the
> group with the lesser amount of running tasks would make sense. Though I
> guess you can find pathological cases where the util per task difference is
> huge and we should look at util first...
I will re-run the tests with logic based on sum_nr_running and post results.
Thank you for suggestions.
