Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAD32075F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5g4XTN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgERWqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgERWqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:46:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97ABC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:46:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so5491728pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DkLeI5J6HwziSm9GMcMf4LhhyvQaOqMYdfxyn+veco=;
        b=o5g4XTN/f5MIQIrb2IaOifUbtd0LeTzQ7ulv0jEzz8P0utvuFD6mqRr4wMfaS3XXRL
         pMeJozi4/8ExgqfwfFfgB6YTXl+OMSapXjCAbZ4mWiuAWIVCkwoPd898VHuR1cKPV/oH
         KsewbuHeURjWR0hRPmKFZTTTLRz2+QMeLc2U++oNbfUKBBvyN1JwwZ4nltjE8entOIgG
         QlgxdpcRpchdy/c82JscVLIKXqdBUdRpvEDv4Tthyq1IUxM2Ok8dupEvG9DY4jWrz3C3
         7FM4VqQi1YYV1JsbtIjyPwx0DQQzKEM/9I2OFW43amRvC7Fz+lUM4hT6TTZcoJVSUOyK
         Pb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DkLeI5J6HwziSm9GMcMf4LhhyvQaOqMYdfxyn+veco=;
        b=A6UI0yEfGE3WmReqmuPFSiyJbhP+ciLsWawWAwc9roCplIjSzck5wbUNN3iEY1r1yB
         sGznI2i1QMfJ1iMLLcZxo6Kv48EtAQa2+T9kVca2PA7svcjlc89UQhd/319Xptvnvf1I
         3k4W+P7AK862r+S+wUYqyjIsxRuZbK+IxClfcptNMekDAiarnxgPBwJYO0CFsrRew06s
         Z2yntYw5JEupTMpJ96tb5OfJ3LEsi8Rg+NLNY+FaY0Y86JqXsXWZXEIiWANAbYadbuAb
         U3b7eslIdLAzJ+cJ07xKOk5K7mWnFAYm7C+y2/l2tNJDplK39dROJcVil7GCfhc7le1R
         GV3w==
X-Gm-Message-State: AOAM532bIqTwUpHX6aUxg4Xe6jyY5qOpqAQwWQbkuvJ1n/Dgzi687llF
        q6+F5BdBXImWX5Lqfd/fFzUsKU2NYQALApr27VS9VA==
X-Google-Smtp-Source: ABdhPJw2876rajEzL4qtvlRTy+vAegRRY6POXCyOdAajXTknbcGTjFoWvJ/uOoA4ZghsbTaEiL1lGqhp+7HMR+6QMlc=
X-Received: by 2002:a62:1684:: with SMTP id 126mr19193842pfw.169.1589842011019;
 Mon, 18 May 2020 15:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-6-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-6-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 15:46:37 -0700
