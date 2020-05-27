Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FE32100A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgE0ILq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgE0ILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0AC061A0F;
        Wed, 27 May 2020 01:11:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrA8-0002T1-ER; Wed, 27 May 2020 10:11:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBDAC1C00ED;
        Wed, 27 May 2020 10:11:43 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:43 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove the TRACE_IRQS cruft
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202120.523289762@linutronix.de>
References: <20200521202120.523289762@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710364.17951.5337501176365228480.tip-bot2@tip-bot2>
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

Commit-ID:     5a7462b1f9c19312da0e489b859184cc88229bad
Gitweb:        https://git.kernel.org/tip/5a7462b1f9c19312da0e489b859184cc88229bad
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:29 +02:00

x86/entry: Remove the TRACE_IRQS cruft

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202120.523289762@linutronix.de
---
 arch/x86/entry/entry_64.S       | 13 -------------
 arch/x86/entry/thunk_64.S       |  9 +--------
 arch/x86/include/asm/irqflags.h | 10 ----------
 3 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2566554..265ff97 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -53,19 +53,6 @@ SYM_CODE_START(native_usergs_sysret64)
 SYM_CODE_END(native_usergs_sysret64)
 #endif /* CONFIG_PARAVIRT */
 
-.macro TRACE_IRQS_FLAGS flags:req
-#ifdef CONFIG_TRACE_IRQFLAGS
-	btl	$9, \flags		/* interrupts off? */
-	jnc	1f
-	TRACE_IRQS_ON
-1:
-#endif
-.endm
-
-.macro TRACE_IRQS_IRETQ
-	TRACE_IRQS_FLAGS EFLAGS(%rsp)
-.endm
-
 /*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 34f980c..ccd3287 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -3,7 +3,6 @@
  * Save registers before calling assembly functions. This avoids
  * disturbance of register allocation in some inline assembly constructs.
  * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
- * Added trace_hardirqs callers - Copyright 2007 Steven Rostedt, Red Hat, Inc.
  */
 #include <linux/linkage.h>
 #include "calling.h"
@@ -37,11 +36,6 @@ SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
@@ -49,8 +43,7 @@ SYM_FUNC_END(\name)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) \
- || defined(CONFIG_PREEMPTION)
+#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
 	popq %r10
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index e00f064..8ddff8d 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -172,14 +172,4 @@ static inline int arch_irqs_disabled(void)
 }
 #endif /* !__ASSEMBLY__ */
 
-#ifdef __ASSEMBLY__
-#ifdef CONFIG_TRACE_IRQFLAGS
-#  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk;
-#  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk;
-#else
-#  define TRACE_IRQS_ON
-#  define TRACE_IRQS_OFF
-#endif
-#endif /* __ASSEMBLY__ */
-
 #endif
