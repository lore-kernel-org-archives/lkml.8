Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5705CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2525C2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgEUQEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:04:13 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:38385 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727973AbgEUQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:04:12 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id B18421C232E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 17:04:10 +0100 (IST)
Received: (qmail 6040 invoked from network); 21 May 2020 16:04:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 May 2020 16:04:10 -0000
Date:   Thu, 21 May 2020 17:04:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>,
        "aokuliar@redhat.com" <aokuliar@redhat.com>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200521160408.GC7167@techsingularity.net>
References: <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200507174934.GD19331@lorien.usersys.redhat.com>
 <20200508034741.13036-1-hdanton@sina.com>
 <CAE4VaGDBAquxbBjuzzyaT1WPR95wiaiHsrEPs-eOP2W+r=fQFg@mail.gmail.com>
 <20200519043154.10876-1-hdanton@sina.com>
 <CAE4VaGAxqK_gr7gstk1S8z3vx+9c6rG-Xo_kUiAzuOWpqOR4cQ@mail.gmail.com>
 <20200521140931.15232-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200521140931.15232-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:09:31PM +0800, Hillf Danton wrote:
> > I'm ignoring the coding style of c++ comments but minimally that should
> > be fixed. More importantly, node_type can be one of node_overloaded,
> > node_has_spare or node_fully busy and this is checking if there is a
> > mismatch. However, it's not taking into account whether the dst_node
> > is more or less loaded than the src and does not appear to be actually
> > checking spare capacity like the comment suggests.
> > 
>
> Type other than node_has_spare is not considered because node is not
> possible to be so idle that two communicating tasks would better
> "stay local."
> 

You hardcode an imbalance of 2 at the start without computing any
imbalance. Then if the source is fully_busy or overloaded while the
dst is idle, a task can move but that is based on an imaginary hard-coded
imbalance of 2. Finally, it appears that that the load balancer and
NUMA balancer are again using separate logic again when one part of the
objective of the series is that the load balancer and NUMA balancer would
not override each other. As the imbalance is never computed, the patch
can create one which the load balancer then overrides. What am I missing?

That said, it does make a certain amount of sense that if the dst has
spare capacity and the src is fully busy or overloaded then allow the
migration regardless of imbalance but that would be a different patch --
something like this but I didn't think too deeply or test it.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..97c0e090e161 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1916,19 +1916,27 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	 * imbalance that would be overruled by the load balancer.
 	 */
 	if (env->dst_stats.node_type == node_has_spare) {
-		unsigned int imbalance;
+		unsigned int imbalance = 0;
 		int src_running, dst_running;
 
 		/*
-		 * Would movement cause an imbalance? Note that if src has
-		 * more running tasks that the imbalance is ignored as the
-		 * move improves the imbalance from the perspective of the
-		 * CPU load balancer.
-		 * */
-		src_running = env->src_stats.nr_running - 1;
-		dst_running = env->dst_stats.nr_running + 1;
-		imbalance = max(0, dst_running - src_running);
-		imbalance = adjust_numa_imbalance(imbalance, src_running);
+		 * Check the imbalance if both src and dst have spare
+		 * capacity. If src is fully_busy or overloaded then
+		 * allow the task to move as it's both improving locality
+		 * and reducing an imbalance.
+		 */
+		if (env->src_stats.node_type == node_has_spare) {
+			/*
+			 * Would movement cause an imbalance? Note that if src
+			 * has more running tasks that the imbalance is
+			 * ignored as the move improves the imbalance from the
+			 * perspective of the CPU load balancer.
+			 */
+			src_running = env->src_stats.nr_running - 1;
+			dst_running = env->dst_stats.nr_running + 1;
+			imbalance = max(0, dst_running - src_running);
+			imbalance = adjust_numa_imbalance(imbalance, src_running);
+		}
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {

> > Then there is this part
> > 
> > +               imbalance = adjust_numa_imbalance(imbalance,
> > +                                               env->src_stats.nr_running);
> > +
> > +               //Do nothing without imbalance
> > +               if (!imbalance) {
> > +                       imbalance = 2;
> > +                       goto check_imb;
> > +               }
> > 
> > So... if there is no imbalance, assume there is an imbalance of 2, jump to
> > a branch that will always be false and fall through to code that ignores
> > the value of imbalance ...... it's hard to see exactly why that code flow
> > is ideal.
> > 
> With spare capacity be certain, then lets see how idle the node is.

But you no longer check how idle it is or what it's relative idleness of
the destination is relative to the source. adjust_numa_imbalance does
not calculate an imbalance, it only decides whether it should be
ignored.

> And I
> can not do that without the tool you created, He bless you. Although not
> sure they're two tasks talking to each other. This is another topic in the
> coming days.
> 

There is insufficient context in this path to determine if two tasks are
communicating. In some cases it may be inferred from last_wakee but that
only works for two tasks, it doesn't work for 1:n waker:wakees such as
might happen with a producer/consumer pattern. I guess you could record
the time that tasks migrated cross-node due to a wakeup and avoid migrating
those tasks for a period of time by either NUMA or load balancer but that
could cause transient overloads of a domain if there are a lot of wakeups
(e.g. hackbench). It's a change that would need to be done on both the
NUMA and load balancer to force the migration even if there are wakeup
relationships if the domain is fully busy or overloaded.

-- 
Mel Gorman
SUSE Labs
