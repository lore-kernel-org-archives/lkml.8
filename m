Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0475D20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LEZPgwYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHJM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgHJM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:26:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15967C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1gdxTGCOCXOCiVyxqJ17K13XKmESbQXv1vfC8SpqAJA=; b=LEZPgwYsopDWi/TFlGBelqitz8
        GWM1tUOy9JbxW+XALwE0rW6SzWLQ75FJEvx8JZ7lvXF2P/sVYinQWKdZ2o2I+nvPfGvTWmt4Trz4y
        a9AbkplhpmUujVaPN0iAwgQJy11lFZRp6uoxKAZ8B9FCCcrpHi0RMIjJX2Z2z1l2Hk0CsnUBFBi+1
        lTe4CEbzC9M4dAGKrcoh6BtezPuTUB+zxa/YGwb8W12/sCDIhQ51WD+cMwKHEK99Xz5hAjMHyLVRs
        NMrfZDLBnLenE7T0TQfz+fuVrbjRjTpzq+94ApbeVZrrRNnljLmFhZ88XoJcshQRV3N1cgP1KBaON
        XH5c+/tQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k56t0-0005we-Se; Mon, 10 Aug 2020 12:26:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C7713003E5;
        Mon, 10 Aug 2020 14:26:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D5D722281168; Mon, 10 Aug 2020 14:26:41 +0200 (CEST)
Date:   Mon, 10 Aug 2020 14:26:41 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net
Subject: [RFC][PATCH v1.1 3/3] lockdep,trace: Expose tracepoints
Message-ID: <20200810122641.GW2674@hirez.programming.kicks-ass.net>
References: <20200807192336.405068898@infradead.org>
 <20200807193018.160331394@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807193018.160331394@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lockdep,trace: Expose tracepoints
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Aug 7 20:53:16 CEST 2020

The lockdep tracepoints are under the lockdep recursion counter, this
has a bunch of nasty side effects:

 - TRACE_IRQFLAGS doesn't work across the entire tracepoint

 - RCU-lockdep doesn't see the tracepoints either, hiding numerous
   "suspicious RCU usage" warnings.

Pull the trace_lock_*() tracepoints completely out from under the
lockdep recursion handling and completely rely on the trace level
recusion handling -- also, tracing *SHOULD* not be taking locks in any
case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4977,6 +4977,8 @@ void lock_acquire(struct lockdep_map *lo
 {
 	unsigned long flags;
 
+	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+
 	if (unlikely(current->lockdep_recursion)) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
@@ -5001,7 +5003,6 @@ void lock_acquire(struct lockdep_map *lo
 	check_flags(flags);
 
 	current->lockdep_recursion++;
-	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5013,13 +5014,15 @@ void lock_release(struct lockdep_map *lo
 {
 	unsigned long flags;
 
+	trace_lock_release(lock, ip);
+
 	if (unlikely(current->lockdep_recursion))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
+
 	current->lockdep_recursion++;
-	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
@@ -5205,8 +5208,6 @@ __lock_acquired(struct lockdep_map *lock
 		hlock->holdtime_stamp = now;
 	}
 
-	trace_lock_acquired(lock, ip);
-
 	stats = get_lock_stats(hlock_class(hlock));
 	if (waittime) {
 		if (hlock->read)
@@ -5225,6 +5226,8 @@ void lock_contended(struct lockdep_map *
 {
 	unsigned long flags;
 
+	trace_lock_contended(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
@@ -5234,7 +5237,6 @@ void lock_contended(struct lockdep_map *
 	raw_local_irq_save(flags);
 	check_flags(flags);
 	current->lockdep_recursion++;
-	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5245,6 +5247,8 @@ void lock_acquired(struct lockdep_map *l
 {
 	unsigned long flags;
 
+	trace_lock_acquired(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
