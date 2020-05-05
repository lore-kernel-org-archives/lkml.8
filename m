Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB3C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F92D21974
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgEEOOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729453AbgEEONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03EEC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:54 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyK6-0000PP-MM; Tue, 05 May 2020 16:13:26 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3704BFFC8D;
        Tue,  5 May 2020 16:13:26 +0200 (CEST)
Message-Id: <20200505134059.061301403@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:12 +0200
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
Subject: [patch V4 part 1 10/36] x86/entry: Remove the unused LOCKDEP_SYSEXIT cruft
References: <20200505131602.633487962@linutronix.de>
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

No users left since two years due to commit 21d375b6b34f ("x86/entry/64:
Remove the SYSCALL64 fast path")

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/thunk_64.S       |    5 -----
 arch/x86/include/asm/irqflags.h |   24 ------------------------
 2 files changed, 29 deletions(-)

--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -42,10 +42,6 @@ SYM_FUNC_END(\name)
 	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
 #endif
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	THUNK lockdep_sys_exit_thunk,lockdep_sys_exit
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
@@ -54,7 +50,6 @@ SYM_FUNC_END(\name)
 #endif
 
 #if defined(CONFIG_TRACE_IRQFLAGS) \
- || defined(CONFIG_DEBUG_LOCK_ALLOC) \
  || defined(CONFIG_PREEMPTION)
 SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -180,30 +180,6 @@ static inline int arch_irqs_disabled(voi
 #  define TRACE_IRQS_ON
 #  define TRACE_IRQS_OFF
 #endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-#  ifdef CONFIG_X86_64
-#    define LOCKDEP_SYS_EXIT		call lockdep_sys_exit_thunk
-#    define LOCKDEP_SYS_EXIT_IRQ \
-	TRACE_IRQS_ON; \
-	sti; \
-	call lockdep_sys_exit_thunk; \
-	cli; \
-	TRACE_IRQS_OFF;
-#  else
-#    define LOCKDEP_SYS_EXIT \
-	pushl %eax;				\
-	pushl %ecx;				\
-	pushl %edx;				\
-	call lockdep_sys_exit;			\
-	popl %edx;				\
-	popl %ecx;				\
-	popl %eax;
-#    define LOCKDEP_SYS_EXIT_IRQ
-#  endif
-#else
-#  define LOCKDEP_SYS_EXIT
-#  define LOCKDEP_SYS_EXIT_IRQ
-#endif
 #endif /* __ASSEMBLY__ */
 
 #endif

