Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7039AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B37E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMnXpMZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgFOTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgFOTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:04:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:04:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i4so262585pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9aW2TqrBLH8LeFdcz9gJFpsSwBcZN5ImxsbMz/APSqI=;
        b=lMnXpMZZ28eB1AUnoYs0tMCcfdx9eomDMjAwwW3tQo1QWecVxMGf4Z9oaZqZ0DSC9J
         2kdu8TS9YCnn3/TZaRoxoLXK308sh0TkEM2S9r1iOsf5XFgv1gHIODJ2b1KSLoDQU2gr
         2GkTorHfQSznZssJuKgKDyKM2FHoLNgGsjtxAaSGs39xQuzdBO8oFjHZRCA1vzJmkHuE
         FrP7hVmxLNMjj55B8KoaF5Zzn5gLiy03derdrZFzbR+UtzN3f/tpmNXR7KuPoQQBbFB2
         zD6DWqxILh+69QkSkIQYbHTSGhmqUbWK5DPPtTDnPrfIO6PmhLpzTNAl2BoKwml1HovC
         CzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9aW2TqrBLH8LeFdcz9gJFpsSwBcZN5ImxsbMz/APSqI=;
        b=YLsTz7OnjXL+/vF42BKFwlxXP58N0X75Za4xGMPdnRene/GiJeaVWBhs0DOnqQpWKB
         dhBNlko+WgsBx/Hj7fOCtwyt1Tn4yXhv10/0mL3UkaTHbcjg1aENnm63lup2fnOWaUoa
         EU+KRp8yLaOc1FBBay8ulfXNEu4XJvq7mcLknh52QhK1MWPrTDSWI1fW9zq1FNzEJyCg
         bTugk9Er8E53cpaxoD6HE0s3VICeMFEHZ40xxf5uC69UDsmwF7FbcGBq/jxhkEBOJAra
         WbK9u5zNu9mroYRJu90xQlpnkmLZpRA0fg7R9op4xV7FeOakrzYRAo6x1X44tLJyPhCg
         pDeg==
X-Gm-Message-State: AOAM530Aj6fiNSMNpzB6qbHNZlN2tqSX2ipk7TReFG6EmoBJZfGsAl9k
        mSEXmLIcvELTMNr1F6ISz3j1U+RkGiJ53XOibe4Si530EHQ=
X-Google-Smtp-Source: ABdhPJylLhumge3iLMOwdrqKasfZc2kbu7Zpnn7izPXUiTo/OOS+izBX7wRfEj0QlmWA813ZcGQ3QUzhmD/VSOhu3wk=
X-Received: by 2002:a17:90b:1244:: with SMTP id gx4mr707505pjb.136.1592247864399;
 Mon, 15 Jun 2020 12:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200615184302.7591-1-elver@google.com>
In-Reply-To: <20200615184302.7591-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 15 Jun 2020 21:04:13 +0200
Message-ID: <CAAeHK+zdNpMhpaHRYHxc9a5ghp4MBR3ecxxWem8-yrNFLYTFEg@mail.gmail.com>
Subject: Re: [PATCH] kcov: Unconditionally add -fno-stack-protector to
 compiler options
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 8:43 PM Marco Elver <elver@google.com> wrote:
>
> Unconditionally add -fno-stack-protector to KCOV's compiler options, as
> all supported compilers support the option. This saves a compiler
> invocation to determine if the option is supported.
>
> Because Clang does not support -fno-conserve-stack, and
> -fno-stack-protector was wrapped in the same cc-option, we were missing
> -fno-stack-protector with Clang. Unconditionally adding this option
> fixes this for Clang.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Split out from series:
>         https://lkml.kernel.org/r/20200605082839.226418-2-elver@google.com
> as there is no dependency on the preceding patch (which will be dropped).
> ---
>  kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index f3218bc5ec69..592cb549dcb8 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -35,7 +35,7 @@ KCOV_INSTRUMENT_stacktrace.o := n
>  KCOV_INSTRUMENT_kcov.o := n
>  KASAN_SANITIZE_kcov.o := n
>  KCSAN_SANITIZE_kcov.o := n
> -CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> +CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
>
>  # cond_syscall is currently not LTO compatible
>  CFLAGS_sys_ni.o = $(DISABLE_LTO)
> --
> 2.27.0.290.gba653c62da-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
