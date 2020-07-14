Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70914C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE72206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEOHcp6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGNUYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgGNUYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:24:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B987C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:24:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id e64so18719593iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2NQULvuOEAYnvgAO7OEbngziveI6HXFBIvKCbGUQGt8=;
        b=jEOHcp6ge0HHz/3BHLQa/8i9Ro5rhqePy7mVFbkqOXznVWCPrYljvxZ/eR5Q9otJsF
         Oljv2JCI8WhjtZurE3LE2vyj8MJyKiEUN3Joqg81nj3dIKEDREw7ird+H3ZkTUafqlcG
         EY0P9scFPXGS/P9l4oavSTEwO44rWbws/Trp4miDtoD1BmbJW2gvj/dBuK1E5sEWtnXm
         bDp+Gdh0iDIfBO51tm/cQLHbBH/DRH3XjXRUzwDvad1E63RnPX3/3v7++LkgL6nRtF1b
         JITIcbyq6ocGKVXheZfbrsioM/HlOIyekcgoV58mUMbtIPa4QlopeqimQg4kSWHpay+q
         HexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2NQULvuOEAYnvgAO7OEbngziveI6HXFBIvKCbGUQGt8=;
        b=nAy8DniZu+FXlTilZ1ElBg2QkPnKXRVRs7tthNh9SxOnpBiM8oPRLbp5drF1SWlIxj
         jmocsOLUyFM6WeT1KSut/KCLNRbAeOkxTJOxdkCoBvBa8xJFKAMpouv0gaXRAoivlJ57
         /FmOZdueRKj22fG18X5L1gGkNW7hPlbTU7XBE+8IXzRDJQKXE/hjtLI1k4ovqLnTbFDM
         sWZ376AT8Kv+LGzRs9YwvhyxhQ4wP8rgeT2Q5ecMJenVfpgtbNQy8pSRP4Ldcgsl9huZ
         DeDN9bj1hQmug69sEPPI2IlbgHj69VjWxx6K37TReSPTVkvwt41OWAop74qpkp4Zgf+b
         4PFQ==
X-Gm-Message-State: AOAM531eJ0cxug7F9SfcNt98C3Lnf7jw7EflQwWdZOX7o5N6A6hESmKX
        YAeHb6vlBuV5FB2bmUgAdE5jA/JNFTdPSBBBTP8=
X-Google-Smtp-Source: ABdhPJyek64KfxSgCjOFnl4NOP3rURv0EWHxL0mtiYhyqqBiBd49GRqamgDYbBIL3SFwWkKqam8Rs1pDIXbglp8e7Mw=
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr6612386iow.163.1594758259727;
 Tue, 14 Jul 2020 13:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan> <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com> <20200714202100.GB902932@rani.riverdale.lan>
In-Reply-To: <20200714202100.GB902932@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 22:24:07 +0200
Message-ID: <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 10:21 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jul 14, 2020 at 10:08:04PM +0200, Sedat Dilek wrote:
> > > >
> > > > In any case, I think the right fix here would be to add -pie and
> > > > --no-dynamic-linker to LDFLAGS_vmlinux instead of KBUILD_LDFLAGS.
> > >
> > > Hmm, you might be right with moving to LDFLAGS_vmlinux.
> > >
> >
> > We will need the "ifndef CONFIG_LD_IS_LLD" as -r and -pie cannot be
> > used together.
> > Is that the or not the fact when moving to LDFLAGS_vmlinux?
>
> LDFLAGS_vmlinux will only be used to link boot/compressed/vmlinux,
> whereas KBUILD_LDFLAGS is used for all linker invocations, and in
> particular the little link to do the modversions stuff ends up using it.
>
> So once we move -pie --no-dynamic-linker to the more correct
> LDFLAGS_vmlinux and/or stop modversions running, we'll be fine. Being
> able to use -pie with lld is one of the goals of this series.
>

OK, I am doing a new full kernel build with:

$ git diff arch/x86/boot/compressed/Makefile
diff --git a/arch/x86/boot/compressed/Makefile
b/arch/x86/boot/compressed/Makefile
index 789d5d14d8b0..056a738e47c6 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -51,7 +51,7 @@ UBSAN_SANITIZE :=n
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
-KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += -pie $(call ld-option, --no-dynamic-linker)
 LDFLAGS_vmlinux := -T

 hostprogs      := mkpiggy

- Sedat -
