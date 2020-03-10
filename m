Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E13C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4B21655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCJOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:22:25 -0400
Received: from foss.arm.com ([217.140.110.172]:37712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:22:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3275D30E;
        Tue, 10 Mar 2020 07:22:24 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4E193F6CF;
        Tue, 10 Mar 2020 07:22:22 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:22:20 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] sched/rt: cpupri_find: Implement fallback
 mechanism for !fit case
Message-ID: <20200310142219.syxzn5ljpdxqtbgx@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-2-qais.yousef@arm.com>
 <20200304112739.7b99677e@gandalf.local.home>
 <20200304173925.43xq4wztummxgs3x@e107158-lin.cambridge.arm.com>
 <20200304135404.146c56eb@gandalf.local.home>
 <20200304200153.c4e2p7qnko54pejt@e107158-lin.cambridge.arm.com>
 <20200305124324.42x6ehjxbnjkklnh@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200305124324.42x6ehjxbnjkklnh@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/20 12:43, Qais Yousef wrote:
> On 03/04/20 20:01, Qais Yousef wrote:
> > On 03/04/20 13:54, Steven Rostedt wrote:
> > > > If we fix 1, then assuming found == -1 for all level, we'll still have the
> > > > problem that the mask is stale.
> > > > 
> > > > We can do a full scan again as Tao was suggestion, the 2nd one without any
> > > > fitness check that is. But isn't this expensive?
> > > 
> > > I was hoping to try to avoid that, but it's not that expensive and will
> > > probably seldom happen. Perhaps we should run some test cases and trace the
> > > results to see how often that can happen.
> > > 
> > > > 
> > > > We risk the mask being stale anyway directly after selecting it. Or a priority
> > > > level might become the lowest level just after we dismissed it.
> > > 
> > > Sure, but that's still a better effort.
> > 
> > Okay let me run some quick tests and send an updated series if it doesn't
> > return something suspicious.
> 
> I ran my 6 tasks test which spawns 6 big tasks on 4 little + 2 big system.
> I verified that the 2nd fallback search happens during this scenario.
> 
> The duration of the run was 10 seconds.
> 
> Using tace-cmd record --profile -l select_task_rq_rt I got the following
> results for
> 
> 	A) Falling back to searching the last unfit_priority_idx only
> 	B) Falling back to a full search with fitness check disabled
> 
> A)
>   Event: func: select_task_rq_rt() (600) Total: 2486002 Avg: 4143 Max: 11400(ts:1084.358268) Min:1(ts:1080.258259)
>   Event: func: select_task_rq_rt() (2) Total: 11900 Avg: 5950 Max: 8680(ts:1079.659145) Min:3220(ts:1079.659288)
>   Event: func: select_task_rq_rt() (4) Total: 13080 Avg: 3270 Max: 3580(ts:1079.659815) Min:3080(ts:1079.659475)
>   Event: func: select_task_rq_rt() (3) Total: 15240 Avg: 5080 Max: 6260(ts:1079.659222) Min:4180(ts:1079.659591)
>   Event: func: select_task_rq_rt() (1) Total: 5500 Avg: 5500 Max: 5500(ts:1079.659344) Min:5500(ts:1079.659344)
>   Event: func: select_task_rq_rt() (2) Total: 8440 Avg: 4220 Max: 4600(ts:1079.659380) Min:3840(ts:1079.659786)
>   Event: func: select_task_rq_rt() (3) Total: 22920 Avg: 7640 Max: 11100(ts:1079.659672) Min:3620(ts:1079.659891)
> 
> B)
>   Event: func: select_task_rq_rt() (600) Total: 2468873 Avg: 4114 Max: 12580(ts:510.268625) Min:1(ts:516.868611)
>   Event: func: select_task_rq_rt() (4) Total: 19260 Avg: 4815 Max: 7920(ts:507.369259) Min:3340(ts:507.369669)
>   Event: func: select_task_rq_rt() (1) Total: 4700 Avg: 4700 Max: 4700(ts:507.369583) Min:4700(ts:507.369583)
>   Event: func: select_task_rq_rt() (3) Total: 7640 Avg: 2546 Max: 3320(ts:507.369403) Min:1300(ts:507.369428)
>   Event: func: select_task_rq_rt() (2) Total: 8760 Avg: 4380 Max: 5100(ts:507.369497) Min:3660(ts:507.369338)
>   Event: func: select_task_rq_rt() (1) Total: 3240 Avg: 3240 Max: 3240(ts:507.369450) Min:3240(ts:507.369450)
> 
> So for both the max seems to be ~12us, which I think is fine.
> 
> In the profile report I got something like this which I didn't know how to
> interpret. The max value is high; ~72ms.
> 
> Did I use and look at the profile output correctly? I still have the trace.dat
> for the 2 runs.
> 
> 
>                 |     + 0x266cb00000000
>                 |     |   1% (1) time:72836320 max:72836320(ts:1079.785460) min:72836320(ts:1079.785460) avg:72836320
>                 |     |    0x309000a
>                 |     |    select_task_rq_rt (0xffff800010152c74)
>                 |     |    0x0
>                 |     |    0xe885dcc56c
>                 |     |    0xe885dcdb24
>                 |     |    0x2788400000000
>                 |     |    0x1090047
> 
> 
> 
> 
> 		...
> 
> 
> 
> 		                + select_task_rq_rt (0xffff800010152c74)
>                 |   88% (1) time:72100 max:72100(ts:507.369339) min:72100(ts:507.369339) avg:72100
>                 |    0x24e4b00000000
>                 |    0x309000a
>                 |    select_task_rq_rt (0xffff800010152c74)
>                 |    0x0
>                 |    0x53be002898
>                 |    0x53be003b6c
>                 |    0x26bc400000000
>                 |

