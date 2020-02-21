Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19041C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E708820801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBUHH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:07:26 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34414 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgBUHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:07:26 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8754A20074B;
        Fri, 21 Feb 2020 07:07:24 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 96C1520AA7; Fri, 21 Feb 2020 07:47:43 +0100 (CET)
Date:   Fri, 21 Feb 2020 07:47:43 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/5] x86: Refactor syscall_wrapper.h
Message-ID: <20200221064743.GB3368@light.dominikbrodowski.net>
References: <20200221050934.719152-1-brgerst@gmail.com>
 <20200221050934.719152-2-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221050934.719152-2-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes

If you move the description to the top (the reason for that is
understandable), you can't talk about "this macro" any more --
as "this macro" is "__SYSCALL_DEFINEx()" which is defined far further
below.

> + * struct pt_regs *regs as the only argument of the syscall stub named
> + * __x64_sys_*(). It decodes just the registers it needs and passes them on to
> + * the __se_sys_*() wrapper performing sign extension and then to the
> + * __do_sys_*() function doing the actual job. These wrappers and functions
> + * are inlined (at least in very most cases), meaning that the assembly looks
> + * as follows (slightly re-ordered for better readability):
> + *
> + * <__x64_sys_recv>:		<-- syscall with 4 parameters
> + *	callq	<__fentry__>
> + *
> + *	mov	0x70(%rdi),%rdi	<-- decode regs->di
> + *	mov	0x68(%rdi),%rsi	<-- decode regs->si
> + *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
> + *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
> + *
> + *	xor	%r9d,%r9d	<-- clear %r9
> + *	xor	%r8d,%r8d	<-- clear %r8
> + *
> + *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
> + *				    which takes 6 arguments
> + *
> + *	cltq			<-- extend return value to 64-bit
> + *	retq			<-- return
> + *
> + * This approach avoids leaking random user-provided register content down
> + * the call chain.

... maybe add the rationale for x86-32 here (in patch 3/5)?

> + * If IA32_EMULATION is enabled, this macro generates an additional wrapper
> + * named __ia32_sys_*() which decodes the struct pt_regs *regs according
> + * to the i386 calling convention (bx, cx, dx, si, di, bp).

... and this likely needs an update in patch 3/5 as well

> -#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
> -	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
> -	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
> -	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
> +#define __SYS_STUB0(abi, name)						\
> +	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
> +	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
> +	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
>  	{								\
> -		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
> +		return __do_##name();					\
>  	}

Instead of __se_compat_sys##name, now __do_comapt_sys##name is called. This
should be equivalent for zero-argument syscalls, but maybe make that change
explicit.

In general terms, I am not sure that the new code is more readable (but I
may be biased) as the conversion to the proper calling convention for the
ABI has to be done by the callee and is not done in the caller. Also, there
are now three levels of macros instead of two.


> +#ifdef CONFIG_X86_64
> +#define __X64_SYS_STUBx(x, name, ...)					\
> +	__SYS_STUBx(x64, name, SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))

s/name/sys_name/g please -- this isn't the name of the syscall any more, but
appended by sys (applies to a number of macros)

> - * named __ia32_sys_*()
> + * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
> + * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
> + * hurt, we only need to re-define it here to keep the naming congruent to
> + * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
> + * macros to work correctly.
>   */
> +#define SYSCALL_DEFINE0(name)					\
> +	SYSCALL_METADATA(_##name, 0);				\
> +	static inline long __do_sys_##name(void);		\
> +	__X64_SYS_STUB0(sys_##name)				\
> +	__IA32_SYS_STUB0(sys_##name)				\
> +	static inline long __do_sys_##name(void)
>  
> -#define SYSCALL_DEFINE0(sname)						\
> -	SYSCALL_METADATA(_##sname, 0);					\
> -	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
> -	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
> -	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
> -	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)

OK, this is a bit more complex change -- you don't use SYSCALL_ALIAS any
more, but define two asmlinakge functions which then call __do_sys_##name().
Maybe needs an explanation in the changelog...

> +#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
> +	__SYS_STUBx(ia32, name, SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))

s/name/compat_sys_name/g/ -- please make it a bit more explicit what "name"
we are talking about here,

> +#define __IA32_COMPAT_SYS_STUB0(name)					\
> +	__SYS_STUB0(ia32, name)

and here,

> +#define __IA32_COMPAT_COND_SYSCALL(name)				\
> +	__COND_SYSCALL(ia32, name)

and here,

> +#define __IA32_COMPAT_SYS_NI(name)					\
> +	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers)

... but not here, as here "name" is actually "name".

Thanks,
	Dominik
