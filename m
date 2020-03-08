Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC991C10F29
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFF32086A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgCHXYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:24:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgCHXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:24:06 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gt-00039s-Or; Mon, 09 Mar 2020 00:23:48 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6EA471040A7;
        Mon,  9 Mar 2020 00:23:36 +0100 (CET)
Message-Id: <20200308231719.023170971@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 00:14:16 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-III V2 06/23] x86/idtentry: Provide macros to define/declare IDT entry points
References: <20200308231410.905396057@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide DECLARE/DEFINE_IDTENTRY() macros.

DEFINE_IDTENTRY() provides a wrapper which acts as the function
definition. The exception handler body is just appended to it with curly
brackets. The entry point is marked notrace/noprobe so that irq tracing and
the enter_from_user_mode() can be moved into the C-entry point. As all
C-entries use the same macro (or a later variant) the necessary entry
handling can be implemented at one central place.

DECLARE_IDTENTRY() provides the function prototypes:
  - The C entry point 	    	cfunc
  - The ASM entry point		asm_cfunc
  - The XEN/PV entry point	xen_asm_cfunc

They all follow the same naming convention.

When included from ASM code DECLARE_IDTENTRY() is a macro which emits the
low level entry point in assembly by instantiating idtentry.

IDTENTRY is the simplest variant which just has a pt_regs argument. It's
going to be used for all exceptions which have no error code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
V2: Add comments to explain the C vs. ASM variants
---
 arch/x86/entry/entry_32.S       |    6 ++
 arch/x86/entry/entry_64.S       |    6 ++
 arch/x86/include/asm/idtentry.h |   85 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/traps.h    |    2 
 4 files changed, 98 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -769,6 +769,12 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * Include the defines which emit the idt entries which are shared
+ * shared between 32 and 64 bit.
+ */
+#include <asm/idtentry.h>
+
+/*
  * %eax: prev task
  * %edx: next task
  */
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -688,6 +688,12 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * Include the defines which emit the idt entries which are shared
+ * shared between 32 and 64 bit.
+ */
+#include <asm/idtentry.h>
+
+/*
  * Interrupt entry helper function.
  *
  * Entry runs with interrupts off. Stack layout at entry:
--- /dev/null
+++ b/arch/x86/include/asm/idtentry.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IDTENTRY_H
+#define _ASM_X86_IDTENTRY_H
+
+/* Interrupts/Exceptions */
+#include <asm/trapnr.h>
+
+#ifndef __ASSEMBLY__
+
+/**
+ * idtentry_enter - Handle state tracking on idtentry
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Place holder for now.
+ */
+static __always_inline void idtentry_enter(struct pt_regs *regs)
+{
+}
+
+/**
+ * idtentry_exit - Prepare returning to low level ASM code
+ *
+ * Place holder for now.
+ */
+static __always_inline void idtentry_exit(struct pt_regs *regs)
+{
+}
+
+/**
+ * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
+ *		      No error code pushed by hardware
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ *
+ * Note: This is the C variant of DECLARE_IDTENTRY(). As the name says it
+ * declares the entry points for usage in C code. There is an ASM variant
+ * as well which is used to emit the entry stubs in entry_32/64.S.
+ */
+#define DECLARE_IDTENTRY(vector, func)					\
+	asmlinkage void asm_##func(void);				\
+	asmlinkage void xen_asm_##func(void);				\
+	__visible void func(struct pt_regs *regs)
+
+/**
+ * DEFINE_IDTENTRY - Emit code for simple IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * @func is called from ASM entry code with interrupts disabled.
+ *
+ * The macro is written so it acts as function definition. Append the
+ * body with a pair of curly brackets.
+ *
+ * idtentry_enter() contains common code which has to be invoked before
+ * arbitrary code in the body. idtentry_exit() contains common code
+ * which has to run before returning to the low level assembly code.
+ */
+#define DEFINE_IDTENTRY(func)						\
+static __always_inline void __##func(struct pt_regs *regs);		\
+									\
+__visible notrace void func(struct pt_regs *regs)			\
+{									\
+	idtentry_enter(regs);						\
+	__##func (regs);						\
+	idtentry_exit(regs);						\
+}									\
+NOKPROBE_SYMBOL(func);							\
+									\
+static __always_inline void __##func(struct pt_regs *regs)
+
+#else /* !__ASSEMBLY__ */
+
+/*
+ * The ASM variants for DECLARE_IDTENTRY*() which emit the ASM entry stubs.
+ */
+#define DECLARE_IDTENTRY(vector, func)					\
+	idtentry vector asm_##func func has_error_code=0
+
+#endif /* __ASSEMBLY__ */
+
+#endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -6,8 +6,8 @@
 #include <linux/kprobes.h>
 
 #include <asm/debugreg.h>
+#include <asm/idtentry.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
-#include <asm/trapnr.h>
 
 #define dotraplinkage __visible
 

