Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA09CC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39FE2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcEl2bDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEGMxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgEGMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:53:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD770C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:53:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so6192499ljl.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itoFpk0rOnDLM0PwGwQS9avTS4/3qHGUdIW12cSPKBA=;
        b=YcEl2bDRJI3iJB/8XtTG3CXQif1X5eYquMR0qzjP5Mpjs7ln8lzeYiI/LVLAweTafJ
         Z6wpNJ/eBMsw+9R5PB85KJN2qZgP51MVjKRbPAFlEnJXJ95LGd8ryQm2/5HCQEzaHunB
         TgqoS0zsvzozAROKQxZwxk8eAyiSyBxwNs2Eu01aqneS3eyqfunRRwrOMvvAZAXfVWE8
         KNt40gSMiiKSK//wsn2rBR+sb7Bep9eQV2WZTWlYH5zGfwLd9ClOnIBtqrH6jG6nTIbF
         6rkfR+lqm08l3D0S3/QBvBN38WvifoXjKyFHpctGJ+nOAlumAB0/2umm0L+/tUygS46Z
         tVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itoFpk0rOnDLM0PwGwQS9avTS4/3qHGUdIW12cSPKBA=;
        b=aT8VbI96BlzpJKOLwcehUIikcWbuHqBByjhEf99iE8m891oXE0qx3eJ/VnOsRSxjMX
         TeW6Cjm+lHBmAbdViGub0u60Q37DwXP2OsFn9zd/oDGE+qDSpveB3TwWmIS0EN7Za6eW
         LvXpwESa/84DeuPht2q+Dc2tP8dfiNnjpWd0XxGsZgZzJyrjI7cjQXwot2PRW5zkaWpg
         iSAWKKZHiPXi8zYvb5PBKp0e1IUupE+0GiwAmfr3CuLV6q6Syi09dP2qXfAy48ipD7tA
         t+W5aODKlTNtJy5iuNir11nrsUKTrBSx1AT+P58dTP+Si/TYTP+zBTLyUUCSGBTn+YqF
         Q4WA==
X-Gm-Message-State: AGi0PuaPqe5EUlxZvH/RaEABjFVlJnLeV6CePg+VTvZ7YePX8VEHjkJl
        qmA9Fx/y/L0ANDwG9zDLANM2Impm4T9TocM9HUqkCw==
X-Google-Smtp-Source: APiQypKMTiMm1C88aomNGpTtnhL8b0bf92b/ZVFoKyedTSXsbaoCwM1dqo2Nb6dx413A1ukBmk/N3InDh6JI1bE/vRo=
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr8327928ljh.65.1588855997313;
 Thu, 07 May 2020 05:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ> <20200505142711.GA12952@vingu-book>
 <jhjftcd1hmx.mognet@arm.com> <CAKfTPtCM7mE7a63rXB4cG5gHn03ArjTB1ZBje=qEWOGR9mj67g@mail.gmail.com>
 <jhjv9l9yrtb.mognet@arm.com> <20200507124104.GA2769@iZj6chx1xj0e0buvshuecpZ>
In-Reply-To: <20200507124104.GA2769@iZj6chx1xj0e0buvshuecpZ>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 May 2020 14:53:05 +0200
Message-ID: <CAKfTPtCjAd0k7482rjfznRFcWmxWWJzVMaSXu2yu4krttLqneQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 at 14:41, Peng Liu <iwtbavbm@gmail.com> wrote:
>
> On Wed, May 06, 2020 at 05:02:56PM +0100, Valentin Schneider wrote:
> >
> > On 06/05/20 14:45, Vincent Guittot wrote:
> > >> But then we may skip an update if we goto abort, no? Imagine we have just
> > >> NOHZ_STATS_KICK, so we don't call any rebalance_domains(), and then as we
> > >> go through the last NOHZ CPU in the loop we hit need_resched(). We would
> > >> end in the abort part without any update to nohz.next_balance, despite
> > >> having accumulated relevant data in the local next_balance variable.
> > >
> > > Yes but on the other end, the last CPU has not been able to run the
> > > rebalance_domain so we must not move  nohz.next_balance otherwise it
> > > will have to wait for at least another full period
> > > In fact, I think that we have a problem with current implementation
> > > because if we abort because  local cpu because busy we might end up
> > > skipping idle load balance for a lot of idle CPUs
> > >
> > > As an example, imagine that we have 10 idle CPUs with the same
> > > rq->next_balance which equal nohz.next_balance.  _nohz_idle_balance
> > > starts on CPU0, it processes idle lb for CPU1 but then has to abort
> > > because of need_resched. If we update nohz.next_balance like
> > > currently, the next idle load balance  will happen after a full
> > > balance interval whereas we still have 8 CPUs waiting for running an
> > > idle load balance.
> > >
> > > My proposal also fixes this problem
> > >
> >
> > That's a very good point; so with NOHZ_BALANCE_KICK we can reduce
> > nohz.next_balance via rebalance_domains(), and otherwise we would only
> > increase it if we go through a complete for_each_cpu() loop in
> > _nohz_idle_balance().
> >
> > That said, if for some reason we keep bailing out of the loop, we won't
> > push nohz.next_balance forward and thus may repeatedly nohz-balance only
> > the first few CPUs in the NOHZ mask. I think that can happen if we have
> > say 2 tasks pinned to a single rq, in that case nohz_balancer_kick() will
> > kick a NOHZ balance whenever now >= nohz.next_balance.
>
> If we face the risk of "repeatly nohz-balance only the first few CPUs",
> Maybe we could remember the interrupted CPU and start nohz-balance from
> it next time. Just replace the loop in _nohz_idle_balance() like:
>
> for_each_cpu_wrap(cpu, nohz.idle_cpus_mask, nohz.anchor) {
>         ...
>         if (need_resched()) {
>                 ...
>                 nohz.anchor = cpu;
>                 ...
>         }
>         ...
> }
>
> This can mitigate the problem, but this can't help the extreme situation

If we rerun _nohz_idle_balance before the balance interval, the 1st
idle CPUs that has already been balanced will be skipped because there
rq->next_balance will be after jiffies and we will start calling
rebalance_domains for idle CPUs which have not yet been balance.
So I'm not sure that this will help a lot because we have to go
through all idle CPU to set the nohz.next_balance at the end

> as @Vincent put, it always failed in the same CPU.

In the case that i described above, the problem comes from the cpu
that is selected to run the ilb but if we kick ilb again, it will not
be selected again.
