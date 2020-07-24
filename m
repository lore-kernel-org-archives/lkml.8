Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D6D206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1P+D5KNS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LULhM0XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGXULl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgGXULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2AC0619D3;
        Fri, 24 Jul 2020 13:11:40 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgR1k7rw+tDo1xas51VMTu+WG+KNqht4eeP91kGAwFo=;
        b=1P+D5KNS1WAfli4RKrBP8cxxZwRqqJvPvt83SyNtnFEBep1Q77xhJ/XWZH6jZSXHjBSTL/
        eBKcWZrUas/lyJCjw0gabhSx681EdL+C5pkAa3QfdVt/1/eR+cKslrhtTWlLLa94M/gb4b
        r26/pHe4EQ75p8XlUtkikiIKlQsTvrIMEsUP51mIc4/BdtLVchY+OUyRhMqKUvkpVFsYu7
        toj2l2/kKXyzWLP6XyNEWZYhXWKMtC4TU1OVzJ3sEntE9sn30SVwYmyvFGAknjpl0tDvdU
        hLDufb2gasNyTX7boEbYXzfPgMqiWcXdMhElzTszLiwc67WaBsMezWse+yMrDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgR1k7rw+tDo1xas51VMTu+WG+KNqht4eeP91kGAwFo=;
        b=LULhM0XT39YorAYEYpNVwke/WvBD7y/LVerp699mwwB4fDH5iqj5M4sDE2PNaMz1w7bbh3
        gHFKYXdJwM8Z7FCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Cleanup idtentry_enter/exit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.855839271@linutronix.de>
References: <20200722220520.855839271@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562149825.4006.15977113258931580815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     a27a0a55495cdde4b8d98f82460dc46eb44777fd
Gitweb:        https://git.kernel.org/tip/a27a0a55495cdde4b8d98f82460dc46eb44777fd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:05:01 +02:00

x86/entry: Cleanup idtentry_enter/exit

Remove the temporary defines and fixup all references.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220520.855839271@linutronix.de


---
 arch/x86/entry/common.c         |  6 +++---
 arch/x86/include/asm/idtentry.h | 33 +++++++++++++-------------------
 arch/x86/kernel/kvm.c           |  6 +++---
 arch/x86/kernel/traps.c         |  6 +++---
 arch/x86/mm/fault.c             |  6 +++---
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 297e08e..3de0303 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -248,9 +248,9 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	bool inhcall;
-	idtentry_state_t state;
+	irqentry_state_t state;
 
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
@@ -266,7 +266,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
-		idtentry_exit(regs, state);
+		irqentry_exit(regs, state);
 	}
 }
 #endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 621e25d..73eb277 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,11 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-/* Temporary defines */
-typedef irqentry_state_t idtentry_state_t;
-#define idtentry_enter irqentry_enter
-#define idtentry_exit irqentry_exit
-
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -45,8 +40,8 @@ typedef irqentry_state_t idtentry_state_t;
  * The macro is written so it acts as function definition. Append the
  * body with a pair of curly brackets.
  *
- * idtentry_enter() contains common code which has to be invoked before
- * arbitrary code in the body. idtentry_exit() contains common code
+ * irqentry_enter() contains common code which has to be invoked before
+ * arbitrary code in the body. irqentry_exit() contains common code
  * which has to run before returning to the low level assembly code.
  */
 #define DEFINE_IDTENTRY(func)						\
@@ -54,12 +49,12 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -101,12 +96,12 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -161,7 +156,7 @@ __visible noinstr void func(struct pt_regs *regs)
  * body with a pair of curly brackets.
  *
  * Contrary to DEFINE_IDTENTRY_ERRORCODE() this does not invoke the
- * idtentry_enter/exit() helpers before and after the body invocation. This
+ * irqentry_enter/exit() helpers before and after the body invocation. This
  * needs to be done in the body itself if applicable. Use if extra work
  * is required before the enter/exit() helpers are invoked.
  */
@@ -197,7 +192,7 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -205,7 +200,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
@@ -229,7 +224,7 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector)
  * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
  * @func:	Function name of the entry point
  *
- * idtentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
+ * irqentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
  * function body. KVM L1D flush request is set.
  *
  * Runs the function on the interrupt stack if the entry hit kernel mode
@@ -239,7 +234,7 @@ static void __##func(struct pt_regs *regs);				\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -247,7 +242,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	run_on_irqstack_cond(__##func, regs, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -268,7 +263,7 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_state_t state = idtentry_enter(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
@@ -276,7 +271,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
-	idtentry_exit(regs, state);					\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 3f78482..233c77d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	u32 reason = kvm_read_and_reset_apf_flags();
-	idtentry_state_t state;
+	irqentry_state_t state;
 
 	switch (reason) {
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
@@ -243,7 +243,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		return false;
 	}
 
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -264,7 +264,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	}
 
 	instrumentation_end();
-	idtentry_exit(regs, state);
+	irqentry_exit(regs, state);
 	return true;
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 59c7f54..be8fcfe 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -245,7 +245,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 
 DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
-	idtentry_state_t state;
+	irqentry_state_t state;
 
 	/*
 	 * We use UD2 as a short encoding for 'CALL __WARN', as such
@@ -255,11 +255,11 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	if (!user_mode(regs) && handle_bug(regs))
 		return;
 
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 	instrumentation_begin();
 	handle_invalid_op(regs);
 	instrumentation_end();
-	idtentry_exit(regs, state);
+	irqentry_exit(regs, state);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 5e41949..5e5edd2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1377,7 +1377,7 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	unsigned long address = read_cr2();
-	idtentry_state_t state;
+	irqentry_state_t state;
 
 	prefetchw(&current->mm->mmap_lock);
 
@@ -1412,11 +1412,11 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 * code reenabled RCU to avoid subsequent wreckage which helps
 	 * debugability.
 	 */
-	state = idtentry_enter(regs);
+	state = irqentry_enter(regs);
 
 	instrumentation_begin();
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
-	idtentry_exit(regs, state);
+	irqentry_exit(regs, state);
 }
