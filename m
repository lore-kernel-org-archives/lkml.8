Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A8C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFDD2076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgDHMVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:21:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDHMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:21:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9hR-0006BX-3V; Wed, 08 Apr 2020 14:20:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A9EB91C0131;
        Wed,  8 Apr 2020 14:20:56 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:56 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Improve 'invalid wait context' splat
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158634845623.28353.3377386291983303791.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     9a019db0b6bebc84d6b64636faf73ed6d64cd4bb
Gitweb:        https://git.kernel.org/tip/9a019db0b6bebc84d6b64636faf73ed6d64cd4bb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 31 Mar 2020 20:38:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 12:05:07 +02:00

locking/lockdep: Improve 'invalid wait context' splat

The 'invalid wait context' splat doesn't print all the information
required to reconstruct / validate the error, specifically the
irq-context state is missing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 51 +++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1511690..ac10db6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3952,10 +3952,36 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	return ret;
 }
 
+static inline short task_wait_context(struct task_struct *curr)
+{
+	/*
+	 * Set appropriate wait type for the context; for IRQs we have to take
+	 * into account force_irqthread as that is implied by PREEMPT_RT.
+	 */
+	if (curr->hardirq_context) {
+		/*
+		 * Check if force_irqthreads will run us threaded.
+		 */
+		if (curr->hardirq_threaded || curr->irq_config)
+			return LD_WAIT_CONFIG;
+
+		return LD_WAIT_SPIN;
+	} else if (curr->softirq_context) {
+		/*
+		 * Softirqs are always threaded.
+		 */
+		return LD_WAIT_CONFIG;
+	}
+
+	return LD_WAIT_MAX;
+}
+
 static int
 print_lock_invalid_wait_context(struct task_struct *curr,
 				struct held_lock *hlock)
 {
+	short curr_inner;
+
 	if (!debug_locks_off())
 		return 0;
 	if (debug_locks_silent)
@@ -3971,6 +3997,10 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	print_lock(hlock);
 
 	pr_warn("other info that might help us debug this:\n");
+
+	curr_inner = task_wait_context(curr);
+	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);
+
 	lockdep_print_held_locks(curr);
 
 	pr_warn("stack backtrace:\n");
@@ -4017,26 +4047,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	}
 	depth++;
 
-	/*
-	 * Set appropriate wait type for the context; for IRQs we have to take
-	 * into account force_irqthread as that is implied by PREEMPT_RT.
-	 */
-	if (curr->hardirq_context) {
-		/*
-		 * Check if force_irqthreads will run us threaded.
-		 */
-		if (curr->hardirq_threaded || curr->irq_config)
-			curr_inner = LD_WAIT_CONFIG;
-		else
-			curr_inner = LD_WAIT_SPIN;
-	} else if (curr->softirq_context) {
-		/*
-		 * Softirqs are always threaded.
-		 */
-		curr_inner = LD_WAIT_CONFIG;
-	} else {
-		curr_inner = LD_WAIT_MAX;
-	}
+	curr_inner = task_wait_context(curr);
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
