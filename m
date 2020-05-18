Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE7120657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObfRZ9Sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgERWQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgERWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:16:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786BDC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:16:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so456389pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkP+UGX470bkhN1JPkQIj9DQ3/sS/6tlpvt6hXlXh0s=;
        b=ObfRZ9Sc3E5TFE30lxNGV1WqAKe/y97qTa4d1IlG5NVXN4NJ7Xe+dYdQn9CpONN1pd
         T33SoElRWHnpXKWSNJXYSoSdu/Iww4MRm/p2CyR6+fRuggGBBNRPy5hPw+Z1IRK6etTc
         ZhjWdAcnZmo+VHcnl06ssK7iJRqrcko72W2jC374kmjWmKO0x9+m7ic+W5eRn/6nQ5ic
         Sf/UYsk/+uBYR0vVSik6ysIRWGKvqipyL2A9kk5N7bXh0SJ+cXZSS0OxBvI5MucoMu9n
         FLiQ9KyAm+zLLL668zsn7hJlTIIAooYINaL1mrMpIrbgT2ElAqSB0351DdYHmNMf3zMH
         E1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkP+UGX470bkhN1JPkQIj9DQ3/sS/6tlpvt6hXlXh0s=;
        b=DxLfjZ4mnPACufw4GdhrvjUFh9omiPdZG/D3CEoJS949eSSJmLGhN57Jb8EW4FDbb/
         TNcghBBTeXH3HQWHmvJtwHkK/B18Db7j8zmddpUG9gr2bdyNVQ5WIRKsJcvh1izBcVlL
         WiA2Rn/SVpL4W7SRFyE08fdJKwoMYb1FD8KbsmntF5kv6BzD8A5/EHpPIKeyn6NL83BW
         c6hyBo+TUlLIOKD84ZK4IHpOMTnOwOlvqekDT7OennTTimty4JaNWsJc4kLpGgrF+6W+
         5sv1IFDs3Ox+mtqYZ1M0OlRtJv7Fh7vk44x1gZ2azX4gAUNCRXfrNPm2EXvL5JrLE3rE
         3Hvg==
X-Gm-Message-State: AOAM530Rj+tXUuVDfDw45qwvLetGHLhdAPB17yUYMk7qe6JIy8NKdXUe
        CFDondyNAbtXqpzAHv92TKL4pvZ7GmUEjq2aRkLN8w==
X-Google-Smtp-Source: ABdhPJwpW88btFxIv/NAYFU+jvFXs36nOMnj2fvP/0c6vy0VwR0DfaecvhsQgWennHvYJpouy3wLZqpslE/fJZnOmRU=
X-Received: by 2002:a17:90b:19cc:: with SMTP id nm12mr1526627pjb.25.1589840172658;
 Mon, 18 May 2020 15:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-7-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-7-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 15:15:58 -0700
