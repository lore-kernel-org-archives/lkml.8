Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B19C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3416B204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PHs4g+Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHGTeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHGTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:34:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3799FC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=B9dTJjOzzVrkha6MNvkzN4hFWnaQt3gD4TB0VFtHlDI=; b=PHs4g+HxALWoirJ/Xn457VPiC1
        /W2e156UVhgJXA1SV1uikodRQJoAYIYgIEO8PUwSSrK0k4hB0N1jeQdt/p8xP+LgqZSMZZOgVe1+H
        tSgpeIAhUm+7tltxDWqa4P+LST4ocCg7C3CoAs4GiVKkkWQfZbuk3JeEHcJrdF08KW547yjGfGVu2
        mDUETS74T/gM/6G6BupzwOruiGZaSGpxXPxjbKPGnzR+6xZutUMlDOQ8fgZuWEQn2d39m6N/hlSwN
        PIislbG17+cr3nYSAlQwfHj49a1yBdChB3yd1JP9EJnlsz64P18aDq+c29SXmrlRmz/2y0tOvqC1H
        d4xJmXJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4887-0001mx-1H; Fri, 07 Aug 2020 19:34:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E9A53012DC;
        Fri,  7 Aug 2020 21:34:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AE36C29BEC9F8; Fri,  7 Aug 2020 21:34:13 +0200 (CEST)
Message-ID: <20200807193018.060388629@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 07 Aug 2020 21:23:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        peterz@infradead.org
Subject: [RFC][PATCH 2/3] locking,entry: #PF vs TRACE_IRQFLAGS
References: <20200807192336.405068898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much of the complexity in irqenter_{enter,exit}() is due to #PF being
the sole exception that can schedule from kernel context.

One additional wrinkle with #PF is that it is non-maskable, it can
happen _anywhere_. Due to this, and the wonders of tracing, we can get
the 'normal' NMI nesting vs TRACE_IRQFLAGS:

	local_irq_disable()
	  raw_local_irq_disable();
	  trace_hardirqs_off();

	local_irq_enable();
	  trace_hardirqs_on();
	  <#PF>
	    trace_hardirqs_off()
	    ...
	    if (!regs_irqs_disabled(regs)
	      trace_hardirqs_on();
	  </#PF>
	  // WHOOPS -- lockdep thinks IRQs are disabled again!
	  raw_local_irqs_enable();

Rework irqenter_{enter,exit}() to save/restore the software state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/entry-common.h |    1 
 kernel/entry/common.c        |   52 ++++++++++++++++++++-----------------------
 2 files changed, 26 insertions(+), 27 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -310,6 +310,7 @@ void irqentry_exit_to_user_mode(struct p
 #ifndef irqentry_state
 typedef struct irqentry_state {
 	bool	exit_rcu;
+	bool	irqs_enabled;
 } irqentry_state_t;
 #endif
 
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -260,6 +260,7 @@ noinstr irqentry_state_t irqentry_enter(
 {
 	irqentry_state_t ret = {
 		.exit_rcu = false,
+		.irqs_enabled = lockdep_hardirqs_enabled(),
 	};
 
 	if (user_mode(regs)) {
@@ -340,35 +341,32 @@ noinstr void irqentry_exit(struct pt_reg
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
-	} else if (!regs_irqs_disabled(regs)) {
-		/*
-		 * If RCU was not watching on entry this needs to be done
-		 * carefully and needs the same ordering of lockdep/tracing
-		 * and RCU as the return to user mode path.
-		 */
-		if (state.exit_rcu) {
-			instrumentation_begin();
-			/* Tell the tracer that IRET will enable interrupts */
-			trace_hardirqs_on_prepare();
-			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-			instrumentation_end();
-			rcu_irq_exit();
-			lockdep_hardirqs_on(CALLER_ADDR0);
-			return;
-		}
+		return;
+	}
 
-		instrumentation_begin();
+	instrumentation_begin();
+	/*
+	 * When returning to interrupts enabled, and RCU was watching see if we
+	 * need preemption.
+	 */
+	if (!regs_irqs_disabled(regs) && !state.exit_rcu) {
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
-		/* Covers both tracing and lockdep */
-		trace_hardirqs_on();
-		instrumentation_end();
-	} else {
-		/*
-		 * IRQ flags state is correct already. Just tell RCU if it
-		 * was not watching on entry.
-		 */
-		if (state.exit_rcu)
-			rcu_irq_exit();
 	}
+
+	/*
+	 * Return the TRACE_IRQFLAGS state to what we found on entry.
+	 * Observe the correct order vs RCU.
+	 */
+	if (state.irqs_enabled) {
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	}
+	instrumentation_end();
+
+	if (state.exit_rcu)
+		rcu_irq_exit();
+
+	if (state.irqs_enabled)
+		lockdep_hardirqs_on(CALLER_ADDR0);
 }


