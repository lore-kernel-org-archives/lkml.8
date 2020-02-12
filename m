Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF374C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F79F206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgBLJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:36:59 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:41085 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728681AbgBLJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:36:59 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 06A74B86DF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:36:57 +0000 (GMT)
Received: (qmail 25117 invoked from network); 12 Feb 2020 09:36:56 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 12 Feb 2020 09:36:56 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 02/11] sched/fair: Optimize select_idle_core()
Date:   Wed, 12 Feb 2020 09:36:45 +0000
Message-Id: <20200212093654.4816-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200212093654.4816-1-mgorman@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Currently we loop through all threads of a core to evaluate if the core is
idle or not. This is unnecessary. If a thread of a core is not idle, skip
evaluating other threads of a core. Also while clearing the cpumask, bits
of all CPUs of a core can be cleared in one-shot.

Collecting ticks on a Power 9 SMT 8 system around select_idle_core
while running schbench shows us

(units are in ticks, hence lesser is better)
Without patch
    N        Min     Max     Median         Avg      Stddev
x 130        151    1083        284   322.72308   144.41494

With patch
    N        Min     Max     Median         Avg      Stddev   Improvement
x 164         88     610        201   225.79268   106.78943        30.03%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lkml.kernel.org/r/20191206172422.6578-1-srikar@linux.vnet.ibm.com
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 199d1476bb90..b058a9ceba7f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5787,10 +5787,12 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			__cpumask_clear_cpu(cpu, cpus);
-			if (!available_idle_cpu(cpu))
+			if (!available_idle_cpu(cpu)) {
 				idle = false;
+				break;
+			}
 		}
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
-- 
2.16.4

