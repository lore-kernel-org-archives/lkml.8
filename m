Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204AA20758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHczdhHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgESVF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:05:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0AC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:05:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so406993pgm.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAwUQNuHSy6Ybc5wRFORWg7jUHg+WoIVkThuFrr1qaY=;
        b=JHczdhHqwHYzn7QC3lQ50mLKHxj5rSbqKh2dG7kr5iitxnv3LOJivjRGJSJ7IhkIyc
         p3BQKH8GIxZRjKPN41CX9TJq/diDBntuBCHKTUQta19KKhoyto4+LXcD7E1pE3DGcE95
         bSFSVMHX1pmFD6/7ZbzVrExuN1JZVnwa6rIbAzLgFawXoHkbyAzTynGOAUSohiJdnbcA
         IGS+WnYdqHM5V6xvzkzXq9A3mFYY5JZbfk7IY85eh3/DwYFygbTm8jO1MQQVk9mDQmxf
         CiQjN0VdLdrW6hV1/WkAZRT//hJqF8uVoX3vKuR1AgZ9ZNgYMNQUFXM7EBAAcuwuRj/h
         mjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAwUQNuHSy6Ybc5wRFORWg7jUHg+WoIVkThuFrr1qaY=;
        b=UMgdPX/XgZc0DNkWCX2VM6X0PkGDbS5UHdiEawNP5Vf6cTJYTJbSUeoK1EoDa0I0+p
         5KKZhDnBYMB8/+S6LBSMeqWnFAMaKmxPxForNU1DmyUI6Qs5JsIV+8DrtenVC4XuHzEY
         tkS6zHptF2hcvddKHUBmpLpht5a8a/xCUpM+Mdq94iK6kO1vO5DdhxN8rGuZBl3mpPy+
         qVvF8dgzZqs2Lp1CAQHsACLmURSbnaUEmNIQOnSqZpiUSMdDeaCYcct5tUdlzEXE5JEt
         DS3aP2zRFAYLZ9D8PknhkN6Cws4ENDA1sP5DizXP2SmuOcybRWCo9M2C6gvQ83nhpw7C
         tzFQ==
X-Gm-Message-State: AOAM533JJxT1FRwOj6DzEIHbweG+W7tKOue5i35Om4+eJu+XijeAFXri
        01U1888NLDX+WPyZcmBCAbX1uan4C8VQhUmRQ/zpNQ==
X-Google-Smtp-Source: ABdhPJx+hHEmFNLYtQfsF2N+ckL+kDTsB3iOv+fjCxCZt6tEuTwRQbefgSTruhEpXmbUKSlA2ZnKNtPUTPO7kDDeRfk=
X-Received: by 2002:a63:2bd3:: with SMTP id r202mr1039983pgr.130.1589922357767;
 Tue, 19 May 2020 14:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200519182459.87166-1-elver@google.com>
In-Reply-To: <20200519182459.87166-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 May 2020 23:05:46 +0200
Message-ID: <CAAeHK+wcrmo=Hhwvqzd8kC-=5UR+fzRcA_4mo8wccWCTdrEzEQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Disable branch tracing for core runtime
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 8:25 PM Marco Elver <elver@google.com> wrote:
>
> During early boot, while KASAN is not yet initialized, it is possible to
> enter reporting code-path and end up in kasan_report(). While
> uninitialized, the branch there prevents generating any reports,
> however, under certain circumstances when branches are being traced
> (TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
> reboots without warning.
>
> To prevent similar issues in future, we should disable branch tracing
> for the core runtime.
>
> Link: https://lore.kernel.org/lkml/20200517011732.GE24705@shao2-debian/
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/kasan/Makefile  | 16 ++++++++--------
>  mm/kasan/generic.c |  1 -
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 434d503a6525..de3121848ddf 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -15,14 +15,14 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
>
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
> -CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> -CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> +CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
>
>  obj-$(CONFIG_KASAN) := common.o init.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 56ff8885fe2e..098a7dbaced6 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -15,7 +15,6 @@
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -#define DISABLE_BRANCH_PROFILING
>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> --
> 2.26.2.761.g0e0b3e54be-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
