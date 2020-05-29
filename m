Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC79C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF18207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqaXB7Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgE2TRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgE2TQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:16:58 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A593C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:16:58 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g5so2290700otg.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Xc0lhcTiVdyNEJ9vgqNoCxeQd0IZqdiHS4mWcX+XOo=;
        b=sqaXB7ZjmBNyRLggIIscCJP4Vi3jpjS3T9XTPNrzG0MgwBcxNfmunNCCV9nuuYCwQt
         Ccq8hl85J9y3Pj1MkyLFkYBaEnYUfxfXXaf7FJMLeYSQnDU2zmLk0osd5c5BijQWHJnJ
         lBaH5XVR8CS2T6xUpt4Tv7qphJzX29voGvC3sA+vIullnnFbo8k0vsI4HgeVjqRCdtxq
         nm0N8pDf0osOMUFm+MVsgaBepq5GqkF+wnpYRpKxXXlxZF7dXAA3/gdYv1f9b0xDQc8e
         oAAf//08S4rnp8yrWpLUSHX+QJSR00maC42j4mmtoI9SjxOyjRul/sr3YTZhuhXLxD4Z
         ajAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Xc0lhcTiVdyNEJ9vgqNoCxeQd0IZqdiHS4mWcX+XOo=;
        b=b9yv3unU092IOn5SgXE8eLphTroMTbTIv4v6h5y5HPTKIMa6FE2s+4Ez48mM6O9NU4
         lVVk0LnKK0S/76iCl+Grgo5jCRExHlS31LEJMaE+O4AcPH4RE6ZfUYZqpsCoiJzeRYKI
         Fmi+9Ks2eUO3rHOoiCxjrnXH2NpUe5DmnjhaddmLzbdgQDeDVPhJJ/bkZhq/xdJSY9jx
         9pgFKpyVHdO5FDOSVI6XOSNTpMeFr8ZfhhG4fwYAGbrI9B7VR8UG84jk+H+ht46pDJV4
         V55rdsDCULOVqP6iSqL8z78+/mqxYBR85gzznReb/ctAccxhGVG867ZzOCS5B0glxFo5
         Qsrw==
X-Gm-Message-State: AOAM531Rpdwf5XZPr5Knt790KhnLBw1upRDBxd3lyQwWW2BjuIRev/PJ
        4VQUMMVGL6cHMFI+NZsHdM9IZw3vI2x2e9iZAdQFbw==
X-Google-Smtp-Source: ABdhPJwUcbOTITcE9Bg0Z69NZnZGnO7QJZrYEkyoG16mHaSiOmFFUBTv9ayFI5nuulNEvAlH2UFpu5MxyT3J/6smlFc=
X-Received: by 2002:a9d:518a:: with SMTP id y10mr7801677otg.17.1590779817471;
 Fri, 29 May 2020 12:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <c2f0c8e4048852ae014f4a391d96ca42d27e3255.1590779332.git.andreyknvl@google.com>
In-Reply-To: <c2f0c8e4048852ae014f4a391d96ca42d27e3255.1590779332.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 29 May 2020 21:16:46 +0200
Message-ID: <CANpmjNM3TiVi3EXEND5KwCt0CNJ9xu2wFT=j79=j5C__QGd9EQ@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix clang compilation warning due to stack protector
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 at 21:12, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> KASAN uses a single cc-option invocation to disable both conserve-stack
> and stack-protector flags. The former flag is not present in Clang, which
> causes cc-option to fail, and results in stack-protector being enabled.
>
> Fix by using separate cc-option calls for each flag. Also collect all
> flags in a variable to avoid calling cc-option multiple times for
> different files.
>
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>
> Changes v1 -> v2:
> - Renamed CC_FLAGS_KASAN_CONFLICT to CC_FLAGS_KASAN_RUNTIME.

Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  mm/kasan/Makefile | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index de3121848ddf..d532c2587731 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -15,14 +15,19 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
>
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
> -CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> -CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> -CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> -CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> -CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> -CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> -CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> -CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CC_FLAGS_KASAN_RUNTIME := $(call cc-option, -fno-conserve-stack)
> +CC_FLAGS_KASAN_RUNTIME += $(call cc-option, -fno-stack-protector)
> +# Disable branch tracing to avoid recursion.
> +CC_FLAGS_KASAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
> +
> +CFLAGS_common.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
>
>  obj-$(CONFIG_KASAN) := common.o init.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>
