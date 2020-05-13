Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DF020671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgEMPa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:30:27 -0400
Received: from outbound-smtp52.blacknight.com ([46.22.136.236]:36715 "EHLO
        outbound-smtp52.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728678AbgEMPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:30:26 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id 49759FAA96
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:30:25 +0100 (IST)
Received: (qmail 22053 invoked from network); 13 May 2020 15:30:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 May 2020 15:30:25 -0000
Date:   Wed, 13 May 2020 16:30:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200513153023.GF3758@techsingularity.net>
References: <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net>
 <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:57:15PM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we have tried the kernel with adjust_numa_imbalance() crippled to just
> return the imbalance it's given.
> 
> It has solved all the performance problems I have reported.
> Performance is the same as with 5.6 kernel (before the patch was
> applied).
> 
> * solved the performance drop upto 20%  with single instance
> SPECjbb2005 benchmark on 8 NUMA node servers (particularly on AMD EPYC
> Rome systems) => this performance drop was INCREASING with higher
> threads counts (10% for 16 threads and 20 % for 32 threads)
> * solved the performance drop for low load scenarios (SPECjvm2008 and NAS)
> 
> Any suggestions on how to proceed? One approach is to turn
> "imbalance_min" into the kernel tunable. Any other ideas?
> 
> https://github.com/torvalds/linux/blob/4f8a3cc1183c442daee6cc65360e3385021131e4/kernel/sched/fair.c#L8914
> 

Complete shot in the dark but restore adjust_numa_imbalance() and try
this

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983da4408..0b31f4468d5b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2393,7 +2393,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq_flags rf;
 
 #if defined(CONFIG_SMP)
-	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
+	if (sched_feat(TTWU_QUEUE)) {
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		ttwu_queue_remote(p, cpu, wake_flags);
 		return;

-- 
Mel Gorman
SUSE Labs
