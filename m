Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA0EC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A476420679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1dJJ6ET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBUOGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:06:10 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37699 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgBUOGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:06:10 -0500
Received: by mail-il1-f193.google.com with SMTP id v13so1720192iln.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtxjIHnjfyNohg9GKayi5UAaEkOMFp3VIwmEXMjUTGw=;
        b=I1dJJ6ETpGPaN44FW2lBmPdq+rliKaXKF1QLSkdVOS4ITLSZdxiJDakbvtsOYwav56
         Q6nXsIckhpakUSC85p0i/z7vr8+f5+gz5C/MQWQrzZXlFWpVq0SFPAWDiMJQexMoWHEq
         x7hzgg39BRRvYiO95WcidRJ/daoTxN9+Ug3HNUsgwZcICrqynsGcRgA/JYuRSrpxqeA9
         pNwU3xt2rbubuu9XqKtvSinYJr8KO3WsR1sAPpFL87SDECys4mMPvSeovLj72HIWY030
         lqrmwyTZw7oQcbvn8yevgzFqLkrTCvGRiRj1uOCwbOyEtz40Oyshd4yy4SCcVvAuR+bU
         /95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtxjIHnjfyNohg9GKayi5UAaEkOMFp3VIwmEXMjUTGw=;
        b=P/E6YhdjNebisVgr8yus3xmBXGo4CjsUNr5ChflVKcLru2wWF1ZTZqijKZu//7cWrP
         DKLQDE+q48fU0CQcQdYbkvDG0ICJX/KiSlYsRJbBUfX/umecnZ0+qWQuUNBba9AVyAG2
         Q984yXkQFYjIXVsA7+EuIzKVan7lkJX5wVMJLbNfWJVIzb74m8S0AlG3f4usO/X/uxDv
         jCyYG9fuoGAB1/+MDW/Mn2c0re3OO5qYpOWFR8f8GVJPgUjCqy5hBrxhmbwrSECoulbx
         hUhZbLUiY2ZQzYIC6cLFekFRiQYvoMlgx/6YJ9bGv7+TuvEI4MCIVoeIWJgfml7tFF64
         6Iwg==
X-Gm-Message-State: APjAAAX/XJIsySx+kc8xBmasf0H5JWgAlU+9LhMiQusonkcduQHdStRJ
        swdJjx9eKwZC1GgRzrcXncWpmNmQvAewQs7IIQ==
X-Google-Smtp-Source: APXvYqxPhDDaIZX2T7FEigKj56VIPaGg65F2OHsz++SNJ2LK2XyYyzR3FRnzKMcJyxFWVGi1yiwE4aboIpSyNUqt4mw=
X-Received: by 2002:a05:6e02:80c:: with SMTP id u12mr37076664ilm.273.1582293968698;
 Fri, 21 Feb 2020 06:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20200221050934.719152-1-brgerst@gmail.com> <20200221050934.719152-2-brgerst@gmail.com>
 <20200221064743.GB3368@light.dominikbrodowski.net>
In-Reply-To: <20200221064743.GB3368@light.dominikbrodowski.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 21 Feb 2020 09:05:57 -0500
Message-ID: <CAMzpN2hC8LVk_o-__nrpqs8ZK2qGwa4frBrPUmFPhNUmKMR+eA@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86: Refactor syscall_wrapper.h
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:07 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> > + * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
>
> If you move the description to the top (the reason for that is
> understandable), you can't talk about "this macro" any more --
> as "this macro" is "__SYSCALL_DEFINEx()" which is defined far further
> below.
>
> > + * struct pt_regs *regs as the only argument of the syscall stub named
> > + * __x64_sys_*(). It decodes just the registers it needs and passes them on to
> > + * the __se_sys_*() wrapper performing sign extension and then to the
> > + * __do_sys_*() function doing the actual job. These wrappers and functions
> > + * are inlined (at least in very most cases), meaning that the assembly looks
> > + * as follows (slightly re-ordered for better readability):
> > + *
> > + * <__x64_sys_recv>:         <-- syscall with 4 parameters
> > + *   callq   <__fentry__>
> > + *
> > + *   mov     0x70(%rdi),%rdi <-- decode regs->di
> > + *   mov     0x68(%rdi),%rsi <-- decode regs->si
> > + *   mov     0x60(%rdi),%rdx <-- decode regs->dx
> > + *   mov     0x38(%rdi),%rcx <-- decode regs->r10
> > + *
> > + *   xor     %r9d,%r9d       <-- clear %r9
> > + *   xor     %r8d,%r8d       <-- clear %r8
> > + *
> > + *   callq   __sys_recvfrom  <-- do the actual work in __sys_recvfrom()
> > + *                               which takes 6 arguments
> > + *
> > + *   cltq                    <-- extend return value to 64-bit
> > + *   retq                    <-- return
> > + *
> > + * This approach avoids leaking random user-provided register content down
> > + * the call chain.
>
> ... maybe add the rationale for x86-32 here (in patch 3/5)?
>
> > + * If IA32_EMULATION is enabled, this macro generates an additional wrapper
> > + * named __ia32_sys_*() which decodes the struct pt_regs *regs according
> > + * to the i386 calling convention (bx, cx, dx, si, di, bp).
>
> ... and this likely needs an update in patch 3/5 as well

