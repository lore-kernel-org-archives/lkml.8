Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832B22068F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHuJEAGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgGBNpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgGBNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:45:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:45:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so7312050ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJIM+Ab7DhARtGNz/vHk/l2fK0qArHA56h3WLyp3ZY4=;
        b=zHuJEAGbPYueRjHvZbz1dAvskakjwhhr62OP1Wppf2jXL4nTV+H22bKSiFCOYT+T/B
         XctATN1sGjFqWn6QDB4Qgpz8bt46VzrRIUSWU4u7V2Bk3fA8rx5sT3CCeavKxFpxZulx
         hkJ6E4HQh1jl6vE0XzHleoJUt2JuauKss6SgE2FeZGbOJgL9eX8wZ5v5cUisTt6GNP15
         gDKRIngEx7rOvjlOYr5f7rlW4cdO3CE6z/I6vSx41AxtajsSl0xqxK3dO4ecLrVVA4/G
         ihKBLaq9PK8uN851HuHArfVEHtNE5voSalZr7rkoBMkaXUg+Jx1nsJrEMJ2mlfi0BlHk
         OK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJIM+Ab7DhARtGNz/vHk/l2fK0qArHA56h3WLyp3ZY4=;
        b=VhOO/GZkFd0AU2AOhW/u7g7YDyxsCKMa9avMt///pZPPVg5XLEmUNgj/rgDQ2w4JIM
         5BxsZYldHwnrZJUVy9A9+yuZGPxsSar3MaKM8y4IqsnTNb6ris0grg6GiMpN4xgkXXFf
         nPMMm8ObsGrhkw/MsljHhr8yKN3S8K/+aVI6NBak09hBcqWUO20eJ8NfiJ1h/0j81z58
         nF5LEofIfH402NCmz7FvR7NKechqTYNFge+olkwm0HOfXolSc/o9gwSKgotICTVojiS9
         ze7je3/yWOKfhi9P4aCF6zndIMiZBG5yPJsKomdo+/9c7jadng/eZAc57ZoDD498S6pn
         uulQ==
X-Gm-Message-State: AOAM5318gUy3ZrGw+Ol90pX8Km5SLpUnr1rKD6Qq47Nfpx4sHVtyHDJB
        p55JZfpukG6ouEGDqyJQFLYEAq5BlRILB0MXTS06sA==
X-Google-Smtp-Source: ABdhPJxg8XpAAFnJqildyVrF3Yl+IOQtQTfgFxPNAO2g/L0bCYCYzv0LOqOZjhF9dH2VzgngtaKjxCa5mIW8n0j6h/s=
X-Received: by 2002:a2e:312:: with SMTP id 18mr16046971ljd.423.1593697522526;
 Thu, 02 Jul 2020 06:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200616164801.18644-1-peter.puhov@linaro.org>
 <jhjo8pidl01.mognet@arm.com> <CAMDPZ0iNtaZ7p3bre31-m6E4Rb92EFshxrcsTjj3cm6=yr_ctw@mail.gmail.com>
 <106350c5-c2b7-a63c-2b06-761f523ee67c@arm.com> <20200702132058.GN3129@suse.de>
In-Reply-To: <20200702132058.GN3129@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Jul 2020 15:45:11 +0200
Message-ID: <CAKfTPtDjAm-6ntvPSqkWPBUBjUJXRCLapLaOBZsw8ocw635Z3A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: update_pick_idlest() Select group with lowest
 group_util when idle_cpus are equal
To:     Mel Gorman <mgorman@suse.de>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Puhov <peter.puhov@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 at 15:29, Mel Gorman <mgorman@suse.de> wrote:
>
> On Thu, Jul 02, 2020 at 11:27:52AM +0200, Dietmar Eggemann wrote:
> > On 17/06/2020 16:52, Peter Puhov wrote:
> > > On Wed, 17 Jun 2020 at 06:50, Valentin Schneider
> > > <valentin.schneider@arm.com> wrote:
> > >>
> > >>
> > >> On 16/06/20 17:48, peter.puhov@linaro.org wrote:
> > >>> From: Peter Puhov <peter.puhov@linaro.org>
> > >>> We tested this patch with following benchmarks:
> > >>>   perf bench -f simple sched pipe -l 4000000
> > >>>   perf bench -f simple sched messaging -l 30000
> > >>>   perf bench -f simple  mem memset -s 3GB -l 15 -f default
> > >>>   perf bench -f simple futex wake -s -t 640 -w 1
> > >>>   sysbench cpu --threads=8 --cpu-max-prime=10000 run
> > >>>   sysbench memory --memory-access-mode=rnd --threads=8 run
> > >>>   sysbench threads --threads=8 run
> > >>>   sysbench mutex --mutex-num=1 --threads=8 run
> > >>>   hackbench --loops 20000
> > >>>   hackbench --pipe --threads --loops 20000
> > >>>   hackbench --pipe --threads --loops 20000 --datasize 4096
> > >>>
> > >>> and found some performance improvements in:
> > >>>   sysbench threads
> > >>>   sysbench mutex
> > >>>   perf bench futex wake
> > >>> and no regressions in others.
> > >>>
> > >>
> > >> One nitpick for the results of those: condensing them in a table form would
> > >> make them more reader-friendly. Perhaps something like:
> > >>
> > >> | Benchmark        | Metric   | Lower is better? | BASELINE | SERIES | DELTA |
> > >> |------------------+----------+------------------+----------+--------+-------|
> > >> | Sysbench threads | # events | No               |    45526 |  56567 |  +24% |
> > >> | Sysbench mutex   | ...      |                  |          |        |       |
> > >>
> > >> If you want to include more stats for each benchmark, you could have one table
> > >> per (e.g. see [1]) - it'd still be a more readable form (or so I believe).
> >
> > Wouldn't Unix Bench's 'execl' and 'spawn' be the ultimate test cases
> > for those kind of changes?
> >
> > I only see minor improvements with tip/sched/core as base on hikey620
> > (Arm64 octa-core).
> >
> >                               base            w/ patch
> > ./Run spawn -c 8 -i 10                 633.6           635.1
> >
> > ./Run execl -c 8 -i 10                1187.5          1190.7
> >
> >
> > At the end of find_idlest_group(), when comparing local and idlest, it
> > is explicitly mentioned that number of idle_cpus is used instead of
> > utilization.
> > The comparision between potential idle groups and local & idlest group
> > should probably follow the same rules.

Comparing the number of idle cpu is not enough in the case described
by Peter because the newly forked thread sleeps immediately and before
we select cpu for the next one. This is shown in the trace where the
same CPU7 is selected for all wakeup_new events.
That's why, looking at utilization when there is the same number of
CPU is a good way to see where the previous task was placed. Using
nr_running doesn't solve the problem because newly forked task is not
running and the cpu would not have been idle in this case and an idle
CPU would have been selected instead

> >
>
> There is the secondary hazard that what update_sd_pick_busiest returns
> is checked later by find_busiest_group when considering the imbalance
> between NUMA nodes. This particular patch splits basic communicating tasks
> cross-node again at fork time so cross node communication is reintroduced
> (same applies if sum_nr_running is used instead of group_util).

As long as there is an idle cpu in the node, new thread doesn't cross
node like previously. The only difference happens inside the node

>
> --
> Mel Gorman
> SUSE Labs
