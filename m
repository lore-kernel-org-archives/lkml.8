Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC58CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FCC2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4A8WiHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEHSI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:08:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0125C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:08:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so1361447pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJNLqaW1D1Ksqfi1Sayg+EttVMlVbom/Q1FHT26F8tA=;
        b=V4A8WiHx1E1i/LBjiNpolLKJ52Q2hroM81XQDlZdFRHTiwiYQrDBxpCVnnNNM3+DCx
         EsdenIzIIFoiYs6wGbL20uCQzBnNKy4FDU5YRK2ySEK/5bRcAM9rSsrZDFqD2b9whIWD
         nuL45rCmvbfeFQcr3dObr9c0xtA1S+V13iTjvmekpFdCQ/R7l7lpGmjU0FU1ImdZb4Lx
         znEbn+VOjSwe0HzZQc5KLVjEazrBR046dwuramCZ+BK2n+FhkrzwyKDmfyyS7/mAXWsI
         GavJgB8Au+xf2RVQURHOqSuBnPZTHOzwQffRy2XhNIWCwpAS1QaQzpCsBOrLxmdcSMWQ
         FJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJNLqaW1D1Ksqfi1Sayg+EttVMlVbom/Q1FHT26F8tA=;
        b=jX5EGj/b8DBod885nKLyvDqP54Daq85a34l+McX0wyaGHqj4U1FVieCCiJh6cTl1IY
         SyVIBkgt0B8VwOQpsuz1QPSng0LL1tSe2CjHghiDvEYpKZIGGhIpkBQ8dhu7ePhD7vzf
         54aYQIbkc9/0dBCn+umsVFXS0Q5av+N/kaXGRnfIT6SLARwMRXIGQswKP+/K5+E4h/GV
         b7CnZWg6l9+uzCa1ctVYkekPBZLLlfqtBxDVCgdjfBzShniX26qNZL0y+QP2VSgg57od
         tkEEoc3xrxQzfmX1pJZc4lLK+X/6ZngDhAWERPRjqLXL4whyRtn2a81c8miVMfaHhUVH
         izuA==
X-Gm-Message-State: AGi0PubgzFmPlKAzqejNx7GIrtaPTbqf8/gsAhz4XugdwjUf1T41386Y
        l8p5MUWOdKzZGu/eDKnVE3/jSfP1WGSyc1B13Rn7HA==
X-Google-Smtp-Source: APiQypK3E4wIJoGyXv6656zULXn+BQ6HaPfdytH1QxCbjk2r4KZT4hWaRNopGCGpKJznGm9R2OdbktOIIqSiFBkKbhY=
X-Received: by 2002:a63:6546:: with SMTP id z67mr3087884pgb.10.1588961337845;
 Fri, 08 May 2020 11:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <8f53b69e-86cc-7ff9-671e-5e0a67ff75a2@zytor.com> <20200508180549.212957-1-ndesaulniers@google.com>
In-Reply-To: <20200508180549.212957-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 May 2020 11:08:46 -0700
Message-ID: <CAKwvOdm=AskJo4h=_P9oSXr_eV7DXu+q_sbYhU7pNQByRwHLBw@mail.gmail.com>
Subject: Re: [PATCH v3] x86: bitops: fix build regression
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 11:06 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
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
> Changes V2 -> V3:
> * use `%b` "x86 Operand Modifier" instead of bitwise op then cast.
> * reword commit message.
> * add Brian and HPA suggested by tags
> * drop Nathan & Sedat Tested by/reviewed by tags (new patch is different
>   enough).

Oh, and I took over authorship for this version.

>
> Changes V1 -> V2:
> * change authorship/signed-off-by to Ilie
> * add Nathan's Tested by/reviewed by
> * update commit message slightly with info sent to HPA.
>
>  arch/x86/include/asm/bitops.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index b392571c1f1d..03e24286e4eb 100644
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
> --
> 2.26.2.645.ge9eca65c58-goog
>


-- 
Thanks,
~Nick Desaulniers
