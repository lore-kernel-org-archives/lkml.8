Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9DEC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2449C204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoFttgUe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkK8n1UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgIDNxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:53:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33272 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbgIDNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:53:04 -0400
Date:   Fri, 04 Sep 2020 13:52:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599227580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkr/HLIUaEn11wmrkQXWUzeWfLZT8iGVmKjEtG27FxE=;
        b=UoFttgUellNkojHltJAC9vwplQQG0ztWz07G2ZJh0Ez+TuDB+4Fc8EuxzWiYkdEVX8W6yQ
        N164fsHMVRS9y58AMpgZMfMltMCUsCDgWL5uDVqFPaezSivV1ye3mEneaMuLMiDRcnlbIm
        7AFWsG4Xthx/4s5q8iNC+oOkyp16DuNUw/unJsXyaAAOyYXEd+H9Ez3Jtwq0+U0+EZq88c
        jLZM8GPaBA+uRzdddHrmXqllBlbp9chOBEglMEELITFiVENcX5i+b+oZVPsJiIOKI+oFTF
        mKCGjr+qUPgfoXNQFONXj/DpbjfZuRx4172/VSxbslfxKZx9COHd99B32joxnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599227580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkr/HLIUaEn11wmrkQXWUzeWfLZT8iGVmKjEtG27FxE=;
        b=PkK8n1ULq+emneJrCYLZPYZ9g0lj9/WUwquEnWqhTL3KQ2wfQy8Tu0GBcmfHj7b97WD/5y
        EHPTeCRS3kYIl1AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Unbreak 32bit fast syscall
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87k0xdjbtt.fsf@nanos.tec.linutronix.de>
References: <87k0xdjbtt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <159922757926.20229.18276989692142979100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4facb95b7adaf77e2da73aafb9ba60996fe42a12
Gitweb:        https://git.kernel.org/tip/4facb95b7adaf77e2da73aafb9ba60996fe42a12
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 02 Sep 2020 01:50:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:50:14 +02:00

x86/entry: Unbreak 32bit fast syscall

Andy reported that the syscall treacing for 32bit fast syscall fails:

# ./tools/testing/selftests/x86/ptrace_syscall_32
...
[RUN] SYSEMU
[FAIL] Initial args are wrong (nr=224, args=10 11 12 13 14 4289172732)
...
[RUN] SYSCALL
[FAIL] Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
 
The eason is that the conversion to generic entry code moved the retrieval
of the sixth argument (EBP) after the point where the syscall entry work
runs, i.e. ptrace, seccomp, audit...

Unbreak it by providing a split up version of syscall_enter_from_user_mode().

- syscall_enter_from_user_mode_prepare() establishes state and enables
  interrupts

- syscall_enter_from_user_mode_work() runs the entry work

Replace the call to syscall_enter_from_user_mode() in the 32bit fast
syscall C-entry with the split functions and stick the EBP retrieval
between them.

Fixes: 27d6b4d14f5c ("x86/entry: Use generic syscall entry function")
Reported-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87k0xdjbtt.fsf@nanos.tec.linutronix.de
---
 arch/x86/entry/common.c      | 29 +++++++++++++-------
 include/linux/entry-common.h | 51 ++++++++++++++++++++++++++++-------
 kernel/entry/common.c        | 35 +++++++++++++++++++-----
 3 files changed, 91 insertions(+), 24 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 48512c7..2f84c7c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -60,16 +60,10 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
 {
-	unsigned int nr = (unsigned int)regs->orig_ax;
-
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
-	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
-	 * orig_ax, the unsigned int return value truncates it.  This may
-	 * or may not be necessary, but it matches the old asm behavior.
-	 */
-	return (unsigned int)syscall_enter_from_user_mode(regs, nr);
+
+	return (unsigned int)regs->orig_ax;
 }
 
 /*
@@ -91,15 +85,29 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	unsigned int nr = syscall_32_enter(regs);
 
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
+	 * orig_ax, the unsigned int return value truncates it.  This may
+	 * or may not be necessary, but it matches the old asm behavior.
+	 */
+	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+
 	do_syscall_32_irqs_on(regs, nr);
 	syscall_exit_to_user_mode(regs);
 }
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr	= syscall_32_enter(regs);
+	unsigned int nr = syscall_32_enter(regs);
 	int res;
 
+	/*
+	 * This cannot use syscall_enter_from_user_mode() as it has to
+	 * fetch EBP before invoking any of the syscall entry work
+	 * functions.
+	 */
+	syscall_enter_from_user_mode_prepare(regs);
+
 	instrumentation_begin();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
@@ -122,6 +130,9 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		return false;
 	}
 
+	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
+	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
 	syscall_exit_to_user_mode(regs);
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index efebbff..159c747 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -110,15 +110,30 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 #endif
 
 /**
- * syscall_enter_from_user_mode - Check and handle work before invoking
- *				 a syscall
+ * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
  * @regs:	Pointer to currents pt_regs
- * @syscall:	The syscall number
  *
  * Invoked from architecture specific syscall entry code with interrupts
  * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct and the subsequent functions can be
- * instrumented.
+ * function returns all state is correct, interrupts are enabled and the
+ * subsequent functions can be instrumented.
+ *
+ * This handles lockdep, RCU (context tracking) and tracing state.
+ *
+ * This is invoked when there is extra architecture specific functionality
+ * to be done between establishing state and handling user mode entry work.
+ */
+void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
+
+/**
+ * syscall_enter_from_user_mode_work - Check and handle work before invoking
+ *				       a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
+ * architecture specific work.
  *
  * Returns: The original or a modified syscall number
  *
@@ -127,12 +142,30 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
  * syscall_set_return_value() first.  If neither of those are called and -1
  * is returned, then the syscall will fail with ENOSYS.
  *
- * The following functionality is handled here:
+ * It handles the following work items:
  *
- *  1) Establish state (lockdep, RCU (context tracking), tracing)
- *  2) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
+ *  1) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
  *     __secure_computing(), trace_sys_enter()
- *  3) Invocation of audit_syscall_entry()
+ *  2) Invocation of audit_syscall_entry()
+ */
+long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
+
+/**
+ * syscall_enter_from_user_mode - Establish state and check and handle work
+ *				  before invoking a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct, interrupts are enabled and the
+ * subsequent functions can be instrumented.
+ *
+ * This is combination of syscall_enter_from_user_mode_prepare() and
+ * syscall_enter_from_user_mode_work().
+ *
+ * Returns: The original or a modified syscall number. See
+ * syscall_enter_from_user_mode_work() for further explanation.
  */
 long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index fcae019..1868359 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -69,22 +69,45 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	return ret ? : syscall_get_nr(current, regs);
 }
 
-noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+static __always_inline long
+__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
 	unsigned long ti_work;
 
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
 	ti_work = READ_ONCE(current_thread_info()->flags);
 	if (ti_work & SYSCALL_ENTER_WORK)
 		syscall = syscall_trace_enter(regs, syscall, ti_work);
-	instrumentation_end();
 
 	return syscall;
 }
 
+long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	return __syscall_enter_from_user_work(regs, syscall);
+}
+
+noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	long ret;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	local_irq_enable();
+	ret = __syscall_enter_from_user_work(regs, syscall);
+	instrumentation_end();
+
+	return ret;
+}
+
+noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
+{
+	enter_from_user_mode(regs);
+	instrumentation_begin();
+	local_irq_enable();
+	instrumentation_end();
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
