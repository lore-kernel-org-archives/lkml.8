Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65492C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1721744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbgBYSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:40:33 -0500
Received: from foss.arm.com ([217.140.110.172]:54622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbgBYSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:40:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26FE131B;
        Tue, 25 Feb 2020 09:52:52 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DF573F6CF;
        Tue, 25 Feb 2020 09:52:50 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com
Subject: [PATCH 2/3] sched/debug: Bunch up printing formats in common macros
Date:   Tue, 25 Feb 2020 17:52:26 +0000
Message-Id: <20200225175227.22090-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200225175227.22090-1-valentin.schneider@arm.com>
References: <20200225175227.22090-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printing macros in debug.c keep redefining the same output
format. Collect each output format in a single definition, and reuse that
definition in the other macros. While at it, replace printf's redefining
those formats with the newly introduced macros.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4670151eb131..47411a85087c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -816,10 +816,12 @@ static int __init init_sched_debug_procfs(void)
 
 __initcall(init_sched_debug_procfs);
 
-#define __P(F)	SEQ_printf(m, "%-45s:%21Ld\n",	     #F, (long long)F)
-#define   P(F)	SEQ_printf(m, "%-45s:%21Ld\n",	     #F, (long long)p->F)
-#define __PN(F)	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define   PN(F)	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)p->F))
+#define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)F)
+#define __P(F) __PS(#F, F)
+#define   P(F) __PS(#F, p->F)
+#define __PSN(S, F) SEQ_printf(m, "%-45s:%14Ld.%06ld\n", S, SPLIT_NS((long long)F))
+#define __PN(F) __PSN(#F, F)
+#define   PN(F) __PSN(#F, p->F)
 
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -868,10 +870,9 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	SEQ_printf(m,
 		"---------------------------------------------------------"
 		"----------\n");
-#define P_SCHEDSTAT(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)schedstat_val(p->F))
-#define PN_SCHEDSTAT(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(p->F)))
+
+#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
+#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
 
 	PN(se.exec_start);
 	PN(se.vruntime);
@@ -931,10 +932,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	}
 
 	__P(nr_switches);
-	SEQ_printf(m, "%-45s:%21Ld\n",
-		   "nr_voluntary_switches", (long long)p->nvcsw);
-	SEQ_printf(m, "%-45s:%21Ld\n",
-		   "nr_involuntary_switches", (long long)p->nivcsw);
+	__PS("nr_voluntary_switches", p->nvcsw);
+	__PS("nr_involuntary_switches", p->nivcsw);
 
 	P(se.load.weight);
 #ifdef CONFIG_SMP
@@ -963,8 +962,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 
 		t0 = cpu_clock(this_cpu);
 		t1 = cpu_clock(this_cpu);
-		SEQ_printf(m, "%-45s:%21Ld\n",
-			   "clock-delta", (long long)(t1-t0));
+		__PS("clock-delta", t1-t0);
 	}
 
 	sched_show_numa(p, m);
-- 
2.24.0

