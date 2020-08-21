Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB7AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87152087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2f7w3SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHUI50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgHUI4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D8C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hkxLrU8XhUojAu54NfL2KIhIUIFNTpOoafP/n2klJek=; b=r2f7w3SYSQt9o+vEpCfBXyf0ri
        iul9mFhG0Cb3ZhXJOD5CPo354XFia0G6x345nm7f9pTrov7GF6oqx/ZDQf3izKmtdHkS/GqEmeQeg
        Ao3KhMd1/x3SKb0P4YTGb+MFWh9hFXscDkfQzuJoncjiIwMtkW+7yZF97kUo7SaMa8QVNrhYiDpvE
        yaUv8k+uzXVHnJZd2ZPEISV4Wg3UeIsnot1AydgpUVcfC1xAGO3ggeI6IsmAM+TcIHjS13FyOGT6G
        Mau0HIBNRgoD6skHxLw9CS+TziRsDH6lhEl4eqcADL07A1HkXIyUz3Vk6hVEsOqera2cE6wD3cZlY
        E/FTfshg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92pJ-0007Sb-4N; Fri, 21 Aug 2020 08:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BEF03075F1;
        Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0FC622B64991E; Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Message-ID: <20200821085348.782688941@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Marco Elver <elver@google.com>
---
 kernel/locking/lockdep.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5044,6 +5044,8 @@ void lock_acquire(struct lockdep_map *lo
 {
 	unsigned long flags;
 
+	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
+
 	if (unlikely(current->lockdep_recursion)) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
@@ -5068,7 +5070,6 @@ void lock_acquire(struct lockdep_map *lo
 	check_flags(flags);
 
 	current->lockdep_recursion++;
-	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5080,13 +5081,15 @@ void lock_release(struct lockdep_map *lo
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
@@ -5272,8 +5275,6 @@ __lock_acquired(struct lockdep_map *lock
 		hlock->holdtime_stamp = now;
 	}
 
-	trace_lock_acquired(lock, ip);
-
 	stats = get_lock_stats(hlock_class(hlock));
 	if (waittime) {
 		if (hlock->read)
@@ -5292,6 +5293,8 @@ void lock_contended(struct lockdep_map *
 {
 	unsigned long flags;
 
+	trace_lock_contended(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
@@ -5301,7 +5304,6 @@ void lock_contended(struct lockdep_map *
 	raw_local_irq_save(flags);
 	check_flags(flags);
 	current->lockdep_recursion++;
-	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5312,6 +5314,8 @@ void lock_acquired(struct lockdep_map *l
 {
 	unsigned long flags;
 
+	trace_lock_acquired(lock, ip);
+
 	if (unlikely(!lock_stat || !debug_locks))
 		return;
 


