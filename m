Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF5FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B0B20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404549AbgFYLyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404454AbgFYLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60200C061573;
        Thu, 25 Jun 2020 04:53:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRZ-0005q4-AE; Thu, 25 Jun 2020 13:53:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E03751C0092;
        Thu, 25 Jun 2020 13:53:24 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:24 -0000
From:   "tip-bot2 for Steven Rostedt (VMware)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove struct sched_class::next field
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191219214558.845353593@goodmis.org>
References: <20191219214558.845353593@goodmis.org>
MIME-Version: 1.0
Message-ID: <159308600465.16989.7710940468649004258.tip-bot2@tip-bot2>
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

Commit-ID:     a87e749e8fa1aaef9b4db32e21c2795e69ce67bf
Gitweb:        https://git.kernel.org/tip/a87e749e8fa1aaef9b4db32e21c2795e69ce67bf
Author:        Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate:    Thu, 19 Dec 2019 16:44:54 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:44 +02:00

sched: Remove struct sched_class::next field

Now that the sched_class descriptors are defined in order via the linker
script vmlinux.lds.h, there's no reason to have a "next" pointer to the
previous priroity structure. The order of the sturctures can be aligned as
an array, and used to index and find the next sched_class descriptor.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191219214558.845353593@goodmis.org
---
 kernel/sched/deadline.c  | 1 -
 kernel/sched/fair.c      | 1 -
 kernel/sched/idle.c      | 1 -
 kernel/sched/rt.c        | 1 -
 kernel/sched/sched.h     | 1 -
 kernel/sched/stop_task.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9e7946..c9cc1d6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2481,7 +2481,6 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 
 const struct sched_class dl_sched_class
 	__attribute__((section("__dl_sched_class"))) = {
-	.next			= &rt_sched_class,
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3365f6b..a63f400 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11124,7 +11124,6 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
  */
 const struct sched_class fair_sched_class
 	__attribute__((section("__fair_sched_class"))) = {
-	.next			= &idle_sched_class,
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f580629..336d478 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -455,7 +455,6 @@ static void update_curr_idle(struct rq *rq)
  */
 const struct sched_class idle_sched_class
 	__attribute__((section("__idle_sched_class"))) = {
-	/* .next is NULL */
 	/* no enqueue/yield_task for idle tasks */
 
 	/* dequeue is not valid, we print a debug message there: */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6543d44..f215eea 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2431,7 +2431,6 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 
 const struct sched_class rt_sched_class
 	__attribute__((section("__rt_sched_class"))) = {
-	.next			= &fair_sched_class,
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4165c06..549e7e6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1754,7 +1754,6 @@ extern const u32		sched_prio_to_wmult[40];
 #define RETRY_TASK		((void *)-1UL)
 
 struct sched_class {
-	const struct sched_class *next;
 
 #ifdef CONFIG_UCLAMP_TASK
 	int uclamp_enabled;
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index f4bbd54..394bc81 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -111,7 +111,6 @@ static void update_curr_stop(struct rq *rq)
  */
 const struct sched_class stop_sched_class
 	__attribute__((section("__stop_sched_class"))) = {
-	.next			= &dl_sched_class,
 
 	.enqueue_task		= enqueue_task_stop,
 	.dequeue_task		= dequeue_task_stop,
