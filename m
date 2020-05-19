Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE3E20849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgEST7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgEST6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58DC08C5C1;
        Tue, 19 May 2020 12:58:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nz-0008Vn-Cd; Tue, 19 May 2020 21:58:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 67F071C0853;
        Tue, 19 May 2020 21:58:38 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:38 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Split trap numbers out in a separate header
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134903.731004084@linutronix.de>
References: <20200505134903.731004084@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831831.17951.6614757473936152416.tip-bot2@tip-bot2>
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

Commit-ID:     9201e511e0f7184bebbd58e98d3d08fa13a34cac
Gitweb:        https://git.kernel.org/tip/9201e511e0f7184bebbd58e98d3d08fa13a34cac
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:54 +02:00

x86/traps: Split trap numbers out in a separate header

So they can be used in ASM code. For this it is also necessary to convert
them to defines. Will be used for the rework of the entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134903.731004084@linutronix.de



---
 arch/x86/include/asm/trapnr.h | 31 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/traps.h  | 26 +-------------------------
 2 files changed, 32 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/include/asm/trapnr.h

diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
new file mode 100644
index 0000000..082f456
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
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 2ae904b..2376620 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -7,6 +7,7 @@
 
 #include <asm/debugreg.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
+#include <asm/trapnr.h>
 
 #define dotraplinkage __visible
 
@@ -122,31 +123,6 @@ void __noreturn handle_stack_overflow(const char *message,
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
