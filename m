Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6929207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nSl/WYg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgFOPtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbgFOPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:49:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/aTpc7TE2Si6G86LJEN2yNkL/a/l/Clrfw1nJF9mG7s=; b=nSl/WYg9Mu7vD9zvYjqzD8s0Dh
        rRXcocivk1w4WcmZ+Um949j2a9JHcOMne6HK+NrErDeXMVFeRP1CmfFbPU599/PW2OjoTErPA1nQ/
        7Q0c0dSrGqpdojx9/wTq2NiDSTd+e+Fuf9DxTTnJi2ERE3l09koZLSHZFxD4q73IL6xQrO3G8GM3t
        Vlx4VpdFf93z8x6UiptbaZq2cQPYRJU4W0vZHMg+Re2pa3fxWljdQ48AC07YMRBs5n3QLS/dRV5v0
        Q0DzycrLU//OPtlu/moKK14+VjO9gG+7py+Doqvp8Ei5N4Tz/yqq3kL09+QmDsLYEsLFmAHXKvFbB
        yL6xNJRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkrMB-0005VA-7y; Mon, 15 Jun 2020 15:49:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79534306102;
        Mon, 15 Jun 2020 17:49:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BB7920E05A91; Mon, 15 Jun 2020 17:49:05 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:49:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603114051.896465666@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 01:40:16PM +0200, Peter Zijlstra wrote:
> A KCSAN build revealed we have explicit annoations through atomic_*()
> usage, switch to arch_atomic_*() for the respective functions.
> 
> vmlinux.o: warning: objtool: rcu_nmi_exit()+0x4d: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_nmi_enter()+0x4f: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x2a: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __rcu_is_watching()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200603084818.GB2627@hirez.programming.kicks-ass.net
> ---

How's this then? It anticipiates the removal of that andnot thing.

---
 kernel/rcu/tree.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -250,7 +250,7 @@ static noinstr void rcu_dynticks_eqs_ent
 	 * next idle sojourn.
 	 */
 	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     (seq & RCU_DYNTICK_CTRL_CTR));
@@ -274,13 +274,13 @@ static noinstr void rcu_dynticks_eqs_exi
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
-		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
+		arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
 		smp_mb__after_atomic(); /* _exit after clearing mask. */
 	}
 }
@@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
+	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
 }
 
 /*
@@ -633,6 +633,10 @@ static noinstr void rcu_eqs_enter(bool u
 	do_nocb_deferred_wakeup(rdp);
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
+
+	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
+	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+
 	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
 	// RCU is watching here ...
@@ -692,6 +696,7 @@ noinstr void rcu_nmi_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
+	instrumentation_begin();
 	/*
 	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
@@ -705,7 +710,6 @@ noinstr void rcu_nmi_exit(void)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
-		instrumentation_begin();
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
 				  atomic_read(&rdp->dynticks));
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
@@ -714,13 +718,15 @@ noinstr void rcu_nmi_exit(void)
 		return;
 	}
 
-	instrumentation_begin();
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
 	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (!in_nmi())
 		rcu_prepare_for_idle();
+
+	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
+	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
 	instrumentation_end();
 
 	// RCU is watching here ...
@@ -838,6 +844,10 @@ static void noinstr rcu_eqs_exit(bool us
 	rcu_dynticks_eqs_exit();
 	// ... but is watching here.
 	instrumentation_begin();
+
+	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
+	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+
 	rcu_cleanup_after_idle();
 	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
@@ -983,13 +993,17 @@ noinstr void rcu_nmi_enter(void)
 		if (!in_nmi())
 			rcu_cleanup_after_idle();
 
+		instrumentation_begin();
+		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
+		instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
+		// instrumentation for the noinstr rcu_dynticks_eqs_exit()
+		instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
+
 		incby = 1;
 	} else if (!in_nmi()) {
 		instrumentation_begin();
 		rcu_irq_enter_check_tick();
-		instrumentation_end();
 	}
-	instrumentation_begin();
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
 			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