Message-ID: <CAKwvOdkEiUuNqnAqdLFx3PEm8DHhs7N6Bkk7m0b4mbEMGKPwHA@mail.gmail.com>
Subject: Re: [PATCH 6/7] x86/percpu: Clean up percpu_xchg_op()
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> The core percpu macros already have a switch on the data size, so the switch
> in the x86 code is redundant and produces more dead code.
>
> Also use appropriate types for the width of the instructions.  This avoids
> errors when compiling with Clang.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/percpu.h | 61 +++++++++++------------------------
>  1 file changed, 18 insertions(+), 43 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index ac8c391a190e..3c95ab3c99cd 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -215,46 +215,21 @@ do {                                                                      \
>   * expensive due to the implied lock prefix.  The processor cannot prefetch
>   * cachelines if xchg is used.
>   */
> -#define percpu_xchg_op(qual, var, nval)                                        \
> +#define percpu_xchg_op(size, qual, _var, _nval)                                \
>  ({                                                                     \
> -       typeof(var) pxo_ret__;                                          \
> -       typeof(var) pxo_new__ = (nval);                                 \
> -       switch (sizeof(var)) {                                          \
> -       case 1:                                                         \
> -               asm qual ("\n\tmov "__percpu_arg(1)",%%al"              \
> -                   "\n1:\tcmpxchgb %2, "__percpu_arg(1)                \
> -                   "\n\tjnz 1b"                                        \
> -                           : "=&a" (pxo_ret__), "+m" (var)             \
> -                           : "q" (pxo_new__)                           \
> -                           : "memory");                                \
> -               break;                                                  \
> -       case 2:                                                         \
> -               asm qual ("\n\tmov "__percpu_arg(1)",%%ax"              \
> -                   "\n1:\tcmpxchgw %2, "__percpu_arg(1)                \
> -                   "\n\tjnz 1b"                                        \
> -                           : "=&a" (pxo_ret__), "+m" (var)             \
> -                           : "r" (pxo_new__)                           \
> -                           : "memory");                                \
> -               break;                                                  \
> -       case 4:                                                         \
> -               asm qual ("\n\tmov "__percpu_arg(1)",%%eax"             \
> -                   "\n1:\tcmpxchgl %2, "__percpu_arg(1)                \
> -                   "\n\tjnz 1b"                                        \
> -                           : "=&a" (pxo_ret__), "+m" (var)             \
> -                           : "r" (pxo_new__)                           \
> -                           : "memory");                                \
> -               break;                                                  \
> -       case 8:                                                         \
> -               asm qual ("\n\tmov "__percpu_arg(1)",%%rax"             \
> -                   "\n1:\tcmpxchgq %2, "__percpu_arg(1)                \
> -                   "\n\tjnz 1b"                                        \
> -                           : "=&a" (pxo_ret__), "+m" (var)             \
> -                           : "r" (pxo_new__)                           \
> -                           : "memory");                                \
> -               break;                                                  \
> -       default: __bad_percpu_size();                                   \
> -       }                                                               \
> -       pxo_ret__;                                                      \
> +       __pcpu_type_##size pxo_old__;                                   \
> +       __pcpu_type_##size pxo_new__ = __pcpu_cast_##size(_nval);       \
> +       asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]),         \
> +                                   "%[oval]")                          \
> +                 "\n1:\t"                                              \
> +                 __pcpu_op2_##size("cmpxchg", "%[nval]",               \
> +                                   __percpu_arg([var]))                \
> +                 "\n\tjnz 1b"                                          \
> +                 : [oval] "=&a" (pxo_old__),                           \
> +                   [var] "+m" (_var)                                   \
> +                 : [nval] __pcpu_reg_##size(, pxo_new__)               \
> +                 : "memory");                                          \
> +       (typeof(_var))(unsigned long) pxo_old__;                        \
>  })
>
>  /*
> @@ -354,9 +329,9 @@ do {                                                                        \
>  #define this_cpu_or_1(pcp, val)                percpu_to_op(1, volatile, "or", (pcp), val)
>  #define this_cpu_or_2(pcp, val)                percpu_to_op(2, volatile, "or", (pcp), val)
>  #define this_cpu_or_4(pcp, val)                percpu_to_op(4, volatile, "or", (pcp), val)
> -#define this_cpu_xchg_1(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
> -#define this_cpu_xchg_2(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
> -#define this_cpu_xchg_4(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
> +#define this_cpu_xchg_1(pcp, nval)     percpu_xchg_op(1, volatile, pcp, nval)
> +#define this_cpu_xchg_2(pcp, nval)     percpu_xchg_op(2, volatile, pcp, nval)
> +#define this_cpu_xchg_4(pcp, nval)     percpu_xchg_op(4, volatile, pcp, nval)
>
>  #define raw_cpu_add_return_1(pcp, val)         percpu_add_return_op(1, , pcp, val)
>  #define raw_cpu_add_return_2(pcp, val)         percpu_add_return_op(2, , pcp, val)
> @@ -409,7 +384,7 @@ do {                                                                        \
>  #define this_cpu_and_8(pcp, val)               percpu_to_op(8, volatile, "and", (pcp), val)
>  #define this_cpu_or_8(pcp, val)                        percpu_to_op(8, volatile, "or", (pcp), val)
>  #define this_cpu_add_return_8(pcp, val)                percpu_add_return_op(8, volatile, pcp, val)
> -#define this_cpu_xchg_8(pcp, nval)             percpu_xchg_op(volatile, pcp, nval)
> +#define this_cpu_xchg_8(pcp, nval)             percpu_xchg_op(8, volatile, pcp, nval)
>  #define this_cpu_cmpxchg_8(pcp, oval, nval)    percpu_cmpxchg_op(volatile, pcp, oval, nval)
>
>  /*
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