Message-ID: <CAKwvOdn7yC1GVA+6gtNewBSq2BK09y9iNWhv1dPFF5i4kT1+6A@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86/percpu: Clean up percpu_add_return_op()
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
> ---
>  arch/x86/include/asm/percpu.h | 51 +++++++++++------------------------
>  1 file changed, 16 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 21c5013a681a..ac8c391a190e 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -199,34 +199,15 @@ do {                                                                      \
>  /*
>   * Add return operation
>   */
> -#define percpu_add_return_op(qual, var, val)                           \
> +#define percpu_add_return_op(size, qual, _var, _val)                   \
>  ({                                                                     \
> -       typeof(var) paro_ret__ = val;                                   \
> -       switch (sizeof(var)) {                                          \
> -       case 1:                                                         \
> -               asm qual ("xaddb %0, "__percpu_arg(1)                   \
> -                           : "+q" (paro_ret__), "+m" (var)             \
> -                           : : "memory");                              \
> -               break;                                                  \
> -       case 2:                                                         \
> -               asm qual ("xaddw %0, "__percpu_arg(1)                   \
> -                           : "+r" (paro_ret__), "+m" (var)             \
> -                           : : "memory");                              \
> -               break;                                                  \
> -       case 4:                                                         \
> -               asm qual ("xaddl %0, "__percpu_arg(1)                   \
> -                           : "+r" (paro_ret__), "+m" (var)             \
> -                           : : "memory");                              \
> -               break;                                                  \
> -       case 8:                                                         \
> -               asm qual ("xaddq %0, "__percpu_arg(1)                   \
> -                           : "+re" (paro_ret__), "+m" (var)            \

^ before we use the "+re" constraint for 8B input.

> -                           : : "memory");                              \
> -               break;                                                  \
> -       default: __bad_percpu_size();                                   \

Comment on the series as a whole.  After applying the series, the
final reference to __bad_percpu_size and switch statement in
arch/x86/include/asm/percpu.h in the definition of the
percpu_stable_op() macro.  If you clean that up, too, then the rest of
this file feels more consistent with your series, even if it's not a
blocker for Clang i386 support. Then you can get rid of
__bad_percpu_size, too!


> -       }                                                               \
> -       paro_ret__ += val;                                              \
> -       paro_ret__;                                                     \
> +       __pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);       \
> +       asm qual (__pcpu_op2_##size("xadd", "%[tmp]",                   \
> +                                    __percpu_arg([var]))               \
> +                 : [tmp] __pcpu_reg_##size("+", paro_tmp__),           \

^ after, for `size == 8`, we use "+r". [0] says for "e":

32-bit signed integer constant, or a symbolic reference known to fit
that range (for immediate operands in sign-extending x86-64
instructions).

I'm guessing we're restricting the input to not allow for 64b signed
integer constants?  Looking at the documentation for `xadd` (ie.
"exchange and add") [1], it looks like immediates are not allowed as
operands, only registers or memory addresses.  So it seems that "e"
was never necessary.  It might be helpful to note that in the commit
message, should you end up sending a v2 of the series.  Maybe some
folks with more x86 inline asm experience can triple check/verify?

Assuming we're good to go, LGTM.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

[0] https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
[1] https://www.felixcloutier.com/x86/xadd


> +                   [var] "+m" (_var)                                   \
> +                 : : "memory");                                        \
> +       (typeof(_var))(unsigned long) (paro_tmp__ + _val);              \
>  })
>
>  /*
> @@ -377,16 +358,16 @@ do {                                                                      \
>  #define this_cpu_xchg_2(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
>  #define this_cpu_xchg_4(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
>
> -#define raw_cpu_add_return_1(pcp, val)         percpu_add_return_op(, pcp, val)
> -#define raw_cpu_add_return_2(pcp, val)         percpu_add_return_op(, pcp, val)
> -#define raw_cpu_add_return_4(pcp, val)         percpu_add_return_op(, pcp, val)
> +#define raw_cpu_add_return_1(pcp, val)         percpu_add_return_op(1, , pcp, val)
> +#define raw_cpu_add_return_2(pcp, val)         percpu_add_return_op(2, , pcp, val)
> +#define raw_cpu_add_return_4(pcp, val)         percpu_add_return_op(4, , pcp, val)
>  #define raw_cpu_cmpxchg_1(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, oval, nval)
>  #define raw_cpu_cmpxchg_2(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, oval, nval)
>  #define raw_cpu_cmpxchg_4(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, oval, nval)
>
> -#define this_cpu_add_return_1(pcp, val)                percpu_add_return_op(volatile, pcp, val)
> -#define this_cpu_add_return_2(pcp, val)                percpu_add_return_op(volatile, pcp, val)
> -#define this_cpu_add_return_4(pcp, val)                percpu_add_return_op(volatile, pcp, val)
> +#define this_cpu_add_return_1(pcp, val)                percpu_add_return_op(1, volatile, pcp, val)
> +#define this_cpu_add_return_2(pcp, val)                percpu_add_return_op(2, volatile, pcp, val)
> +#define this_cpu_add_return_4(pcp, val)                percpu_add_return_op(4, volatile, pcp, val)
>  #define this_cpu_cmpxchg_1(pcp, oval, nval)    percpu_cmpxchg_op(volatile, pcp, oval, nval)
>  #define this_cpu_cmpxchg_2(pcp, oval, nval)    percpu_cmpxchg_op(volatile, pcp, oval, nval)
>  #define this_cpu_cmpxchg_4(pcp, oval, nval)    percpu_cmpxchg_op(volatile, pcp, oval, nval)
> @@ -418,7 +399,7 @@ do {                                                                        \
>  #define raw_cpu_add_8(pcp, val)                        percpu_add_op(8, , (pcp), val)
>  #define raw_cpu_and_8(pcp, val)                        percpu_to_op(8, , "and", (pcp), val)
>  #define raw_cpu_or_8(pcp, val)                 percpu_to_op(8, , "or", (pcp), val)
> -#define raw_cpu_add_return_8(pcp, val)         percpu_add_return_op(, pcp, val)
> +#define raw_cpu_add_return_8(pcp, val)         percpu_add_return_op(8, , pcp, val)
>  #define raw_cpu_xchg_8(pcp, nval)              raw_percpu_xchg_op(pcp, nval)
>  #define raw_cpu_cmpxchg_8(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, oval, nval)
>
> @@ -427,7 +408,7 @@ do {                                                                        \
>  #define this_cpu_add_8(pcp, val)               percpu_add_op(8, volatile, (pcp), val)
>  #define this_cpu_and_8(pcp, val)               percpu_to_op(8, volatile, "and", (pcp), val)
>  #define this_cpu_or_8(pcp, val)                        percpu_to_op(8, volatile, "or", (pcp), val)
> -#define this_cpu_add_return_8(pcp, val)                percpu_add_return_op(volatile, pcp, val)
> +#define this_cpu_add_return_8(pcp, val)                percpu_add_return_op(8, volatile, pcp, val)
>  #define this_cpu_xchg_8(pcp, nval)             percpu_xchg_op(volatile, pcp, nval)
>  #define this_cpu_cmpxchg_8(pcp, oval, nval)    percpu_cmpxchg_op(volatile, pcp, oval, nval)
>
> --
> 2.25.4
>


--
Thanks,
~Nick Desaulniers
