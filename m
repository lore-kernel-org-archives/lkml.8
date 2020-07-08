Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC50C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C64820775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdvWAJpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGHIB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:01:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB55C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:01:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so21300605pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E8pJhv0K/z9zkJ1ZclLt/dLEPitFJi7Ik0lEjCM6nVQ=;
        b=IdvWAJpB2QFYN8Jx6HgSHocjnE5heB/iKcYCe2syUpk+WfVheo2YOaPOBz40DE1Kye
         /yELr3JYXQkzYnmb6aTMm6Do6sclHFGyx9TBd4q5aCB9SrLfEXyDfmMKjzveM+DfDPwS
         1eKIBMr46c9kyhGwt8DmVJbRgh9W0OaJvvfEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E8pJhv0K/z9zkJ1ZclLt/dLEPitFJi7Ik0lEjCM6nVQ=;
        b=KDKNYmArYcW6fYcIcAiTPOy3WD2b0wVllFxfMyAXt1gKgLi6pZRXUlbsnXpEvMdMFL
         NqXz3g26aw7o+DK8VzoAzF6sIkKUk81s+UdyjS9gT8waO45pmJH9vWif/pgHe77QkgpE
         VUOTfEOW2ll9Lps8FA50QYXhh60YUYinLSXVOUjUN/9ToCpUZBDW5M/ySZ9ok/FFsG6I
         zpRROUwdbuueQ0vfopjPEAkGPu7jhT8s95qSuVZH+igPoiqhotMItHTY0Dl8QStkU6Y6
         FOgp4oxPJ+ufhXeh+xndM/CKD3EOQ8WHpbC32U89va8WTN/6DmzGin3ZyczLfCPwUpJN
         hnSw==
X-Gm-Message-State: AOAM532H2bYct/CQiG2ykgmLg3HtlLTIXdzQ3d85YH9vhT8vCuHfPeAC
        7k4U9ffbAPJkoRdO0dVf7ok7ag==
X-Google-Smtp-Source: ABdhPJyiPrP8+4Kbkkyu0LcoZKk7fahGkIRcWmV9i1xeGXLm/tkL0elKoy7bXmBdQhQB0WquYJTFGA==
X-Received: by 2002:a62:3446:: with SMTP id b67mr29297223pfa.184.1594195283083;
        Wed, 08 Jul 2020 01:01:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm629110pfl.14.2020.07.08.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 01:01:22 -0700 (PDT)
Date:   Wed, 8 Jul 2020 01:01:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>
Subject: Re: [PATCH RFC] kernel: Implement selective syscall redirection
 through personality
Message-ID: <202007072347.368E1B975@keescook>
References: <20200708055600.2169213-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708055600.2169213-1-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 01:56:00AM -0400, Gabriel Krisman Bertazi wrote:
> Introduce a mechanism to quickly disable/enable syscall handling for a
> specific process and redirect to userspace via SIGSYS.  This is useful
> for processes that have different personalities depending on which part
> of the application is executing, but who need to perform the personality
> switch really fast, without paying the cost of a system call on each
> boundary transition.  This is particularly important for Windows games
> running over Wine.

nit: probably best to avoid saying "personality" here, since this isn't
using the personality bits.

> The proposed interface looks like this:
> 
>   prctl(PR_SET_SYSCALL_DISABLE, <mode>, <dispatcher>, [fast_selector])
> 
> Dispatcher is the address of a syscall instruction that is allowed to
> by-pass the blockage, such that in fast paths you don't need to disable
> the trap nor check the fast selector.  This is essential to return from
> SIGSYS to a blocked area without triggering another SIGSYS from the
> rt_sigreturn.
> 
> fast-selector is an optional pointer to an aligned int-sized userspace
> memory region that has a key switch for the mechanism. The only policy
> the kernel enforces on that area is that zero means SYSCALL_ALLOW while
> !0 means SYSCALL_BLOCK.

