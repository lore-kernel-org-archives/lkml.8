Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FB3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3525920738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SlUqS3YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFCLmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgFCLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB72EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YtDsltKEuKDuBSNGU0EYICMCiPeDra4uCaDiVXYzdZw=; b=SlUqS3YPzG753zLpAc4q4lUSXN
        qW+qjOX9itDRedsa+mjuLMfrLn+XHhB/1Y64UqITi8iGlLB9JfJfTWZZ0i6k38Ty+wIYtEnvdxAv4
        7rehbBxfczByXcqzv0HrElYxuR7t28FaTWv9M9Q8ZmVOOzNKnXgtTBnllXtbxH583m/9RpN5cKCCj
        yXuCqmHIEZn+RfdT4c62vV9JIZgxxETGtmi0KwBssAeeS485mLXyhgqp29yd1Y2hC0hVskIWzOsYm
        /bT/JG7w96dG6tg/L7T7A/0Cif9YXaHwU5nbNMAPIbqGDZt7bptMyAIREsgIFe4pU0n7ewwA1yUp/
        rS8bWXBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRmr-0005jm-RH; Wed, 03 Jun 2020 11:42:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0342C306E4A;
        Wed,  3 Jun 2020 13:42:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B6147209DB0CC; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114052.127756554@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 6/9] x86/entry: Re-order #DB handler to avoid *SAN instrumentation
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: exc_debug()+0xbb: call to clear_ti_thread_flag.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: noist_exc_debug()+0x55: call to clear_ti_thread_flag.constprop.0() leaves .noinstr.text section

Rework things so that handle_debug() looses the noinstr and move the
clear_thread_flag() into that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   55 +++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -775,26 +775,44 @@ static __always_inline void debug_exit(u
  *
  * May run on IST stack.
  */
-static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
-				 bool user_icebp)
+static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 {
 	struct task_struct *tsk = current;
+	bool user_icebp;
 	int si_code;
 
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
+	/*
+	 * If DR6 is zero, no point in trying to handle it. The kernel is
+	 * not using INT1.
+	 */
+	if (!user && !dr6)
+		return;
+
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	user_icebp = user && !dr6;
+
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
 
-	instrumentation_begin();
 #ifdef CONFIG_KPROBES
 	if (kprobe_debug_handler(regs)) {
-		instrumentation_end();
 		return;
 	}
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
 		       SIGTRAP) == NOTIFY_STOP) {
-		instrumentation_end();
 		return;
 	}
 
@@ -825,7 +843,6 @@ static void noinstr handle_debug(struct
 
 out:
 	cond_local_irq_disable(regs);
-	instrumentation_end();
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -834,14 +851,6 @@ static __always_inline void exc_debug_ke
 	nmi_enter();
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
-	instrumentation_end();
-
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
 
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
@@ -850,14 +859,8 @@ static __always_inline void exc_debug_ke
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
-	/*
-	 * If DR6 is zero, no point in trying to handle it. The kernel is
-	 * not using INT1.
-	 */
-	if (dr6)
-		handle_debug(regs, dr6, false);
+	handle_debug(regs, dr6, false);
 
-	instrumentation_begin();
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
@@ -868,14 +871,10 @@ static __always_inline void exc_debug_us
 					   unsigned long dr6)
 {
 	idtentry_enter_user(regs);
-	clear_thread_flag(TIF_BLOCKSTEP);
+	instrumentation_begin();
 
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	handle_debug(regs, dr6, !dr6);
+	handle_debug(regs, dr6, true);
+	instrumentation_end();
 	idtentry_exit_user(regs);
 }
 


