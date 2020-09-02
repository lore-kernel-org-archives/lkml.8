Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A2F20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DTW8EqKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgIBQDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:03:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F845C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8wXbeiYpiyC/FwlZaBrMqiVCBYUCNC8eflkT/nMFfyg=; b=DTW8EqKpvS16FUEoxqa0HEJhyr
        hCqIyuHwSZRJvsPI3tNrerAeulqWow56KWpfeOasD/PD190Bk+/WGQggLdMQqr0ro9+bbaJikDBz2
        FcVK+Vl4oAPgJ2YUH/0ErBH4uLcn1Pp+eAUL5unNX1MV7STLw8gcjvGrF1mMOtJWUK68vvymn8iS1
        gkCmUY7Xb4itpRJV/6DBo9TRbAyxt7UBOvEFzWryoWQGBkyFXoXPIEbkdxXiYC8QTUCXt/huB0sLu
        NgpF4r3l3sAKZg2Ci+loebLVn8jk/ebIlLP0w5gJLv43yPJnhbYdMAalIxAxPq4b7g5Rkpq9u0EqI
        VNFD9f0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDVEK-000579-0b; Wed, 02 Sep 2020 16:03:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25E163003E5;
        Wed,  2 Sep 2020 18:03:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13AA02127D319; Wed,  2 Sep 2020 18:03:23 +0200 (CEST)
Date:   Wed, 2 Sep 2020 18:03:23 +0200
From:   peterz@infradead.org
To:     mingo@kernel.org, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, frederic@kernel.org,
        joel@joelfernandes.org
Subject: [PATCH] lockdep: Fix "USED" <- "IN-NMI" inversions
Message-ID: <20200902160323.GK1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cccf4bc759c6..454355c033d2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4324,13 +4324,18 @@ static int separate_irq_context(struct task_struct *curr,
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
@@ -4343,13 +4348,22 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
 
@@ -4363,6 +4377,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			return 0;
 	}
 
+unlock:
 	graph_unlock();
 
 	/*
@@ -5297,12 +5312,20 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
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
index baca699b94e9..b0be1560ed17 100644
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
