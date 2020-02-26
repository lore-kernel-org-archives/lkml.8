Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96574C4BA04
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0972467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgBZMNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:13:11 -0500
Received: from foss.arm.com ([217.140.110.172]:35052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgBZMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:13:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FE831FB;
        Wed, 26 Feb 2020 04:13:10 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 901653FA00;
        Wed, 26 Feb 2020 04:13:09 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] sched/fair: Fix unused prototype warning
Date:   Wed, 26 Feb 2020 12:12:44 +0000
Message-Id: <20200226121244.7524-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building against the latest tip/sched/core

  a0f03b617c3b ("sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found")

with the arm64 defconfig (which doesn't have CONFIG_SCHED_SMT set) leads
to:

  kernel/sched/fair.c:1525:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]
   static inline bool test_idle_cores(int cpu, bool def);
		      ^~~~~~~~~~~~~~~

Rather than define it in its own CONFIG_SCHED_SMT #define island, bunch it
up with test_idle_cores().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..fa048cba6077 100644
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
@@ -1571,10 +1570,12 @@ static inline int numa_idle_core(int idle_core, int cpu)
 	 */
 	if (is_core_idle(cpu))
 		idle_core = cpu;
-#endif
 
 	return idle_core;
 }
+#else
+static inline int numa_idle_core(int idle_core, int cpu) { return idle_core; }
+#endif
 
 /*
  * Gather all necessary information to make NUMA balancing placement
-- 
2.24.0

