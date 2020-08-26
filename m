Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F9821741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUwcXI8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgHZNgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbgHZNgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:36:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54ECC061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:36:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kx11so873332pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SP5d3jG0vnXwMEQbip8bqbDIaxrDFT2DZzwmlreys9g=;
        b=FUwcXI8S8muSj7MVzzGKs+YctUqEEY5UV/FKoUXmhe1EoJXyEIVwoaLJPj0FHphXBX
         +fqWeMmU/0aL42b9epfEWZedvmpCj80qY+WGdrLpUcKaIMgNqkC8C5n2fACBER2q2n2K
         rm72ABEAU6bi+uWz9kF7CYQgrVe2VAPDLiG9Zne/DCeAnnzgmCI9B264omQ9JwFYTPeW
         QWiNk63gesvxyPy5tITjH0DtrThCh2pZYKkNxU5ckelYKRKsOqtr0lbrK/rRHjW80XkZ
         RCLuadhJpyynt/wdxdNlkI41Y2C5ILXeKWN/kpYbgiKCWSonFiAIFwTfqETuJw7u1DdP
         I1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SP5d3jG0vnXwMEQbip8bqbDIaxrDFT2DZzwmlreys9g=;
        b=ZfMDSyGc8RyUA4NajbikYVr3HHWyTLyx6p9fusVLGZGOaAgreA5YJvKcjzvo4q74J8
         0Z5K4bW//WW6lvovz7fxCnkTI1UdS4BXW/Fs5r3czxaNEm3VGkb32SSogpaSUGkuO+cW
         mgNgfVba/9WDyJVmclHpAlTCKNYrRvLUAQb+rdWhkQ7Nu5OPEMnXbtBnPNyCZUPL9tnN
         cxnlpmcRabWlxG+F1EOjvdhJznek45Ih4d7UKLtrKfMllYNsKJzD5DbWJJXvc9cb73KI
         blBKanqLfF9JMCjTqpv8+nkO7dn1QKuaUcvatgO+b3Hs9pAD6fK/NOpKl8JB1JOHQf7t
         4fug==
X-Gm-Message-State: AOAM530UtkXrJjCH43oQ12j1qqsiAIX3lZRtWLkh8JZaLOVK+2B7ogYL
        8HKx6JMVoaCjZHCZDGF0Ag6C3+h9gS8GSQW0vslvXw==
X-Google-Smtp-Source: ABdhPJzOvpJvmeB9B6yKLT7BUlBedj6j6ygue2qTzOkcYNiDvuHnjuFl2J2gHY059Kb/SlfwYRwhA1ImD3nzOXc+rPg=
X-Received: by 2002:a17:902:fe01:: with SMTP id g1mr11873819plj.71.1598448999463;
 Wed, 26 Aug 2020 06:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200825231438.15682-1-natechancellor@gmail.com>
In-Reply-To: <20200825231438.15682-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Aug 2020 06:36:28 -0700
Message-ID: <CAKwvOdnCGoRHxgoV+qZNZQx04jwcttckCoxTpFKp9C=jRHw5+w@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: Improve formatting of commands,
 variables, and arguments
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:14 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> While reviewing a separate patch, I noticed that the formatting of the
> commands, variables, and arguments was not in a monospaced font like the
> rest of the Kbuild documentation (see kbuild/kconfig.rst for an
> example). This is due to a lack of "::" before indented command blocks
> and single backticks instead of double backticks for inline formatting.
>
> Add those so that the document looks nicer in an HTML format, while not
> ruining the look in plain text.
>
> As a result of this, we can remove the escaped backslashes in the last
> code block and move them to single backslashes.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Ah, yeah, I saw that. Thanks for the fix!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Documentation/kbuild/llvm.rst | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index 2aac50b97921..334df758dce3 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -23,8 +23,8 @@ supports C and the GNU C extensions required by the kernel, and is pronounced
>  Clang
>  -----
>
> -The compiler used can be swapped out via `CC=` command line argument to `make`.
> -`CC=` should be set when selecting a config and during a build.
> +The compiler used can be swapped out via ``CC=`` command line argument to ``make``.
> +``CC=`` should be set when selecting a config and during a build. ::
>
>         make CC=clang defconfig
>
> @@ -34,33 +34,33 @@ Cross Compiling
>  ---------------
>
>  A single Clang compiler binary will typically contain all supported backends,
> -which can help simplify cross compiling.
> +which can help simplify cross compiling. ::
>
>         ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang
>
> -`CROSS_COMPILE` is not used to prefix the Clang compiler binary, instead
> -`CROSS_COMPILE` is used to set a command line flag: `--target <triple>`. For
> -example:
> +``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
> +``CROSS_COMPILE`` is used to set a command line flag: ``--target <triple>``. For
> +example: ::
>
>         clang --target aarch64-linux-gnu foo.c
>
>  LLVM Utilities
>  --------------
>
> -LLVM has substitutes for GNU binutils utilities. Kbuild supports `LLVM=1`
> -to enable them.
> +LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
> +to enable them. ::
>
>         make LLVM=1
>
> -They can be enabled individually. The full list of the parameters:
> +They can be enabled individually. The full list of the parameters: ::
>
> -       make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \\
> -         OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size \\
> -         READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar \\
> +       make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
> +         OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size \
> +         READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar \
>           HOSTLD=ld.lld
>
>  Currently, the integrated assembler is disabled by default. You can pass
> -`LLVM_IAS=1` to enable it.
> +``LLVM_IAS=1`` to enable it.
>
>  Getting Help
>  ------------
>
> base-commit: abb3438d69fb6dd5baa4ae23eafbf5b87945eff1
> --
> 2.28.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200825231438.15682-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
