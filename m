Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BED20771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgDIPoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:44:17 -0400
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:55477 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbgDIPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:44:17 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id B0947FADED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 16:44:15 +0100 (IST)
Received: (qmail 25920 invoked from network); 9 Apr 2020 15:44:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2020 15:44:15 -0000
Date:   Thu, 9 Apr 2020 16:44:13 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Cgroup memory barrier usage and call frequency from scheduler
Message-ID: <20200409154413.GK3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Commit 9a9e97b2f1f2 ("cgroup: Add memory barriers to plug
cgroup_rstat_updated() race window") introduced two full memory
barriers to close a race. The one in cgroup_rstat_updated can be
called at a high frequency from the scheduler from update_curr ->
cgroup_account_cputime. The patch has no cc's, acks or reviews so I'm
not sure how closely this was looked at. cgroup_rstat_updated shows up
in profiles of netperf UDP_STREAM accounting for about 1% of overhead
which doesn't sound a lot but that's about the same weight as some of
the critical network paths. I have three questions about the patch

1. Why were full barriers used?
2. Why was it important that the data race be closed when the inaccuracy
   is temporary?
3. Why is it called from the context of update_curr()?

For 1, the use of a full barrier seems unnecessary when it appears that
you could have used a read barrier and a write barrier. The following
patch drops the profile overhead to 0.1%

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ca19b4c8acf5..bc3125949b4b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -36,7 +36,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	 * Paired with the one in cgroup_rstat_cpu_pop_upated().  Either we
 	 * see NULL updated_next or they see our updated stat.
 	 */
-	smp_mb();
+	smp_rmb();
 
 	/*
 	 * Because @parent's updated_children is terminated with @parent
@@ -139,7 +139,7 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 		 * Either they see NULL updated_next or we see their
 		 * updated stat.
 		 */
-		smp_mb();
+		smp_wmb();
 
 		return pos;
 	}

For 2, the changelog says the barriers are necessary because "we plan to use
rstat to track counters which need to be accurate". That is a bit vague.
Under what circumstances is a transient inaccuracy a serious enough
problem to justify additional barriers in the scheduler?

For 3, update_curr() is called from a lot of places, some of which are
quite hot -- e.g. task enqueue/dequeue. This is necessary information from
the runqueue needs to be preserved. However, it's less clear that the cpu
accounting information needs to be up to date on this granularity although
it might be related to question 2. Why was the delta_exec not similarly
accumulated in cpuacct_change() and defer the hierarchical update to
be called from somewhere like entity_tick()? It would need tracking the
CPU time at the last update as delta_exec would be lost so it's not very
trivial but it does not look like it would be overly complicated.

Thanks

-- 
Mel Gorman
SUSE Labs