I like this; the boundary control is nice and clean! (The only potentially
weird bit is threads being able to accidentally muck with each other,
but that'd just lead to debugging bizarre behaviors if one thread pokes
another thread's fast_selector.)

> Internally, this doesn't add overhead to the syscall hot path, and it
> requires very little per-architecture support.  I avoided using seccomp,

Yeah -- it's basically a TIF flag and the plumbing to get the syscall
number (actually.. can you use syscall_get_nr()... notes below).

> even though it duplicates some functionality, due to previous feedback
> that maybe it shouldn't mix with seccomp since it is not a security
> mechanism.  And obviously, this should never be considered a security
> mechanism, since any part of the program can by-pass it by using the
> syscall dispatcher.

Yeah, I'd really *like* this to be part of seccomp because it feels so
very close in several aspects, but ultimately I think it's right to be
separate.

> +config HAVE_ARCH_FAST_SYSCALL_DISABLE
> +	bool
> +	help
> +	  An arch should select this symbol if it provides all of these things:
> +	  - TIF_FAST_SYSCALL_DISABLE
> +	  - syscall_get_arch
> +	  - syscall_rollback

I'm going to propose including syscall_get_nr() in this list for
a note below...

> +	  - SIGSYS siginfo_t support
> +
> +config FAST_SYSCALL_DISABLE
> +	bool "Support rejecting syscalls not coming from a dispatcher"
> +	depends on HAVE_ARCH_FAST_SYSCALL_DISABLE
> +	help
> +	  Enable tasks to ask the kernel to reject syscalls not
> +	  issued from a predefined dispatcher depending on a userspace
> +	  key.
> +
> +	  This option is useful to optimize games running over Wine.
> +
>  config HAVE_ARCH_STACKLEAK
>  	bool
>  	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 883da0abf779..36f711570d19 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -149,6 +149,7 @@ config X86
>  	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
>  	select HAVE_ARCH_PREL32_RELOCATIONS
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_FAST_SYSCALL_DISABLE
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index bd3f14175193..26b3afbeea37 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -138,6 +138,13 @@ static long syscall_trace_enter(struct pt_regs *regs)
>  			return -1L;
>  	}
>  
> +#ifdef CONFIG_FAST_SYSCALL_DISABLE

This implementation is so small I have to wonder if this even needs a
CONFIG for it generally. Here, though, you can leave it off too and just
use no-op static inline functions for do_fast_syscall_disable().
(Since you're adding the TIF unconditionally.)

> +	if (work & _TIF_FAST_SYSCALL_DISABLE) {
> +		if (do_fast_syscall_disable(regs->orig_ax, regs))

Instead of even needing to learn about regs->orig_ax, you can just use
syscall_get_nr() here so when other architectures look at this
implementation, they can just literally copy/paste the same lines. :)

While I was looking at this, I'm actually wonder if this can be made
entirely architecture agnostic by stuffing it into
tracehook_report_syscall_entry() instead. That'd require some
refactoring, but seeing how _TIF_FAST_SYSCALL_DISABLE is the last
available bit on x86, I'm wondering about raising all of the common
trace-related stuff up into arch-agnostic areas. seccomp could move too,
I bet. But anyway, I don't think you need to worry about that for this
patch. Stick to the arch-specific bits for now. I just mostly wanted to
dump my thoughts on this so I can find it later. :)

