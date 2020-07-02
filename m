Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303EEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC8420672
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgGBN3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:29:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:34510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgGBN3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:29:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DE30BA17;
        Thu,  2 Jul 2020 13:29:41 +0000 (UTC)
Date:   Thu, 2 Jul 2020 14:20:58 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Puhov <peter.puhov@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>
Subject: Re: [PATCH] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
Message-ID: <20200702132058.GN3129@suse.de>
References: <20200616164801.18644-1-peter.puhov@linaro.org>
 <jhjo8pidl01.mognet@arm.com>
 <CAMDPZ0iNtaZ7p3bre31-m6E4Rb92EFshxrcsTjj3cm6=yr_ctw@mail.gmail.com>
 <106350c5-c2b7-a63c-2b06-761f523ee67c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <106350c5-c2b7-a63c-2b06-761f523ee67c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:27:52AM +0200, Dietmar Eggemann wrote:
> On 17/06/2020 16:52, Peter Puhov wrote:
> > On Wed, 17 Jun 2020 at 06:50, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >>
> >> On 16/06/20 17:48, peter.puhov@linaro.org wrote:
> >>> From: Peter Puhov <peter.puhov@linaro.org>
> >>> We tested this patch with following benchmarks:
> >>>   perf bench -f simple sched pipe -l 4000000
> >>>   perf bench -f simple sched messaging -l 30000
> >>>   perf bench -f simple  mem memset -s 3GB -l 15 -f default
> >>>   perf bench -f simple futex wake -s -t 640 -w 1
> >>>   sysbench cpu --threads=8 --cpu-max-prime=10000 run
> >>>   sysbench memory --memory-access-mode=rnd --threads=8 run
> >>>   sysbench threads --threads=8 run
> >>>   sysbench mutex --mutex-num=1 --threads=8 run
> >>>   hackbench --loops 20000
> >>>   hackbench --pipe --threads --loops 20000
> >>>   hackbench --pipe --threads --loops 20000 --datasize 4096
> >>>
> >>> and found some performance improvements in:
> >>>   sysbench threads
> >>>   sysbench mutex
> >>>   perf bench futex wake
> >>> and no regressions in others.
> >>>
> >>
> >> One nitpick for the results of those: condensing them in a table form would
> >> make them more reader-friendly. Perhaps something like:
> >>
> >> | Benchmark        | Metric   | Lower is better? | BASELINE | SERIES | DELTA |
> >> |------------------+----------+------------------+----------+--------+-------|
> >> | Sysbench threads | # events | No               |    45526 |  56567 |  +24% |
> >> | Sysbench mutex   | ...      |                  |          |        |       |
> >>
> >> If you want to include more stats for each benchmark, you could have one table
> >> per (e.g. see [1]) - it'd still be a more readable form (or so I believe).
> 
> Wouldn't Unix Bench's 'execl' and 'spawn' be the ultimate test cases
> for those kind of changes?
> 
> I only see minor improvements with tip/sched/core as base on hikey620
> (Arm64 octa-core).
> 
> 				base		w/ patch
> ./Run spawn -c 8 -i 10		 633.6		 635.1
> 
> ./Run execl -c 8 -i 10		1187.5		1190.7	
> 
> 
> At the end of find_idlest_group(), when comparing local and idlest, it
> is explicitly mentioned that number of idle_cpus is used instead of
> utilization.
> The comparision between potential idle groups and local & idlest group
> should probably follow the same rules.
> 

There is the secondary hazard that what update_sd_pick_busiest returns
is checked later by find_busiest_group when considering the imbalance
between NUMA nodes. This particular patch splits basic communicating tasks
cross-node again at fork time so cross node communication is reintroduced
(same applies if sum_nr_running is used instead of group_util).

-- 
Mel Gorman
SUSE Labs
