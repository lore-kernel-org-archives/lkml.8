Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7A320776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bw8wnVbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgE2O41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2O41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:56:27 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B5C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:56:27 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a7so2428515oic.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTRjknFZ9qzPfihryROjWMbhSeglLc+Gkjpy43aIAlk=;
        b=Bw8wnVbkJ4eFG5S0/yvHVX3yM808HVhZWnbP0E4cwEACib0swhqcBFNyibum2MJNvJ
         X9cloOyMS5BoAvjgYih03f1Hx+hqv0+1LfiJqqfUAbvLShlO3RDnNrEPFXrOSgpw1oB9
         d7ZhoA9CSxzCirz8GdpTLOpaVMUY+W5ZgvaisubXYQxx/QMEdw4hFqS2i9hiGvm9QVkc
         AVx2yhw1E09qnmkhBl0YtwDUyUFhZaxB3iFAxB4GJ6PTgdf6jliEMTxQ+sqNZR22+Q9X
         3Y4kJMW2QH2d9d8mIf25Lo+f7CEJDAQ2Rsbd/9NnkRR4oSkvdHtzbLIM5VE3JPlyzZWQ
         Vxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTRjknFZ9qzPfihryROjWMbhSeglLc+Gkjpy43aIAlk=;
        b=YJUopMJ6qp4h3a+676tr9WKhA0zhSUsBAw1Tmv+thJS0xwWtH+wH1dRSBsTFcMa4r/
         i6Bw0A7vZ+gsZMj4UJeG+CWmGBQ2lixTJaEuBT1TUPtDUwgcevdNPGlcW/WDN7QLUebP
         gBy3FP0RXy3aO0VxqMmZ6nRnlcqZvnN20kVKlyMLyNpqRSDIKvL+mngUGkrxU9HQxpfU
         X9PY3EvI7YHgscBN4iIbGQ6RPr5JHJR9rDqlGzbqTh+gIkqVAzA/0CplxHSy43gWTlo/
         5hfy55KZFXq+wF4ZrnJOMJN6Vp0WLMrWghhVIeTQGlM71ZSYGlGJVMbPdxySrHcHQn4L
         hskA==
X-Gm-Message-State: AOAM533ugxG8MS9qB/m1YQVTRdSFb57YNWXtCVaAmGCtJ6PM3F2u861k
        +dWk42BKLpKlX3gDU1jhq1HffIlZKxrBylzfp5mL8Q==
X-Google-Smtp-Source: ABdhPJzvuCFWLwd57Rq4aTjv56+LZIwQNvyNu6px1dmLEfT7QLAv22678ajvzbs/WC7gzKZmUrEh8SYPXBfHanwvfrU=
X-Received: by 2002:aca:d0d:: with SMTP id 13mr6056826oin.172.1590764181216;
 Fri, 29 May 2020 07:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <ced83584eec86a1a9ce264013cf6c0da5e0add6a.1590686292.git.andreyknvl@google.com>
In-Reply-To: <ced83584eec86a1a9ce264013cf6c0da5e0add6a.1590686292.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 29 May 2020 16:56:09 +0200
Message-ID: <CANpmjNPr5MrwPFOW10pRkUgxwktXNiUweNj+pGJMunoZKi7Cdw@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix clang compilation warning due to stack protector
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

On Thu, 28 May 2020 at 19:20, 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
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

Thank you! I was about to send an almost identical patch, as I
encountered this when using clang.

Reviewed-by: Marco Elver <elver@google.com>

>  mm/kasan/Makefile | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index de3121848ddf..bf6f7b1f6b18 100644
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
> +CC_FLAGS_KASAN_CONFLICT := $(call cc-option, -fno-conserve-stack)
> +CC_FLAGS_KASAN_CONFLICT += $(call cc-option, -fno-stack-protector)
> +# Disable branch tracing to avoid recursion.
> +CC_FLAGS_KASAN_CONFLICT += -DDISABLE_BRANCH_PROFILING

Note that maybe CC_FLAGS_KASAN_RUNTIME could be a better name, because
other flags added in future might not be conflict-related. But until
that future, it doesn't really matter.

> +CFLAGS_common.o := $(CC_FLAGS_KASAN_CONFLICT)
> +CFLAGS_generic.o := $(CC_FLAGS_KASAN_CONFLICT)
> +CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_CONFLICT)
> +CFLAGS_init.o := $(CC_FLAGS_KASAN_CONFLICT)
> +CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_CONFLICT)
> +CFLAGS_report.o := $(CC_FLAGS_KASAN_CONFLICT)
> +CFLAGS_tags.o := $(CC_FLAGS_KASAN_CONFLICT)
> +CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_CONFLICT)
>
>  obj-$(CONFIG_KASAN) := common.o init.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/ced83584eec86a1a9ce264013cf6c0da5e0add6a.1590686292.git.andreyknvl%40google.com.
