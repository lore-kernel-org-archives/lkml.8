Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBA320826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgEUUc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbgEUUcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED639C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqw-0000eI-Ip; Thu, 21 May 2020 22:31:42 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0086C100C2D;
        Thu, 21 May 2020 22:31:42 +0200 (CEST)
Message-Id: <20200521202118.984573165@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:36 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V9 23/39] x86/entry: Add IRQENTRY_IRQ macro
References: <20200521200513.656533920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide a seperate IDTENTRY macro for device interrupts. Similar to
IDTENTRY_ERRORCODE with the addition of invoking irq_enter/exit_rcu() and
providing the errorcode as a 'u8' argument to the C function, which
truncates the sign extended vector number.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
V9: Use cond RCU handling
---
 arch/x86/entry/entry_32.S       |   14 +++++++++++
 arch/x86/entry/entry_64.S       |   14 +++++++++++
 arch/x86/include/asm/idtentry.h |   48 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -751,6 +751,20 @@ SYM_CODE_START(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
 
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+SYM_CODE_START_LOCAL(asm_\cfunc)
+	ASM_CLAC
+	SAVE_ALL switch_stacks=1
+	ENCODE_FRAME_POINTER
+	movl	%esp, %eax
+	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
+	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
+	call	\cfunc
+	jmp	handle_exception_return
+SYM_CODE_END(asm_\cfunc)
+.endm
+
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit.
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -528,6 +528,20 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * Interrupt entry/exit.
+ *
+ + The interrupt stubs push (vector) onto the stack, which is the error_code
+ * position of idtentry exceptions, and jump to one of the two idtentry points
+ * (common/spurious).
+ *
+ * common_interrupt is a hotpath, align it to a cache line
+ */
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+	idtentry \vector asm_\cfunc \cfunc has_error_code=1
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -165,6 +165,50 @@ static __always_inline void __##func(str
 #define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
 __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
 
+/**
+ * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
+ *			  points (common/spurious)
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_ERRORCODE()
+ */
+#define DECLARE_IDTENTRY_IRQ(vector, func)				\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * The vector number is pushed by the low level entry stub and handed
+ * to the function as error_code argument which needs to be truncated
+ * to an u8 because the push is sign extending.
+ *
+ * On 64bit dtentry_enter/exit() are invoked in the ASM entry code before
+ * and after switching to the interrupt stack. On 32bit this happens in C.
+ *
+ * irq_enter/exit_rcu() are invoked before the function body and the
+ * KVM L1D flush request is set.
+ */
+#define DEFINE_IDTENTRY_IRQ(func)					\
+static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
+									\
+__visible noinstr void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
+	instrumentation_begin();					\
+	irq_enter_rcu();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	__##func (regs, (u8)error_code);				\
+	irq_exit_rcu();							\
+	lockdep_hardirq_exit();						\
+	instrumentation_end();						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs, u8 vector)
 
 #ifdef CONFIG_X86_64
 /**
@@ -297,6 +341,10 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)			\
 	DECLARE_IDTENTRY_ERRORCODE(vector, func)
 
+/* Entries for common/spurious (device) interrupts */
+#define DECLARE_IDTENTRY_IRQ(vector, func)				\
+	idtentry_irq vector func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func

