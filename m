Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB85C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE35C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo4EcoTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEHSWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:22:36 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE11C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:22:34 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z2so2710926iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuLGBSMOTYn4dAx7WFdAghXNS6+9FS80m4Fr5hGuJ/Y=;
        b=oo4EcoTSJnRzGK1caVtJqQpbOCfEmRASCbjGqaAJzHumOfLSUu7XlJ/LUsCESdEdMe
         PH+6h0hr/UwnzhbInLEUiwDOC0H0LqovghEWw1L1ednOMarEoe2f+Lqz3Fhfwxli3j4f
         wosVZwjt3c93VlHjHJdvMq9Gvc6jPd9M2G2hSZS+JmeQV5M01m3vkFHyWbaLen+6hbDw
         CWEd+wA9cJSOTBIwXJZutPoeuYdry7eoXDOqTyO8h/LHm7EVn80sXVRylYlBotJAcD8O
         0F/dAI6cXDyL4b5QM6+jFd52TEKA9jCja2naDEkQJ9x39n43u+TBiyh2lNK47Tpkoa40
         Cjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuLGBSMOTYn4dAx7WFdAghXNS6+9FS80m4Fr5hGuJ/Y=;
        b=Ax6V57G0jz5oBsccrepWPlVU7L97BXzxvDGpt39wcmCD0EIKdz/e+PRLzzwCAx9ST9
         YFk8MKRvEBHAyQz4L72CcRYYm1vpSGW0lfcOu1add2FSXvo2XzuqM0MbJAa1phnVZejw
         DCxOXWcr4DFqD6M5ZK1qAXoxCoQb5iDolA3jnEHEXzJ/OjD6Ikp9raEt7zWXdBnAri/h
         FCvkMEg6iwHAKGRa0g+ZCmMVUHu1ppcgc8HciqvPZB5VymtORtdmMQKptTSekjACEt+Q
         Ipfv2iv1d/1KQ5cymvzCqhWi48+uTR4BWifVKwtUuij1yNxZE/f/EegsGAVd8PoBO7an
         pD2g==
X-Gm-Message-State: AGi0Puabup2HABN1uUmBtaEgC9RPGAvhfRTE/7GEyEkuo9yqJabbw8Tv
        PT4kVOihyUNhGBGkQv1Jt08bRtiu4BGIRWFv+0U0Cp8=
X-Google-Smtp-Source: APiQypK8wzIwJ63XmNOmJu52cxPLGKCR6XNJDyjImRBbZURtIsJGhTmk64vNaZ1fCg5LD3eeue7SIY7TyekkvMsyrYU=
X-Received: by 2002:a02:c848:: with SMTP id r8mr3811480jao.55.1588962154227;
 Fri, 08 May 2020 11:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <8f53b69e-86cc-7ff9-671e-5e0a67ff75a2@zytor.com> <20200508180549.212957-1-ndesaulniers@google.com>
In-Reply-To: <20200508180549.212957-1-ndesaulniers@google.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 8 May 2020 14:22:23 -0400
Message-ID: <CAMzpN2ix+Ltu2_4ORaeqD0_6VmDUxTRDVbvaJ+Q9D8s-5p7Bhw@mail.gmail.com>
Subject: Re: [PATCH v3] x86: bitops: fix build regression
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 2:06 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
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

arch_change_bit() should also be changed, but otherwise looks good.

--
Brian Gerst
