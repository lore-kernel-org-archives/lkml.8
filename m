Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD301C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C6B21741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWARtL0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBHHyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 02:54:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38579 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBHHyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 02:54:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so5132968wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 23:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TqSOzSAKSsYvnnzVEi6urtzhXp7OVeHxDe+9KpIZTA=;
        b=rWARtL0ukHQNT+TvxZs4+kgMqutC0CeHhMoIImJkHjHbjuSMGdKEaRE5StVVfC0QJv
         tjE9kWjEJE+cmubyMlDpX0/rrqdN6to5mwVx5uJ5/Xwdu0Sy/KwVMWmeXQYiAyVhKTSS
         bfr8u9vuJSFc/QbXQ16RShd17CYFyMZ7Jo/Qab7ehHCnwuLXTZ9iISvsFCZM+uiMsn95
         1P6lmVqElXlhFF5AJJlDpHrKO0PgkaOU1+3U6aJPqB0YKyP7GMLhQ0HQAP5kUt5jOHPB
         jcboylyGULeGJ2jr0i65e/J52lVeSn35T8xmCN8V2Zq2v68tocyXlS817obp+iWH9TzC
         P95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TqSOzSAKSsYvnnzVEi6urtzhXp7OVeHxDe+9KpIZTA=;
        b=prAGM8iONUqyd+DrcRANJbJaxUrZZwp3LLHpL3UaqYVcgJFGbixgoBcsanIfrOD2uU
         QnQCW1IEFt3OSbCSSqC2sNNwM+zSz6JByf9BhHWVj5ilmB7XBvRTdMxHHfi6+kpo2Ri3
         00KNvVS16c/bxGmJWzLUICUoQZw/TCcaapdW0/QHoNVfNAW7gze34qXyK/Dypc/kXrRV
         hId2B7o3F+RU7+eP/in0PEWrHavFyeW+nYZY1q5D7PCCIRYqNw/9yjW7WDBKkhepLEzj
         im5x6QjgYVCsz4+rL97X88rVgHYEwrQm1dfv3tFHesaweUupgYVL8rQ/6ilM8qeK9oXT
         Mpbw==
X-Gm-Message-State: APjAAAVM4KbuupQ/g2MTt002Pk4PzFHkIR+mo6Gla2YOQ91T3s0PvIAk
        ux3S3tR1l1wJbT3/ERwejhU3xeUHfqy6MkPQq2Bs5Q==
X-Google-Smtp-Source: APXvYqynvhr5YGpRwcBYP4yDLNbMRX0LTg2KUMPlXfyWVZaJCpY1l4H20puJJGHrcYZXRtch/ngUJNQNXHmz5wJ6Zfg=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr3328511wmk.68.1581148490179;
 Fri, 07 Feb 2020 23:54:50 -0800 (PST)
MIME-Version: 1.0
References: <202002071754.F5F073F1D@keescook>
In-Reply-To: <202002071754.F5F073F1D@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 8 Feb 2020 07:54:39 +0000
Message-ID: <CAKv+Gu8Wt-QX1+9E+QCk30CAttkXP2P5ZKQACqeMDFGeQ9FCKA@mail.gmail.com>
Subject: Re: [PATCH] ARM: rename missed uaccess .fixup section
To:     Kees Cook <keescook@chromium.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Feb 2020 at 02:02, Kees Cook <keescook@chromium.org> wrote:
>
> When the uaccess .fixup section was renamed to .text.fixup, one case was
> missed. Under ld.bfd, the orphaned section was moved close to .text
> (since they share the "ax" bits), so things would work normally on
> uaccess faults. Under ld.lld, the orphaned section was placed outside
> the .text section, making it unreachable. Rename the missed section.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/282
> Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c44
> Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.1912032147340.17114@knanqh.ubzr
> Fixes: c4a84ae39b4a5 ("ARM: 8322/1: keep .text and .fixup regions closer together")
> Cc: stable@vger.kernel.org
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: Manoj Gupta <manojgupta@google.com>
> Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

As Nick points out, the *(.fixup) line still appears in the
decompressor's linker script, but this is harmless, given that we
don't ever emit anything into that section. But while we're at it, we
might just remove it as well.


> ---
> I completely missed this the first several times I looked at this
> problem. Thank you Nicolas for pushing back on the earlier patch!
> Manoj or Nathan, can you test this?
> ---
>  arch/arm/lib/copy_from_user.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 95b2e1ce559c..f8016e3db65d 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -118,7 +118,7 @@ ENTRY(arm_copy_from_user)
>
>  ENDPROC(arm_copy_from_user)
>
> -       .pushsection .fixup,"ax"
> +       .pushsection .text.fixup,"ax"
>         .align 0
>         copy_abort_preamble
>         ldmfd   sp!, {r1, r2, r3}
> --
> 2.20.1
>
>
> --
> Kees Cook
