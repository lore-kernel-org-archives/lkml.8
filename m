Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD27FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C5B20735
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3gnOA1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCXBWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:22:20 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34450 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgCXBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:22:20 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so589646pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bF4kWzVYozUGgvzITVBuWBVodBeRJJH7jEiGrv7K80=;
        b=C3gnOA1KGbgctO0Lp0HFjTkts2ZuawK2Gtonne3GnlpAlxES6N2cVc48Eh2mlbPqKw
         0fRsVvuCnkk2nGRDF14yXkHSww9uBJk9UGxzj+6osUWddCnQGDa7o0CSgp+M9q6tyLrg
         GY0dKiSHTnANrrd866y8msYp0HRWQLpRLYGbhWzqg4F6YPRehHYek6HW8r+Lx1lhK7qQ
         Zf7rsyuWoOA+ky5bDrlZyWZFdqynEqI6DSWnB53jSwtpXHjyqBQVrMdldKnksLLYGawh
         1fRKA5BsGVSWGghzY8UFaJhFTbm1XSeiToSCH3br8IqU2lr13mDlptEBwa0EJZkLYWA+
         WZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bF4kWzVYozUGgvzITVBuWBVodBeRJJH7jEiGrv7K80=;
        b=dG/DUQREG8VPTv5WvTHKuavxOiBknF9NMfEA+hD0M4AdF7cd4hunRalrpNLP/X8nLR
         E0s6nZ2ltww+xw2znlyqB05sd5VEX076IZtHofk/iIXEEm7aMC4w/ccf0jDMYoPgvvL8
         FdvOS0BNt6X0Fw92Wjer6G0EhrrzWx03GeeJHyQMadewLF5W4f0gec7s+z+AvPRk4Jfk
         m2gHsN88hUtZ21ty8dxz5qvfYocaIfsJ1bHWBw5ErPhx4XqEePaASxqGEDiXwDqln1Vb
         ba3uhjiP5LA4WNU6iBpd/XJFoC3u4Q2pmRBW/L1KGdiGV9Uw/XW7XZ65jD1jemPqQ+qp
         lIcQ==
X-Gm-Message-State: ANhLgQ0aNsFGQyKae2vCvD+3Mxa8on9F7LJresFMTdccjaOQYeg48AaJ
        IRJWQyON6ejJ246+rWDHtwR2guY5HosRbj/2u0L2yg==
X-Google-Smtp-Source: ADFU+vuf70YD77cB/+c34ky+GnUOhP1DPbKc9usAnuwuJKD6vuqm6MWSNQmjSAZ/yhXJl5KzWiT4bajDRrEw8qHzsWU=
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr17986977plt.223.1585012938823;
 Mon, 23 Mar 2020 18:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Mar 2020 18:22:05 -0700
Message-ID: <CAKwvOd=p5jkqopHr2ka_9PM345d-hzoqT97Gq6z1ZsmJS1ZQvw@mail.gmail.com>
Subject: Re: [PATCH] x86: Alias memset to __builtin_memset.
To:     Clement Courbet <courbet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 4:43 AM 'Clement Courbet' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
>     Recent compilers know the meaning of builtins (`memset`,
>     `memcpy`, ...) and can replace calls by inline code when
>     deemed better. For example, `memset(p, 0, 4)` will be lowered
>     to a four-byte zero store.
>
>     When using -ffreestanding (this is the case e.g. building on
>     clang), these optimizations are disabled. This means that **all**
>     memsets, including those with small, constant sizes, will result
>     in an actual call to memset.

Isn't this only added for 32b x86 (if I'm reading arch/x86/Makefile
right)? Who's adding it for 64b?

arch/x86/Makefile has a comment:
 88         # temporary until string.h is fixed
 89         KBUILD_CFLAGS += -ffreestanding
Did you look into fixing that?

>
>     We have identified several spots where we have high CPU usage
>     because of this. For example, a single one of these memsets is
>     responsible for about 0.3% of our total CPU usage in the kernel.
>
>     Aliasing `memset` to `__builtin_memset` allows the compiler to
>     perform this optimization even when -ffreestanding is used.
>     There is no change when -ffreestanding is not used.
>
>     Below is a diff (clang) for `update_sg_lb_stats()`, which
>     includes the aforementionned hot memset:
>         memset(sgs, 0, sizeof(*sgs));
>
>     Diff:
>         movq %rsi, %rbx        ~~~>  movq $0x0, 0x40(%r8)
>         movq %rdi, %r15        ~~~>  movq $0x0, 0x38(%r8)
>         movl $0x48, %edx       ~~~>  movq $0x0, 0x30(%r8)
>         movq %r8, %rdi         ~~~>  movq $0x0, 0x28(%r8)
>         xorl %esi, %esi        ~~~>  movq $0x0, 0x20(%r8)
>         callq <memset>         ~~~>  movq $0x0, 0x18(%r8)
>                                ~~~>  movq $0x0, 0x10(%r8)
>                                ~~~>  movq $0x0, 0x8(%r8)
>                                ~~~>  movq $0x0, (%r8)
>
>     In terms of code size, this grows the clang-built kernel a
>     bit (+0.022%):
>     440285512 vmlinux.clang.after
>     440383608 vmlinux.clang.before

The before number looks bigger? Did it shrink in size, or was the
above mislabeled?

>
> Signed-off-by: Clement Courbet <courbet@google.com>
> ---
>  arch/x86/include/asm/string_64.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 75314c3dbe47..7073c25aa4a3 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -18,6 +18,15 @@ extern void *__memcpy(void *to, const void *from, size_t len);
>  void *memset(void *s, int c, size_t n);
>  void *__memset(void *s, int c, size_t n);
>
> +/* Recent compilers can generate much better code for known size and/or
> + * fill values, and will fallback on `memset` if they fail.
> + * We alias `memset` to `__builtin_memset` explicitly to inform the compiler to
> + * perform this optimization even when -ffreestanding is used.
> + */
> +#if (__GNUC__ >= 4)
> +#define memset(s, c, count) __builtin_memset(s, c, count)
> +#endif
> +
>  #define __HAVE_ARCH_MEMSET16
>  static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
>  {
> @@ -74,6 +83,7 @@ int strcmp(const char *cs, const char *ct);
>  #undef memcpy
>  #define memcpy(dst, src, len) __memcpy(dst, src, len)
>  #define memmove(dst, src, len) __memmove(dst, src, len)
> +#undef memset
>  #define memset(s, c, n) __memset(s, c, n)
>
>  #ifndef __NO_FORTIFY
> --

-- 
Thanks,
~Nick Desaulniers
