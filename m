Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C1EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EF620768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogyMpgi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbgFXVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389905AbgFXVN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:13:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:13:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q90so1231915pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omCkUcZNHVXP0sWRywzjOwxTXZ4YyisMAxm749WU5GU=;
        b=ogyMpgi9tPFXqD3+b4TskFtzlAE3qRSfSFlhxLkMzfZQl068z8vqJlL5I/k1hQA4j2
         8+KaTuQNKpStTyBjn2ssQsUKa/GWq7f607kaEaeXU2o8/Ft2sUgUsqmcJHltC+KgIKVl
         o3jZ4P3X6AywcFpecW/k8P5ZOrqPI9Z99iVivwkxvFoyUq4G2KcudRcYQ4mOacJiN+sQ
         WfzuwRbr7it+GIQZRqsNndeZ4kbhXyBxzlSPEB5SEo0dkcZcdM6751ifbYi1L0YxNGzl
         zLZYU7QD65uDvjwEcqlKMDaY6jKyUjhUxCFnXE3C+lzv6bRpSkWGLHXOkAgDh/7Se2CC
         j7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omCkUcZNHVXP0sWRywzjOwxTXZ4YyisMAxm749WU5GU=;
        b=LPvsNjDchmcHieCDJoCX4oGfiT93MR2bMoQ3P3SOxe38OsWCp7aavmdRQgIIvXjF4l
         hGO0cm8H8DegKAzSexprDJRAhdbxRG/AfiWS0s1qThaQbz/yYVSrgYKnV9aojq9tQbGZ
         PyksXY955fY6h4N+L7Qb4TSMmwfhnJPaiS+hgJ3UpSwpqiMOqZ/BJ8epilg5TsntkUbT
         GCvFQwTW6t+MpwdEDcAds1tsMM5FiYqrjb+vtu0BWGzCogWKu9EV/qmRYR9ajYXKjMNd
         KbH4poaaOuL/WVATcN93GoJO2VRUUr/bJVyDE8O7OAfkvg2lCTlHIup2NQi2UAHhGJ9N
         soIQ==
X-Gm-Message-State: AOAM532aZsglmeFOpWYLkU0w1ZZlH0NH71ZRb4LgfVIam8wRYt7AQ3Rc
        TQT6qCvRub+1yx7uVW4AksDB1UuW18nCb2iixZtlyQ==
X-Google-Smtp-Source: ABdhPJyvmG5uGb8Lyk5i53Q9bt53kqBtuDjO8DoRXX4pnhndW+Y4vnp4+GK0S4oFxok0KRSkaflUBQ+yOxnxS3G2Ct0=
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr29536869pls.223.1593033238474;
 Wed, 24 Jun 2020 14:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-9-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-9-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 14:13:46 -0700
Message-ID: <CAKwvOdmcDxa+h9i6_XQc8ZDQjD9cTrD7s9eNU0fSxZbXciKhDQ@mail.gmail.com>
Subject: Re: [PATCH 08/22] kbuild: lto: remove duplicate dependencies from
 .mod files
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With LTO, llvm-nm prints out symbols for each archive member
> separately, which results in a lot of duplicate dependencies in the
> .mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
> consists of several compilation units, the output can exceed the
> default xargs command size limit and split the dependency list to
> multiple lines, which results in used symbols getting trimmed.
>
> This change removes duplicate dependencies, which will reduce the
> probability of this happening and makes .mod files smaller and
> easier to read.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 82977350f5a6..82b465ce3ca0 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -291,7 +291,7 @@ endef
>
>  # List module undefined symbols (or empty line if not enabled)
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
> -cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
> +cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
>  else
>  cmd_undef_syms = echo
>  endif
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
