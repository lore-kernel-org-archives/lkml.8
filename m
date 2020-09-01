Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91411C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679212071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qrFZU/0h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhgC21YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIAXu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:50:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgIAXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:50:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599004255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wK6RDi1krNWXVmj0inMohutKNsAx8frJh82p3BOn6WY=;
        b=qrFZU/0h6bgCxn+pt/aoDLNvlU+oeGlo3pWB5KbFEToUpizcOig27PSh7G6rUi020/eJuK
        leZlBnHg7YBLohHF4rhXmZH62tNPyXiWKDkXkQ4T+KqsntxKUMuGqOeSARFrip9hV9jeec
        taUGX5Rq6ElrD6qaOCku9pjgW33kbZSgD8rRLKBezyOJFA3IsuOR3Y3iQo9bBi1vlqTFZv
        CJPYGNHGEeHq7lqZ+yHrBYLzTxFauqlDnL0go8luoIneibPXJiimta9ocfJ+A83MmqDPOU
        odW9OKK0O38PRNzu4rIoduK2EfEc1bwgJmr0KFWpw1SsrN7mW4bOL74fGZ7HRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599004255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wK6RDi1krNWXVmj0inMohutKNsAx8frJh82p3BOn6WY=;
        b=BhgC21YOoROYrIYwEjc5/tHh16okw6IRuQspc0YjCo4rtnDkQJBqnZMigw0YNOTKniQ8Gn
        44fVd/glXw4GwTDg==
To:     Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: ptrace_syscall_32 is failing
In-Reply-To: <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com>
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com> <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com> <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com>
Date:   Wed, 02 Sep 2020 01:50:54 +0200
Message-ID: <87k0xdjbtt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30 2020 at 08:52, Andy Lutomirski wrote:
>> > [RUN]    SYSCALL
>> > [FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
>> > [RUN]    SYSCALL
>> > [OK]    Args after SIGUSR1 are correct (ax = -514)
>> > [OK]    Child got SIGUSR1
>> > [RUN]    Step again
>> > [OK]    pause(2) restarted correctly
>>
>> Bisected to commit 0b085e68f407 ("x86/entry: Consolidate 32/64 bit
>> syscall entry").
>> It looks like it is because syscall_enter_from_user_mode() is called
>> before reading the 6th argument from the user stack.

Bah.I don't know how I managed to miss that part and interestingly
enough that none of the robots caught that either

> Thomas, can we revert the syscall_enter() and syscall_exit() part of
> the series?

Hrm.

> I think that they almost work for x86, but not quite as
> indicated by this bug.  Even if we imagine we can somehow hack around
> this bug, I imagine we're going to find other problems with this
> model, e.g. the potential upcoming exit problem I noted in my review.

What's the upcoming problem?

> I really think the model should be:
>
> void do_syscall_whatever(...)
> {
>   irqentry_enter(...);
>   instrumentation_begin();
>
>   /* Do whatever arch ABI oddities are needed on entry. */
>
>   Then either:
>   syscall_begin(arch, nr, regs);
>   dispatch the syscall;
>   syscall_end(arch, nr, regs);
>
>   Or just:
>   generic_do_syscall(arch, nr, regs);
>
>   /* Do whatever arch ABI oddities are needed on exit from the syscall. */
>
>   instrumentation_end();
>   irqentry_exit(...);
> }

I don't think we want that in general. The current variant is perfectly
fine for everything except the 32bit fast syscall nonsense. Also
irqentry_entry/exit is not equivalent to the syscall_enter/exit
counterparts.

> x86 has an ABI oddity needed on entry: this fast syscall argument
> fixup.  We also might end up with ABI oddities on exit if we ever try
> to make single-stepping of syscalls work fully correctly.  x86 sort of
> gets away without specifying arch because the arch helpers that get
> called for audit, etc can deduce the arch, but this is kind of gross.
> I suppose we could omit arch as an explicit parameter.

I had that in one of the early versions and was advised to drop that.

> Or I suppose we could try to rejigger the API in time for 5.9.
> Fortunately only x86 uses the new APIs so far.  I cc'd a bunch of
> other arch maintainers to see if other architectures fit well in the
> new syscall_enter() model, but I feel like the fact that x86 is
> already broken indicates that we messed it up a bit.

It's not unfixable and the fix is close to what you suggested above
except that it preserves the straight forward stuff for the !32bit fast
syscall case. Completely untested patch below. I run proper tests
tomorrow with brain awake.

Thanks,

        tglx
---
 arch/x86/entry/common.c      |   29 ++++++++++++++++--------
 include/linux/entry-common.h |   51 +++++++++++++++++++++++++++++++++++--------
 kernel/entry/common.c        |   35 ++++++++++++++++++++++++-----
 3 files changed, 91 insertions(+), 24 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -60,16 +60,10 @@
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
@@ -91,15 +85,29 @@ static __always_inline void do_syscall_3
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
@@ -122,6 +130,9 @@ static noinstr bool __do_fast_syscall_32
 		return false;
 	}
 
+	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
+	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
 	syscall_exit_to_user_mode(regs);
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -110,15 +110,30 @@ static inline __must_check int arch_sysc
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
@@ -127,12 +142,30 @@ static inline __must_check int arch_sysc
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
 
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -68,22 +68,45 @@ static long syscall_trace_enter(struct p
 	return ret ? : syscall;
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
