Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B4F2081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9jr7hXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgERV1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 17:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:27:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:27:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so4760338plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lLuwaV0OShIX6Y/zoqEkFMKTylODQnH9FgeQd+o814=;
        b=M9jr7hXTvW2v4sSCa2jW8xiD3gYm71VLOVPBKJ78BgrECQee5RjkWlrvRQOdqXOStp
         qlsB7Xb9reKMM+aC16CHv0U4CIU2yKHaRSA859xP/H9MsCQDtFRQbDYiV6YoF1Jdizd3
         fXYNj13DWSkwOCKxYmtfg9od1CnULcsHEA6c6glQjpaK2Mo1CbDf44SKkMNov1Pwqta+
         gdY8cDFN6PtRmrD+p51iGnMSnhFrp5xPzB4UGIYvbuRhWO1rQcQk9YPTBGqN7VJmMqdL
         2z027QYnTwUhMnRss7ScklqL5+nR+dmJzNnhiGkcSgED9zqPaFfdhOX73kLJtDDxZojF
         2ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lLuwaV0OShIX6Y/zoqEkFMKTylODQnH9FgeQd+o814=;
        b=LYDAiiOj2eK5gpzRAHHJAKcXkUmFYQcOfM4CdL4FCw0ULpgROXI1b6+1YrUZwn1U3/
         Vlhm9eA7WawM97Gl4ZMXH+96lhaq1IGC1f+nd2/oXht1ANFGdLobcHz/W5P+uYbInK5v
         InfXFCieUaFFuw4abqM+/UvY+6DMerMLMoU+n652gUBjK8rLFF3XE11ms4VGPJK8/8fP
         9w6z/8N/sYcB0aFTcQ16DDoGcVVbtytHUmVdHSuBPNr8CANoAqzPZrXLcw9UPzKnrNwi
         oHcFUS0jXkTa0cg7a96VRb1uglLjvpOYCFCaJb3dYq31iaUCPAikD31OvFSYBU8AJUHE
         cK1Q==
X-Gm-Message-State: AOAM532TRDLa07Ahde+SjEFsF/cA1dSZM9iTCtALjA2Rjv0h35RgeV+L
        1M1T2O5pU80aL5xzvATqGqVIh7j58/bvlY/iu85jMw==
X-Google-Smtp-Source: ABdhPJy6eVMmfgD+ND+/1gqtT8ctYqwt6Pdtw+ofr8oNoBLPynZ4K0QTCK/Y8rW0ZSlpaAsGC44e8xgfh3wT1WRqSMQ=
X-Received: by 2002:a17:90b:19cc:: with SMTP id nm12mr1361091pjb.25.1589837257134;
 Mon, 18 May 2020 14:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-4-brgerst@gmail.com>