> +			return -1L;
> +	}
> +#endif
> +
>  #ifdef CONFIG_SECCOMP
>  	/*
>  	 * Do seccomp after ptrace, to catch any tracer changes.
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 8de8ceccb8bc..be72d14fc570 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -93,6 +93,7 @@ struct thread_info {
>  #define TIF_NOTSC		16	/* TSC is not accessible in userland */
>  #define TIF_IA32		17	/* IA32 compatibility process */
>  #define TIF_SLD			18	/* Restore split lock detection on context switch */
> +#define TIF_FAST_SYSCALL_DISABLE 19	/* fast syscall disable active */
>  #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
>  #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
>  #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
> @@ -123,6 +124,7 @@ struct thread_info {
>  #define _TIF_NOTSC		(1 << TIF_NOTSC)
>  #define _TIF_IA32		(1 << TIF_IA32)
>  #define _TIF_SLD		(1 << TIF_SLD)
> +#define _TIF_FAST_SYSCALL_DISABLE (1 << TIF_FAST_SYSCALL_DISABLE)
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>  #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
>  #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
> @@ -136,7 +138,7 @@ struct thread_info {
>  /* Work to do before invoking the actual syscall. */
>  #define _TIF_WORK_SYSCALL_ENTRY	\
>  	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
> -	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
> +	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | _TIF_FAST_SYSCALL_DISABLE)
>  
>  /* flags to check in __switch_to() */
>  #define _TIF_WORK_CTXSW_BASE					\
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a70327..3c40b00aa19f 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1502,6 +1502,10 @@ void setup_new_exec(struct linux_binprm * bprm)
>  
>  	arch_setup_new_exec();
>  
> +#ifdef CONFIG_FAST_SYSCALL_DISABLE
> +	clear_tsk_thread_flag(me, TIF_FAST_SYSCALL_DISABLE);
> +#endif

I would just leave the #ifdef off -- the TIF exists unconditionally
anyway.

> +
>  	/* Set the new mm task size. We have to do that late because it may
>  	 * depend on TIF_32BIT which is only updated in flush_thread() on
>  	 * some architectures like powerpc
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 692e327d7455..f502b7fc2bfd 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -32,6 +32,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/rseq.h>
>  #include <linux/kcsan.h>
> +#include <linux/syscall_disable.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
> @@ -953,6 +954,10 @@ struct task_struct {
>  #endif
>  	struct seccomp			seccomp;
>  
> +#ifdef CONFIG_FAST_SYSCALL_DISABLE
> +	struct fast_syscall_disable	syscall_disable;
> +#endif

You can actually drop this too and instead hide an empty struct via the
header (see how seccomp does this for example).

> +
>  	/* Thread group tracking: */
>  	u64				parent_exec_id;
>  	u64				self_exec_id;
> diff --git a/include/linux/syscall_disable.h b/include/linux/syscall_disable.h
> new file mode 100644
> index 000000000000..96e52f50eee5
> --- /dev/null
> +++ b/include/linux/syscall_disable.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SYSCALL_DISABLE_H
> +#define _SYSCALL_DISABLE_H
> +
> +#ifdef CONFIG_FAST_SYSCALL_DISABLE
> +struct fast_syscall_disable {
> +	int __user *fastlock;
> +	unsigned long __user dispatcher;
> +};
> +
> +int do_fast_syscall_disable(int nr_syscall, struct pt_regs *regs);
> +int set_syscall_disable(int mode, unsigned long __user dispatcher,
> +			int __user *fastlock);
> +
> +#else

i.e. add:
struct fast_syscall_disable { };

> +static inline int set_syscall_disable(int mode, unsigned long __user dispatcher,
> +				      int __user *fastlock)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int do_fast_syscall_disable(int nr_syscall, struct pt_regs *regs)
> +{
> +	WARN_ON(1);

I would make this a WARN_ON_ONCE().

> +	return 0;
> +}
> +#endif /* CONFIG_FAST_SYSCALL_DISABLE */
> +
> +#endif
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index cb3d6c267181..09d4ef45a341 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -285,6 +285,7 @@ typedef struct siginfo {
>   */
>  #define SYS_SECCOMP	1	/* seccomp triggered */
>  #define NSIGSYS		1
> +#define SYS_DISABLED	2
>  
>  /*
>   * SIGEMT si_codes
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 07b4f8131e36..383773269ade 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -238,4 +238,8 @@ struct prctl_mm_map {
>  #define PR_SET_IO_FLUSHER		57
>  #define PR_GET_IO_FLUSHER		58
>  
> +#define PR_SET_SYSCALL_DISABLE		59
> +# define PR_SYSCALL_ALLOW		0
> +# define PR_SYSCALL_BLOCK		1
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index f3218bc5ec69..e0449ed68fd5 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
>  obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
>  obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
>  obj-$(CONFIG_SECCOMP) += seccomp.o
> +obj-$(CONFIG_FAST_SYSCALL_DISABLE) += syscall_disable.o
>  obj-$(CONFIG_RELAY) += relay.o
>  obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
>  obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..529f0b5e02d3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -922,6 +922,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	clear_tsk_need_resched(tsk);
>  	set_task_stack_end_magic(tsk);
>  
> +#ifdef CONFIG_FAST_SYSCALL_DISABLE
> +	clear_tsk_thread_flag(tsk, TIF_FAST_SYSCALL_DISABLE);
> +#endif
> +
>  #ifdef CONFIG_STACKPROTECTOR
>  	tsk->stack_canary = get_random_canary();
>  #endif
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 00a96746e28a..2205df99ba67 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -42,6 +42,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/version.h>
>  #include <linux/ctype.h>
> +#include <linux/syscall_disable.h>
>  
>  #include <linux/compat.h>
>  #include <linux/syscalls.h>
> @@ -2527,6 +2528,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  
>  		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
>  		break;
> +	case PR_SET_SYSCALL_DISABLE:
> +		if (arg5)
> +			return -EINVAL;
> +		error = set_syscall_disable((int) arg2, (unsigned long __user) arg3,
> +					    (int __user *) arg4);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/kernel/syscall_disable.c b/kernel/syscall_disable.c
> new file mode 100644
> index 000000000000..4b0a1f916df3
> --- /dev/null
> +++ b/kernel/syscall_disable.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/sched.h>
> +#include <linux/prctl.h>
> +#include <linux/syscall_disable.h>
> +#include <linux/uaccess.h>
> +#include <linux/signal.h>
> +#include <linux/processor.h>
> +
> +#include <asm/syscall.h>
> +
> +#include <linux/sched/signal.h>
> +#include <linux/sched/task_stack.h>
> +
> +static void trigger_sigsys(int nr_syscall)
> +{
> +	struct kernel_siginfo info;
> +
> +	clear_siginfo(&info);
> +	info.si_signo = SIGSYS;
> +	info.si_code = SYS_DISABLED;
> +	info.si_call_addr = (void __user *)KSTK_EIP(current);
> +	info.si_errno = 0;
> +	info.si_arch = syscall_get_arch(current);
> +	info.si_syscall = nr_syscall;
> +
> +	force_sig_info(&info);
> +}
> +
> +int do_fast_syscall_disable(int nr_syscall, struct pt_regs *regs)
> +{
> +	int state;
> +
> +	if (current->syscall_disable.dispatcher == instruction_pointer(regs))
> +		return 0;
> +
> +	if (current->syscall_disable.fastlock) {
> +		if (__get_user(state, current->syscall_disable.fastlock))
> +			do_exit(SIGSEGV);
> +
> +		if (!state)

Just like the prctl arg5 == 0 checking, I actually think this should use
explicit values. 0 and 1, everything else -> SIGSEGV.

> +			return 0;
> +	}
> +
> +	syscall_rollback(current, regs);
> +	trigger_sigsys(nr_syscall);
> +
> +	return 1;
> +}
> +
> +int set_syscall_disable(int mode, unsigned long __user dispatcher,
> +			int __user *fastlock)
> +{
> +	switch (mode) {
> +	case PR_SYSCALL_ALLOW:
> +		if (dispatcher || fastlock)
> +			return -EINVAL;
> +		break;
> +	case PR_SYSCALL_BLOCK:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (fastlock) {
> +		if (!access_ok(fastlock, sizeof(int)))
> +			return -EFAULT;
> +	}
> +
> +	spin_lock_irq(&current->sighand->siglock);
> +
> +	current->syscall_disable.fastlock = fastlock;
> +	current->syscall_disable.dispatcher = dispatcher;
> +
> +	/* make sure fsb_address is committed before setting the flag. */

"fsb_address"? renamed from earlier version?

> +	smp_mb__before_atomic();
> +
> +	if (mode == PR_SYSCALL_BLOCK)
> +		set_tsk_thread_flag(current, TIF_FAST_SYSCALL_DISABLE);
> +	else
> +		clear_tsk_thread_flag(current, TIF_FAST_SYSCALL_DISABLE);
> +
> +	spin_unlock_irq(&current->sighand->siglock);
> +
> +	return 0;
> +}
> -- 
> 2.27.0
> 

This looks really clean to me. I like it. Time for bikeshed painting!
"fast syscall disable" seems an odd name. I would just call it "syscall
dispatch" or "syscall userspace dispatch". Yes, it's fast, but that
doesn't really say _what_ it is. And "disable" is true, but that's not
the point -- using it for just disabling syscalls isn't the point,
providing a userspace dispatcher, though, is.

So how about "fast syscall disable" -> "syscall user dispatch"
through-out? And it's only 1 extra letter. :)

-- 
Kees Cook
