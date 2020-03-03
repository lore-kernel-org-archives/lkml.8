Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B52C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885AF20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgCCLDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:03:33 -0500
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:45553 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgCCLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:03:33 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 7AD72FA7F9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 11:03:31 +0000 (GMT)
Received: (qmail 15378 invoked from network); 3 Mar 2020 11:03:31 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 3 Mar 2020 11:03:31 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paul McKenney <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/3] sched/fair: Fix kernel build warning in test_idle_cores() for !SMT NUMA
Date:   Tue,  3 Mar 2020 11:02:57 +0000
Message-Id: <20200303110258.1092-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303110258.1092-1-mgorman@techsingularity.net>
References: <20200303110258.1092-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

From: Valentin Schneider <valentin.schneider@arm.com>

Building against the tip/sched/core as ff7db0bf24db ("sched/numa: Prefer
using an idle CPU as a migration target instead of comparing tasks") with
the arm64 defconfig (which doesn't have CONFIG_SCHED_SMT set) leads to:

  kernel/sched/fair.c:1525:20: warning: 'test_idle_cores' declared 'static' but never defined [-Wunused-function]
   static inline bool test_idle_cores(int cpu, bool def);
		      ^~~~~~~~~~~~~~~

Rather than define it in its own CONFIG_SCHED_SMT #define island, bunch it
up with test_idle_cores().

Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
[mgorman@techsingularity.net: Edit changelog, minor style change]
Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b5d5e5e701e..33622bbfcea7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1520,9 +1520,6 @@ static inline bool is_core_idle(int cpu)
 	return true;
 }
 
-/* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu, bool def);
-
 struct task_numa_env {
 	struct task_struct *p;
 
@@ -1558,9 +1555,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 	return node_fully_busy;
 }
 
+#ifdef CONFIG_SCHED_SMT
+/* Forward declarations of select_idle_sibling helpers */
+static inline bool test_idle_cores(int cpu, bool def);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
-#ifdef CONFIG_SCHED_SMT
 	if (!static_branch_likely(&sched_smt_present) ||
 	    idle_core >= 0 || !test_idle_cores(cpu, false))
 		return idle_core;
@@ -1571,10 +1570,15 @@ static inline int numa_idle_core(int idle_core, int cpu)
 	 */
 	if (is_core_idle(cpu))
 		idle_core = cpu;
-#endif
 
 	return idle_core;
 }
+#else
+static inline int numa_idle_core(int idle_core, int cpu)
+{
+	return idle_core;
+}
+#endif
 
 /*
  * Gather all necessary information to make NUMA balancing placement
-- 
2.16.4

