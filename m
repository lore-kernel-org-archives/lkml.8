Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCCC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C4E20836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgEEOOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729601AbgEEOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA95C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:36 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKw-0000yg-Ip; Tue, 05 May 2020 16:14:18 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C45671001F5;
        Tue,  5 May 2020 16:14:17 +0200 (CEST)
Message-Id: <20200505134340.520277507@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:16 +0200
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
Subject: [patch V4 part 2 04/18] x86/entry/common: Protect against instrumentation
References: <20200505134112.272268764@linutronix.de>
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

Mark the various syscall entries with noinstr to protect them against
instrumentation and add the noinstr_begin()/end() annotations to mark the
parts of the functions which are safe to call out into instrumentable code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |  135 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 90 insertions(+), 45 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -41,15 +41,26 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING
 /* Called on entry from user mode with IRQs off. */
-__visible inline noinstr void enter_from_user_mode(void)
+__visible noinstr void enter_from_user_mode(void)
 {
-	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	enum ctx_state state = ct_state();
+
 	user_exit_irqoff();
+
+	instr_begin();
+	CT_WARN_ON(state != CONTEXT_USER);
+	instr_end();
 }
 #else
 static inline void enter_from_user_mode(void) {}
 #endif
 
+static noinstr void exit_to_user_mode(void)
+{
+	user_enter_irqoff();
+	mds_user_clear_cpu_buffers();
+}
+
 static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
 {
 #ifdef CONFIG_X86_64
@@ -179,8 +190,7 @@ static void exit_to_usermode_loop(struct
 	}
 }
 
-/* Called with IRQs disabled. */
-__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
+static void __prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags;
@@ -219,10 +229,14 @@ static void exit_to_usermode_loop(struct
 	 */
 	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
 #endif
+}
 
-	user_enter_irqoff();
-
-	mds_user_clear_cpu_buffers();
+__visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
+{
+	instr_begin();
+	__prepare_exit_to_usermode(regs);
+	instr_end();
+	exit_to_user_mode();
 }
 
 #define SYSCALL_EXIT_WORK_FLAGS				\
@@ -251,11 +265,7 @@ static void syscall_slow_exit_work(struc
 		tracehook_report_syscall_exit(regs, step);
 }
 
-/*
- * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
- * state such that we can immediately switch to user mode.
- */
-__visible inline void syscall_return_slowpath(struct pt_regs *regs)
+static void __syscall_return_slowpath(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags = READ_ONCE(ti->flags);
@@ -276,15 +286,29 @@ static void syscall_slow_exit_work(struc
 		syscall_slow_exit_work(regs, cached_flags);
 
 	local_irq_disable();
-	prepare_exit_to_usermode(regs);
+	__prepare_exit_to_usermode(regs);
+}
+
+/*
+ * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
+ * state such that we can immediately switch to user mode.
+ */
+__visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
+{
+	instr_begin();
+	__syscall_return_slowpath(regs);
+	instr_end();
+	exit_to_user_mode();
 }
 
 #ifdef CONFIG_X86_64
-__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
 	enter_from_user_mode();
+	instr_begin();
+
 	local_irq_enable();
 	ti = current_thread_info();
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
@@ -301,8 +325,10 @@ static void syscall_slow_exit_work(struc
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
 	}
+	__syscall_return_slowpath(regs);
 
-	syscall_return_slowpath(regs);
+	instr_end();
+	exit_to_user_mode();
 }
 #endif
 
@@ -310,10 +336,10 @@ static void syscall_slow_exit_work(struc
 /*
  * Does a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.  Does
  * all entry and exit work and returns with IRQs off.  This function is
- * extremely hot in workloads that use it, and it's usually called from
+ * ex2tremely hot in workloads that use it, and it's usually called from
  * do_fast_syscall_32, so forcibly inline it to improve performance.
  */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
+static void do_syscall_32_irqs_on(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	unsigned int nr = (unsigned int)regs->orig_ax;
@@ -337,27 +363,62 @@ static __always_inline void do_syscall_3
 		regs->ax = ia32_sys_call_table[nr](regs);
 	}
 
-	syscall_return_slowpath(regs);
+	__syscall_return_slowpath(regs);
 }
 
 /* Handles int $0x80 */
-__visible void do_int80_syscall_32(struct pt_regs *regs)
+__visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	enter_from_user_mode();
+	instr_begin();
+
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
+
+	instr_end();
+	exit_to_user_mode();
+}
+
+static bool __do_fast_syscall_32(struct pt_regs *regs)
+{
+	int res;
+
+	/* Fetch EBP from where the vDSO stashed it. */
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/*
+		 * Micro-optimization: the pointer we're following is
+		 * explicitly 32 bits, so it can't be out of range.
+		 */
+		res = __get_user(*(u32 *)&regs->bp,
+			 (u32 __user __force *)(unsigned long)(u32)regs->sp);
+	} else {
+		res = get_user(*(u32 *)&regs->bp,
+		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
+	}
+
+	if (res) {
+		/* User code screwed up. */
+		regs->ax = -EFAULT;
+		local_irq_disable();
+		__prepare_exit_to_usermode(regs);
+		return false;
+	}
+
+	/* Now this is just like a normal syscall. */
+	do_syscall_32_irqs_on(regs);
+	return true;
 }
 
 /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible long do_fast_syscall_32(struct pt_regs *regs)
+__visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 {
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
-
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
-		vdso_image_32.sym_int80_landing_pad;
+					vdso_image_32.sym_int80_landing_pad;
+	bool success;
 
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
@@ -367,33 +428,17 @@ static __always_inline void do_syscall_3
 	regs->ip = landing_pad;
 
 	enter_from_user_mode();
+	instr_begin();
 
 	local_irq_enable();
+	success = __do_fast_syscall_32(regs);
 
-	/* Fetch EBP from where the vDSO stashed it. */
-	if (
-#ifdef CONFIG_X86_64
-		/*
-		 * Micro-optimization: the pointer we're following is explicitly
-		 * 32 bits, so it can't be out of range.
-		 */
-		__get_user(*(u32 *)&regs->bp,
-			    (u32 __user __force *)(unsigned long)(u32)regs->sp)
-#else
-		get_user(*(u32 *)&regs->bp,
-			 (u32 __user __force *)(unsigned long)(u32)regs->sp)
-#endif
-		) {
-
-		/* User code screwed up. */
-		local_irq_disable();
-		regs->ax = -EFAULT;
-		prepare_exit_to_usermode(regs);
-		return 0;	/* Keep it simple: use IRET. */
-	}
+	instr_end();
+	exit_to_user_mode();
 
-	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs);
+	/* If it failed, keep it simple: use IRET. */
+	if (!success)
+		return 0;
 
 #ifdef CONFIG_X86_64
 	/*

