Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A78C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4B2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nufeHlQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgFQEYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgFQEYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:24:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB7C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 21:24:01 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q8so1237380iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 21:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qnyhMMIEN0LrK0bROeu2AicdajFIxeITYjNsoHRgC8U=;
        b=nufeHlQ+xs1/zH/m/xtBaDN2m0JgiiUl7Wu3rP4N8z3WkDzhLoj21XpHN2NG386Hsm
         hmXxXQGLHDNFtUBZRgP2U/FAY3zrMGXf9gUI7N6wpsLwgTuaeCFAbO/4ctgt7XP7qXmT
         MzONHz5hsVNIgP90DFzJCOoA05nCbJWYz2jIAwLCTvldLhFSbmF4+kr1QLdvJCuSiWfG
         44pTap6vEFqEZo7RcDJirK6m8XuQydmfcFb+LpBOx5lCfr/yEqnTMGPUjYO2LYk0X5lJ
         QmbaCHJspStHUqXAiu9+eHrK73JZA2PutbiE6LuG9NjKEKqKqAETNGx+FWJ5jXwDxDGb
         49SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qnyhMMIEN0LrK0bROeu2AicdajFIxeITYjNsoHRgC8U=;
        b=PsrXxbb9W/lDM2qt/LHhIIq2+szd6PI8RkppQ5xf0dLb7jWtWpbzk+k3Rznx3O6Aj0
         m/ywka4OfLxmAa8b5MG/iOid/PrnRsShR4UKjE/+SS9UfYUUJHt0oOjYy4G2fsL2vryw
         95277ZYV2hCXEQTORZvYmlWlwvmAK+v6XnTEznolXvWTcDGaN4LeSCfUGwCG2XGFF4Qe
         WA6CxpfR7rGl3Zdww7SeCiRrPJ+BmTghBdLBvuKBSHufuUO8Pv/S8eh35j7zMmYv8NqR
         Ug5AK8groVLpcXEvhfE1EoNe3eH5EBB9naKxYgYjtaxGbjlBmwQzPHsq4Y08aC62RwIP
         MKCg==
X-Gm-Message-State: AOAM530S/m1WdNPP64mSN22Ff/H2zdFemOJywjfeBZITWIjJRhXFVriy
        MUnWndpzm95mE8SPssMIhppma8MwYah5j1ZfFsI=
X-Google-Smtp-Source: ABdhPJz/K2qXUqRHjBV/LroAG+ddFcf6lDuQMXgC6ECLEuTBBbDkmXm8wh92hdHPJtYTo1J8chzIQRHjdjVxqbq2di0=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr6354932iov.80.1592367840047;
 Tue, 16 Jun 2020 21:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200616223633.73971-1-nhuck@google.com>
In-Reply-To: <20200616223633.73971-1-nhuck@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 17 Jun 2020 06:23:48 +0200
Message-ID: <CA+icZUW4Jv7589yCU55+C-P0=B0ztzvsOZ9TEMcTt4vKjFU1dA@mail.gmail.com>
Subject: Re: [PATCH] Fix unwind_frame for clang-built kernels
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     linux@armlinux.org.uk, vincent.whitchurch@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:36 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
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
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Just a small nit.

Please label your patch with: "arm/stacktrace: ..." or "arm: stacktrace: ..."

git log --oneline arch/arm/kernel/stacktrace.c
...is your friend :-).

- Sedat -

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
> 2.27.0.290.gba653c62da-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200616223633.73971-1-nhuck%40google.com.
