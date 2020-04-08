Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C47C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61522083E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgDHMVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:21:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49636 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgDHMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gu-00063W-D7; Wed, 08 Apr 2020 14:20:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F00AD1C0131;
        Wed,  8 Apr 2020 14:20:23 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:23 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Factor out printing formats into
 common macros
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200226124543.31986-3-valentin.schneider@arm.com>
References: <20200226124543.31986-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158634842347.28353.13932771277221700536.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9e3bf9469c29f7e4e49c5c0d8fecaf8ac57d1fe4
Gitweb:        https://git.kernel.org/tip/9e3bf9469c29f7e4e49c5c0d8fecaf8ac57d1fe4
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 26 Feb 2020 12:45:42 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:26 +02:00

sched/debug: Factor out printing formats into common macros

The printing macros in debug.c keep redefining the same output
format. Collect each output format in a single definition, and reuse that
definition in the other macros. While at it, add a layer of parentheses and
replace printf's  with the newly introduced macros.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200226124543.31986-3-valentin.schneider@arm.com
---
 kernel/sched/debug.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4670151..315ef6d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -816,10 +816,12 @@ static int __init init_sched_debug_procfs(void)
 
 __initcall(init_sched_debug_procfs);
 
-#define __P(F)	SEQ_printf(m, "%-45s:%21Ld\n",	     #F, (long long)F)
-#define   P(F)	SEQ_printf(m, "%-45s:%21Ld\n",	     #F, (long long)p->F)
-#define __PN(F)	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define   PN(F)	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)p->F))
+#define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
+#define __P(F) __PS(#F, F)
+#define   P(F) __PS(#F, p->F)
+#define __PSN(S, F) SEQ_printf(m, "%-45s:%14Ld.%06ld\n", S, SPLIT_NS((long long)(F)))
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
