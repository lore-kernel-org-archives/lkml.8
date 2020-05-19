Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46750C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1ED2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgESUA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgEST67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D50C08C5C0;
        Tue, 19 May 2020 12:58:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O6-00009A-03; Tue, 19 May 2020 21:58:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F0D8A1C084B;
        Tue, 19 May 2020 21:58:42 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:42 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/common: Protect against instrumentation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.520277507@linutronix.de>
References: <20200505134340.520277507@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832287.17951.17265850780241065833.tip-bot2@tip-bot2>
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

Commit-ID:     aa9712e07f82a5458f2f16c100c491d736240d60
Gitweb:        https://git.kernel.org/tip/aa9712e07f82a5458f2f16c100c491d736240d60
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Mar 2020 14:46:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:50 +02:00

x86/entry/common: Protect against instrumentation

Mark the various syscall entries with noinstr to protect them against
instrumentation and add the noinstrumentation_begin()/end() annotations to mark the
parts of the functions which are safe to call out into instrumentable code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134340.520277507@linutronix.de


---
 arch/x86/entry/common.c | 133 ++++++++++++++++++++++++++-------------
 1 file changed, 89 insertions(+), 44 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index d862add..9892fb7 100644
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
+	instrumentation_begin();
+	CT_WARN_ON(state != CONTEXT_USER);
+	instrumentation_end();
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
@@ -179,8 +190,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 	}
 }
 
-/* Called with IRQs disabled. */
-__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
+static void __prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags;
@@ -219,10 +229,14 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 	 */
 	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
 #endif
+}
 
-	user_enter_irqoff();
-
-	mds_user_clear_cpu_buffers();
+__visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	__prepare_exit_to_usermode(regs);
+	instrumentation_end();
+	exit_to_user_mode();
 }
 
 #define SYSCALL_EXIT_WORK_FLAGS				\
@@ -251,11 +265,7 @@ static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
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
@@ -276,15 +286,29 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
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
+	instrumentation_begin();
+	__syscall_return_slowpath(regs);
+	instrumentation_end();
+	exit_to_user_mode();
 }
 
 #ifdef CONFIG_X86_64
-__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
 	enter_from_user_mode();
+	instrumentation_begin();
+
 	local_irq_enable();
 	ti = current_thread_info();
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
@@ -301,8 +325,10 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
 	}
+	__syscall_return_slowpath(regs);
 
-	syscall_return_slowpath(regs);
+	instrumentation_end();
+	exit_to_user_mode();
 }
 #endif
 
@@ -313,7 +339,7 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
  * extremely hot in workloads that use it, and it's usually called from
  * do_fast_syscall_32, so forcibly inline it to improve performance.
  */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
+static void do_syscall_32_irqs_on(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	unsigned int nr = (unsigned int)regs->orig_ax;
@@ -337,27 +363,62 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
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
+	instrumentation_begin();
+
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
+
+	instrumentation_end();
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
@@ -367,33 +428,17 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 	regs->ip = landing_pad;
 
 	enter_from_user_mode();
+	instrumentation_begin();
 
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
+	instrumentation_end();
+	exit_to_user_mode();
 
-	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs);
+	/* If it failed, keep it simple: use IRET. */
+	if (!success)
+		return 0;
 
 #ifdef CONFIG_X86_64
 	/*
