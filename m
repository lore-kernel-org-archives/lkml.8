Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41433C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A93320826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgEUUca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgEUUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:22 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrrG-0000z2-SP; Thu, 21 May 2020 22:32:03 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E2956100606;
        Thu, 21 May 2020 22:32:01 +0200 (CEST)
Message-Id: <20200521202120.523289762@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:52 +0200
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
Subject: [patch V9 39/39] x86/entry: Remove the TRACE_IRQS cruft
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

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S       |   13 -------------
 arch/x86/entry/thunk_64.S       |    9 +--------
 arch/x86/include/asm/irqflags.h |   10 ----------
 3 files changed, 1 insertion(+), 31 deletions(-)

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
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -172,14 +172,4 @@ static inline int arch_irqs_disabled(voi
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

