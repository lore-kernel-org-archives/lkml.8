Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EDAC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272DD20658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9wTzPUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGNUfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:35:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:35:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w27so13918609qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ontnMwPVk3JI+fxLYQf4YU002R2JgbxcsAm8SNBm6RA=;
        b=K9wTzPUiJDG1KitvZfj6VluRApPRlU7Osz+5FJujkwRKxywnstFY6Qa8RF/WN34Jkn
         R/M8G8uBEQSOYJrdr/dfyEq1/u6/a4OHCPvkM3D9+a4MHV/HREVZGVLFVdt92iCUgYYg
         H6IzWJc98X/TsdloSVjyhTZzkLailEtvzHfFMFO0n/wQznictut6kHQqWSZFCgoSyX5M
         efrKGGF+fbWFAhkaHAwXBbuN/G4D4k/7R+sA+mQZBSt3/Eu3/vmxOUnKH1R0p9FPebdw
         pmLQQMcNfBL0R9VDGpLT8gEGswMcDQc/1miK9lLBrdfny5cCnfx+EtUJCd2If2i7fy1B
         4Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ontnMwPVk3JI+fxLYQf4YU002R2JgbxcsAm8SNBm6RA=;
        b=iQGonRDBorYlJNDZodBaCLGm01ew2OyQNPxV0CbggY6hWH4LFEgm4/h9vlGADyztYF
         TXmqTvb54s4yZNrc1eLeYClAEUI4zgrA+DH0ol9MLi5w5nWDrA2xz7bpD33eG/EylC2P
         P6E3HZ5ZJALHLja6Rtfwx5DsjCA2pD5Q7G0C1q4GhZztihewnk9fgqtZ5ZC6xW03hY+2
         4EBu1NK9cN6d/TOWA+G6bDI7EqYlMudCpFsmf3piGZR7vjqL1k+qrltz63mOE30Kx3FT
         Xnkd8fTF6jflVVBFXyH5XFcnLc1MGE2jl83bxTxx2qj2Sb/PMrt9Lfz5kfd8Jnz4yACq
         v7DA==
X-Gm-Message-State: AOAM533qOc4Yr55+UX1JXDSqWeILy+cGmPQrYLcS+eKX8s8TYadAkn6R
        OymnJzbnzMmyCzb/Ymtx2Dc=
X-Google-Smtp-Source: ABdhPJx6m+G4SGG+oHbp2jZFIS+rIcIdqQDULHmZruUVJtElMPTKkDBUN/8XbIpntgNf1rhRelNjrg==
X-Received: by 2002:ac8:311d:: with SMTP id g29mr6673218qtb.54.1594758939296;
        Tue, 14 Jul 2020 13:35:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j203sm23121710qke.13.2020.07.14.13.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:35:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 16:35:37 -0400
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
Message-ID: <20200714203537.GD902932@rani.riverdale.lan>
References: <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan>
 <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan>
 <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
 <20200714202100.GB902932@rani.riverdale.lan>
 <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
 <CA+icZUUtcQhzO=1KToJyhL0-kWFvV6Ow49u_28Ez9AhvkVjWEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUUtcQhzO=1KToJyhL0-kWFvV6Ow49u_28Ez9AhvkVjWEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:27:25PM +0200, Sedat Dilek wrote:
> On Tue, Jul 14, 2020 at 10:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 10:21 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Jul 14, 2020 at 10:08:04PM +0200, Sedat Dilek wrote:
> > > > > >
> > > > > > In any case, I think the right fix here would be to add -pie and
> > > > > > --no-dynamic-linker to LDFLAGS_vmlinux instead of KBUILD_LDFLAGS.
> > > > >
> > > > > Hmm, you might be right with moving to LDFLAGS_vmlinux.
> > > > >
> > > >
> > > > We will need the "ifndef CONFIG_LD_IS_LLD" as -r and -pie cannot be
> > > > used together.
> > > > Is that the or not the fact when moving to LDFLAGS_vmlinux?
> > >
> > > LDFLAGS_vmlinux will only be used to link boot/compressed/vmlinux,
> > > whereas KBUILD_LDFLAGS is used for all linker invocations, and in
> > > particular the little link to do the modversions stuff ends up using it.
> > >
> > > So once we move -pie --no-dynamic-linker to the more correct
> > > LDFLAGS_vmlinux and/or stop modversions running, we'll be fine. Being
> > > able to use -pie with lld is one of the goals of this series.
> > >
> >
> > OK, I am doing a new full kernel build with:
> >
> > $ git diff arch/x86/boot/compressed/Makefile
> > diff --git a/arch/x86/boot/compressed/Makefile
> > b/arch/x86/boot/compressed/Makefile
> > index 789d5d14d8b0..056a738e47c6 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -51,7 +51,7 @@ UBSAN_SANITIZE :=n
> >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >  # address by the bootloader.
> > -KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> > +LDFLAGS_vmlinux += -pie $(call ld-option, --no-dynamic-linker)
> >  LDFLAGS_vmlinux := -T
> >
> >  hostprogs      := mkpiggy
> >
> > - Sedat -
> 
> Not my day - today.
> 
> $ git diff arch/x86/boot/compressed/Makefile
> diff --git a/arch/x86/boot/compressed/Makefile
> b/arch/x86/boot/compressed/Makefile
> index 789d5d14d8b0..9784ed37a5d7 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -51,8 +51,8 @@ UBSAN_SANITIZE :=n
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
> -KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
>  LDFLAGS_vmlinux := -T
> +LDFLAGS_vmlinux += -pie $(call ld-option, --no-dynamic-linker)
> 
>  hostprogs      := mkpiggy
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> 
> - Sedat -

Nope -- -T needs to be last, since it's (trickily) put together with the
first prerequisite $(obj)/vmlinux.lds.
