Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F05420776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bF2QN7Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgFATri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgFATri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:47:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FF9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:47:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nm22so268787pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyvA62biKTQGNyyqx4DnGpsV+JYlCmkfnivzJZ0J7rU=;
        b=bF2QN7Z3Im/VQTjcR3/xlJQHRUN0MP+Yx+hwfS/ip45iFEUwHQfFFZR1V/lYCQr6ef
         4DaTEh7g3277Q5SOHYmtLT9E6TKShfmt+nhNVcN++LbNmnuqZFcpfPbbqcehv0VAMEgR
         8O+d2L/mkPDCiGDSqkYs1SWvSIk40mFNC1HsdKKKOoC3E4xWKshB341mfFeX3Eyk8fhe
         +dq1WcRJ6CwDoQ06pOkv4WNhjrIGAjyKb3gxd5Bx8JzYAr6VNBK4yucqRHopI7gEpAiS
         uBkbvSo6pR1aN5w8ptcn3NdDK9Zgsxv7+OAMij5ca6XhfH6T+h+2nBvAvxXsS/0Yk83T
         KaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyvA62biKTQGNyyqx4DnGpsV+JYlCmkfnivzJZ0J7rU=;
        b=WwkmY6dMUp1uoMy4QJBJvJTakdouw79qPvDJ7sQCSCqTpcx/O5lPQlqCuKgKUbGyWn
         z1z+0b5wS3+RRDSB36flwEu1CXVIdDZF5RggXbwJ64+q5CZjClMcBUy1PshM/fi+X/7j
         VPzF9FanPPw7rrqnN047mnD6U3kw8uLNyHLOum7B2NrI+eCw+rgChbwZXe5XSzQ3HOhn
         urev0db94aYrv08aDCUDAGL6uP/TFicqOnX8nIC01FnbiXHxE1xqQAORdReqXD/0uroZ
         LQ68aobcJ+/ZJgJPRZlXUMHrGBDX6H4mTipMm8J5To4D+Dit7d9d2rhcCqfAf1Y8FU+k
         kqaw==
X-Gm-Message-State: AOAM533ltrfTFwulZD/IYk/IZNNQYwAsMaT/esZDAKKdA1QyN0r3sr3L
        xdFc91ADN0Y1IjFGDwWBQVRiONAzsNAKR1+QUlAOeg==
X-Google-Smtp-Source: ABdhPJxvmk0uoCIiXmWi8TZ+xeZlLJihm/6WMOzXGhbK1A1pTxzZT+Sf42eiWQ829u5tbLUjbzFa7LJugyPnnb+qlSk=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr1109786pjb.101.1591040856878;
 Mon, 01 Jun 2020 12:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-7-brgerst@gmail.com>
In-Reply-To: <20200530221127.459704-7-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 12:47:25 -0700
Message-ID: <CAKwvOdnj4M6xy3DhqE9U05bBhNEHR7-o8CM0T-KoQFRck0o39g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] x86/percpu: Clean up percpu_add_return_op()
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

On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> The core percpu macros already have a switch on the data size, so the switch
> in the x86 code is redundant and produces more dead code.
>
> Also use appropriate types for the width of the instructions.  This avoids
> errors when compiling with Clang.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

I think it would have been ok to carry forward my reviewed by tag here
from v1, hidden at the bottom of
https://lore.kernel.org/lkml/CAKwvOdn7yC1GVA+6gtNewBSq2BK09y9iNWhv1dPFF5i4kT1+6A@mail.gmail.com/
even though you split removing 'e' into it's own patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/percpu.h | 51 +++++++++++------------------------
>  1 file changed, 16 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 9bb5440d98d3..0776a11e7e11 100644
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
> -                           : "+r" (paro_ret__), "+m" (var)             \
> -                           : : "memory");                              \
> -               break;                                                  \
> -       default: __bad_percpu_size();                                   \
> -       }                                                               \
> -       paro_ret__ += val;                                              \
> -       paro_ret__;                                                     \
> +       __pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);       \
> +       asm qual (__pcpu_op2_##size("xadd", "%[tmp]",                   \
> +                                    __percpu_arg([var]))               \
> +                 : [tmp] __pcpu_reg_##size("+", paro_tmp__),           \
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
