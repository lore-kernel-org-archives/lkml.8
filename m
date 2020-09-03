Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21ECC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F6E20658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnlOmX22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgICO65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgICOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:07:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F979C06123D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 07:06:56 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a2so2777023otr.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5ObVubezy/CF71fQSZkxZrEK4lO9ry8fuSW6qb1uHYU=;
        b=mnlOmX22+hb4jFyQYUkirTEFlCInl5pcZghHXo2F+tk94ARUGRgWm910cEgAi4fnAf
         4bkelPrscOnG8hwGT2fAJPFtjR0iqCi0qoSFBKJG5ajyD2IxRyHqT3XE1RJAMdC9fXmX
         Nl/ktCAtkX5wB8kN9by7WtfJ2xYyJ+2gIWzgY+3IQGWMMTkg4GpZqWK2LMdjsKRS2r+W
         Qx6Mm3V7A861hOev6gpqDTdZwbTKiCDLRntUnY3NK0G6ObxvHHFvzyKhZqSP4/jM/e5M
         FT+Viz27/iPKwZEfbJd8eXSLBW7vEc2L2UEot5RGrI5ZNRTPowTALru0cEwggNEwsAGt
         fZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5ObVubezy/CF71fQSZkxZrEK4lO9ry8fuSW6qb1uHYU=;
        b=lazUrVu12GxSMgGtVfkRUPI68ro3P33des5bcVkGb/ZK4o3uM7iWV6IgL7FqBNDNpl
         t/3mHSZJpXPEN7V1J0UdswTtTqBLRFhYnWY8lz5E5geLrvOs/o5wlpsRdc9B2sdNR0M8
         Q3n3fg2I8gpiAkQqOWpqdHNeMUFTc8MG5tM7Nw77CDBIUNIybKhc6Hga6kvW+Ug+BEpU
         eTd/owpbFBWcNCiv9Jrw0L3JBVQZVzmzBb0w22G3jYjfA5gcd7xarTe7h+rBZzohqiUH
         qn9KOhunwSE+34yjQf1jT72KTBFTNRiSTKP9T12sPXTDam+2h/0cKlScBMeo5B/EQo6n
         6BYw==
X-Gm-Message-State: AOAM5333KB2vheZ9X/xRci2rierKlfLBjx+Z7rHDRWu7F2xyy9xtMbfA
        RrHOGj8xRJfBTaf0yG85ZF9GQge7hLeJRj7Qh7yFMmJtDqg=
X-Google-Smtp-Source: ABdhPJzkhlIwpHkxQ87E0m/GK+QpChX0xde9XCcp7C2AaJK+UlzZjod+IAmt6DqC8fetNN2Wvwo8zD0uvw/QY25VAys=
X-Received: by 2002:a9d:7656:: with SMTP id o22mr1649411otl.109.1599142015719;
 Thu, 03 Sep 2020 07:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
In-Reply-To: <20200902225911.209899-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 3 Sep 2020 16:06:43 +0200
Message-ID: <CA+icZUXCLyGmYCnHSBJ+8s5QdbPRr+fsfpW43M7pYFEDFOOdJA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] set clang minimum version to 10.0.1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 12:59 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Adds a compile time #error to compiler-clang.h setting the effective
> minimum supported version to clang 10.0.1. A separate patch has already
> been picked up into the Documentation/ tree also confirming the version.
>
> Next are a series of reverts. One for 32b arm is a partial revert.
>
> Then Marco suggested fixes to KASAN docs.
>
> Finally, improve the warning for GCC too as per Kees.
>
> Patches after 001 are new for v2.
>
> v3 just collects tags and fixes typos in a few commit messages.
>

Through which Git tree is this patch-series going through?
Do the new LLVM/Clang maintainers already have their own Git tree @
git.kernel.org?

Is this patch-series material for Linux v5.9 or v5.10?

- Sedat -

> Marco Elver (1):
>   kasan: Remove mentions of unsupported Clang versions
>
> Nick Desaulniers (6):
>   compiler-clang: add build check for clang 10.0.1
>   Revert "kbuild: disable clang's default use of -fmerge-all-constants"
>   Revert "arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support"
>   Revert "arm64: vdso: Fix compilation with clang older than 8"
>   Partially revert "ARM: 8905/1: Emit __gnu_mcount_nc when using Clang
>     10.0.0 or newer"
>   compiler-gcc: improve version error
>
>  Documentation/dev-tools/kasan.rst | 4 ++--
>  Makefile                          | 9 ---------
>  arch/arm/Kconfig                  | 2 +-
>  arch/arm64/Kconfig                | 2 --
>  arch/arm64/kernel/vdso/Makefile   | 7 -------
>  include/linux/compiler-clang.h    | 8 ++++++++
>  include/linux/compiler-gcc.h      | 2 +-
>  lib/Kconfig.kasan                 | 9 ++++-----
>  8 files changed, 16 insertions(+), 27 deletions(-)
>
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
