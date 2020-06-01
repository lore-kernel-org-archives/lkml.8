Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FAA2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chgEHp56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgFAUs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAUs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:48:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F78C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:48:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so429303plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwK0hDI3RT0Fw5Fv7d7S4iGl7fGYafR6/uYcldSg7to=;
        b=chgEHp564d1oXgmJvE7dCSuplvb1FNO60K+dX0GdC3soF7/UPx89q3gnoich+mTGEV
         OKWnIGqA9xOMKAPTVQUT5MHLAuhXlE4mqDIh1ScVV/sOPEFyufpJqIdI0HIIajNcwYBt
         j77gruEEg+QPaWU6HS83jgb6uBXP7n/YKWfOWpIz+zQoQCvEU2E8o4zCsBLvapf7qRGv
         JT4H47tQQGmnyxDqxNrEpNY/FX+JvFMwNe4YxTlhHE70vbwdBOtVnUgn0HjqmDhtHtT7
         GoTdY6nY7qjpvxxyaBPeQud+bgu1NToAbxDEn0f8mgbgWtHgSmauc+RBG+pm1lk+ow2f
         yq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwK0hDI3RT0Fw5Fv7d7S4iGl7fGYafR6/uYcldSg7to=;
        b=nISST64Z75H84CfsPxiA18ISpghPAAclwlDzFplxm9uff6AGmFwnAo+21xvr84yjPn
         e/reA802rCo/sOwO/eVz3yR3C7GoA4cL14ngPPV8hDi2UvLqrRkgLEkoV92ntGf1pATi
         upG4aY2Agf6n39yOehA4YTlFIgj/nietanenr70PH/57CV9a8qLceUekPb+FeGIPEBVY
         eX6PiK2f0f8t+oPWsxLnvY3G3L6M+DjGdR/3m+/hG6tB0dhG/lhyBgKqCsKIZmZpJg8n
         9JN8tELpQYH3p6xEWB0AwRRfPImP865aI2jiOYOfH3w6hLv80tTRnY5OOp3c0qhMl1WH
         ZsFw==
X-Gm-Message-State: AOAM530k8c5KcBd9jXnz0WbbPN2klN4JkSJ7RXMCmMHxb3W4f5cDNA1G
        9qzNaKa3DiIsSWJ0t/Jwt/6hLKe9/HJhnPlBQxODO7RK
X-Google-Smtp-Source: ABdhPJx/tOoqtOJK5yO0lxFBAeSUZPMMsOAXhYTRptexVH9C3DVhrtvEnDva+HtWWrX58bhkXy0n2Zyk1fcYYkUIPhc=
X-Received: by 2002:a17:902:341:: with SMTP id 59mr20657863pld.119.1591044537188;
 Mon, 01 Jun 2020 13:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-2-brgerst@gmail.com>
In-Reply-To: <20200530221127.459704-2-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 13:48:45 -0700
Message-ID: <CAKwvOd=vf9J8PFcNod49Gh=2N-UGJrRo_OdgTfGa2Dh-H74=xw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] x86/percpu: Introduce size abstraction macros
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
> In preparation for cleaning up the percpu operations, define macros for
> abstraction based on the width of the operation.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 2278797c769d..19838e4f7a8f 100644
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
> +#define __pcpu_cast_1(val) ((u8)(((unsigned long) val) & 0xff))
> +#define __pcpu_cast_2(val) ((u16)(((unsigned long) val) & 0xffff))
> +#define __pcpu_cast_4(val) ((u32)(((unsigned long) val) & 0xffffffff))
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
> +
> +#define __pcpu_reg_1(mod, x) mod "q" (x)
> +#define __pcpu_reg_2(mod, x) mod "r" (x)
> +#define __pcpu_reg_4(mod, x) mod "r" (x)
> +#define __pcpu_reg_8(mod, x) mod "r" (x)
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
