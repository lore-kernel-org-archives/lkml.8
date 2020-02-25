Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA6C4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8141324680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgBYX0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55942 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbgBYX0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:42 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jau-00053H-0i; Wed, 26 Feb 2020 00:26:28 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1D46F1040C1;
        Wed, 26 Feb 2020 00:25:52 +0100 (CET)
Message-Id: <20200225231609.412892623@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 05/15] x86/entry: Provide IDTEnTRY_SYSVEC
References: <20200225224719.950376311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a IDTENTRY variant for system vectors to consolidate the differnt
mechanisms to emit the ASM stubs for 32 an 64 bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    4 ++++
 arch/x86/entry/entry_64.S       |   19 +++++++++++++++----
 arch/x86/include/asm/idtentry.h |   25 +++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1261,6 +1261,10 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
 SYM_CODE_END(asm_\cfunc)
 .endm
 
+.macro idtentry_sysvec vector cfunc
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0
+.endm
+
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit.
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -577,6 +577,21 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * System vectors which invoke their handlers directly and are not
+ * going through the regular common device interrupt handling code.
+ *
+ * Stick them all into the irqentry.text section.
+ */
+#define PUSH_SECTION_IRQENTRY	.pushsection .irqentry.text, "ax"
+#define POP_SECTION_IRQENTRY	.popsection
+
+.macro idtentry_sysvec vector cfunc
+	PUSH_SECTION_IRQENTRY
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0 irq_stack=0
+	POP_SECTION_IRQENTRY
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
@@ -973,10 +988,6 @@ SYM_CODE_END(\sym)
 _ASM_NOKPROBE(\sym)
 .endm
 
-/* Make sure APIC interrupt handlers end up in the irqentry section: */
-#define PUSH_SECTION_IRQENTRY	.pushsection .irqentry.text, "ax"
-#define POP_SECTION_IRQENTRY	.popsection
-
 .macro apicinterrupt num sym do_sym
 PUSH_SECTION_IRQENTRY
 apicinterrupt3 \num \sym \do_sym
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -210,6 +210,27 @@ NOKPROBE_SYMBOL(func);							\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
 				     unsigned long vector)
+/**
+ * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ */
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * @func is called from ASM entry code with interrupts disabled.
+ */
+#define DEFINE_IDTENTRY_SYSVEC(func)					\
+	DEFINE_IDTENTRY(func)
 
 #ifdef CONFIG_X86_64
 /**
@@ -384,6 +405,10 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_IRQ(vector, func)			\
 	idtentry_irq vector func
 
+/* System vector entries */
+#define DECLARE_IDTENTRY_SYSVEC(__vector, __func)		\
+	idtentry_sysvec __vector __func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)			\
 	idtentry_mce_db vector asm_##func func

