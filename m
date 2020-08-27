Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F192922BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vt9pXnuM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FlWsXzof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgH0HzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:55:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgH0Hyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:33 -0400
Date:   Thu, 27 Aug 2020 07:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS0B/Fc8ttTFAoYL2xaPmYpFUqXrIKnco5J+1jeN79U=;
        b=Vt9pXnuMCkejGTYz5kqZ6z/NmYGhEFkyyGhG2+4ACAdAKvUZ/mj9M6wJ5X69YJmMZzfCe6
        o35tYqZuMjZXOAnTxNSyhsTlRd34gtoK48IMptO7bwZmO1sb5lAoAih7nynGRREdwAEspS
        oYAig0Kw9g6z6/mHrdILSSr1KmRyJCuHAyLqQ0k2Gozgo8txTrJhhazaE1ud7vlBvGpJXe
        0n49nvb+kOXo9FUdZOkKNS3Nonif5q0uDoxVvHHsjLlZKve2NYIWWXJwHxDoBOAZCVpa35
        BZsefmRewOrn+mUVZNlsxiIzhUPvd2m9Zrp+e0JwiYsxTAUvUlQJEzW/PSP7Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS0B/Fc8ttTFAoYL2xaPmYpFUqXrIKnco5J+1jeN79U=;
        b=FlWsXzofzP5gkKUmCRI7fbIS0y0JVRiq9wUGpLoj5vz5nqO6rs7TusFdRtlFfgaAdyRXt3
        Hjn36YDBFFsHvtAQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Cache task_struct::flags in sched_submit_work()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200819200025.lqvmyefqnbok5i4f@linutronix.de>
References: <20200819200025.lqvmyefqnbok5i4f@linutronix.de>
MIME-Version: 1.0
Message-ID: <159851487131.20229.10063015332671420555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c1cecf884ad748f63f9139d5a18ee265ee2f70fb
Gitweb:        https://git.kernel.org/tip/c1cecf884ad748f63f9139d5a18ee265ee2f70fb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 19 Aug 2020 22:00:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:58 +02:00

sched: Cache task_struct::flags in sched_submit_work()

sched_submit_work() is considered to be a hot path. The preempt_disable()
instruction is a compiler barrier and forces the compiler to load
task_struct::flags for the second comparison.
By using a local variable, the compiler can load the value once and keep it in
a register for the second comparison.

Verified on x86-64 with gcc-10.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200819200025.lqvmyefqnbok5i4f@linutronix.de
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f..c36dc1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4551,9 +4551,12 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
+	unsigned int task_flags;
+
 	if (!tsk->state)
 		return;
 
+	task_flags = tsk->flags;
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
@@ -4562,9 +4565,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
 	 * requires it.
 	 */
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		preempt_disable();
-		if (tsk->flags & PF_WQ_WORKER)
+		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
