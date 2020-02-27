Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB31FC54FF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D66E24688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgB0OCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:02:33 -0500
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:37069 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733117AbgB0OC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:02:27 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id C9D13FA874
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:02:25 +0000 (GMT)
Received: (qmail 3656 invoked from network); 27 Feb 2020 14:02:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Feb 2020 14:02:25 -0000
Date:   Thu, 27 Feb 2020 14:02:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH] sched/fair: Fix kernel build warning in test_idle_cores()
 for !SMT NUMA
Message-ID: <20200227140222.GH3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building against tip/sched/core as of as ff7db0bf24db ("sched/numa: Prefer
using an idle CPU as a migration target instead of comparing tasks") with
the arm64 defconfig (which doesn't have CONFIG_SCHED_SMT set) leads to:

  kernel/sched/fair.c:1525:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]
   static inline bool test_idle_cores(int cpu, bool def);
		      ^~~~~~~~~~~~~~~

Rather than define it in its own CONFIG_SCHED_SMT #define island, bunch it
up with test_idle_cores().

Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
[mgorman@techsingularity.net: Edit changelog, minor style change]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..10f9e6729fcf 100644
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