In-Reply-To: <20200517152916.3146539-4-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 14:27:23 -0700
Message-ID: <CAKwvOdk7dTndpMaVmEH874zfzLSK3DGGmfaEvaza=g6OwhX61g@mail.gmail.com>
Subject: Re: [PATCH 3/7] x86/percpu: Clean up percpu_from_op()
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
>  arch/x86/include/asm/percpu.h | 50 +++++++++++------------------------
>  1 file changed, 15 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 233c7a78d1a6..93f33202492d 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -190,33 +190,13 @@ do {                                                                      \
>         }                                                               \
>  } while (0)
>
> -#define percpu_from_op(qual, op, var)                  \
> -({                                                     \
> -       typeof(var) pfo_ret__;                          \
> -       switch (sizeof(var)) {                          \
> -       case 1:                                         \
> -               asm qual (op "b "__percpu_arg(1)",%0"   \
> -                   : "=q" (pfo_ret__)                  \
> -                   : "m" (var));                       \
> -               break;                                  \
> -       case 2:                                         \
> -               asm qual (op "w "__percpu_arg(1)",%0"   \
> -                   : "=r" (pfo_ret__)                  \
> -                   : "m" (var));                       \
> -               break;                                  \
> -       case 4:                                         \
> -               asm qual (op "l "__percpu_arg(1)",%0"   \
> -                   : "=r" (pfo_ret__)                  \
> -                   : "m" (var));                       \
> -               break;                                  \
> -       case 8:                                         \
> -               asm qual (op "q "__percpu_arg(1)",%0"   \
> -                   : "=r" (pfo_ret__)                  \
> -                   : "m" (var));                       \
> -               break;                                  \
> -       default: __bad_percpu_size();                   \
> -       }                                               \
> -       pfo_ret__;                                      \
> +#define percpu_from_op(size, qual, op, _var)                           \
> +({                                                                     \
> +       __pcpu_type_##size pfo_val__;                                   \
> +       asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")  \
> +           : [val] __pcpu_reg_##size("=", pfo_val__)                   \
> +           : [var] "m" (_var));                                        \
> +       (typeof(_var))(unsigned long) pfo_val__;                        \
>  })
>
>  #define percpu_stable_op(op, var)                      \
> @@ -401,9 +381,9 @@ do {                                                                        \
>   */
>  #define this_cpu_read_stable(var)      percpu_stable_op("mov", var)
>
> -#define raw_cpu_read_1(pcp)            percpu_from_op(, "mov", pcp)
> -#define raw_cpu_read_2(pcp)            percpu_from_op(, "mov", pcp)
> -#define raw_cpu_read_4(pcp)            percpu_from_op(, "mov", pcp)
> +#define raw_cpu_read_1(pcp)            percpu_from_op(1, , "mov", pcp)
> +#define raw_cpu_read_2(pcp)            percpu_from_op(2, , "mov", pcp)
> +#define raw_cpu_read_4(pcp)            percpu_from_op(4, , "mov", pcp)
>
>  #define raw_cpu_write_1(pcp, val)      percpu_to_op(1, , "mov", (pcp), val)
>  #define raw_cpu_write_2(pcp, val)      percpu_to_op(2, , "mov", (pcp), val)
> @@ -433,9 +413,9 @@ do {                                                                        \
>  #define raw_cpu_xchg_2(pcp, val)       raw_percpu_xchg_op(pcp, val)
>  #define raw_cpu_xchg_4(pcp, val)       raw_percpu_xchg_op(pcp, val)
>
> -#define this_cpu_read_1(pcp)           percpu_from_op(volatile, "mov", pcp)
> -#define this_cpu_read_2(pcp)           percpu_from_op(volatile, "mov", pcp)
> -#define this_cpu_read_4(pcp)           percpu_from_op(volatile, "mov", pcp)
> +#define this_cpu_read_1(pcp)           percpu_from_op(1, volatile, "mov", pcp)
> +#define this_cpu_read_2(pcp)           percpu_from_op(2, volatile, "mov", pcp)
> +#define this_cpu_read_4(pcp)           percpu_from_op(4, volatile, "mov", pcp)
>  #define this_cpu_write_1(pcp, val)     percpu_to_op(1, volatile, "mov", (pcp), val)
>  #define this_cpu_write_2(pcp, val)     percpu_to_op(2, volatile, "mov", (pcp), val)
>  #define this_cpu_write_4(pcp, val)     percpu_to_op(4, volatile, "mov", (pcp), val)
> @@ -488,7 +468,7 @@ do {                                                                        \
>   * 32 bit must fall back to generic operations.
>   */
>  #ifdef CONFIG_X86_64
> -#define raw_cpu_read_8(pcp)                    percpu_from_op(, "mov", pcp)
> +#define raw_cpu_read_8(pcp)                    percpu_from_op(8, , "mov", pcp)
>  #define raw_cpu_write_8(pcp, val)              percpu_to_op(8, , "mov", (pcp), val)
>  #define raw_cpu_add_8(pcp, val)                        percpu_add_op(, (pcp), val)
>  #define raw_cpu_and_8(pcp, val)                        percpu_to_op(8, , "and", (pcp), val)
> @@ -497,7 +477,7 @@ do {                                                                        \
>  #define raw_cpu_xchg_8(pcp, nval)              raw_percpu_xchg_op(pcp, nval)
>  #define raw_cpu_cmpxchg_8(pcp, oval, nval)     percpu_cmpxchg_op(, pcp, oval, nval)
>
> -#define this_cpu_read_8(pcp)                   percpu_from_op(volatile, "mov", pcp)
> +#define this_cpu_read_8(pcp)                   percpu_from_op(8, volatile, "mov", pcp)
>  #define this_cpu_write_8(pcp, val)             percpu_to_op(8, volatile, "mov", (pcp), val)
>  #define this_cpu_add_8(pcp, val)               percpu_add_op(volatile, (pcp), val)
>  #define this_cpu_and_8(pcp, val)               percpu_to_op(8, volatile, "and", (pcp), val)
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
