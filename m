Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD59420709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WFmCzD4N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OfqRvd0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgICJxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:53:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53202 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICJxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:53:06 -0400
Date:   Thu, 03 Sep 2020 09:53:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599126783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/kD0C2ce/PG0VaecIEgH1SPucWeW3p3tVJLCyotnaM=;
        b=WFmCzD4NjT+oFM2ZRJ1uDWZlT4s+tTuZ1ikizT1PccE6Fl0Kv2xuvkgIwnnhzyUHMkaLAD
        nfnDAzOsNdlVQvWFAvGIvhg8j6Pdkr9eatmJQS0+Z/CS/hAmNQGzzejQfj734WfkytcK+K
        87zciz/+5fDHFvK15ik+kZffmjiVJ8CyMNgNqZB4VHMcnIhOaqk31hI50A7mlin1m4XyqM
        Ocst2lW+2UGl+9j3bJKCadySr7iYv6BYYQLYTbplns12eKagQLqaTCB4ngfxEYkMbkKIRO
        YqU0Kf2jqOXpHoFXF6mwo00IS06Se6pZWJD8QgBjFNwe6o6cPLJbIco4wtjZmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599126783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/kD0C2ce/PG0VaecIEgH1SPucWeW3p3tVJLCyotnaM=;
        b=OfqRvd0v6Lo5895QArcnF/tQtQYUsr/778vQX5nqEGgOdxGffeX6tHGA0I1UErAFCTyI1H
        w8Wlw+2qxPCfJdDw==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Fix "USED" <- "IN-NMI" inversions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902160323.GK1362448@hirez.programming.kicks-ass.net>
References: <20200902160323.GK1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159912678267.20229.6272648886640686007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     23870f1227680d2aacff6f79c3ab2222bd04e86e
Gitweb:        https://git.kernel.org/tip/23870f1227680d2aacff6f79c3ab2222bd04e86e
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 18:03:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Sep 2020 11:19:42 +02:00

locking/lockdep: Fix "USED" <- "IN-NMI" inversions

During the LPC RCU BoF Paul asked how come the "USED" <- "IN-NMI"
detector doesn't trip over rcu_read_lock()'s lockdep annotation.

Looking into this I found a very embarrasing typo in
verify_lock_unused():

	-	if (!(class->usage_mask & LOCK_USED))
	+	if (!(class->usage_mask & LOCKF_USED))

fixing that will indeed cause rcu_read_lock() to insta-splat :/

The above typo means that instead of testing for: 0x100 (1 <<
LOCK_USED), we test for 8 (LOCK_USED), which corresponds to (1 <<
LOCK_ENABLED_HARDIRQ).

So instead of testing for _any_ used lock, it will only match any lock
used with interrupts enabled.

The rcu_read_lock() annotation uses .check=0, which means it will not
set any of the interrupt bits and will thus never match.

In order to properly fix the situation and allow rcu_read_lock() to
correctly work, split LOCK_USED into LOCK_USED and LOCK_USED_READ and by
having .read users set USED_READ and test USED, pure read-recursive
locks are permitted.

Fixes: f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20200902160323.GK1362448@hirez.programming.kicks-ass.net
---
 kernel/locking/lockdep.c           | 35 ++++++++++++++++++++++++-----
 kernel/locking/lockdep_internals.h |  2 ++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 54b74fa..2facbbd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3969,13 +3969,18 @@ static int separate_irq_context(struct task_struct *curr,
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			     enum lock_usage_bit new_bit)
 {
-	unsigned int new_mask = 1 << new_bit, ret = 1;
+	unsigned int old_mask, new_mask, ret = 1;
 
 	if (new_bit >= LOCK_USAGE_STATES) {
 		DEBUG_LOCKS_WARN_ON(1);
 		return 0;
 	}
 
+	if (new_bit == LOCK_USED && this->read)
+		new_bit = LOCK_USED_READ;
+
+	new_mask = 1 << new_bit;
+
 	/*
 	 * If already set then do not dirty the cacheline,
 	 * nor do any checks:
@@ -3988,13 +3993,22 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	/*
 	 * Make sure we didn't race:
 	 */
-	if (unlikely(hlock_class(this)->usage_mask & new_mask)) {
-		graph_unlock();
-		return 1;
-	}
+	if (unlikely(hlock_class(this)->usage_mask & new_mask))
+		goto unlock;
 
+	old_mask = hlock_class(this)->usage_mask;
 	hlock_class(this)->usage_mask |= new_mask;
 
+	/*
+	 * Save one usage_traces[] entry and map both LOCK_USED and
+	 * LOCK_USED_READ onto the same entry.
+	 */
+	if (new_bit == LOCK_USED || new_bit == LOCK_USED_READ) {
+		if (old_mask & (LOCKF_USED | LOCKF_USED_READ))
+			goto unlock;
+		new_bit = LOCK_USED;
+	}
+
 	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
 		return 0;
 
@@ -4008,6 +4022,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			return 0;
 	}
 
+unlock:
 	graph_unlock();
 
 	/*
@@ -4942,12 +4957,20 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
 {
 #ifdef CONFIG_PROVE_LOCKING
 	struct lock_class *class = look_up_lock_class(lock, subclass);
+	unsigned long mask = LOCKF_USED;
 
 	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
 	if (!class)
 		return;
 
-	if (!(class->usage_mask & LOCK_USED))
+	/*
+	 * READ locks only conflict with USED, such that if we only ever use
+	 * READ locks, there is no deadlock possible -- RCU.
+	 */
+	if (!hlock->read)
+		mask |= LOCKF_USED_READ;
+
+	if (!(class->usage_mask & mask))
 		return;
 
 	hlock->class_idx = class - lock_classes;
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index baca699..b0be156 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -19,6 +19,7 @@ enum lock_usage_bit {
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	LOCK_USED,
+	LOCK_USED_READ,
 	LOCK_USAGE_STATES
 };
 
@@ -40,6 +41,7 @@ enum {
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	__LOCKF(USED)
+	__LOCKF(USED_READ)
 };
 
 #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE |
