Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D80C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251C420829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPSdew+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgERW3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgERW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:29:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:29:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci23so478516pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J9orov8nDrybWoUV5nL1VoYUgfhGVvl5noZ7L+X0xw4=;
        b=sPSdew+BSi8gsLPO+OmURXsRdlHwNF2qdMQLxF8q6OJF+NgOc2TNfz6cpVqYavpLgA
         8kmJnLPSs0tUAWhqUPzRX/+AxgCeu/tMF0bwwiQKjEIxaAfJMP5o5kTbKGlg8wTTuax6
         4DIAxTc7GMG31XBgcBgfRcsAZ289e38fAwcIb4smB3SRzk+yTfAJoj3qfRMUHMv3OBnE
         M059OraCsjn9OlL0s6pzOpxQZ/TwE945RgBXUMb4juU3vzbfrfIw4YWTPTZiXgE2p8l6
         2PIZmnfDPoXMTbp8IszB3u582laVkYgUDxDVN7hblhrHGGRzkt0Wg6minPST6b/Qd+oK
         5aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J9orov8nDrybWoUV5nL1VoYUgfhGVvl5noZ7L+X0xw4=;
        b=DYrOn9VEEsa7x7T77eEF9aibAzVfTylVah8lzy2u0iPfekx8F03imuZvANlMK1FNvi
         a0A8URD5/jnNQDulHfNFmexf9Xol2gDsTjdyGj3z6M/AnVKtpMKI+du+awfjU/G1wgNC
         DYQAW4ZiGMcry0j4SSNmYgxUT3ZxnGgyQ0l/5n1vOro1w9231poReEZyKg21vAkWILVV
         n80Fl3HIStDwddqYdKIFXszW3wNHuI/KJD/IIEDU1OtWqSZW+agIW62N4J4bE2zzPlVs
         SAmi9m7uomH8D40DYqPzA9TdpSolor5+5z+ZN7dWH0YDPlF0WPdaSUoQgN2tvjSzHY/C
         yGoA==
X-Gm-Message-State: AOAM533wpavTnFew+4c2lqyqIpd1ZJvJMps5sifclw94Xxx72VrJBCGy
        ujxy14eCx17w/TuFPsu+HcEI82sjsvRk+Q+L0xZpdg==
X-Google-Smtp-Source: ABdhPJzKoJovtbV4HtkmX4bDK6BW7YD8WyL3WyUsevXn4wAuEg3TvFcsyTCuXvPvZS61gFikCzfVRJB1k7FAG9/1GZk=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr1722287pjb.101.1589840943985;
 Mon, 18 May 2020 15:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-8-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-8-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 15:28:50 -0700
