Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2EAC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCFB21655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWxIXHgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEIMUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbgEIMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:20:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBBFC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 05:20:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f7so2388081pfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXKyYGr9YIbgPDRRYEd+DzsyJNldm5JCechXyPM1bv8=;
        b=MWxIXHgdKGeqrApfOhKtlOvocclEFKSVYXA1UNcD8aodaW/3hJW1TD7InRh6QhY+mP
         /1cepdEY9ft9ipYlIaFl3wh0AZrEVUHs5QiYd5VHNPsYxwnsY0kj0bA3fp3p/wZI79XJ
         cyUPuYkWO7kwWJFhyjg33UB34S5d/9+qKZhYN1pm+mb6dDMi8NINh5X9Nn50uMg4VOVx
         6fGRqwUyt/YPU/gKaqd70ePi3DFgfFl3ydjM0PScR9q/PToNyERHYKbI/8IMF97wpsY1
         rBV6j2ev2o7rJKFr6Z1GxMldoBAnj3tRjH4TrziUeBsvaI/fXIti6ZZXETMxNxCcJuU5
         6OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXKyYGr9YIbgPDRRYEd+DzsyJNldm5JCechXyPM1bv8=;
        b=tsPLN28dDya4/WzYukXevo8rvMUo3n96F+nSU3bUIEHoVLKTlGflKkJXCsTnsMbk6o
         ACPgai3W1rlYKm0j8Fxs9CIolkkM9chT3rMU723GWKRcDOxmWlil2B/h1mbLOIaVoWth
         NfjwmCTnnj/VGANlSKkEZ7XVLQTpluJPByAPAlv4MH1cEh7J6pgm1i72WqaibYIqY7RB
         gzoqsajwm4l/GAe/6S81iobxZ8MPuZMhnkDCcsEIMGBofojXulib/C3u94I2DGLSKU9+
         +Mc85icEnEgnmw/erhGnXKhHHIfjE1mvDGk//xGgCrptuc0ihhjogDJ4RFvf+8ctUItr
         4z/A==
X-Gm-Message-State: AGi0PuYgt8ezBkHn5Pr2QM9honO5P7vKCE98J3kgJ3+h9KOJqGvnYVve
        4+KxF86yL1XgDZN70oCJ7IkMlWtgIcMaKbYK8n2vNOMO
X-Google-Smtp-Source: APiQypJ05gJG8wBJmv5Jg0fxoeAxSJLNongGHpoEvtBFPG4ZR6c3Hh54Fhgojgs63R93Je2oeLiMgW19uKD4e+JUDTI=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr7484973pfb.130.1589026841665;
 Sat, 09 May 2020 05:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200508182835.228107-1-ndesaulniers@google.com> <20200508183230.229464-1-ndesaulniers@google.com>
In-Reply-To: <20200508183230.229464-1-ndesaulniers@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 May 2020 15:20:30 +0300
Message-ID: <CAHp75Vcsi9o2eUbyozhmPEz6Tfd_6ZFk2q-vcdrm9QxcVPQwMA@mail.gmail.com>
Subject: Re: [PATCH v5] x86: bitops: fix build regression
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 9:35 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> This is easily reproducible via CC=clang+CONFIG_STAGING=y+CONFIG_VT6656=m.
>
> It turns out that if your config tickles __builtin_constant_p via
> differences in choices to inline or not, these statements produce
> invalid assembly:
>
> $ cat foo.c
> long a(long b, long c) {
>   asm("orb\t%1, %0" : "+q"(c): "r"(b));
>   return c;
> }
> $ gcc foo.c
> foo.c: Assembler messages:
> foo.c:2: Error: `%rax' not allowed with `orb'
>
> Use the `%b` "x86 Operand Modifier" to instead force register allocation
> to select a lower-8-bit GPR operand.
>
> The "q" constraint only has meaning on -m32 otherwise is treated as
> "r". Not all GPRs have low-8-bit aliases for -m32.
>

Looks very good!
One question though, does it work with minimum supported version of gcc?

> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/961
> Link: https://lore.kernel.org/lkml/20200504193524.GA221287@google.com/
> Link: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
> Fixes: 1651e700664b4 ("x86: Fix bitops.h warning with a moved cast")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V4 -> V5:
> * actually use `%b` in arch_change_bit().
>
> Changes V3 -> V4:
> * drop (u8) cast from arch_change_bit() as well.
>
> Changes V2 -> V3:
> * use `%b` "x86 Operand Modifier" instead of bitwise op then cast.
> * reword commit message.
> * add Brian and HPA suggested by tags
> * drop Nathan & Sedat Tested by/reviewed by tags (new patch is different
>   enough).
> * Take over authorship.
>
> Changes V1 -> V2:
> * change authorship/signed-off-by to Ilie
> * add Nathan's Tested by/reviewed by
> * update commit message slightly with info sent to HPA.
>  arch/x86/include/asm/bitops.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index b392571c1f1d..35460fef39b8 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -52,9 +52,9 @@ static __always_inline void
>  arch_set_bit(long nr, volatile unsigned long *addr)
>  {
>         if (__builtin_constant_p(nr)) {
> -               asm volatile(LOCK_PREFIX "orb %1,%0"
> +               asm volatile(LOCK_PREFIX "orb %b1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
> -                       : "iq" (CONST_MASK(nr) & 0xff)
> +                       : "iq" (CONST_MASK(nr))
>                         : "memory");
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -72,9 +72,9 @@ static __always_inline void
>  arch_clear_bit(long nr, volatile unsigned long *addr)
>  {
>         if (__builtin_constant_p(nr)) {
> -               asm volatile(LOCK_PREFIX "andb %1,%0"
> +               asm volatile(LOCK_PREFIX "andb %b1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
> -                       : "iq" (CONST_MASK(nr) ^ 0xff));
> +                       : "iq" (~CONST_MASK(nr)));
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> @@ -123,9 +123,9 @@ static __always_inline void
>  arch_change_bit(long nr, volatile unsigned long *addr)
>  {
>         if (__builtin_constant_p(nr)) {
> -               asm volatile(LOCK_PREFIX "xorb %1,%0"
> +               asm volatile(LOCK_PREFIX "xorb %b1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
> -                       : "iq" ((u8)CONST_MASK(nr)));
> +                       : "iq" (CONST_MASK(nr)));
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
>                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> --
> 2.26.2.645.ge9eca65c58-goog
>


-- 
With Best Regards,
Andy Shevchenko
