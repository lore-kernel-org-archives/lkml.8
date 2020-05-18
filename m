Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630C8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB83207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qy8NlnJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgERVP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:15:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB8C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:15:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so4747200plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/vnN5gH6BslrLObMcvHBTBiOn8u+dV4QWVrVm5Swqw=;
        b=Qy8NlnJPeruYGixeVc5WHhMhQ0SUfcdMFBptXdyX8NYDdOOxFD4yqFSWnlUt4eQF3f
         ulNbqtp/dh+5jGD7lL7nVI6sklWPlbbKfvwg9jW5UO34zMz39xfQGjLwgzrNZ4dVm+sB
         55DM/JZpO/Oa5FYT8sBN19+cns5vyGAaA+0B6Ly0JlmZ6TZhzXAaPDmswpxh8sFQg9k/
         k/11XlciUErIdrmLzJcmYxeglVlNo60FicLQ6fon5rCXV28/FGoEGWSyivSjLF8xKd4s
         kl+vwkV693zDiYspvfNyvB5bnMiKbKZ2kgPjAdwN6oXC1GtBt7VusDvAnVmqmXQS16hN
         L/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/vnN5gH6BslrLObMcvHBTBiOn8u+dV4QWVrVm5Swqw=;
        b=HX11zF2bSK86t7USNd9549H1MRv0oGmzRNd83daRVVLzENuKa9TStNTDjqjxOa8A8P
         LR/kVgU8Tb27HwrUsZRDnCIYl9ZM/Jr6do7CciY4gU3smkvPLRfMfXRE2TMj/B7lzfgX
         h3jyhuAMTI3BygIglIGHpXLbK2kFjl1cmtBB/YRUIJEwPN8t1hJXrAzXj9snem9iSOBx
         34iDthqDdHmRtkm8ESJGiuDxRW4q4MWvNNk/aQi16kp1/6ht4qN7U+gM+MkUx9zcxAde
         q4IWEoPAo27WQaOMgIIQ3Gqi0DMJRAxB3POQdWMJSHR2RfQufAn/lbrKBcYlAwFH5OeI
         8V7g==
X-Gm-Message-State: AOAM533o4EQHGj3PDuI8Bczhe1rexRmLv9kOXNgKnFrlDpOXFdyt3woE
        /AVHRwDuNQEAAjA1QsIzAIvZIPexmf9rUlmaNcIEmg==
X-Google-Smtp-Source: ABdhPJxdPTR4MhSQG6u4ruhUFbKAdl4HWM9yyYqDsNpYItmvqWEnnY7479pk+LUrSYwpKUSlZ1EXKBCr7WEEvNrWmKU=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr1449010pjb.101.1589836558003;
 Mon, 18 May 2020 14:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-3-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-3-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 14:15:44 -0700
