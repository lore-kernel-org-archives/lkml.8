Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21060C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021B220721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEULG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:06:28 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:56551 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgEULG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:06:28 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 0E32FFABA8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:06:26 +0100 (IST)
Received: (qmail 690 invoked from network); 21 May 2020 11:06:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 May 2020 11:06:25 -0000
Date:   Thu, 21 May 2020 12:06:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>, Phil Auld <pauld@redhat.com>,
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
Message-ID: <20200521110623.GB7167@techsingularity.net>
References: <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200507174934.GD19331@lorien.usersys.redhat.com>
 <20200508034741.13036-1-hdanton@sina.com>
 <CAE4VaGDBAquxbBjuzzyaT1WPR95wiaiHsrEPs-eOP2W+r=fQFg@mail.gmail.com>
 <20200519043154.10876-1-hdanton@sina.com>
 <CAE4VaGAxqK_gr7gstk1S8z3vx+9c6rG-Xo_kUiAzuOWpqOR4cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGAxqK_gr7gstk1S8z3vx+9c6rG-Xo_kUiAzuOWpqOR4cQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:58:01PM +0200, Jirka Hladky wrote:
> Hi Hillf, Mel and all,
> 
> thanks for the patch! It has produced really GOOD results.
> 
> 1) It has fixed performance problems with 5.7 vanilla kernel for
> single-tenant workload and low system load scenarios, without
> performance degradation for the multi-tenant tasks. It's producing the
> same results as the previous proof-of-concept patch where
> adjust_numa_imbalance function was modified to be a no-op (returning
> the same value of imbalance as it gets on the input).
> 

I worry that what it's doing is sort of reverts the patch but in a
relatively obscure way. We already know that a side-effect of having a
pair of tasks sharing cache is that the wakeup paths can be more expensive
and the difference in the wakeup path exceeds the advantage of using
local memory. However, I don't think the right approach long term is to
keep tasks artificially apart so that a different wakeup path is used as
a side-effect.

The patch also needs a changelog and better comments to follow exactly
what the rationale is. Take this part


+               //No imbalance computed without spare capacity
+               if (env->dst_stats.node_type != env->src_stats.node_type)
+                       goto check_imb;

I'm ignoring the coding style of c++ comments but minimally that should
be fixed. More importantly, node_type can be one of node_overloaded,
node_has_spare or node_fully busy and this is checking if there is a
mismatch. However, it's not taking into account whether the dst_node
is more or less loaded than the src and does not appear to be actually
checking spare capacity like the comment suggests.

Then there is this part

+               imbalance = adjust_numa_imbalance(imbalance,
+                                               env->src_stats.nr_running);
+
+               //Do nothing without imbalance
+               if (!imbalance) {
+                       imbalance = 2;
+                       goto check_imb;
+               }

So... if there is no imbalance, assume there is an imbalance of 2, jump to
a branch that will always be false and fall through to code that ignores
the value of imbalance ...... it's hard to see exactly why that code flow
is ideal.

> 2) We have also added Mel's netperf-cstate-small-cross-socket test to
> our test battery:
> https://github.com/gormanm/mmtests/blob/master/configs/config-network-netperf-cstate-small-cross-socket
> 
> Mel told me that he had seen significant performance improvements with
> 5.7 over 5.6 for the netperf-cstate-small-cross-socket scenario.
> 
> Out of 6 different patches we have tested, your patch has performed
> the best for this scenario. Compared to vanilla, we see minimal
> performance degradation of 2.5% for the udp stream throughput and 0.6%
> for the tcp throughput.

Which implies that we are once again using remote memory for netperf and
possibly getting some interference from NUMA balancing hinting faults.

> The testing was done on a dual-socket system
> with Gold 6132 CPU.
> 
> @Mel - could you please test Hillf's patch with your full testing
> suite? So far, it looks very promising, but I would like to check the
> patch thoroughly to make sure it does not hurt performance in other
> areas.
> 

I can't at the moment due to a backlog on my test grid which isn't helped
that by the fact I lost two days development time due to a thrashed work
machine. That aside, I'm finding it hard to see exactly why the patch
is suitable. What I've seen so far is that there are two outstanding
problems after the rewritten load balancer and the reconcilation between
load balancer and NUMA balancer.

The first is that 57abff067a08 ("sched/fair: Rework find_idlest_group()")
has shown up some problems with LKP reporting it here
https://lore.kernel.org/lkml/20200514141526.GA30976@xsang-OptiPlex-9020/
but I've also seen numerous workloads internally bisect to the same
commit. This patch is meant to ensure that finding the busiest group uses
similar logic to finding the idlest group but something is hiding in there.

The second is that waking two tasks sharing tasks can be more expensive
than waking two remote tasks but it's preferable to fix the wakeup logic
than keep related tasks on separate caches just because it happens to
generate good numbers in some cases.

I feel that it makes sense to try and get both of those issues resolved
before making adjust_numa_imbalance a tunable or reverting it but I
really think it makes sense for communicating tasks to be sharing cache
if possible unless a node is overloaded or limited by memory bandwidth.

-- 
Mel Gorman
SUSE Labs
