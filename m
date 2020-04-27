Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C558C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636C32087E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgD0Ih5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:37:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgD0Ih4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:37:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3265A139F;
        Mon, 27 Apr 2020 01:37:56 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB86C3F68F;
        Mon, 27 Apr 2020 01:37:51 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] sched/deadline: Implement fallback mechanism for !fit case
Date:   Mon, 27 Apr 2020 10:37:09 +0200
Message-Id: <20200427083709.30262-7-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427083709.30262-1-dietmar.eggemann@arm.com>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Abeni <luca.abeni@santannapisa.it>

When a task has a runtime that cannot be served within the scheduling
deadline by any of the idle CPU (later_mask) the task is doomed to miss
its deadline.

This can happen since the SCHED_DEADLINE admission control guarantees
only bounded tardiness and not the hard respect of all deadlines.
In this case try to select the idle CPU with the largest CPU capacity
to minimize tardiness.

Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpudeadline.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8630f2a40a3f..b6c7a0bc0880 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -121,19 +121,30 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 	if (later_mask &&
 	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
-		int cpu;
+		unsigned long cap, max_cap = 0;
+		int cpu, max_cpu = -1;
 
 		if (!static_branch_unlikely(&sched_asym_cpucapacity))
 			return 1;
 
 		/* Ensure the capacity of the CPUs fits the task. */
 		for_each_cpu(cpu, later_mask) {
-			if (!dl_task_fits_capacity(p, cpu))
+			if (!dl_task_fits_capacity(p, cpu)) {
 				cpumask_clear_cpu(cpu, later_mask);
+
+				cap = capacity_orig_of(cpu);
+
+				if (cap > max_cap) {
+					max_cap = cap;
+					max_cpu = cpu;
+				}
+			}
 		}
 
-		if (!cpumask_empty(later_mask))
-			return 1;
+		if (cpumask_empty(later_mask))
+			cpumask_set_cpu(max_cpu, later_mask);
+
+		return 1;
 	} else {
 		int best_cpu = cpudl_maximum(cp);
 
-- 
2.17.1

