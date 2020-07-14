Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC1E229EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa0xe+8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgGNSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:33:32 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:33:31 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t27so15034575ill.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+GrWComU6TBiIyymRd8f6GtXs9/MoZhC4FrxlGlnlig=;
        b=Xa0xe+8Qcmx/ymrkj23nB3jIFtCMBlAwRV26M9ftEsSHshXYtA54soUcQmeVWa5vJ4
         JgCoxeEuvPQH2ZnS3UQX9OrRgPsyoq/SNaxK3v5nHYWjQv7Tg/j4aIwqxbMxojQ4ZLZx
         VdWgM7h4YhHVcgkX23DfjwwjK3nhGndJ7+cJ3EW4uiH+WTSbgN6SYk49IZPeCAR0M/fD
         PCm/ib867eRLK2GUKmekIeg7duOIUjjADCJl08ORUWOztWcmpwub8uLEwrUrUUrf1Tak
         SQJSlQjUlV5a67mLzj5FRORhO/DDS7FCmBBchVzp05k2OEJofKa5xJuJWI8pGIUuyW/n
         jNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+GrWComU6TBiIyymRd8f6GtXs9/MoZhC4FrxlGlnlig=;
        b=Sntb6X4UKoBLv9k5EdqoPS5Myaj+Rix3d2tqJbtzAF8jImK3p8jq8kicYrZH6k1lNA
         qD5p0svC3nicagmm3hl5BYryXvtAyt5V/mBFbK0OwszRkS7cQqyvP1ATerQ76lzZXpZy
         BsWhByS9sPLjEj1lNhixAL3lb+XuY6/3T6+7+Bb2JXLFMy1xwL+ezlWffsHznZQMBZGe
         K9i5klxD4PFGAxDKru7yVVE5af2ljmVPT2wOTYVzVsPIquLVsxSp8Ns0CQWhDm9D5q6x
         6Tx4v1obEXTdbmFPruwMEIxPIeSSvEL73zbpMk4n+OrcqX9Ladbdh4ocGw374ZQSzHOP
         TXWQ==
X-Gm-Message-State: AOAM532FBgBEYewRVG3OybuY05M0h5HJ1lkEuyEAPyn3csEPTaJQJiTi
        JMqnsz5qWswvjTTGlitcP88Ioz7zWUwcD8GH5Iw=
X-Google-Smtp-Source: ABdhPJyPemS7zsyNCYJIK3K/PqcPh9lIRF1DIinCrjXbvndkLzkY0bN0ijo9FaTZZeENw5QZH2lMIY/ekD9lzxCoBqo=
X-Received: by 2002:a92:8b11:: with SMTP id i17mr5986875ild.212.1594751611244;
 Tue, 14 Jul 2020 11:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
In-Reply-To: <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 20:33:19 +0200
Message-ID: <CA+icZUWip6xAFdTiLNWT4QHS0R6bQuCZ6W7dWd+UbbZGnBBh4w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 8:30 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> > I did a full new build...
> >
> > ...and it fails with ld.lld-11 as linker:
> >
> > ld.lld-11 -m elf_x86_64 -pie  --no-dynamic-linker -r -o
> > arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o
> > -T arch/x86/boot/compressed/.tmp_misc.ver; mv -f
> > arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o;
> > rm -f arch/x86/boot/compressed/.tmp_misc.ver; fi
> > *** ld.lld-11: error: -r and -pie may not be used together ***
> > make[5]: *** [scripts/Makefile.build:281:
> > arch/x86/boot/compressed/misc.o] Error 1
> >
> > It's annoying to fail on the last minutes of a build.
> > Sorry for being very honest.
> >
>
> I applied this diff...
>
> $ git diff arch/x86/boot/compressed/Makefile
> diff --git a/arch/x86/boot/compressed/Makefile
> b/arch/x86/boot/compressed/Makefile
> index 789d5d14d8b0..9ba52a656838 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -51,7 +51,10 @@ UBSAN_SANITIZE :=n
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
> +# LLD linker does not allow -r and -pie options to be used together.
> +ifndef CONFIG_LD_IS_LLD
>  KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> +endif
>  LDFLAGS_vmlinux := -T
>
>  hostprogs      := mkpiggy
>
> ...and was able to build, assemble, link arch/x86/boot/compressed/*.
>

I checked my last succesfull build without your patchset:

$ grep no-dynamic-linker build-log_5.8.0-rc5-1-amd64-llvm11-ias.txt
[ EMPTY ]

- Sedat -
