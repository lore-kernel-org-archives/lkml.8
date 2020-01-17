Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ECBC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513A124681
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAQKKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:10:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgAQKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYX-0005SH-42; Fri, 17 Jan 2020 11:08:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DC8EF1C19CE;
        Fri, 17 Jan 2020 11:08:41 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:41 -0000
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: move rq parameter in
 irqtime_account_process_tick
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <157925572173.396.14623531131441259192.tip-bot2@tip-bot2>
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

Commit-ID:     9dec1b6949ae9509cdc3edb2d75fda39c9db9fa2
Gitweb:        https://git.kernel.org/tip/9dec1b6949ae9509cdc3edb2d75fda39c9db9fa2
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Thu, 02 Jan 2020 18:07:52 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:21 +01:00

sched/cputime: move rq parameter in irqtime_account_process_tick

Every time we call irqtime_account_process_tick() is in a interrupt,
Every caller will get and assign a parameter rq = this_rq(), This is
unnecessary and increase the code size a little bit. Move the rq getting
action to irqtime_account_process_tick internally is better.

             base               with this patch
cputime.o    578792 bytes        577888 bytes

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com
---
 kernel/sched/cputime.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d43318a..cff3e65 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -355,7 +355,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
  * softirq as those do not count in task exec_runtime any more.
  */
 static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-					 struct rq *rq, int ticks)
+					 int ticks)
 {
 	u64 other, cputime = TICK_NSEC * ticks;
 
@@ -381,7 +381,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
 	} else if (user_tick) {
 		account_user_time(p, cputime);
-	} else if (p == rq->idle) {
+	} else if (p == this_rq()->idle) {
 		account_idle_time(cputime);
 	} else if (p->flags & PF_VCPU) { /* System time or guest time */
 		account_guest_time(p, cputime);
@@ -392,14 +392,12 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 
 static void irqtime_account_idle_ticks(int ticks)
 {
-	struct rq *rq = this_rq();
-
-	irqtime_account_process_tick(current, 0, rq, ticks);
+	irqtime_account_process_tick(current, 0, ticks);
 }
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
 static inline void irqtime_account_idle_ticks(int ticks) { }
 static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-						struct rq *rq, int nr_ticks) { }
+						int nr_ticks) { }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 /*
@@ -473,13 +471,12 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 void account_process_tick(struct task_struct *p, int user_tick)
 {
 	u64 cputime, steal;
-	struct rq *rq = this_rq();
 
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 
 	if (sched_clock_irqtime) {
-		irqtime_account_process_tick(p, user_tick, rq, 1);
+		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
 
@@ -493,7 +490,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 
 	if (user_tick)
 		account_user_time(p, cputime);
-	else if ((p != rq->idle) || (irq_count() != HARDIRQ_OFFSET))
+	else if ((p != this_rq()->idle) || (irq_count() != HARDIRQ_OFFSET))
 		account_system_time(p, HARDIRQ_OFFSET, cputime);
 	else
 		account_idle_time(cputime);
