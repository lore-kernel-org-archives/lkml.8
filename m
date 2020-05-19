Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA53C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5754F2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgEST7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgEST66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C873C08C5C2;
        Tue, 19 May 2020 12:58:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O0-0008Sf-TM; Tue, 19 May 2020 21:58:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3EB1E1C0820;
        Tue, 19 May 2020 21:58:36 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:36 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Provide macros to define/declare IDT
 entry points
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134904.273363275@linutronix.de>
References: <20200505134904.273363275@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831609.17951.16740794273202663663.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     c5c3c71d132f6480c71bc91723d3d987abfdfaa3
Gitweb:        https://git.kernel.org/tip/c5c3c71d132f6480c71bc91723d3d987abfdfaa3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:56 +02:00

x86/idtentry: Provide macros to define/declare IDT entry points

Provide DECLARE/DEFINE_IDTENTRY() macros.

DEFINE_IDTENTRY() provides a wrapper which acts as the function
definition. The exception handler body is just appended to it with curly
brackets. The entry point is marked noinstr so that irq tracing and the
enter_from_user_mode() can be moved into the C-entry point. As all
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
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134904.273363275@linutronix.de


---
 arch/x86/entry/entry_32.S       |  6 +++-
 arch/x86/entry/entry_64.S       |  6 +++-
 arch/x86/include/asm/idtentry.h | 67 ++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/traps.h    |  2 +-
 4 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/idtentry.h

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index eb64e78..8c0e07e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -753,6 +753,12 @@ SYM_CODE_END(\asmsym)
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 96ad26f..ee07162 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -699,6 +699,12 @@ SYM_CODE_END(\asmsym)
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
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
new file mode 100644
index 0000000..bbd81e2
--- /dev/null
+++ b/arch/x86/include/asm/idtentry.h
@@ -0,0 +1,67 @@
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
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	idtentry_enter(regs);						\
+	instrumentation_begin();					\
+	__##func (regs);						\
+	instrumentation_end();						\
+	idtentry_exit(regs);						\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs)
+
+#else /* !__ASSEMBLY__ */
+
+/*
+ * The ASM variants for DECLARE_IDTENTRY*() which emit the ASM entry stubs.
+ */
+#define DECLARE_IDTENTRY(vector, func)					\
+	idtentry vector asm_##func func has_error_code=0 sane=1
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 2376620..814273f 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -6,8 +6,8 @@
 #include <linux/kprobes.h>
 
 #include <asm/debugreg.h>
+#include <asm/idtentry.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
-#include <asm/trapnr.h>
 
 #define dotraplinkage __visible
 
