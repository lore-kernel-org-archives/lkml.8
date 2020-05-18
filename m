Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946B9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC20207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGQEVj7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgERXnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:43:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D8AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:43:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so5668478pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8muLYD1xgYtE5+3MTylpFgEPs9F6TZH1Nw2fhOJgUio=;
        b=IGQEVj7L/R7z4ITm2v8CeDn1w+RbyUDjXMunf10w3Z8NaBiy9G43an36FyXjdKBwpw
         /1EeObQZCUW6aDh9DRDR0DfW16kw4hn/s5jD6kGNDoQBxREtinKAvdjHJEaw7w61uu4/
         cxEi0o/dFKz7DMrDYJ3DuOdrDclYd+GCEG3Z5FJssl1qC8VNzaaxcL42rA081QNBbtl0
         TfM/mFGOaqUrzVAa3BbmvWqb7scrhwRB1abSBtvILZHnZCKsfrFluWIuMhl473xB31uV
         jq2NSeLUKPiBDXpYob/HlDZCVrZwuB2DZtKqERkQ3Ahb1ZJ1sBFHb+e96f5hukFKvUi6
         t+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8muLYD1xgYtE5+3MTylpFgEPs9F6TZH1Nw2fhOJgUio=;
        b=FBud0Z0VbT+LoDl7PXMhfblcJ+bg7MaXujTga91JZr/jatjSi3gVzlMQcmt3uHyWqy
         ohzR+UVNdyngXhf5vjDy2HU0uuzVWUxgA/eRs7q/5S97GqpUgs9Eq0crnrZ2RkimHg+Y
         P6Cv28BjHMxWNrXUKTD4FgJaJZdXuuFA4GNsTbppqdFyhxsTzQ4vvy1YYucS4YwiZuOa
         k8Uamj/M+qjsgWdQneuSdB0UXT+pPdOW5GAdnMUeZV+noXJRdW5nNaAW2WsJWSZFOWAJ
         tiMGJg4nNSD2+4Pz15yqfPADePdO+Sbl0IeLy3tfO2gSnHSwDu0q9G1DFYD778QRT7dP
         pyTw==
X-Gm-Message-State: AOAM532ZpVRhsJ2/bnftFHvnKVnuYl3x3ihcawtcFO0zMBzVXzZZLDAr
        iLPpMHTyqdIYRg0DLhUDXGJ/U8JVGrR9jhM8FtRbyg==
X-Google-Smtp-Source: ABdhPJx/7JXccs6kAtgKdajeCzLDEtupuHGNAhqB7XW+i8WRmsGBUog7+xFYvXTtFil4FWMQEUkq/ZBa9eLbk5kl+bs=
X-Received: by 2002:a63:d010:: with SMTP id z16mr7031605pgf.381.1589845392505;
 Mon, 18 May 2020 16:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-5-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-5-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 16:42:58 -0700