This patch was already picked by Ingo, which I'm fine (and slightly prefer) the
current version. But for the sake of completeness here's patch that falls back
to a full 2nd scan.

Steve, can you please ping Peter/Ingo if you prefer the below version to be
picked up instead? It is based on tip/sched/core and should apply on top of the
picked up series.

Thanks!

--
Qais Yousef

-->8--


From 35d135a629cdd1390ed290648a23975475c9aa95 Mon Sep 17 00:00:00 2001
From: Qais Yousef <qais.yousef@arm.com>
Date: Thu, 5 Mar 2020 10:24:50 +0000
Subject: [PATCH] sched/rt: cpupri_find: Trigger a full search as fallback

If we failed to find a fitting CPU, in cpupri_find(), we only fallback
to the level we found a hit at.

But Steve suggested to fallback to a second full scan instead as this
could be a better effort.

	https://lore.kernel.org/lkml/20200304135404.146c56eb@gandalf.local.home/

We trigger the 2nd search unconditionally since the argument about
triggering a full search is that the recorded fall back level might have
become empty by then. Which means storing any data about what happened
would be meaningless and stale.

I had a humble try at timing it and it seemed okay for the small 6 CPUs
system I was running on

	https://lore.kernel.org/lkml/20200305124324.42x6ehjxbnjkklnh@e107158-lin.cambridge.arm.com/

On large system this second full scan could be expensive. But there are
no users outside capacity awareness for this fitness function at the
moment. Heterogeneous systems tend to be small with 8cores in total.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/cpupri.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index dd3f16d1a04a..0033731a0797 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -122,8 +122,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 		bool (*fitness_fn)(struct task_struct *p, int cpu))
 {
 	int task_pri = convert_prio(p->prio);
-	int best_unfit_idx = -1;
-	int idx = 0, cpu;
+	int idx, cpu;
 
 	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
 
@@ -145,31 +144,15 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 		 * If no CPU at the current priority can fit the task
 		 * continue looking
 		 */
-		if (cpumask_empty(lowest_mask)) {
-			/*
-			 * Store our fallback priority in case we
-			 * didn't find a fitting CPU
-			 */
-			if (best_unfit_idx == -1)
-				best_unfit_idx = idx;
-
+		if (cpumask_empty(lowest_mask))
 			continue;
-		}
 
 		return 1;
 	}
 
 	/*
-	 * If we failed to find a fitting lowest_mask, make sure we fall back
-	 * to the last known unfitting lowest_mask.
-	 *
-	 * Note that the map of the recorded idx might have changed since then,
-	 * so we must ensure to do the full dance to make sure that level still
-	 * holds a valid lowest_mask.
-	 *
-	 * As per above, the map could have been concurrently emptied while we
-	 * were busy searching for a fitting lowest_mask at the other priority
-	 * levels.
+	 * If we failed to find a fitting lowest_mask, kick off a new search
+	 * but without taking into account any fitness criteria this time.
 	 *
 	 * This rule favours honouring priority over fitting the task in the
 	 * correct CPU (Capacity Awareness being the only user now).
@@ -184,8 +167,8 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 	 * must do proper RT planning to avoid overloading the system if they
 	 * really care.
 	 */
-	if (best_unfit_idx != -1)
-		return __cpupri_find(cp, p, lowest_mask, best_unfit_idx);
+	if (fitness_fn)
+		return cpupri_find(cp, p, lowest_mask);
 
 	return 0;
 }
-- 
2.17.1

