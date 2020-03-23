Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB2C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D62206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLjc3+ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCWVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:11:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46638 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCWVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:11:48 -0400
Received: by mail-io1-f65.google.com with SMTP id a20so8653476ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGBr9jvogiz8JipTpVFMYqU4Y3lYowhsirajT5/Adqc=;
        b=BLjc3+MLuARd3PN7k8BcyIeXzE5Lefh0MP3NZlkpfkJUYmM2NeVdzPeUiWUzsP3UCE
         yVlLasN6WLiG4ihks72HBnhL1YRm2z2q6DRVhzVWbI+orX0uVq1IyFZhn4aZ7w8BQptH
         +OUwUrSjSR6aibNlLnmAl3BYq1Jkaf5p5T+l+Bx+P6m6M66fnn7dBM1Q+9HcDzE1gKwc
         +Y6sZwJb83EUt7mdm/4qyrUFnmqkWlZYzidm+Za8OS94llnNt+Dzdb2RzIfgk7A1ho0L
         jvTdR2nab3Tlq3lQOE8CFQeVXOTpBJeUcMvuU2kOdLAb0Epx0imQ8Px9hzhNQLdpSlwQ
         bVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGBr9jvogiz8JipTpVFMYqU4Y3lYowhsirajT5/Adqc=;
        b=JdJSSMHRAje41bF84CJAwVNy7H0ydb0l6GnR6TsAc1qs+rZUk8an4dvaIzKCKAqW2b
         tRO0P6sYjCw/7tTl11kYBAXMJjdIILHXr1LyMnqFrHmYTq/nZ7sgDR+iwy22TCB8dA9T
         smvZTf6jRofzVOPCxzZq6xniu/T+v3FUIKwOSUS0xlRW+yK5zwbtQkP/RMqB+6GxxihU
         qn94VOEZIIoVHOoTFD4bIDq8qeRebUWfnCqsK91o8J2viR3yhYg5Hkjy3VZQTbwDs9PA
         4dS7YFriqQlQIlpo9Jo9jIkFvgv97eFBjeAf/zJDGBw2Oja1QQUqHikXUecgrA4I/9vp
         Z9Pw==
X-Gm-Message-State: ANhLgQ0RGHfyLGj3YHK2n0C9QUeCIA7HTjyly2yJYqa8G292gwG9jnUo
        sUyxs0RCxMKguOAR1AMh1KvDKs+l5/qFGJYAqg==
X-Google-Smtp-Source: ADFU+vu+L+y2znHKpLng0hBBqI79bT7WzfRRDkFT4E6f8gBcUu0syzIrXfa52mMI+eFqr9iI5gsLU8C+3KfzIf7kLFY=
X-Received: by 2002:a5e:8214:: with SMTP id l20mr20760338iom.168.1584997907029;
 Mon, 23 Mar 2020 14:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200313195144.164260-1-brgerst@gmail.com> <20200313195144.164260-5-brgerst@gmail.com>
 <20200323081114.GA10796@gmail.com>
In-Reply-To: <20200323081114.GA10796@gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 23 Mar 2020 17:11:36 -0400
Message-ID: <CAMzpN2iZi2cAVj8dNXY4forQ4wdv7nNEGW4ufueY8hFXTnwkrw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry: Fix SYS_NI() build failure
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 4:11 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > Pull the common code out from the SYS_NI macros into a new __SYS_NI macro.
> > Also conditionalize the X64 version in preparation for enabling syscall
> > wrappers on 32-bit native kernels.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > Reviewed-by: Andy Lutomirski <luto@kernel.org>
>
> >  #define COMPAT_SYS_NI(name)                                          \
> > -     SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);   \
> > -     SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
> > +     __IA32_COMPAT_SYS_NI(name)                                      \
> > +     __X32_COMPAT_SYS_NI(name)
> >
> >  #endif /* CONFIG_COMPAT */
> >
> > @@ -231,9 +245,9 @@ struct pt_regs;
> >       __X64_COND_SYSCALL(name)                                        \
> >       __IA32_COND_SYSCALL(name)
> >
> > -#ifndef SYS_NI
> > -#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
> > -#endif
> > +#define SYS_NI(name)                                                 \
> > +     __X64_SYS_NI(name)                                              \
> > +     __IA32_SYS_NI(name)
>
> This breaks the x86-64 build on !CONFIG_POSIX_TIMERS (and probably also
> with some x32 build variants), because of a missing ';' between
> __X64_SYS_NI() and __IA32_SYS_NI().
>
> I suspect testing didn't catch this because SYS_NI() is rarely used in
> our x86-64 Kconfig space.
>
> Very lightly tested fix attached.
>
> I didn't see the COND_SYSCALL_COMPAT() build failure, but seems to have a
> similar bug.
>
> Thanks,
>
>         Ingo
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
> ---
>  arch/x86/include/asm/syscall_wrapper.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index e10efa1454bc..8929419b9783 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -214,12 +214,12 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>   * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
>   * kernel/time/posix-stubs.c to cover this case as well.
>   */
> -#define COND_SYSCALL_COMPAT(name)                                      \
> -       __IA32_COMPAT_COND_SYSCALL(name)                                \
> +#define COND_SYSCALL_COMPAT(name)                                      \
> +       __IA32_COMPAT_COND_SYSCALL(name);                               \
>         __X32_COMPAT_COND_SYSCALL(name)
>
>  #define COMPAT_SYS_NI(name)                                            \
> -       __IA32_COMPAT_SYS_NI(name)                                      \
> +       __IA32_COMPAT_SYS_NI(name);                                     \
>         __X32_COMPAT_SYS_NI(name)
>
>  #endif /* CONFIG_COMPAT */
> @@ -257,7 +257,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>         __IA32_COND_SYSCALL(name)
>
>  #define SYS_NI(name)                                                   \
> -       __X64_SYS_NI(name)                       6e4847640c6aebcaa2d9b3686cecc91b41f09269                       \
> +       __X64_SYS_NI(name);                                             \
>         __IA32_SYS_NI(name)
>
>

A simpler fix would be to add the semicolon to the end of the __SYS_NI
macro.  COND_SYSCALL_COMPAT isn't a problem because it expands to a
function instead of an asm statement.

That said, I think __SYS_NI should be changed to mirror
__COND_SYSCALL, so that the function prototypes match (see commit
6e484764)

--
Brian Gerst
