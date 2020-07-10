Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEDEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB64020725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8jqouEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGJQqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:46:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF11C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:46:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so2768215pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEJ4O5IRtxDaBgCbgZ/Q408W88KkDEGUZbbV6ihxQP4=;
        b=m8jqouEai9bWz+XEvv1yWqI+GZ0fpiFnMhVhotCGhobHSsVF0OzprD/Pu+8bIz883f
         wn2NMRgiZgQhyXD3guMQPXhE7b0qa30Goqz+Maq/Af+u2SmZzvdmH8XHzIeOQyuAQ2LE
         pWucWqF61fm5PbBH1RVdMIpsLsNikV8VlUloYdHkTVWbHEfryUU7JVSwYr32AG54tSTK
         wSqPgq/K/NXtYGP/ELB7Hi1ciGgWF6CYUVsDCosZD2CrdAQvo5yQFVmNEK1r5YcMzBsz
         uf06YTRPOXqdexRP7lNgmTxtXk+LEJkUpqA9iOnQ/EKmeNgnEzTrjp6KfXn77H6ptzjJ
         nqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEJ4O5IRtxDaBgCbgZ/Q408W88KkDEGUZbbV6ihxQP4=;
        b=LbRN8TZVAJGrZUcSTy1yrgYxC14oAdWzg5EbgfPmCu+ldhYSNur9LpVMN05p1sUXUC
         r28tmG6+AeBUntqieN+limP40K6oP29FaRJhz0nHPltuXffWY2iNOCBG0GfscONPXdpQ
         Qp/iRLM+CiSQGnJ7Gi86B9NSQCVdXVm2gPTk9fNipazU4taxYWxD4ESjhZ9t1erp3/P1
         E2R88pPhte7xeCsPFtwrJxiQ4u1J8Ojblvyw3ZhHTTDPd3czdbuazucEnVWYRrCP/j1t
         BIQ5NSehN0biiKfTjBGCLYWh9iuwvcUd7Z7v99LbnxYBjdHPLT9FxFVu0Thm575RJXwz
         K50g==
X-Gm-Message-State: AOAM533rHHNphOBp7rvhpzfx4VMTmnybXumA8KakV+L4+HiW1O4LQajX
        Z1haw/+iboHuSBpPQCNYszMSPlHKMQj3/29QeKr/3Q==
X-Google-Smtp-Source: ABdhPJy8cHwcMXMhJq9cSqCnrxYD9RfJGdZHhE8eWmzDboeqXj7ICfFj6ZLURk23deguvCVvRehqxZsJwzcI+YvF9Ws=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr64641771pfu.169.1594399568391;
 Fri, 10 Jul 2020 09:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <1592531704.23014.1.camel@mtkswgap22> <20200706182713.3693762-1-nhuck@google.com>
In-Reply-To: <20200706182713.3693762-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Jul 2020 09:45:55 -0700
Message-ID: <CAKwvOdmAsNsAMxAQdKdNHujDFhM_STdHj7d+q+2W=Q0N_spNrQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: stacktrace: Fix unwind_frame for clang-built kernels
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miles Chen <miles.chen@mediatek.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,
Would you please submit this to Russell's patch tracking system:
https://www.arm.linux.org.uk/developer/patches/
login -> add new patch.

On Mon, Jul 6, 2020 at 11:27 AM Nathan Huckleberry <nhuck@google.com> wrote:
>
> Since clang does not push pc and sp in function prologues, the current
> implementation of unwind_frame does not work. By using the previous
> frame's lr/fp instead of saved pc/sp we get valid unwinds on clang-built
> kernels.
>
> The bounds check on next frame pointer must be changed as well since
> there are 8 less bytes between frames.
>
> This fixes /proc/<pid>/stack.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/912
> Reported-by: Miles Chen <miles.chen@mediatek.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  arch/arm/kernel/stacktrace.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> index cc726afea023..76ea4178a55c 100644
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -22,6 +22,19 @@
>   * A simple function epilogue looks like this:
>   *     ldm     sp, {fp, sp, pc}
>   *
> + * When compiled with clang, pc and sp are not pushed. A simple function
> + * prologue looks like this when built with clang:
> + *
> + *     stmdb   {..., fp, lr}
> + *     add     fp, sp, #x
> + *     sub     sp, sp, #y
> + *
> + * A simple function epilogue looks like this when built with clang:
> + *
> + *     sub     sp, fp, #x
> + *     ldm     {..., fp, pc}
> + *
> + *
>   * Note that with framepointer enabled, even the leaf functions have the same
>   * prologue and epilogue, therefore we can ignore the LR value in this case.
>   */
> @@ -34,6 +47,16 @@ int notrace unwind_frame(struct stackframe *frame)
>         low = frame->sp;
>         high = ALIGN(low, THREAD_SIZE);
>
> +#ifdef CONFIG_CC_IS_CLANG
> +       /* check current frame pointer is within bounds */
> +       if (fp < low + 4 || fp > high - 4)
> +               return -EINVAL;
> +
> +       frame->sp = frame->fp;
> +       frame->fp = *(unsigned long *)(fp);
> +       frame->pc = frame->lr;
> +       frame->lr = *(unsigned long *)(fp + 4);
> +#else
>         /* check current frame pointer is within bounds */
>         if (fp < low + 12 || fp > high - 4)
>                 return -EINVAL;
> @@ -42,6 +65,7 @@ int notrace unwind_frame(struct stackframe *frame)
>         frame->fp = *(unsigned long *)(fp - 12);
>         frame->sp = *(unsigned long *)(fp - 8);
>         frame->pc = *(unsigned long *)(fp - 4);
> +#endif
>
>         return 0;
>  }
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
