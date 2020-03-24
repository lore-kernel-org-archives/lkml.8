Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0BC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E242145D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCXJTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgCXJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffy-00083t-N0; Tue, 24 Mar 2020 10:16:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BACE11C04D4;
        Tue, 24 Mar 2020 10:16:40 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:40 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: *_ONCE() for rcu_tasks_cbs_head
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140043.28353.3341465329368209906.tip-bot2@tip-bot2>
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

Commit-ID:     fcb7381265e6cceb1d54283878d145db52b9d9d7
Gitweb:        https://git.kernel.org/tip/fcb7381265e6cceb1d54283878d145db52b9d9d7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 06 Jan 2020 11:59:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:00:45 -08:00

rcu-tasks: *_ONCE() for rcu_tasks_cbs_head

The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
single potential store outside of rcu_tasks_kthread.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 6c4b862..a27df76 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -528,7 +528,7 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
 	rhp->func = func;
 	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
 	needwake = !rcu_tasks_cbs_head;
-	*rcu_tasks_cbs_tail = rhp;
+	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
 	rcu_tasks_cbs_tail = &rhp->next;
 	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
 	/* We can't create the thread unless interrupts are enabled. */
@@ -658,7 +658,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		/* If there were none, wait a bit and start over. */
 		if (!list) {
 			wait_event_interruptible(rcu_tasks_cbs_wq,
-						 rcu_tasks_cbs_head);
+						 READ_ONCE(rcu_tasks_cbs_head));
 			if (!rcu_tasks_cbs_head) {
 				WARN_ON(signal_pending(current));
 				schedule_timeout_interruptible(HZ/10);
