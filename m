Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CE02064B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unoUiIVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGNUnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgGNUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:43:23 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:43:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so18795295ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=659l3loeZVWVHQe88TmNq0IOrVNRvE12czGtYHK/OHE=;
        b=unoUiIVBsAzV6xaO9AwGRaVHJ6FFju2MiesoVKPzEXictkod4LyHQKxT/Q3gK03GyR
         QEZYeB9OvwcCwZq2pksu9VHP0OJ4Vx7AgQIUFMWuHyJUGRXiedi3PL5qWT/VSMvhY21U
         ahB1VCmdzi6+cCqJl67J6yztKzVBNl3tpYYqyj50GF9OG7UJs9fVGOxuAhCmtzvQxafi
         ZHgaMZS2nylS4xM/KV5jLclh+Llsa5PQ2pXtETLb9E1eZ0s7ba9ynU5yDT57pHcsPHKf
         bYr+mwjR2SzSmEH0ch/SJ9AdFPJ3lRVU2iI1+8S3QS7QMbAON4ila3cEuUQasHdo3FTK
         +ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=659l3loeZVWVHQe88TmNq0IOrVNRvE12czGtYHK/OHE=;
        b=oOSXAFq12g3dishYQVx5qcHrRnBgc01K/xu5hK3Q1HyFloAK4QYaJld6X7McX4H4OY
         RxSl1Ag0g37HhNGAE8a/0wh7B+omKh58H/svcnr3MZnlKn2BdIhYpZtYSlsIdyOJFiaA
         Os6msNOdQ3hfs/CGHbPDMiFAEq0oFsbD/yrT5OiwHT2jSSGw2DSvO2uN4eAkLs15hYVs
         2AgjgC7gCtSqEDr7VBjcvnyPwh4q/YXOiIzX/yS4NEVI/cAo+l6XIu2jgUL2PYKWw6tj
         LISExZL642d/ory6kGwI+y8S6JqubgX4z4tggjmBUdugSFRm4Asj+z4aWbsh1WlefqYp
         SMFg==
X-Gm-Message-State: AOAM532cbqkZl18iASEwU5LcxOYHYiF5gUYFmYJLEum972wdmnfyYSaS
        nmeJdvGwLQzcaBgeVLlFyC4P67WnnIOwPtO+05U=
X-Google-Smtp-Source: ABdhPJzLnJoyPjinIikSQc08ZEF7ew3F3Iy3RIyO7SymqG+CZRStmBalJ1Tm12FmlpTPjMkF5LFs/hV2KcwqtN+qFkc=
X-Received: by 2002:a05:6638:2591:: with SMTP id s17mr8067905jat.23.1594759403170;
 Tue, 14 Jul 2020 13:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan> <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
 <20200714202100.GB902932@rani.riverdale.lan> <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
 <CA+icZUUtcQhzO=1KToJyhL0-kWFvV6Ow49u_28Ez9AhvkVjWEw@mail.gmail.com> <20200714203537.GD902932@rani.riverdale.lan>
In-Reply-To: <20200714203537.GD902932@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 22:43:11 +0200
Message-ID: <CA+icZUX93x_vhG-j+H+ktC_vt1d0f-KWZ+0L+hf1dnr=0L9h7g@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 10:35 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jul 14, 2020 at 10:27:25PM +0200, Sedat Dilek wrote:
> > On Tue, Jul 14, 2020 at 10:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Tue, Jul 14, 2020 at 10:21 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Jul 14, 2020 at 10:08:04PM +0200, Sedat Dilek wrote:
> > > > > > >
> > > > > > > In any case, I think the right fix here would be to add -pie and
> > > > > > > --no-dynamic-linker to LDFLAGS_vmlinux instead of KBUILD_LDFLAGS.
> > > > > >
> > > > > > Hmm, you might be right with moving to LDFLAGS_vmlinux.
> > > > > >
> > > > >
> > > > > We will need the "ifndef CONFIG_LD_IS_LLD" as -r and -pie cannot be
> > > > > used together.
> > > > > Is that the or not the fact when moving to LDFLAGS_vmlinux?
> > > >
> > > > LDFLAGS_vmlinux will only be used to link boot/compressed/vmlinux,
> > > > whereas KBUILD_LDFLAGS is used for all linker invocations, and in
> > > > particular the little link to do the modversions stuff ends up using it.
> > > >
> > > > So once we move -pie --no-dynamic-linker to the more correct
> > > > LDFLAGS_vmlinux and/or stop modversions running, we'll be fine. Being
> > > > able to use -pie with lld is one of the goals of this series.
> > > >
> > >
> > > OK, I am doing a new full kernel build with:
> > >
> > > $ git diff arch/x86/boot/compressed/Makefile
> > > diff --git a/arch/x86/boot/compressed/Makefile
> > > b/arch/x86/boot/compressed/Makefile
> > > index 789d5d14d8b0..056a738e47c6 100644
> > > --- a/arch/x86/boot/compressed/Makefile
> > > +++ b/arch/x86/boot/compressed/Makefile
> > > @@ -51,7 +51,7 @@ UBSAN_SANITIZE :=n
> > >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> > >  # Compressed kernel should be built as PIE since it may be loaded at any
> > >  # address by the bootloader.
> > > -KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> > > +LDFLAGS_vmlinux += -pie $(call ld-option, --no-dynamic-linker)
> > >  LDFLAGS_vmlinux := -T
> > >
> > >  hostprogs      := mkpiggy
> > >
> > > - Sedat -
> >
> > Not my day - today.
> >
> > $ git diff arch/x86/boot/compressed/Makefile
> > diff --git a/arch/x86/boot/compressed/Makefile
> > b/arch/x86/boot/compressed/Makefile
> > index 789d5d14d8b0..9784ed37a5d7 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -51,8 +51,8 @@ UBSAN_SANITIZE :=n
> >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >  # address by the bootloader.
> > -KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> >  LDFLAGS_vmlinux := -T
> > +LDFLAGS_vmlinux += -pie $(call ld-option, --no-dynamic-linker)
> >
> >  hostprogs      := mkpiggy
> >  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> >
> > - Sedat -
>
> Nope -- -T needs to be last, since it's (trickily) put together with the
> first prerequisite $(obj)/vmlinux.lds.

Good I read this.

Checked the previous build-log:

  ld.lld-11 -m elf_x86_64  -T arch/x86/boot/compressed/vmlinux.lds
arch/x86/boot/compressed/kernel_info.o
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o
arch/x86/boot/compressed/cpuflags.o
arch/x86/boot/compressed/early_serial_console.o
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o
arch/x86/boot/compressed/mem_encrypt.o
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o
drivers/firmware/efi/libstub/lib.a
arch/x86/boot/compressed/efi_thunk_64.o -o
arch/x86/boot/compressed/vmlinux

So there is no -r option in this line.

If we move to LDFLAGS_vmlinux we can drop the "call ld-option" as both
linker GNU/ld.bfd and LLVM/lld.ld support this?

Do we need to adjust the comments?
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader

That's the minimal change needed:

$ git diff arch/x86/boot/compressed/Makefile
diff --git a/arch/x86/boot/compressed/Makefile
b/arch/x86/boot/compressed/Makefile
index 789d5d14d8b0..d0aafcd8cf6c 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -51,8 +51,8 @@ UBSAN_SANITIZE :=n
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
-KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
-LDFLAGS_vmlinux := -T
+LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += -T

 hostprogs      := mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include

- Sedat -
