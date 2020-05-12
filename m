Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE19C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ABD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgELPNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgELPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:13:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F1FC061A0C;
        Tue, 12 May 2020 08:13:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYWb1-00074F-9G; Tue, 12 May 2020 17:13:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C0B721C02FC;
        Tue, 12 May 2020 17:13:26 +0200 (CEST)
Date:   Tue, 12 May 2020 15:13:26 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make scheduler_ipi inline
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134058.453581595@linutronix.de>
References: <20200505134058.453581595@linutronix.de>
MIME-Version: 1.0
Message-ID: <158929640661.390.13262559099538803651.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2a0a24ebb499c9d499eea948d3fc108f936e36d4
Gitweb:        https://git.kernel.org/tip/2a0a24ebb499c9d499eea948d3fc108f936e36d4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 27 Mar 2020 12:42:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 17:10:49 +02:00

sched: Make scheduler_ipi inline

Now that the scheduler IPI is trivial and simple again there is no point to
have the little function out of line. This simplifies the effort of
constraining the instrumentation nicely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134058.453581595@linutronix.de
---
 include/linux/sched.h | 10 +++++++++-
 kernel/sched/core.c   | 10 ----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5c..d4ea440 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1715,7 +1715,15 @@ extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
 })
 
 #ifdef CONFIG_SMP
-void scheduler_ipi(void);
+static __always_inline void scheduler_ipi(void)
+{
+	/*
+	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
+	 * TIF_NEED_RESCHED remotely (for the first time) will also send
+	 * this IPI.
+	 */
+	preempt_fold_need_resched();
+}
 extern unsigned long wait_task_inactive(struct task_struct *, long match_state);
 #else
 static inline void scheduler_ipi(void) { }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cd2070d..74fb89b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2312,16 +2312,6 @@ static void wake_csd_func(void *info)
 	sched_ttwu_pending();
 }
 
-void scheduler_ipi(void)
-{
-	/*
-	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
-	 * TIF_NEED_RESCHED remotely (for the first time) will also send
-	 * this IPI.
-	 */
-	preempt_fold_need_resched();
-}
-
 static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