Message-ID: <CAKwvOdkK1pZbwjVvKyzgjMGhYtu0XyTKgRJoWVJW5-mbpx+R=w@mail.gmail.com>
Subject: Re: [PATCH 7/7] x86/percpu: Clean up percpu_cmpxchg_op()
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> The core percpu macros already have a switch on the data size, so the swi=
tch
> in the x86 code is redundant and produces more dead code.
>
> Also use appropriate types for the width of the instructions.  This avoid=
s
> errors when compiling with Clang.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/include/asm/percpu.h | 58 +++++++++++------------------------
>  1 file changed, 18 insertions(+), 40 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.=
h
> index 3c95ab3c99cd..b61d4fc5568e 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -236,39 +236,17 @@ do {                                               =
                       \
>   * cmpxchg has no such implied lock semantics as a result it is much
>   * more efficient for cpu local operations.
>   */
> -#define percpu_cmpxchg_op(qual, var, oval, nval)                       \
> +#define percpu_cmpxchg_op(size, qual, _var, _oval, _nval)              \
>  ({                                                                     \
> -       typeof(var) pco_ret__;                                          \
> -       typeof(var) pco_old__ =3D (oval);                                =
 \
> -       typeof(var) pco_new__ =3D (nval);                                =
 \
> -       switch (sizeof(var)) {                                          \
> -       case 1:                                                         \
> -               asm qual ("cmpxchgb %2, "__percpu_arg(1)                \
> -                           : "=3Da" (pco_ret__), "+m" (var)             =
 \
> -                           : "q" (pco_new__), "0" (pco_old__)          \
> -                           : "memory");                                \
> -               break;                                                  \
> -       case 2:                                                         \
> -               asm qual ("cmpxchgw %2, "__percpu_arg(1)                \
> -                           : "=3Da" (pco_ret__), "+m" (var)             =
 \
> -                           : "r" (pco_new__), "0" (pco_old__)          \
> -                           : "memory");                                \
> -               break;                                                  \
> -       case 4:                                                         \
> -               asm qual ("cmpxchgl %2, "__percpu_arg(1)                \
> -                           : "=3Da" (pco_ret__), "+m" (var)             =
 \
> -                           : "r" (pco_new__), "0" (pco_old__)          \
> -                           : "memory");                                \
> -               break;                                                  \
> -       case 8:                                                         \
> -               asm qual ("cmpxchgq %2, "__percpu_arg(1)                \
> -                           : "=3Da" (pco_ret__), "+m" (var)             =
 \
> -                           : "r" (pco_new__), "0" (pco_old__)          \
> -                           : "memory");                                \
> -               break;                                                  \
> -       default: __bad_percpu_size();                                   \
> -       }                                                               \
> -       pco_ret__;                                                      \
> +       __pcpu_type_##size pco_old__ =3D __pcpu_cast_##size(_oval);      =
 \
> +       __pcpu_type_##size pco_new__ =3D __pcpu_cast_##size(_nval);      =
 \
> +       asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",               \
> +                                   __percpu_arg([var]))                \
> +                 : [oval] "+a" (pco_old__),                            \
> +                   [var] "+m" (_var)                                   \
> +                 : [nval] __pcpu_reg_##size(, pco_new__)               \

Looks like we're no longer using "=3Da" and "0" constraints.  Looking
these up for reference for other reviewers:

"0" [0]:
Input constraints can also be digits (for example, "0"). This
indicates that the specified input must be in the same place as the
output constraint at the (zero-based) index in the output constraint
list. When using asmSymbolicName syntax for the output operands, you
may use these names (enclosed in brackets =E2=80=98[]=E2=80=99) instead of =
digits.
[0] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Extended-Asm

"+" [1]:
Means that this operand is both read and written by the instruction.
[1] https://gcc.gnu.org/onlinedocs/gcc/Modifiers.html#Modifiers

"=3D" [1]:
Means that this operand is written to by this instruction: the
previous value is discarded and replaced by new data.

So this looks like a nice simplification.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +                 : "memory");                                          \
> +       (typeof(_var))(unsigned long) pco_old__;                        \
>  })
>
>  /*
> @@ -336,16 +314,16 @@ do {                                               =
                       \
>  #define raw_cpu_add_return_1(pcp, val)         percpu_add_return_op(1, ,=
 pcp, val)
>  #define raw_cpu_add_return_2(pcp, val)         percpu_add_return_op(2, ,=
 pcp, val)
>  #define raw_cpu_add_return_4(pcp, val)         percpu_add_return_op(4, ,=
 pcp, val)
> -#define raw_cpu_cmpxchg_1(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, =
oval, nval)
> -#define raw_cpu_cmpxchg_2(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, =
oval, nval)
> -#define raw_cpu_cmpxchg_4(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, =
oval, nval)
> +#define raw_cpu_cmpxchg_1(pcp, oval, nval)     percpu_cmpxchg_op(1, , pc=
p, oval, nval)
> +#define raw_cpu_cmpxchg_2(pcp, oval, nval)     percpu_cmpxchg_op(2, , pc=
p, oval, nval)
> +#define raw_cpu_cmpxchg_4(pcp, oval, nval)     percpu_cmpxchg_op(4, , pc=
p, oval, nval)
>
>  #define this_cpu_add_return_1(pcp, val)                percpu_add_return=
_op(1, volatile, pcp, val)
>  #define this_cpu_add_return_2(pcp, val)                percpu_add_return=
_op(2, volatile, pcp, val)
>  #define this_cpu_add_return_4(pcp, val)                percpu_add_return=
_op(4, volatile, pcp, val)
> -#define this_cpu_cmpxchg_1(pcp, oval, nval)    percpu_cmpxchg_op(volatil=
e, pcp, oval, nval)
> -#define this_cpu_cmpxchg_2(pcp, oval, nval)    percpu_cmpxchg_op(volatil=
e, pcp, oval, nval)
> -#define this_cpu_cmpxchg_4(pcp, oval, nval)    percpu_cmpxchg_op(volatil=
e, pcp, oval, nval)
> +#define this_cpu_cmpxchg_1(pcp, oval, nval)    percpu_cmpxchg_op(1, vola=
tile, pcp, oval, nval)
> +#define this_cpu_cmpxchg_2(pcp, oval, nval)    percpu_cmpxchg_op(2, vola=
tile, pcp, oval, nval)
> +#define this_cpu_cmpxchg_4(pcp, oval, nval)    percpu_cmpxchg_op(4, vola=
tile, pcp, oval, nval)
>
>  #ifdef CONFIG_X86_CMPXCHG64
>  #define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)            \
> @@ -376,7 +354,7 @@ do {                                                 =
                       \
>  #define raw_cpu_or_8(pcp, val)                 percpu_to_op(8, , "or", (=
pcp), val)
>  #define raw_cpu_add_return_8(pcp, val)         percpu_add_return_op(8, ,=
 pcp, val)
>  #define raw_cpu_xchg_8(pcp, nval)              raw_percpu_xchg_op(pcp, n=
val)
> -#define raw_cpu_cmpxchg_8(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, =
oval, nval)
> +#define raw_cpu_cmpxchg_8(pcp, oval, nval)     percpu_cmpxchg_op(8, , pc=
p, oval, nval)
>
>  #define this_cpu_read_8(pcp)                   percpu_from_op(8, volatil=
e, "mov", pcp)
>  #define this_cpu_write_8(pcp, val)             percpu_to_op(8, volatile,=
 "mov", (pcp), val)
> @@ -385,7 +363,7 @@ do {                                                 =
                       \
>  #define this_cpu_or_8(pcp, val)                        percpu_to_op(8, v=
olatile, "or", (pcp), val)
>  #define this_cpu_add_return_8(pcp, val)                percpu_add_return=
_op(8, volatile, pcp, val)
>  #define this_cpu_xchg_8(pcp, nval)             percpu_xchg_op(8, volatil=
e, pcp, nval)
> -#define this_cpu_cmpxchg_8(pcp, oval, nval)    percpu_cmpxchg_op(volatil=
e, pcp, oval, nval)
> +#define this_cpu_cmpxchg_8(pcp, oval, nval)    percpu_cmpxchg_op(8, vola=
tile, pcp, oval, nval)
>
>  /*
>   * Pretty complex macro to generate cmpxchg16 instruction.  The instruct=
ion
> --
> 2.25.4
>


--=20
Thanks,
~Nick Desaulniers
