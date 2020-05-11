Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3431BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2179D2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgEKVDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731981AbgEKU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0BC061A0C;
        Mon, 11 May 2020 13:59:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWY-0005rc-3Z; Mon, 11 May 2020 22:59:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D47641C0857;
        Mon, 11 May 2020 22:59:31 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:31 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Use unique names for RCU-Tasks kthreads
 and messages
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077179.390.10203434020604120221.tip-bot2@tip-bot2>
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

Commit-ID:     c97d12a63c26fc4521d0904f073f9997ae796cba
Gitweb:        https://git.kernel.org/tip/c97d12a63c26fc4521d0904f073f9997ae796cba
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 03 Mar 2020 15:50:31 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcu-tasks: Use unique names for RCU-Tasks kthreads and messages

This commit causes the flavors of RCU Tasks to use different names
for their kthreads and in their console messages.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7f9ed20..9ca83c6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -22,6 +22,8 @@ typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @call_func: This flavor's call_rcu()-equivalent function.
+ * @name: This flavor's textual name.
+ * @kname: This flavor's kthread name.
  */
 struct rcu_tasks {
 	struct rcu_head *cbs_head;
@@ -31,16 +33,20 @@ struct rcu_tasks {
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	call_rcu_func_t call_func;
+	char *name;
+	char *kname;
 };
 
-#define DEFINE_RCU_TASKS(name, gp, call)				\
-static struct rcu_tasks name =						\
+#define DEFINE_RCU_TASKS(rt_name, gp, call, n)				\
+static struct rcu_tasks rt_name =					\
 {									\
-	.cbs_tail = &name.cbs_head,					\
-	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(name.cbs_wq),		\
-	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(name.cbs_lock),		\
+	.cbs_tail = &rt_name.cbs_head,					\
+	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),	\
+	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_lock),		\
 	.gp_func = gp,							\
 	.call_func = call,						\
+	.name = n,							\
+	.kname = #rt_name,						\
 }
 
 /* Track exiting tasks in order to allow them to be waited for. */
@@ -145,8 +151,8 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 {
 	struct task_struct *t;
 
-	t = kthread_run(rcu_tasks_kthread, rtp, "rcu_tasks_kthread");
-	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
+	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
+	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
 	smp_mb(); /* Ensure others see full kthread. */
 }
@@ -342,7 +348,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 }
 
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
@@ -437,7 +443,8 @@ static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 }
 
 void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
+DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
+		 "RCU Tasks Rude");
 
 /**
  * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
