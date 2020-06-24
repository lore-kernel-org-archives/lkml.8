Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0361C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790FE2081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pd1+e0uX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391446AbgFXU7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391610AbgFXU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:59:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8675C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:59:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so1710607pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWM/30Wl1IsQgoPaDiN0rPEEBtrHBKt/BJnnp0eLWds=;
        b=pd1+e0uXRIvGNNQgZ7G0+2YkwsDFhSclmocO1GbaT5UM3c6xBTX7UYJjCsai0aiyT7
         fIoijSJoU+eUl8voyiO0IOyBsavQt6eREqkk3whDlDlHejxDQRKECAFiVGUe/CKDHaTc
         EpZ2md8ULTkAVVBJ6O72PRwIcg/GiVClV1rha8JNSiYzT4/v2ecYsi++FLxwW19Hw/Gd
         Fr/Z+ikfp69sRAivcJnbajJT1/5/Qn2W6vWHskjofe5p2ZJr6Cthm+UKTVG2rZslsDkG
         xO7mHbrOSScz4BsI8HgHuMYhqH42CQPx5Ip80xrwiQdph3TwAg+m578XBSL3rfWRIGQZ
         ATEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWM/30Wl1IsQgoPaDiN0rPEEBtrHBKt/BJnnp0eLWds=;
        b=uNySgrnGviazDIi3IS0SuhNLHG4hoaKy2tTKRufxFkIzLo0EiM2SrP8Cke2fK8w40J
         N8BjY8YWcNkqgHF6QvfujMZ+4Dl9qMS/2KFjScWODf1nJRvedPt2u6czsRouwSMh7IkJ
         y/GKhjlokESwWeCE7kOSvH7rQPKwJoh27zLoUJ1axr8gQ7Na36zTflvpgrRO/+9cF6wJ
         v1yspvAi56YZaOHFaWEgbuFkgtnPnDG4cPB1vcnoTs6zokwjCB1QAHY+SfsKABu8dugY
         Qt7PBMiEir0N5zFdtPpChhav8TQwpX0O0K3M3/NEW10W/tlc7rk5RmjoAnSH4BXdr/hE
         M3Sg==
X-Gm-Message-State: AOAM533sVlr28Dexe3Lbj3uGIpsq5m3xDAxAy+Vdbx19MRIkTDDuiGLP
        HMA1NQg9OXhVkjz3YVWT8yewWWeNfufnZbEydTVSzw==
X-Google-Smtp-Source: ABdhPJxCHHL5VXpLPing5E72KwPslmx5t7evOEk09T9ji09mKT6bSRCDPTi/AxhdrzEhszh9gGm6vbYGZSEoMtti7/U=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr5252324pjc.101.1593032350091;
 Wed, 24 Jun 2020 13:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-18-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-18-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 13:58:57 -0700
Message-ID: <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
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
> Filter out CC_FLAGS_LTO for the vDSO.

Just curious about this patch (and the following one for x86's vdso),
do you happen to recall specifically what the issues with the vdso's
are?

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kernel/vdso/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 556d424c6f52..cfad4c296ca1 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -29,8 +29,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
>  ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
> -KBUILD_CFLAGS                  += $(DISABLE_LTO)
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> +                               $(CC_FLAGS_LTO)
>  KASAN_SANITIZE                 := n
>  UBSAN_SANITIZE                 := n
>  OBJECT_FILES_NON_STANDARD      := y
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
