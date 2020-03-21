Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8297C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ABE20757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCUPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:53:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCUPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRX-0005Rd-KF; Sat, 21 Mar 2020 16:53:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 33F131C22EF;
        Sat, 21 Mar 2020 16:53:47 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/swait: Prepare usage in completions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113242.228481202@linutronix.de>
References: <20200321113242.228481202@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602688.28353.9251110165142890607.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b3212fe2bc06fa1014b3063b85b2bac4332a1c28
Gitweb:        https://git.kernel.org/tip/b3212fe2bc06fa1014b3063b85b2bac4332a1c28
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:25:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:23 +01:00

sched/swait: Prepare usage in completions

As a preparation to use simple wait queues for completions:

  - Provide swake_up_all_locked() to support complete_all()
  - Make __prepare_to_swait() public available

This is done to enable the usage of complete() within truly atomic contexts
on a PREEMPT_RT enabled kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113242.228481202@linutronix.de
---
 kernel/sched/sched.h |  3 +++
 kernel/sched/swait.c | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ea6478..fdc77e7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2492,3 +2492,6 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 	return true;
 }
 #endif
+
+void swake_up_all_locked(struct swait_queue_head *q);
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e83a3f8..e1c655f 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -32,6 +32,19 @@ void swake_up_locked(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_locked);
 
+/*
+ * Wake up all waiters. This is an interface which is solely exposed for
+ * completions and not for general usage.
+ *
+ * It is intentionally different from swake_up_all() to allow usage from
+ * hard interrupt context and interrupt disabled regions.
+ */
+void swake_up_all_locked(struct swait_queue_head *q)
+{
+	while (!list_empty(&q->task_list))
+		swake_up_locked(q);
+}
+
 void swake_up_one(struct swait_queue_head *q)
 {
 	unsigned long flags;
@@ -69,7 +82,7 @@ void swake_up_all(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_all);
 
-static void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
 	if (list_empty(&wait->task_list))
