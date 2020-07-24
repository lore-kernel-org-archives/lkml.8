Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BDC206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+LLPAyH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0lSGboMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGXUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGXULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D279C0619D3;
        Fri, 24 Jul 2020 13:11:44 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:11:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyTRoVIGpvap3NbIv3I6YbK4fVbBU3IzoqXk+GSZlWQ=;
        b=E+LLPAyHWgAxywdlXKOWuo6NaMRi4gZSqF4+wh0z9C/SdairROpnpWqp6ldgHMgQcvp14g
        esOuSKMohjrNSi6U4zhp94HTE0pTbHNc6uZILRxjXqyWq5Whtcz7f3YlBnkp+Y4pd4lJar
        wSrqsMjHRGwF6S7aE8becAbfSnE/nTHSnXxD8d3mhW/pmTT6wwU0vrz8LBq2/6WvBggx5E
        zWoYUDvvZd2MMb3IWKmFUuxdgb4P8YFx48IdTG39q3N7W19SNk292pyHzx/maOaPrPskBZ
        pUMkyNNMLMll5GWrSn4Se2/RvccRDLTm3PDadBv11xmdNpWwxdzJNG6ExVAQ5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyTRoVIGpvap3NbIv3I6YbK4fVbBU3IzoqXk+GSZlWQ=;
        b=0lSGboMRZIVLDRT5P+2TbMzuxnNNTRAHI+cRS3X+Odrd5/GZFAcXTeL+3hjJWiR2KsmTZy
        LblBJnBqrMJf7dBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Consolidate 32/64 bit syscall entry
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.051234096@linutronix.de>
References: <20200722220520.051234096@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562150262.4006.11750463088671474026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0b085e68f4072024ecaa3889aeeaab5f6c8eba5c
Gitweb:        https://git.kernel.org/tip/0b085e68f4072024ecaa3889aeeaab5f6c8eba5c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:04:58 +02:00

x86/entry: Consolidate 32/64 bit syscall entry

64bit and 32bit entry code have the same open coded syscall entry handling
after the bitwidth specific bits.

Move it to a helper function and share the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200722220520.051234096@linutronix.de


---
 arch/x86/entry/common.c | 93 +++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 52 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ab6cb86..68d5c86 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -366,8 +366,7 @@ __visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
-#ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+static noinstr long syscall_enter(struct pt_regs *regs, unsigned long nr)
 {
 	struct thread_info *ti;
 
@@ -379,6 +378,16 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
+	instrumentation_end();
+	return nr;
+}
+
+#ifdef CONFIG_X86_64
+__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+{
+	nr = syscall_enter(regs, nr);
+
+	instrumentation_begin();
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
 		regs->ax = sys_call_table[nr](regs);
@@ -390,64 +399,53 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
 	}
-	__syscall_return_slowpath(regs);
-
 	instrumentation_end();
-	exit_to_user_mode();
+	syscall_return_slowpath(regs);
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		current_thread_info()->status |= TS_COMPAT;
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
+	 * orig_ax, the unsigned int return value truncates it.  This may
+	 * or may not be necessary, but it matches the old asm behavior.
+	 */
+	return syscall_enter(regs, (unsigned int)regs->orig_ax);
+}
+
 /*
- * Does a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.  Does
- * all entry and exit work and returns with IRQs off.  This function is
- * extremely hot in workloads that use it, and it's usually called from
- * do_fast_syscall_32, so forcibly inline it to improve performance.
+ * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
-static void do_syscall_32_irqs_on(struct pt_regs *regs)
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
+						  unsigned int nr)
 {
-	struct thread_info *ti = current_thread_info();
-	unsigned int nr = (unsigned int)regs->orig_ax;
-
-#ifdef CONFIG_IA32_EMULATION
-	ti->status |= TS_COMPAT;
-#endif
-
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
-		/*
-		 * Subtlety here: if ptrace pokes something larger than
-		 * 2^32-1 into orig_ax, this truncates it.  This may or
-		 * may not be necessary, but it matches the old asm
-		 * behavior.
-		 */
-		nr = syscall_trace_enter(regs);
-	}
-
 	if (likely(nr < IA32_NR_syscalls)) {
+		instrumentation_begin();
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
+		instrumentation_end();
 	}
-
-	__syscall_return_slowpath(regs);
 }
 
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
-	instrumentation_begin();
+	unsigned int nr = syscall_32_enter(regs);
 
-	local_irq_enable();
-	do_syscall_32_irqs_on(regs);
-
-	instrumentation_end();
-	exit_to_user_mode();
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_return_slowpath(regs);
 }
 
-static bool __do_fast_syscall_32(struct pt_regs *regs)
+static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
+	unsigned int nr	= syscall_32_enter(regs);
 	int res;
 
+	instrumentation_begin();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
@@ -460,17 +458,18 @@ static bool __do_fast_syscall_32(struct pt_regs *regs)
 		res = get_user(*(u32 *)&regs->bp,
 		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
 	}
+	instrumentation_end();
 
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
-		local_irq_disable();
-		__prepare_exit_to_usermode(regs);
+		syscall_return_slowpath(regs);
 		return false;
 	}
 
 	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs);
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_return_slowpath(regs);
 	return true;
 }
 
@@ -483,7 +482,6 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
 					vdso_image_32.sym_int80_landing_pad;
-	bool success;
 
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
@@ -492,17 +490,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
-	success = __do_fast_syscall_32(regs);
-
-	instrumentation_end();
-	exit_to_user_mode();
-
-	/* If it failed, keep it simple: use IRET. */
-	if (!success)
+	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
+	if (!__do_fast_syscall_32(regs))
 		return 0;
 
 #ifdef CONFIG_X86_64
