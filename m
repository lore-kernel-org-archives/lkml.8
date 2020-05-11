Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B8BC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E62120836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgEKVER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731916AbgEKU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41390C061A0C;
        Mon, 11 May 2020 13:59:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWR-0005m4-7N; Mon, 11 May 2020 22:59:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F4551C0838;
        Mon, 11 May 2020 22:59:25 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:25 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Allow rcu_read_unlock_trace() under
 scheduler locks
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076530.390.5183687395305308409.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b38f57c1fe64276773b124dffb0a139cc32ab3cb
Gitweb:        https://git.kernel.org/tip/b38f57c1fe64276773b124dffb0a139cc32ab3cb
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 20 Mar 2020 14:29:08 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks

The rcu_read_unlock_trace() can invoke rcu_read_unlock_trace_special(),
which in turn can call wake_up().  Therefore, if any scheduler lock is
held across a call to rcu_read_unlock_trace(), self-deadlock can occur.
This commit therefore uses the irq_work facility to defer the wake_up()
to a clean environment where no scheduler locks will be held.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
[ paulmck: Update #includes for m68k per kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h  | 12 +++++++++++-
 kernel/rcu/update.c |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a9e8ecb..dd311e9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -729,6 +729,16 @@ void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
 
+/*
+ * This irq_work handler allows rcu_read_unlock_trace() to be invoked
+ * while the scheduler locks are held.
+ */
+static void rcu_read_unlock_iw(struct irq_work *iwp)
+{
+	wake_up(&trc_wait);
+}
+static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
+
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
@@ -742,7 +752,7 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
 	WRITE_ONCE(t->trc_reader_nesting, nesting);
 	if (nq && atomic_dec_and_test(&trc_n_readers_need_end))
-		wake_up(&trc_wait);
+		irq_work_queue(&rcu_tasks_trace_iw);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c579934..b1f07a0 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -41,6 +41,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/kprobes.h>
 #include <linux/slab.h>
+#include <linux/irq_work.h>
 
 #define CREATE_TRACE_POINTS
 
