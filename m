Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C03C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0D120702
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404498AbgFYLxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404459AbgFYLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D29C061795;
        Thu, 25 Jun 2020 04:53:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRa-0005qA-2q; Thu, 25 Jun 2020 13:53:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BA4831C0092;
        Thu, 25 Jun 2020 13:53:25 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:25 -0000
From:   "tip-bot2 for Steven Rostedt (VMware)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Force the address order of each sched class
 descriptor
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <159308600548.16989.3126944310676712144.tip-bot2@tip-bot2>
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

Commit-ID:     590d69796346353878b275c5512c664e3f875f24
Gitweb:        https://git.kernel.org/tip/590d69796346353878b275c5512c664e3f875f24
Author:        Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate:    Thu, 19 Dec 2019 16:44:52 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:43 +02:00

sched: Force the address order of each sched class descriptor

In order to make a micro optimization in pick_next_task(), the order of the
sched class descriptor address must be in the same order as their priority
to each other. That is:

 &idle_sched_class < &fair_sched_class < &rt_sched_class <
 &dl_sched_class < &stop_sched_class

In order to guarantee this order of the sched class descriptors, add each
one into their own data section and force the order in the linker script.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/157675913272.349305.8936736338884044103.stgit@localhost.localdomain
---
 include/asm-generic/vmlinux.lds.h | 13 +++++++++++++
 kernel/sched/deadline.c           |  3 ++-
 kernel/sched/fair.c               |  3 ++-
 kernel/sched/idle.c               |  3 ++-
 kernel/sched/rt.c                 |  3 ++-
 kernel/sched/stop_task.c          |  3 ++-
 6 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef..2186d7b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -109,6 +109,18 @@
 #endif
 
 /*
+ * The order of the sched class addresses are important, as they are
+ * used to determine the order of the priority of each sched class in
+ * relation to each other.
+ */
+#define SCHED_DATA				\
+	*(__idle_sched_class)			\
+	*(__fair_sched_class)			\
+	*(__rt_sched_class)			\
+	*(__dl_sched_class)			\
+	*(__stop_sched_class)
+
+/*
  * Align to a 32 byte boundary equal to the
  * alignment gcc 4.5 uses for a struct
  */
@@ -388,6 +400,7 @@
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
+		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d4708e2..d9e7946 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2479,7 +2479,8 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	}
 }
 
-const struct sched_class dl_sched_class = {
+const struct sched_class dl_sched_class
+	__attribute__((section("__dl_sched_class"))) = {
 	.next			= &rt_sched_class,
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0424a0a..3365f6b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11122,7 +11122,8 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 /*
  * All the scheduling class methods:
  */
-const struct sched_class fair_sched_class = {
+const struct sched_class fair_sched_class
+	__attribute__((section("__fair_sched_class"))) = {
 	.next			= &idle_sched_class,
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8d75ca2..f580629 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -453,7 +453,8 @@ static void update_curr_idle(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
-const struct sched_class idle_sched_class = {
+const struct sched_class idle_sched_class
+	__attribute__((section("__idle_sched_class"))) = {
 	/* .next is NULL */
 	/* no enqueue/yield_task for idle tasks */
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f395ddb..6543d44 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2429,7 +2429,8 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 		return 0;
 }
 
-const struct sched_class rt_sched_class = {
+const struct sched_class rt_sched_class
+	__attribute__((section("__rt_sched_class"))) = {
 	.next			= &fair_sched_class,
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 3e50a6a..f4bbd54 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -109,7 +109,8 @@ static void update_curr_stop(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU stop tasks:
  */
-const struct sched_class stop_sched_class = {
+const struct sched_class stop_sched_class
+	__attribute__((section("__stop_sched_class"))) = {
 	.next			= &dl_sched_class,
 
 	.enqueue_task		= enqueue_task_stop,
