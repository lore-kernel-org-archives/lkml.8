Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5BEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BE722AB9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCZcMlRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgGNTaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:29:59 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC18C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:29:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so13757103qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGNvPJrHn1Rri9TOnWUH5zEtUJcHDoODobxdHdGDsPM=;
        b=BCZcMlRntxTI5jblvCeUvd216n7w0E/8W6IjcbntL9UzLJJ/xqnuM1unpNE2TBje+e
         sUDmXjigeM+iQp4cejYES+dBr3D2LDL+udZH4scnvBcw01Oz261qVqDews1Hmr2URi0U
         tmFNb37rO2UsDFWGo6OAuejqHKsSA89vYzceszlDyHXlBJVxk+DsEZ/cS3ItoHHnWKKM
         NpiLTKrISMTnqixB9X4I+2XAX0HWXUVTKC0DhhqU430TYEobYb6RCkhnHkXY6fAAKwSz
         b6K116zy756G8EZSNuD5iH0p1z9/ktcGdaEurmHR8OZD+OlJ3D/0YQemmbSX78zvRiET
         hwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BGNvPJrHn1Rri9TOnWUH5zEtUJcHDoODobxdHdGDsPM=;
        b=lXk4z7zakRRW0/XRpU6806k+sG+mSMj2BDm97tb2gfEdXwxGCv/OEXJPPXOIozno/R
         T7v5GEK1/HmoNUxKOjEc2yD7VXSRxtKirQQzBVNeQ6wjrl/MFMSrnovDtgoXt34Qvl0C
         DqQ9nDoEdQBRUQSRDuenU8E3iqZRkxqU8ywZS6PGIUjoEUqgNaNs5VBTDtpX4dvn5Cij
         L0P3mpzAJgaAfGTmrlI6PVDRCSzxjgZ52zNUrbZYXNy68e7hSK/62c+woCov5op/2hdh
         LOJNXlvDMCoeVyOMb/E1ybyCb22IurNtY5HIieCbI47FiEt23iWcT6ph7l/exoZOB52S
         56fA==
X-Gm-Message-State: AOAM532msaCYuVO2Y1qLle0nQN8J/ksfgxXHDUPLGWAiCJtbw3XVS4Hs
        BXDmEVpeBVPrCkHYH/U8C0U=
X-Google-Smtp-Source: ABdhPJwE3IRlWdcvdzeV0c/tM1hdgKDI+t+TaC71Iq1h1s5VSHTlOzopi2KbwFxck+wqF+C88uu3KQ==
X-Received: by 2002:ac8:178b:: with SMTP id o11mr6187972qtj.320.1594754998616;
        Tue, 14 Jul 2020 12:29:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c9sm22591590qko.24.2020.07.14.12.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:29:58 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 15:29:56 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200714192956.GA689174@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan>
 <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:30:14PM +0200, Sedat Dilek wrote:
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
> - Sedat -

Thanks for the test.

Can you share your .config? The error messages look like they're coming
from running modversions on misc.o, which is unexpected as it shouldn't
have any exported symbols, and it doesn't in my builds.

In any case, I think the right fix here would be to add -pie and
--no-dynamic-linker to LDFLAGS_vmlinux instead of KBUILD_LDFLAGS.
