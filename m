Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E262224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPgv1US9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHGTeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHGTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:34:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31FC061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=q7qulpqAdX36SfnH7+5yo69CQ5s+D4aJ7X9LFvgh0dc=; b=OPgv1US9Kj0ipv/Yx3OOubA9lq
        Ul8Ou8HB1nNei8N2PYbmLJr9yp73JSvs2xLhONYm5j/+3DUny5hcrVwDOjIQDfIJ4e6Khu0x2bWXz
        aLCZetMQJ5cCtuxs1JB/mRBSuOh6nd5C5//sm9BBRIsfk3u5K3g1aLKHLnfEnnNX8xCqYg3oPuZAv
        G69bQRBVzDqR+EHfmwHq4M/vtFv5S1u1WoZRi0H/ssPTuD9IT+srVqrfgso2/7QGlQqHwPBLWtnx9
        NorRBvLNCQIkehqQqn2zjWqzaJJJ/vY5HQeSGE4YYS1wiN3iOBG40Yd/4B9VgnJw9Llqfm/TNExSl
        K6Farn2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4887-0001mv-1O; Fri, 07 Aug 2020 19:34:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D8733010D2;
        Fri,  7 Aug 2020 21:34:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B75A92B2C82C3; Fri,  7 Aug 2020 21:34:13 +0200 (CEST)
Message-ID: <20200807193018.160331394@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 07 Aug 2020 21:23:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        peterz@infradead.org
Subject: [RFC][PATCH 3/3] lockdep,trace: Expose tracepoints
References: <20200807192336.405068898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep tracepoints are under the lockdep recursion counter, this
has a bunch of nasty side effects:

 - TRACE_IRQFLAGS doesn't work across the entire tracepoint, leading to
   all sorts of dodgy complaints.

 - RCU-lockdep doesn't see the tracepoints either, hiding numerous
   "suspicious RCU usage" warnings.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5000,8 +5000,9 @@ void lock_acquire(struct lockdep_map *lo
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+
+	current->lockdep_recursion++;
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5016,10 +5017,13 @@ void lock_release(struct lockdep_map *lo
 	if (unlikely(current->lockdep_recursion))
 		return;
 
+
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion++;
+
 	trace_lock_release(lock, ip);
+
+	current->lockdep_recursion++;
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
@@ -5171,7 +5175,7 @@ __lock_contended(struct lockdep_map *loc
 		stats->bounces[bounce_contended + !!hlock->read]++;
 }
 
-static void
+static bool
 __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	struct task_struct *curr = current;
@@ -5187,16 +5191,16 @@ __lock_acquired(struct lockdep_map *lock
 	 * acquire, how the heck did that happen?
 	 */
 	if (DEBUG_LOCKS_WARN_ON(!depth))
-		return;
+		return false;
 
 	hlock = find_held_lock(curr, lock, depth, &i);
 	if (!hlock) {
 		print_lock_contention_bug(curr, lock, _RET_IP_);
-		return;
+		return false;
 	}
 
 	if (hlock->instance != lock)
-		return;
+		return false;
 
 	cpu = smp_processor_id();
 	if (hlock->waittime_stamp) {
@@ -5205,8 +5209,6 @@ __lock_acquired(struct lockdep_map *lock
 		hlock->holdtime_stamp = now;
 	}
 
-	trace_lock_acquired(lock, ip);
-
 	stats = get_lock_stats(hlock_class(hlock));
 	if (waittime) {
 		if (hlock->read)
@@ -5219,6 +5221,8 @@ __lock_acquired(struct lockdep_map *lock
 
 	lock->cpu = cpu;
 	lock->ip = ip;
+
+	return true;
 }
 
 void lock_contended(struct lockdep_map *lock, unsigned long ip)
@@ -5244,6 +5248,7 @@ EXPORT_SYMBOL_GPL(lock_contended);
 void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
+	bool trace;
 
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
@@ -5254,8 +5259,12 @@ void lock_acquired(struct lockdep_map *l
 	raw_local_irq_save(flags);
 	check_flags(flags);
 	current->lockdep_recursion++;
-	__lock_acquired(lock, ip);
+	trace = __lock_acquired(lock, ip);
 	lockdep_recursion_finish();
+
+	if (trace)
+		trace_lock_acquired(lock, ip);
+
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquired);