I will update that comment section.  The code for 32-bit will follow
the same pattern, just with different register names.

> > -#define __IA32_COMPAT_SYS_STUBx(x, name, ...)                                \
> > -     asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
> > -     ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);          \
> > -     asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
> > +#define __SYS_STUB0(abi, name)                                               \
> > +     asmlinkage long __##abi##_##name(const struct pt_regs *regs);   \
> > +     ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
> > +     asmlinkage long __##abi##_##name(const struct pt_regs *regs)    \
> >       {                                                               \
> > -             return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
> > +             return __do_##name();                                   \
> >       }
>
> Instead of __se_compat_sys##name, now __do_comapt_sys##name is called. This
> should be equivalent for zero-argument syscalls, but maybe make that change
> explicit.

The __se_* layer (sign-extension) is unnecessary when there are no
arguments to extend.  But I can make that a separate patch if that
makes it clearer.

> In general terms, I am not sure that the new code is more readable (but I
> may be biased) as the conversion to the proper calling convention for the
> ABI has to be done by the callee and is not done in the caller. Also, there
> are now three levels of macros instead of two.

I added the __STUBx layer to avoid 4 copies of the same boilerplate
code.  The middle layer is needed because you can't have #ifdefs
inside a macro.

>
>
> > +#ifdef CONFIG_X86_64
> > +#define __X64_SYS_STUBx(x, name, ...)                                        \
> > +     __SYS_STUBx(x64, name, SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
>
> s/name/sys_name/g please -- this isn't the name of the syscall any more, but
> appended by sys (applies to a number of macros)
>
> > - * named __ia32_sys_*()
> > + * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
> > + * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
> > + * hurt, we only need to re-define it here to keep the naming congruent to
> > + * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
> > + * macros to work correctly.
> >   */
> > +#define SYSCALL_DEFINE0(name)                                        \
> > +     SYSCALL_METADATA(_##name, 0);                           \
> > +     static inline long __do_sys_##name(void);               \
> > +     __X64_SYS_STUB0(sys_##name)                             \
> > +     __IA32_SYS_STUB0(sys_##name)                            \
> > +     static inline long __do_sys_##name(void)
> >
> > -#define SYSCALL_DEFINE0(sname)                                               \
> > -     SYSCALL_METADATA(_##sname, 0);                                  \
> > -     asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
> > -     ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);                \
> > -     SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);           \
> > -     asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
>
> OK, this is a bit more complex change -- you don't use SYSCALL_ALIAS any
> more, but define two asmlinakge functions which then call __do_sys_##name().
> Maybe needs an explanation in the changelog...

IIRC this was because in the 32-bit native case the __x64_* variant
wasn't present to alias to.  I'll see if I can come up with a
different solution.

> > +#define __IA32_COMPAT_SYS_STUBx(x, name, ...)                                \
> > +     __SYS_STUBx(ia32, name, SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
>
> s/name/compat_sys_name/g/ -- please make it a bit more explicit what "name"
> we are talking about here,
>
> > +#define __IA32_COMPAT_SYS_STUB0(name)                                        \
> > +     __SYS_STUB0(ia32, name)
>
> and here,
>
> > +#define __IA32_COMPAT_COND_SYSCALL(name)                             \
> > +     __COND_SYSCALL(ia32, name)
>
> and here,
>
> > +#define __IA32_COMPAT_SYS_NI(name)                                   \
> > +     SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers)
>
> ... but not here, as here "name" is actually "name".
>
> Thanks,
>         Dominik

--
Brian Gerst
