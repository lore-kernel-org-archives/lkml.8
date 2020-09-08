Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB757C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C49F2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsHA4dEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgIHJjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgIHJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:39:27 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A6C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 02:39:24 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x14so15859846oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti/MkgxNUqOT9JqnKGwbINcNBIfh+eLyLU5FCjEJEmk=;
        b=DsHA4dEcxSSp8Gu6WKRrd28BfZSrzJmdbmlAQ2G0wgEeH2V5GJuFe2onHTWcSrAF9J
         ++n+zhcSEnqesz6SOc4szXf2BevJ1HUMg5bdRcp3LKkJruVbN5kOJkFcck2w1KC/aaxC
         g/eYlUfniEI2sFVLsNw2yZaGPrj8voB9/qfQiNrXJMz5uT77l2pBmOBdoU0Q/ry/28H1
         uRXd6tw8FHgA93WbFgi74PAJFZQUCp4CKw3OqHAIywym0aSuGPNADCzM+UzBDCs21sI0
         uXR4m0q+SB1DIP7qfr6MJqcpA+a8/KnwEWqCdqjxT9AvQKgHjXZP69WlqEv14sRCrKW2
         dmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti/MkgxNUqOT9JqnKGwbINcNBIfh+eLyLU5FCjEJEmk=;
        b=FX145qD9VZcl9746Z7h2SbUkD48VAbnHYhOMzm+dOLfgy6dHVqchz6I/tnzaoXLp/x
         FZg3NGNvnwiS70sxTHY1wxssjJE+3K5nXhanzBhe1jh0xiWsWSnIQgFX7NzIKVUlFDFc
         oNUHC+db/+ovRTwd5YK/nbzhE6sMAtj5GLVawPUkV8MJWUithsInzjyR8to4xq/JVCjd
         YjZeEon2SYIcfVPvEDh7f+5+BPnHL71L10QrQ8/gGihC3KMmRKcoj9W99sjzR/pSgh5f
         Vwtv0DoOi+AQ72DobqfldzxFXSh/9v0D4K9xnHWKhZxPb14DsFgrUl3LSEd1pf9a+A/h
         +L1Q==
X-Gm-Message-State: AOAM533zBMZpkeZGdaawOtVcbM419jOkdwXLY642pkNJqkdMkkGRxgjh
        Tj0k7RjUasx38hHTNzNIEQPwhnpzglE3Kg3zSgHiiA==
X-Google-Smtp-Source: ABdhPJzK1Sxw+zo3XwEojt6gb+U3eyOsZcMfWVWUqoXe6fXqfYXCrhFBy6tRra7kXM5QBRMdWw+Q3z8oJq5hnS6jfsk=
X-Received: by 2002:aca:54d1:: with SMTP id i200mr2085966oib.172.1599557963595;
 Tue, 08 Sep 2020 02:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200905222323.1408968-1-nivedita@alum.mit.edu> <20200905222323.1408968-2-nivedita@alum.mit.edu>
In-Reply-To: <20200905222323.1408968-2-nivedita@alum.mit.edu>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Sep 2020 11:39:11 +0200
Message-ID: <CANpmjNMnU03M0UJiLaHPkRipDuOZht0c9S3d40ZupQVNZLR+RA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lib/string: Disable instrumentation
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Sep 2020 at 00:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> String functions can be useful in early boot, but using instrumented
> versions can be problematic: eg on x86, some of the early boot code is
> executing out of an identity mapping rather than the kernel virtual
> addresses. Accessing any global variables at this point will lead to a
> crash.
>
> Tracing and KCOV are already disabled, and CONFIG_AMD_MEM_ENCRYPT will
> additionally disable KASAN and stack protector.
>
> Additionally disable GCOV, UBSAN, KCSAN, STACKLEAK_PLUGIN and branch
> profiling, and make it unconditional to allow safe use of string
> functions.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  lib/Makefile | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index a4a4c6864f51..5e421769bbc6 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -8,7 +8,6 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
>  # These files are disabled because they produce lots of non-interesting and/or
>  # flaky coverage that is not a function of syscall inputs. For example,
>  # rbtree can be global and individual rotations don't correlate with inputs.
> -KCOV_INSTRUMENT_string.o := n
>  KCOV_INSTRUMENT_rbtree.o := n
>  KCOV_INSTRUMENT_list_debug.o := n
>  KCOV_INSTRUMENT_debugobjects.o := n
> @@ -20,12 +19,16 @@ KCOV_INSTRUMENT_fault-inject.o := n
>  # them into calls to themselves.
>  CFLAGS_string.o := -ffreestanding
>
> -# Early boot use of cmdline, don't instrument it
> -ifdef CONFIG_AMD_MEM_ENCRYPT
> +# Early boot use of string functions, disable instrumentation
> +GCOV_PROFILE_string.o := n
> +KCOV_INSTRUMENT_string.o := n
>  KASAN_SANITIZE_string.o := n
> +UBSAN_SANITIZE_string.o := n
> +KCSAN_SANITIZE_string.o := n

Ouch.

We have found manifestations of bugs in lib/string.c functions, e.g.:
  https://groups.google.com/forum/#!msg/syzkaller-bugs/atbKWcFqE9s/x7AtoVoBAgAJ
  https://groups.google.com/forum/#!msg/syzkaller-bugs/iGBUm-FDhkM/chl05uEgBAAJ

Is there any way this can be avoided?

If the use of string functions is really necessary, we could introduce
'__'-prefixed variants (maybe only for the ones that are needed?),
a'la

static void __always_inline strfoo_impl(...) { ... }
void strfoo(...) { strfoo_impl(...); }
EXPORT_SYMBOL(strfoo);
noinstr void __strfoo(...) { strfoo_impl(...); }
EXPORT_SYMBOL(__strfoo);
// If __HAVE_ARCH_STRFOO then we can probably just alias __strfoo to strfoo.

But if the whole thing could be avoided entirely would be even better.

Thanks,
-- Marco


>  CFLAGS_string.o += -fno-stack-protector
> -endif
> +CFLAGS_string.o += $(DISABLE_STACKLEAK_PLUGIN)
> +CFLAGS_string.o += -DDISABLE_BRANCH_PROFILING
