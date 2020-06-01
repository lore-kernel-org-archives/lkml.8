Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C99C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA55020734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLct5r9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgFAUTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgFAUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:19:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:19:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nm22so300144pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AY2ZWBDhct5rIZ8Gd0EN9P2ySlyhjItremWqFuYw9Dg=;
        b=gLct5r9r7nigHYxf77uvViIJH8YENu/3ZIgBphsOJrvfqu+hMNVoE0z2n9gEUxPIBu
         q4CpmGNN6Lf/CbdpmkzMmiTKVJQWWySBcIPlSEh0+ShoJLPNuT3iLC5scUorn493q9wI
         bncz18ZNhKaWh8GBjuBCYnsWZKTwnQkbwwrpk1eZbO0A9NEQj0VP4O/Pq+reBuPBEIxo
         HGZNIoIz/5priJ7E7NqNztqJOk3GuUVXmqopOLy2++7pqR6iSW+IMZjW8v+tBQ7ZQ8pe
         UGy5C+gbgEiWMnxNc6BaQtbHXrIGtOB+X0aQI1T47ywEf0A7qSDcq0GrrnURxB3YjNHj
         D7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AY2ZWBDhct5rIZ8Gd0EN9P2ySlyhjItremWqFuYw9Dg=;
        b=OcmgklJCzSZ7coeVzk7ig+OIzq5squZ55EKCjuBrpnyprwPqxRCwsJTpGa2wLWJqWE
         idHLAirl0cYtXQrXTBcFlprDfKoZqkQQyU4zD8Zzmgy7dyNV2n5tF3gB8xTRjqd8x+bH
         Vy+JhehAQzCHVORSyBQGm4HSep44KcmlFK/w3sEqzxOe8RJcro5erx20BMiJfoRImI/P
         WUDbMvEgqz9B8woyfGUysGMuelwSQ8QPYulpCcJZUJcgorc0dbnjkauuMkfVY3RfutzA
         sjaPpXehi1xVoisQDhU+SJ/RxqIJ0sryUzRDaFmuu2fLruSwU+qOqjnKfB6y0CGtfqI/
         lJVw==
X-Gm-Message-State: AOAM532/v0OLtkwEkrBw45Vg7DM8D/pfE/5WyobM3kNsKRZ3HjUKCmMN
        AfmxxG3Z8ywyfxVbio0PphgYNEmQVTWpVKbwRtaGBg==
X-Google-Smtp-Source: ABdhPJwsB2HN2/7eLdaocxnMRYCjXmr6voJBGEeoo7ju7znn6+NPa9BTopAdGaDrxu8xVCclNa6p1RvC8DK7uCX3hxA=
X-Received: by 2002:a17:902:341:: with SMTP id 59mr20575702pld.119.1591042741804;
 Mon, 01 Jun 2020 13:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-5-brgerst@gmail.com>
In-Reply-To: <20200530221127.459704-5-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 13:18:50 -0700
Message-ID: <CAKwvOdkWGjqLHkZ7TTvROuG=-v9O46ij942DWLCqksjwtTLFfQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] x86/percpu: Clean up percpu_add_op()
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

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/percpu.h | 99 ++++++++---------------------------
>  1 file changed, 22 insertions(+), 77 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index a40d2e055f58..2a24f3c795eb 100644
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