Message-ID: <CAKwvOdnCcpS_9A2y9tMqeiAg2NfcVx=gNeA2V=+zHknit7wGkg@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86/percpu: Clean up percpu_to_op()
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
>  arch/x86/include/asm/percpu.h | 90 ++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 55 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 89f918a3e99b..233c7a78d1a6 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
>  #define __pcpu_reg_imm_4(x) "ri" (x)
>  #define __pcpu_reg_imm_8(x) "re" (x)
>
> -#define percpu_to_op(qual, op, var, val)               \
> -do {                                                   \
> -       typedef typeof(var) pto_T__;                    \
> -       if (0) {                                        \
> -               pto_T__ pto_tmp__;                      \
> -               pto_tmp__ = (val);                      \
> -               (void)pto_tmp__;                        \
> -       }                                               \
> -       switch (sizeof(var)) {                          \
> -       case 1:                                         \
> -               asm qual (op "b %1,"__percpu_arg(0)     \
> -                   : "+m" (var)                        \
> -                   : "qi" ((pto_T__)(val)));           \
> -               break;                                  \
> -       case 2:                                         \
> -               asm qual (op "w %1,"__percpu_arg(0)     \
> -                   : "+m" (var)                        \
> -                   : "ri" ((pto_T__)(val)));           \
> -               break;                                  \
> -       case 4:                                         \
> -               asm qual (op "l %1,"__percpu_arg(0)     \
> -                   : "+m" (var)                        \
> -                   : "ri" ((pto_T__)(val)));           \
> -               break;                                  \
> -       case 8:                                         \
> -               asm qual (op "q %1,"__percpu_arg(0)     \
> -                   : "+m" (var)                        \
> -                   : "re" ((pto_T__)(val)));           \
> -               break;                                  \
> -       default: __bad_percpu_size();                   \
> -       }                                               \
> +#define percpu_to_op(size, qual, op, _var, _val)                       \
> +do {                                                                   \
> +       __pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);        \
> +       if (0) {                                                        \
> +               typeof(_var) pto_tmp__;                                 \
> +               pto_tmp__ = (_val);                                     \
> +               (void)pto_tmp__;                                        \
> +       }                                                               \

Please replace the whole `if (0)` block with:
```c
__same_type(_var, _val);
```
from include/linux/compiler.h.

> +       asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))   \
> +           : [var] "+m" (_var)                                         \
> +           : [val] __pcpu_reg_imm_##size(pto_val__));                  \
>  } while (0)
>
>  /*
> @@ -425,18 +405,18 @@ do {                                                                      \
>  #define raw_cpu_read_2(pcp)            percpu_from_op(, "mov", pcp)
>  #define raw_cpu_read_4(pcp)            percpu_from_op(, "mov", pcp)
>
> -#define raw_cpu_write_1(pcp, val)      percpu_to_op(, "mov", (pcp), val)
> -#define raw_cpu_write_2(pcp, val)      percpu_to_op(, "mov", (pcp), val)
> -#define raw_cpu_write_4(pcp, val)      percpu_to_op(, "mov", (pcp), val)
> +#define raw_cpu_write_1(pcp, val)      percpu_to_op(1, , "mov", (pcp), val)
> +#define raw_cpu_write_2(pcp, val)      percpu_to_op(2, , "mov", (pcp), val)
> +#define raw_cpu_write_4(pcp, val)      percpu_to_op(4, , "mov", (pcp), val)
>  #define raw_cpu_add_1(pcp, val)                percpu_add_op(, (pcp), val)
>  #define raw_cpu_add_2(pcp, val)                percpu_add_op(, (pcp), val)
>  #define raw_cpu_add_4(pcp, val)                percpu_add_op(, (pcp), val)
> -#define raw_cpu_and_1(pcp, val)                percpu_to_op(, "and", (pcp), val)
> -#define raw_cpu_and_2(pcp, val)                percpu_to_op(, "and", (pcp), val)
> -#define raw_cpu_and_4(pcp, val)                percpu_to_op(, "and", (pcp), val)
> -#define raw_cpu_or_1(pcp, val)         percpu_to_op(, "or", (pcp), val)
> -#define raw_cpu_or_2(pcp, val)         percpu_to_op(, "or", (pcp), val)
> -#define raw_cpu_or_4(pcp, val)         percpu_to_op(, "or", (pcp), val)
> +#define raw_cpu_and_1(pcp, val)                percpu_to_op(1, , "and", (pcp), val)
> +#define raw_cpu_and_2(pcp, val)                percpu_to_op(2, , "and", (pcp), val)
> +#define raw_cpu_and_4(pcp, val)                percpu_to_op(4, , "and", (pcp), val)
> +#define raw_cpu_or_1(pcp, val)         percpu_to_op(1, , "or", (pcp), val)
> +#define raw_cpu_or_2(pcp, val)         percpu_to_op(2, , "or", (pcp), val)
> +#define raw_cpu_or_4(pcp, val)         percpu_to_op(4, , "or", (pcp), val)
>
>  /*
>   * raw_cpu_xchg() can use a load-store since it is not required to be
> @@ -456,18 +436,18 @@ do {                                                                      \
>  #define this_cpu_read_1(pcp)           percpu_from_op(volatile, "mov", pcp)
>  #define this_cpu_read_2(pcp)           percpu_from_op(volatile, "mov", pcp)
>  #define this_cpu_read_4(pcp)           percpu_from_op(volatile, "mov", pcp)
> -#define this_cpu_write_1(pcp, val)     percpu_to_op(volatile, "mov", (pcp), val)
> -#define this_cpu_write_2(pcp, val)     percpu_to_op(volatile, "mov", (pcp), val)
> -#define this_cpu_write_4(pcp, val)     percpu_to_op(volatile, "mov", (pcp), val)
> +#define this_cpu_write_1(pcp, val)     percpu_to_op(1, volatile, "mov", (pcp), val)
> +#define this_cpu_write_2(pcp, val)     percpu_to_op(2, volatile, "mov", (pcp), val)
> +#define this_cpu_write_4(pcp, val)     percpu_to_op(4, volatile, "mov", (pcp), val)
>  #define this_cpu_add_1(pcp, val)       percpu_add_op(volatile, (pcp), val)
>  #define this_cpu_add_2(pcp, val)       percpu_add_op(volatile, (pcp), val)
>  #define this_cpu_add_4(pcp, val)       percpu_add_op(volatile, (pcp), val)
> -#define this_cpu_and_1(pcp, val)       percpu_to_op(volatile, "and", (pcp), val)
> -#define this_cpu_and_2(pcp, val)       percpu_to_op(volatile, "and", (pcp), val)
> -#define this_cpu_and_4(pcp, val)       percpu_to_op(volatile, "and", (pcp), val)
> -#define this_cpu_or_1(pcp, val)                percpu_to_op(volatile, "or", (pcp), val)
> -#define this_cpu_or_2(pcp, val)                percpu_to_op(volatile, "or", (pcp), val)
> -#define this_cpu_or_4(pcp, val)                percpu_to_op(volatile, "or", (pcp), val)
> +#define this_cpu_and_1(pcp, val)       percpu_to_op(1, volatile, "and", (pcp), val)
> +#define this_cpu_and_2(pcp, val)       percpu_to_op(2, volatile, "and", (pcp), val)
> +#define this_cpu_and_4(pcp, val)       percpu_to_op(4, volatile, "and", (pcp), val)
> +#define this_cpu_or_1(pcp, val)                percpu_to_op(1, volatile, "or", (pcp), val)
> +#define this_cpu_or_2(pcp, val)                percpu_to_op(2, volatile, "or", (pcp), val)
> +#define this_cpu_or_4(pcp, val)                percpu_to_op(4, volatile, "or", (pcp), val)
>  #define this_cpu_xchg_1(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
>  #define this_cpu_xchg_2(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
>  #define this_cpu_xchg_4(pcp, nval)     percpu_xchg_op(volatile, pcp, nval)
> @@ -509,19 +489,19 @@ do {                                                                      \
>   */
>  #ifdef CONFIG_X86_64
>  #define raw_cpu_read_8(pcp)                    percpu_from_op(, "mov", pcp)
> -#define raw_cpu_write_8(pcp, val)              percpu_to_op(, "mov", (pcp), val)
> +#define raw_cpu_write_8(pcp, val)              percpu_to_op(8, , "mov", (pcp), val)
>  #define raw_cpu_add_8(pcp, val)                        percpu_add_op(, (pcp), val)
> -#define raw_cpu_and_8(pcp, val)                        percpu_to_op(, "and", (pcp), val)
> -#define raw_cpu_or_8(pcp, val)                 percpu_to_op(, "or", (pcp), val)
> +#define raw_cpu_and_8(pcp, val)                        percpu_to_op(8, , "and", (pcp), val)
> +#define raw_cpu_or_8(pcp, val)                 percpu_to_op(8, , "or", (pcp), val)
>  #define raw_cpu_add_return_8(pcp, val)         percpu_add_return_op(, pcp, val)
>  #define raw_cpu_xchg_8(pcp, nval)              raw_percpu_xchg_op(pcp, nval)
>  #define raw_cpu_cmpxchg_8(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, oval, nval)
>
>  #define this_cpu_read_8(pcp)                   percpu_from_op(volatile, "mov", pcp)
> -#define this_cpu_write_8(pcp, val)             percpu_to_op(volatile, "mov", (pcp), val)
> +#define this_cpu_write_8(pcp, val)             percpu_to_op(8, volatile, "mov", (pcp), val)
>  #define this_cpu_add_8(pcp, val)               percpu_add_op(volatile, (pcp), val)
> -#define this_cpu_and_8(pcp, val)               percpu_to_op(volatile, "and", (pcp), val)
> -#define this_cpu_or_8(pcp, val)                        percpu_to_op(volatile, "or", (pcp), val)
> +#define this_cpu_and_8(pcp, val)               percpu_to_op(8, volatile, "and", (pcp), val)
> +#define this_cpu_or_8(pcp, val)                        percpu_to_op(8, volatile, "or", (pcp), val)
>  #define this_cpu_add_return_8(pcp, val)                percpu_add_return_op(volatile, pcp, val)
>  #define this_cpu_xchg_8(pcp, nval)             percpu_xchg_op(volatile, pcp, nval)
>  #define this_cpu_cmpxchg_8(pcp, oval, nval)    percpu_cmpxchg_op(volatile, pcp, oval, nval)
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
