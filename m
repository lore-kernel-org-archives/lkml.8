Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23521C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A162068E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxsWQEUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFKSuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFKSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:50:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A89C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:50:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so2653442plv.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HOxmX84CtOBZELFo2yLdhQ76D4cXxjqf83woFragKk=;
        b=oxsWQEUnqGUCXsQYu4Q4x7fbNFwOw7SuMdOl2l++cT3hILmvMY43Cvlvc01lQcNDq6
         EgiVfO3Em6SfYWGww+r6raQdqBbm9Aqqap+8XWBkuPoYyG7bP85i6gV0TCm3FndV+bnU
         fz9L/NdwwXaCqNvr1QJGjDquY1L6DPen4q3Gy8ppp5emfJsw3oxr/kGuw92STRey/iLN
         1o6WGWm4rspjzYqfxh0VyYljMtSYn0iIresX7/RdLCt5KB/JRotFSmB9xzK3gC4GvbMf
         7T+Ao/6ynTLcC1eq+v+TK+5wuCcAtn+gBl6P8br8V+fXY8dIL9NMY1P3avrVq9o5JVCA
         KgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HOxmX84CtOBZELFo2yLdhQ76D4cXxjqf83woFragKk=;
        b=EC016hVi1w7W3Mxj0zgjsStTqfEuZc5Z0aqYH/seAv3/nTofyx1G8NsfGSRHwT/r3t
         /pdg0K99e+soLQWrlcOhMo3yiFcp9noWQg3jLxU1wtFyd8G6tf40kOvrzQrJwqu3iLDY
         E7yeIF9DGqHQCTxgFIPj7HRiESjHlQAv6mIQIln1Vc3BhpnWUjWaVLjwQZIhJkHQJ8B4
         aQoTEqs8ticOOgu8ty+sLgVteBimrgsL2LlNV5MrgLO97v1SlAN5Sj2/qeDEWfxcJOEK
         r38Fc4JyDpDm7785bZZs/I11EqMXiCFeFDmWoeDayeqtkfS2IedPXeAa7C7oWUaYqgyv
         wPDg==
X-Gm-Message-State: AOAM5335/jMQ7qzaPIWaOYKza+Fv/t/91R9jogfuzV+XPJ/cbQ/HZvkK
        7i9Bm91jhX/26mosFBKzzAi8OzKr8rbLeXyHdnSHTw==
X-Google-Smtp-Source: ABdhPJyJtc1w81gMIYy1ZYthLEsyyhDaPcYkmrzbwsIH3A4ulWVJtPADJXXEIc8Z3352j9KkW6UDv9s9TSKEAizZ1/s=
X-Received: by 2002:a17:90a:1e:: with SMTP id 30mr8711851pja.25.1591901402456;
 Thu, 11 Jun 2020 11:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200611183235.37508-1-nhuck@google.com>
In-Reply-To: <20200611183235.37508-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jun 2020 11:49:51 -0700
Message-ID: <CAKwvOdnnP3cHZMjgV355r=OO7MDLmSoOoU_ch8+ByRaJEkF=rg@mail.gmail.com>
Subject: Re: [PATCH] riscv/atomic: Fix sign extension for RV64I
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:34 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> The argument passed to cmpxchg is not guaranteed to be sign
> extended, but lr.w sign extends on RV64I.

I had a hard time finding documentation on this sign extension. Is
lr.w just the atomic version of lw?

https://content.riscv.org/wp-content/uploads/2019/06/riscv-spec.pdf
pdf page 54, printed page 38 says:
   The LW instruction loads a 32-bit value from memory and sign-extends
    this to 64 bits before storing it in register rd for RV64I.

> This makes cmpxchg
> fail on clang built kernels when __old is negative.
>
> To fix this, we just cast __old to long which sign extends on
> RV64I. With this fix, clang built RISC-V kernels now boot.

Oh, indeed, nice!  Thanks for digging into this issue, and sending the patch.
Tested-by: Nick Desaulniers <ndesaulniers@google.com> # QEMU boot, clang build

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/867
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index d969bab4a26b..262e5bbb2776 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -179,7 +179,7 @@
>                         "       bnez %1, 0b\n"                          \
>                         "1:\n"                                          \
>                         : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> +                       : "rJ" ((long)__old), "rJ" (__new)              \
>                         : "memory");                                    \
>                 break;                                                  \
>         case 8:                                                         \
> @@ -224,7 +224,7 @@
>                         RISCV_ACQUIRE_BARRIER                           \
>                         "1:\n"                                          \
>                         : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> +                       : "rJ" ((long)__old), "rJ" (__new)              \
>                         : "memory");                                    \
>                 break;                                                  \
>         case 8:                                                         \
> @@ -270,7 +270,7 @@
>                         "       bnez %1, 0b\n"                          \
>                         "1:\n"                                          \
>                         : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> +                       : "rJ" ((long)__old), "rJ" (__new)              \
>                         : "memory");                                    \
>                 break;                                                  \
>         case 8:                                                         \
> @@ -316,7 +316,7 @@
>                         "       fence rw, rw\n"                         \
>                         "1:\n"                                          \
>                         : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> +                       : "rJ" ((long)__old), "rJ" (__new)              \
>                         : "memory");                                    \
>                 break;                                                  \
>         case 8:                                                         \
> --
-- 
Thanks,
~Nick Desaulniers
