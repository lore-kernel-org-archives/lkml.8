Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7671C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B974207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4ug2w6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgERXsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgERXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:48:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2B3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:48:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y198so4106844pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4fzbBElXtTIr3PNPe3azlCL8R6APe5mvo9mrWeA9Ko=;
        b=m4ug2w6HCsqkksGMVsGJZw+uKYrQYSthKHp4BL86VeRz22B2+vswCFEnaUlMDaf0ps
         du31l4Y9wsY2zQNJgjPVkLxrOSzFiIGNbenQTiTscVKW6ZxkDvLLt3rdFq58S9DOZG89
         SIUN9tia1+ik34l8S3fpMXgKHOis0SXrXGfyGNiLqFhWNmF8XfqEr4en7mn9YByW9deC
         6mmLkNewqNGLdLopeMwkzGs7mzEOKf4fQQPpS7YSHe9TOhHZEL4/9S6c2mCi9XTjh8wh
         g949a7aKhwwH6zZy8Gyq9jHQSq0fY3c/uGP2A/vM2Rc9obzsw1agauW9+qwD6efS7aAs
         +bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4fzbBElXtTIr3PNPe3azlCL8R6APe5mvo9mrWeA9Ko=;
        b=Kj0b9fs/xEUZSDKh+BtGnpJCOJ2gdGJiVgY/s7m2biksSKyFDqA4Hn2F/PkfY5H9YC
         o9PdLrbcoSEtJGIgeDpnlmxC03qf44fngRsPoIWWlKwAW30jOcYDmkGe7EPu/ZdVZ44n
         FxazZwijX/xksO6GEdYjvVfrj3B+7QZVE9D3dnb9vtKsy7o5s02Kbyz8wlE0nGf6/qK/
         am77Jtai3sMV/mgYLbf26GcNJl/XofJ8XBR6I1oVWmSTdY9zFaEOAFGX1S4KPkt6mDEj
         L2u1wpxU+CY1fLYdRpbZCaAeHAXYyUgQkcdulKWTFhyjsud8zsSYGv8L8gM14p7YUEov
         eLGQ==
X-Gm-Message-State: AOAM5324T9/0ktX96q3sJQjErQTu7GUINqKaizmd7iI+ksb5/uWydzI4
        E8fo+Xwk4fSQ0LbgWVYKZV7+nFG93sKFpE+a7wsJbEXdO0s=
X-Google-Smtp-Source: ABdhPJxdFqqXKu4BYgg/5aC2aMFOT9/yeJFsvOvYECyCq2IGjvT/ZhnBiHq2d71hY38X7l7MZxIXWOEyG7NQUcsRXtQ=
X-Received: by 2002:a63:d010:: with SMTP id z16mr7045649pgf.381.1589845717162;
 Mon, 18 May 2020 16:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-2-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-2-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 16:48:23 -0700
Message-ID: <CAKwvOdmq5A-X-u7_=RGCjf6BAd=4n0B2x8H64nu5TTyze3V06w@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/percpu: Introduce size abstraction macros
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
> In preparation for cleaning up the percpu operations, define macros for
> abstraction based on the width of the operation.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 2278797c769d..89f918a3e99b 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -87,6 +87,36 @@
>   * don't give an lvalue though). */
>  extern void __bad_percpu_size(void);
>
> +#define __pcpu_type_1 u8
> +#define __pcpu_type_2 u16
> +#define __pcpu_type_4 u32
> +#define __pcpu_type_8 u64
> +
> +#define __pcpu_cast_1(val) ((u8)((unsigned long) val))
> +#define __pcpu_cast_2(val) ((u16)((unsigned long) val))
> +#define __pcpu_cast_4(val) ((u32)((unsigned long) val))
> +#define __pcpu_cast_8(val) ((u64)(val))
> +
> +#define __pcpu_op1_1(op, dst) op "b " dst
> +#define __pcpu_op1_2(op, dst) op "w " dst
> +#define __pcpu_op1_4(op, dst) op "l " dst
> +#define __pcpu_op1_8(op, dst) op "q " dst
> +
> +#define __pcpu_op2_1(op, src, dst) op "b " src ", " dst
> +#define __pcpu_op2_2(op, src, dst) op "w " src ", " dst
> +#define __pcpu_op2_4(op, src, dst) op "l " src ", " dst
> +#define __pcpu_op2_8(op, src, dst) op "q " src ", " dst

`op1` and `op2` aren't the most descriptive, though we kind of would
like terseness here.  I guess "op1"s have 1 operand, and "op2"s have 2
operands.

> +
> +#define __pcpu_reg_1(out, x) out "q" (x)
> +#define __pcpu_reg_2(out, x) out "r" (x)
> +#define __pcpu_reg_4(out, x) out "r" (x)
> +#define __pcpu_reg_8(out, x) out "r" (x)

I think `mod` is more descriptive than `out`, as there are modifiers.
https://gcc.gnu.org/onlinedocs/gcc/Modifiers.html#Modifiers

I don't want to bikeshed, since the naming changes potentially mean
touching each patch.  Just food for thought in case other reviewers
agree/disagree.  So I'll just add:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +
> +#define __pcpu_reg_imm_1(x) "qi" (x)
> +#define __pcpu_reg_imm_2(x) "ri" (x)
> +#define __pcpu_reg_imm_4(x) "ri" (x)
> +#define __pcpu_reg_imm_8(x) "re" (x)
> +
>  #define percpu_to_op(qual, op, var, val)               \
>  do {                                                   \
>         typedef typeof(var) pto_T__;                    \
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
