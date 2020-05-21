Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E3CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C22520826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgEUUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgEUUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5DC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:03 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqd-0000Lr-6r; Thu, 21 May 2020 22:31:23 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D3742100606;
        Thu, 21 May 2020 22:31:20 +0200 (CEST)
Message-Id: <20200521202117.382387286@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:19 +0200
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
Subject: [patch V9 06/39] x86/idtentry: Switch to conditional RCU handling
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

Switch all idtentry_enter/exit() users over to the new conditional RCU
handling scheme and make the user mode entries in #DB, #INT3 and #MCE use
the user mode idtentry functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: New patch
---
 arch/x86/include/asm/idtentry.h |   10 ++++++----
 arch/x86/kernel/cpu/mce/core.c  |    4 ++--
 arch/x86/kernel/traps.c         |   10 +++++-----
 3 files changed, 13 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -61,11 +61,12 @@ static __always_inline void __##func(str
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_enter(regs);						\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	idtentry_exit(regs);						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -107,11 +108,12 @@ static __always_inline void __##func(str
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	idtentry_enter(regs);						\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	idtentry_exit(regs);						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1929,11 +1929,11 @@ static __always_inline void exc_machine_
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
-	idtentry_enter(regs);
+	idtentry_enter_user(regs);
 	instrumentation_begin();
 	machine_check_vector(regs);
 	instrumentation_end();
-	idtentry_exit(regs);
+	idtentry_exit_user(regs);
 }
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -619,18 +619,18 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		return;
 
 	/*
-	 * idtentry_enter() uses static_branch_{,un}likely() and therefore
+	 * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
 	 * can trigger INT3, hence poke_int3_handler() must be done
 	 * before. If the entry came from kernel mode, then use nmi_enter()
 	 * because the INT3 could have been hit in any context including
 	 * NMI.
 	 */
 	if (user_mode(regs)) {
-		idtentry_enter(regs);
+		idtentry_enter_user(regs);
 		instrumentation_begin();
 		do_int3_user(regs);
 		instrumentation_end();
-		idtentry_exit(regs);
+		idtentry_exit_user(regs);
 	} else {
 		nmi_enter();
 		instrumentation_begin();
@@ -877,7 +877,7 @@ static __always_inline void exc_debug_ke
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
-	idtentry_enter(regs);
+	idtentry_enter_user(regs);
 	clear_thread_flag(TIF_BLOCKSTEP);
 
 	/*
@@ -886,7 +886,7 @@ static __always_inline void exc_debug_us
 	 * User wants a sigtrap for that.
 	 */
 	handle_debug(regs, dr6, !dr6);
-	idtentry_exit(regs);
+	idtentry_exit_user(regs);
 }
 
 #ifdef CONFIG_X86_64

