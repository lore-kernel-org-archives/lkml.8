Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1201C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D056720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgEEOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729769AbgEEOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DFBC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLZ-0001Hh-Hc; Tue, 05 May 2020 16:14:57 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 08E4A1001F5;
        Tue,  5 May 2020 16:14:57 +0200 (CEST)
Message-Id: <20200505134903.731004084@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:43:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 3 05/29] x86/traps: Split trap numbers out in a
 seperate header
References: <20200505134354.774943181@linutronix.de>
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

So they can be used in ASM code. For this it is also necessary to convert
them to defines. Will be used for the rework of the entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

---
 arch/x86/include/asm/trapnr.h |   31 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/traps.h  |   26 +-------------------------
 2 files changed, 32 insertions(+), 25 deletions(-)

--- /dev/null
+++ b/arch/x86/include/asm/trapnr.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_TRAPNR_H
+#define _ASM_X86_TRAPNR_H
+
+/* Interrupts/Exceptions */
+
+#define X86_TRAP_DE		 0	/* Divide-by-zero */
+#define X86_TRAP_DB		 1	/* Debug */
+#define X86_TRAP_NMI		 2	/* Non-maskable Interrupt */
+#define X86_TRAP_BP		 3	/* Breakpoint */
+#define X86_TRAP_OF		 4	/* Overflow */
+#define X86_TRAP_BR		 5	/* Bound Range Exceeded */
+#define X86_TRAP_UD		 6	/* Invalid Opcode */
+#define X86_TRAP_NM		 7	/* Device Not Available */
+#define X86_TRAP_DF		 8	/* Double Fault */
+#define X86_TRAP_OLD_MF		 9	/* Coprocessor Segment Overrun */
+#define X86_TRAP_TS		10	/* Invalid TSS */
+#define X86_TRAP_NP		11	/* Segment Not Present */
+#define X86_TRAP_SS		12	/* Stack Segment Fault */
+#define X86_TRAP_GP		13	/* General Protection Fault */
+#define X86_TRAP_PF		14	/* Page Fault */
+#define X86_TRAP_SPURIOUS	15	/* Spurious Interrupt */
+#define X86_TRAP_MF		16	/* x87 Floating-Point Exception */
+#define X86_TRAP_AC		17	/* Alignment Check */
+#define X86_TRAP_MC		18	/* Machine Check */
+#define X86_TRAP_XF		19	/* SIMD Floating-Point Exception */
+#define X86_TRAP_VE		20	/* Virtualization Exception */
+#define X86_TRAP_CP		21	/* Control Protection Exception */
+#define X86_TRAP_IRET		32	/* IRET Exception */
+
+#endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -7,6 +7,7 @@
 
 #include <asm/debugreg.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
+#include <asm/trapnr.h>
 
 #define dotraplinkage __visible
 
@@ -127,31 +128,6 @@ void __noreturn handle_stack_overflow(co
 				      unsigned long fault_address);
 #endif
 
-/* Interrupts/Exceptions */
-enum {
-	X86_TRAP_DE = 0,	/*  0, Divide-by-zero */
-	X86_TRAP_DB,		/*  1, Debug */
-	X86_TRAP_NMI,		/*  2, Non-maskable Interrupt */
-	X86_TRAP_BP,		/*  3, Breakpoint */
-	X86_TRAP_OF,		/*  4, Overflow */
-	X86_TRAP_BR,		/*  5, Bound Range Exceeded */
-	X86_TRAP_UD,		/*  6, Invalid Opcode */
-	X86_TRAP_NM,		/*  7, Device Not Available */
-	X86_TRAP_DF,		/*  8, Double Fault */
-	X86_TRAP_OLD_MF,	/*  9, Coprocessor Segment Overrun */
-	X86_TRAP_TS,		/* 10, Invalid TSS */
-	X86_TRAP_NP,		/* 11, Segment Not Present */
-	X86_TRAP_SS,		/* 12, Stack Segment Fault */
-	X86_TRAP_GP,		/* 13, General Protection Fault */
-	X86_TRAP_PF,		/* 14, Page Fault */
-	X86_TRAP_SPURIOUS,	/* 15, Spurious Interrupt */
-	X86_TRAP_MF,		/* 16, x87 Floating-Point Exception */
-	X86_TRAP_AC,		/* 17, Alignment Check */
-	X86_TRAP_MC,		/* 18, Machine Check */
-	X86_TRAP_XF,		/* 19, SIMD Floating-Point Exception */
-	X86_TRAP_IRET = 32,	/* 32, IRET Exception */
-};
-
 /*
  * Page fault error code bits:
  *

