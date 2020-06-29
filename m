Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F232067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoCEwiDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgF2TdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbgF2Tcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61354C02A56D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:34:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so7121108ple.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UqCNZ+OTg1lzw/q2Kz2sA9G3h4mbPe/xzzDfR/Wl6o=;
        b=uoCEwiDCGEqtbe7O+Em8bzStBM5vKsAYjy8MoMFXisoatf8+XTf+LrMkC5VTawzwLX
         SSXx/hr7EtwZ12rlaxaID/8K3ZYsYMPMxZYfkgLnKptbkLt/0VrDUwfR+pm5TaM1uPvt
         A43qeOdeLNDUBAodtLWwre4CS6LwzTRSjqAeSu7iyS0bCxasJ5EP6PlaFtKreB56bhfd
         t4qjXFO0/sehcK29CoOm4TCk/IfanJKC3PGukuY1X2otfHa9MzoxRO1coKxiXHLMokr+
         uEBBJdQex0pl5UGlSC0UFZ0o+btw8jDnk4NqQvBITF9aRn92xPH3J5ec02+6MYCCe2Gy
         4HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UqCNZ+OTg1lzw/q2Kz2sA9G3h4mbPe/xzzDfR/Wl6o=;
        b=VNt/vE9Rp4Acyf/AhXJonOHTDGAzIosYl3O4OMBadnwWpwqr0ewShzqU3rLuDLIxvm
         3nyw6KsuxQTg8sjeEC6CtIiLNNnW/iEGRyIjiSo9zB6S7iVYATjKetlp6ovEMAde1hlJ
         7qKUyg0y4wkAIohLKGPIjIBJJz5G49cZyAWLEq5Z27C22ZACp1++li5Mt037TNOztO8w
         YxtpTnBaQFKc65OFAk2DePonHm2sup/+JsivJgBN7znO9jiNJRS09OyIVGXOwQXbYMjd
         bT4Vk4ib1E+ZAYBmnYjx3UFFlxwcsEWcSD2i7yX9URnkj7QC0J+gmMRM+B3UCaVKaNWE
         jYuQ==
X-Gm-Message-State: AOAM530fVL0A2YX9zQOKFp2QZ56cKMDvpUj9e5kQgSgylVKd1QkCJNM7
        IGpWqYmKNzAl3Va4qwPlBIf4lUHbMDrnmiCjdQC/JQ==
X-Google-Smtp-Source: ABdhPJyyemzBk8k+EQj691PWuk6+4I3GKU57Y8C1zgPV7Ot5fRccf1akeHSxr5QncO44LEIGHn+Chol5ExPGybUsiX4=
X-Received: by 2002:a17:902:6ac1:: with SMTP id i1mr14053992plt.147.1593437689499;
 Mon, 29 Jun 2020 06:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200629104157.3242503-1-elver@google.com>
In-Reply-To: <20200629104157.3242503-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 29 Jun 2020 15:34:38 +0200
Message-ID: <CAAeHK+wbaHoeEqaKCNgPhFFWQZ0Ck2BYF9QiCcOuyB9JGDmhsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: Improve and simplify Kconfig.kasan
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Axtens <dja@axtens.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:42 PM Marco Elver <elver@google.com> wrote:
>
> Turn 'KASAN' into a menuconfig, to avoid cluttering its parent menu with
> the suboptions if enabled. Use 'if KASAN ... endif' instead of having
> to 'depend on KASAN' for each entry.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/Kconfig.kasan | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 34b84bcbd3d9..89053defc0d9 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -18,7 +18,7 @@ config CC_HAS_KASAN_SW_TAGS
>  config CC_HAS_WORKING_NOSANITIZE_ADDRESS
>         def_bool !CC_IS_GCC || GCC_VERSION >= 80300
>
> -config KASAN
> +menuconfig KASAN
>         bool "KASAN: runtime memory debugger"
>         depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
>                    (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
> @@ -29,9 +29,10 @@ config KASAN
>           designed to find out-of-bounds accesses and use-after-free bugs.
>           See Documentation/dev-tools/kasan.rst for details.
>
> +if KASAN
> +
>  choice
>         prompt "KASAN mode"
> -       depends on KASAN
>         default KASAN_GENERIC
>         help
>           KASAN has two modes: generic KASAN (similar to userspace ASan,
> @@ -88,7 +89,6 @@ endchoice
>
>  choice
>         prompt "Instrumentation type"
> -       depends on KASAN
>         default KASAN_OUTLINE
>
>  config KASAN_OUTLINE
> @@ -113,7 +113,6 @@ endchoice
>
>  config KASAN_STACK_ENABLE
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> -       depends on KASAN
>         help
>           The LLVM stack address sanitizer has a know problem that
>           causes excessive stack usage in a lot of functions, see
> @@ -134,7 +133,7 @@ config KASAN_STACK
>
>  config KASAN_S390_4_LEVEL_PAGING
>         bool "KASan: use 4-level paging"
> -       depends on KASAN && S390
> +       depends on S390
>         help
>           Compiling the kernel with KASan disables automatic 3-level vs
>           4-level paging selection. 3-level paging is used by default (up
> @@ -151,7 +150,7 @@ config KASAN_SW_TAGS_IDENTIFY
>
>  config KASAN_VMALLOC
>         bool "Back mappings in vmalloc space with real shadow memory"
> -       depends on KASAN && HAVE_ARCH_KASAN_VMALLOC
> +       depends on HAVE_ARCH_KASAN_VMALLOC
>         help
>           By default, the shadow region for vmalloc space is the read-only
>           zero page. This means that KASAN cannot detect errors involving
> @@ -164,8 +163,10 @@ config KASAN_VMALLOC
>
>  config TEST_KASAN
>         tristate "Module for testing KASAN for bug detection"
> -       depends on m && KASAN
> +       depends on m
>         help
>           This is a test module doing various nasty things like
>           out of bounds accesses, use after free. It is useful for testing
>           kernel debugging features like KASAN.
> +
> +endif # KASAN
> --
> 2.27.0.212.ge8ba1cc988-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