Message-ID: <CAKwvOdnVU3kZnGzkYjEFJWMPuVjOmAHuRSB8FJ-Ks+FWzX2M_Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/percpu: Clean up percpu_add_op()
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
>  arch/x86/include/asm/percpu.h | 99 ++++++++---------------------------
>  1 file changed, 22 insertions(+), 77 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 93f33202492d..21c5013a681a 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -130,64 +130,32 @@ do {                                                                      \
>             : [val] __pcpu_reg_imm_##size(pto_val__));                  \
>  } while (0)
>
> +#define percpu_unary_op(size, qual, op, _var)                          \
> +({                                                                     \
> +       asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))            \
> +           : [var] "+m" (_var));                                       \
> +})
> +
>  /*
>   * Generate a percpu add to memory instruction and optimize code
>   * if one is added or subtracted.
>   */
> -#define percpu_add_op(qual, var, val)                                  \
> +#define percpu_add_op(size, qual, var, val)                            \
>  do {                                                                   \
> -       typedef typeof(var) pao_T__;                                    \
>         const int pao_ID__ = (__builtin_constant_p(val) &&              \
>                               ((val) == 1 || (val) == -1)) ?            \
>                                 (int)(val) : 0;                         \
>         if (0) {                                                        \
> -               pao_T__ pao_tmp__;                                      \
> +               typeof(var) pao_tmp__;                                  \
>                 pao_tmp__ = (val);                                      \
>                 (void)pao_tmp__;                                        \
>         }                                                               \

Prefer __same_type() from include/linux/compiler_types.h here as well.
Nice elimination of the typedef.

> -       switch (sizeof(var)) {                                          \
> -       case 1:                                                         \
> -               if (pao_ID__ == 1)                                      \
> -                       asm qual ("incb "__percpu_arg(0) : "+m" (var)); \
> -               else if (pao_ID__ == -1)                                \
> -                       asm qual ("decb "__percpu_arg(0) : "+m" (var)); \
> -               else                                                    \
> -                       asm qual ("addb %1, "__percpu_arg(0)            \
> -                           : "+m" (var)                                \
> -                           : "qi" ((pao_T__)(val)));                   \
> -               break;                                                  \
> -       case 2:                                                         \
> -               if (pao_ID__ == 1)                                      \
> -                       asm qual ("incw "__percpu_arg(0) : "+m" (var)); \
> -               else if (pao_ID__ == -1)                                \
> -                       asm qual ("decw "__percpu_arg(0) : "+m" (var)); \
> -               else                                                    \
> -                       asm qual ("addw %1, "__percpu_arg(0)            \
> -                           : "+m" (var)                                \
> -                           : "ri" ((pao_T__)(val)));                   \
> -               break;                                                  \
> -       case 4:                                                         \
> -               if (pao_ID__ == 1)                                      \
> -                       asm qual ("incl "__percpu_arg(0) : "+m" (var)); \
> -               else if (pao_ID__ == -1)                                \
> -                       asm qual ("decl "__percpu_arg(0) : "+m" (var)); \
> -               else                                                    \
> -                       asm qual ("addl %1, "__percpu_arg(0)            \
> -                           : "+m" (var)                                \
> -                           : "ri" ((pao_T__)(val)));                   \
> -               break;                                                  \
> -       case 8:                                                         \
> -               if (pao_ID__ == 1)                                      \
> -                       asm qual ("incq "__percpu_arg(0) : "+m" (var)); \
> -               else if (pao_ID__ == -1)                                \
> -                       asm qual ("decq "__percpu_arg(0) : "+m" (var)); \
> -               else                                                    \
> -                       asm qual ("addq %1, "__percpu_arg(0)            \
> -                           : "+m" (var)                                \
> -                           : "re" ((pao_T__)(val)));                   \
> -               break;                                                  \
> -       default: __bad_percpu_size();                                   \
> -       }                                                               \
> +       if (pao_ID__ == 1)                                              \
> +               percpu_unary_op(size, qual, "inc", var);                \
> +       else if (pao_ID__ == -1)                                        \
> +               percpu_unary_op(size, qual, "dec", var);                \
> +       else                                                            \
> +               percpu_to_op(size, qual, "add", var, val);              \

Nice simplification, and it was clever of you to reuse percpu_to_op()
for the case of addition!

In terms of the 0day bot test failures:
>> include/linux/percpu-rwsem.h:91:17: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> include/net/tcp.h:1521:9: sparse: sparse: cast truncates bits from constant value (1d4c0 becomes d4c0)
>> include/net/sch_generic.h:888:9: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> drivers/infiniband/hw/hfi1/pio_copy.c:164:9: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
which is reminiscent of our discussion in:
https://lore.kernel.org/lkml/CAMzpN2gu4stkRKTsMTVxyzckO3SMhfA+dmCnSu6-aMg5QAA_JQ@mail.gmail.com/

I'm not able to repro with i386_defconfig, but it looks like one
report was i386_allmodconfig, the other was (64b) allyesconfig.
I am able to repro with:
$ rm -f drivers/infiniband/hw/hfi1/pio_copy.o
$ make -j71 CC=clang allyesconfig
$ make -j71 CC=clang C=1 drivers/infiniband/hw/hfi1/pio_copy.o

It's not immediately clear to me from this diff which cast sparse is
complaining about.  Looking at the report and expanding this_cpu_dec()
seems to eventually expand to `this_cpu_add_<number>, so the reporting
does look potentially against the right patch in the series.  (Seeing
`(typeof((ptr) + 0))NULL` in __verify_pcpu_ptr() in
include/linux/percpu-defs.h is a real WTF, though the comment
explains).

Indeed, if I checkout before the series is applied, the warnings
disappear.  So let's follow up tomorrow on where this is coming from.

>  } while (0)
>
>  #define percpu_from_op(size, qual, op, _var)                           \
> @@ -228,29 +196,6 @@ do {                                                                       \
>         pfo_ret__;                                      \
>  })
>
> -#define percpu_unary_op(qual, op, var)                 \
> -({                                                     \
> -       switch (sizeof(var)) {                          \
> -       case 1:                                         \
> -               asm qual (op "b "__percpu_arg(0)        \
> -                   : "+m" (var));                      \
> -               break;                                  \
> -       case 2:                                         \
> -               asm qual (op "w "__percpu_arg(0)        \
> -                   : "+m" (var));                      \
> -               break;                                  \
> -       case 4:                                         \
> -               asm qual (op "l "__percpu_arg(0)        \
> -                   : "+m" (var));                      \
> -               break;                                  \
> -       case 8:                                         \
> -               asm qual (op "q "__percpu_arg(0)        \
> -                   : "+m" (var));                      \
> -               break;                                  \
> -       default: __bad_percpu_size();                   \
> -       }                                               \
> -})
> -
>  /*
>   * Add return operation
>   */
> @@ -388,9 +333,9 @@ do {                                                                        \
>  #define raw_cpu_write_1(pcp, val)      percpu_to_op(1, , "mov", (pcp), val)
>  #define raw_cpu_write_2(pcp, val)      percpu_to_op(2, , "mov", (pcp), val)
>  #define raw_cpu_write_4(pcp, val)      percpu_to_op(4, , "mov", (pcp), val)
> -#define raw_cpu_add_1(pcp, val)                percpu_add_op(, (pcp), val)
> -#define raw_cpu_add_2(pcp, val)                percpu_add_op(, (pcp), val)
> -#define raw_cpu_add_4(pcp, val)                percpu_add_op(, (pcp), val)
> +#define raw_cpu_add_1(pcp, val)                percpu_add_op(1, , (pcp), val)
> +#define raw_cpu_add_2(pcp, val)                percpu_add_op(2, , (pcp), val)
> +#define raw_cpu_add_4(pcp, val)                percpu_add_op(4, , (pcp), val)
>  #define raw_cpu_and_1(pcp, val)                percpu_to_op(1, , "and", (pcp), val)
>  #define raw_cpu_and_2(pcp, val)                percpu_to_op(2, , "and", (pcp), val)
>  #define raw_cpu_and_4(pcp, val)                percpu_to_op(4, , "and", (pcp), val)
> @@ -419,9 +364,9 @@ do {                                                                        \
>  #define this_cpu_write_1(pcp, val)     percpu_to_op(1, volatile, "mov", (pcp), val)
>  #define this_cpu_write_2(pcp, val)     percpu_to_op(2, volatile, "mov", (pcp), val)
>  #define this_cpu_write_4(pcp, val)     percpu_to_op(4, volatile, "mov", (pcp), val)
> -#define this_cpu_add_1(pcp, val)       percpu_add_op(volatile, (pcp), val)
> -#define this_cpu_add_2(pcp, val)       percpu_add_op(volatile, (pcp), val)
> -#define this_cpu_add_4(pcp, val)       percpu_add_op(volatile, (pcp), val)
> +#define this_cpu_add_1(pcp, val)       percpu_add_op(1, volatile, (pcp), val)
> +#define this_cpu_add_2(pcp, val)       percpu_add_op(2, volatile, (pcp), val)
> +#define this_cpu_add_4(pcp, val)       percpu_add_op(4, volatile, (pcp), val)
>  #define this_cpu_and_1(pcp, val)       percpu_to_op(1, volatile, "and", (pcp), val)
>  #define this_cpu_and_2(pcp, val)       percpu_to_op(2, volatile, "and", (pcp), val)
>  #define this_cpu_and_4(pcp, val)       percpu_to_op(4, volatile, "and", (pcp), val)
> @@ -470,7 +415,7 @@ do {                                                                        \
>  #ifdef CONFIG_X86_64
>  #define raw_cpu_read_8(pcp)                    percpu_from_op(8, , "mov", pcp)
>  #define raw_cpu_write_8(pcp, val)              percpu_to_op(8, , "mov", (pcp), val)
> -#define raw_cpu_add_8(pcp, val)                        percpu_add_op(, (pcp), val)
> +#define raw_cpu_add_8(pcp, val)                        percpu_add_op(8, , (pcp), val)
>  #define raw_cpu_and_8(pcp, val)                        percpu_to_op(8, , "and", (pcp), val)
>  #define raw_cpu_or_8(pcp, val)                 percpu_to_op(8, , "or", (pcp), val)
>  #define raw_cpu_add_return_8(pcp, val)         percpu_add_return_op(, pcp, val)
> @@ -479,7 +424,7 @@ do {                                                                        \
>
>  #define this_cpu_read_8(pcp)                   percpu_from_op(8, volatile, "mov", pcp)
>  #define this_cpu_write_8(pcp, val)             percpu_to_op(8, volatile, "mov", (pcp), val)
> -#define this_cpu_add_8(pcp, val)               percpu_add_op(volatile, (pcp), val)
> +#define this_cpu_add_8(pcp, val)               percpu_add_op(8, volatile, (pcp), val)
>  #define this_cpu_and_8(pcp, val)               percpu_to_op(8, volatile, "and", (pcp), val)
>  #define this_cpu_or_8(pcp, val)                        percpu_to_op(8, volatile, "or", (pcp), val)
>  #define this_cpu_add_return_8(pcp, val)                percpu_add_return_op(volatile, pcp, val)
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
