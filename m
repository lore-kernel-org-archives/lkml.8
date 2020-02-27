Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66924C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8412469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgB0RTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:19:39 -0500
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:51229 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbgB0RTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:19:38 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id B2210C0ABC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:19:36 +0000 (GMT)
Received: (qmail 25326 invoked from network); 27 Feb 2020 17:19:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Feb 2020 17:19:36 -0000
Date:   Thu, 27 Feb 2020 17:19:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qian Cai <cai@lca.pw>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: suspicious RCU due to "Prefer using an idle CPU as a migration
 target instead of comparing tasks"
Message-ID: <20200227171934.GI3818@techsingularity.net>
References: <1582812549.7365.134.camel@lca.pw>
 <1582814862.7365.135.camel@lca.pw>
 <jhjimjsvyoe.mognet@arm.com>
 <1582821327.7365.137.camel@lca.pw>
 <1582822024.7365.139.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1582822024.7365.139.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:47:04AM -0500, Qian Cai wrote:
> On Thu, 2020-02-27 at 11:35 -0500, Qian Cai wrote:
> > On Thu, 2020-02-27 at 15:26 +0000, Valentin Schneider wrote:
> > > On Thu, Feb 27 2020, Qian Cai wrote:
> > > 
> > > > On Thu, 2020-02-27 at 09:09 -0500, Qian Cai wrote:
> > > > > The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
> > > > > migration target instead of comparing tasks") introduced a boot warning,
> > > > 
> > > > This?
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index a61d83ea2930..ca780cd1eae2 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -1607,7 +1607,9 @@ static void update_numa_stats(struct task_numa_env *env,
> > > > if (ns->idle_cpu == -1)
> > > > ns->idle_cpu = cpu;
> > > > 
> > > > +rcu_read_lock();
> > > > idle_core = numa_idle_core(idle_core, cpu);
> > > > +rcu_read_unlock();
> > > > }
> > > > }
> > > > 
> > > 
> > > 
> > > Hmph right, we have
> > > numa_idle_core()->test_idle_cores()->rcu_dereference().
> > > 
> > > Dunno if it's preferable to wrap the entirety of update_numa_stats() or
> > > if that fine-grained read-side section is ok.
> > 
> > I could not come up with a better fine-grained one than this.
> 
> Correction -- this one,
> 

Thanks for reporting this!

The proposed fix would be a lot of rcu locks and unlocks. While they are
cheap, they're not free and it's a fairly standard pattern to acquire
the rcu lock when scanning CPUs during a domain search (load balancing,
nohz balance, idle balance etc). While in this context the lock is only
needed for SMT, I do not think it's worthwhile fine-graining this or
conditionally acquiring the rcu lock so will we keep it simple?


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11cdba201425..d34ac4ea5cee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1592,6 +1592,7 @@ static void update_numa_stats(struct task_numa_env *env,
 	memset(ns, 0, sizeof(*ns));
 	ns->idle_cpu = -1;
 
+	rcu_read_lock();
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
@@ -1611,6 +1612,7 @@ static void update_numa_stats(struct task_numa_env *env,
 			idle_core = numa_idle_core(idle_core, cpu);
 		}
 	}
+	rcu_read_unlock();
 
 	ns->weight = cpumask_weight(cpumask_of_node(nid));
 
