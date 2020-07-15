Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7CFC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D689B206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTqPG3r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgGOJM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgGOJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:12:27 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E24C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:12:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so1358174ilk.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8rsbdVH+KC3/YgU90lgBBUyoDt5JRerD1kAjn5HbfQs=;
        b=fTqPG3r7k7Rir+aggjqLVPVv93H+pVOYdXx/pVqNA5+R0lb44r//w+YMaAK5TU0iO3
         75ItLkjbFI4hetEO7gpm8fS8aAGlR0/ECcsCVhBQM/QbSGfAmqGGjpsr4/1do8Pc4wcH
         bJa4aBCm/z9f09gKvFKu7d9m2Y4gwQckfw4I0hf2uju3rEkvB76M+QUydQ+6pCW5Y8vd
         xlciehkKhEVbv1rbwSfitl+iO/+JhAwRnY7E/TPfIN//pZytmQnfgjzgdOQ2qqUfE64a
         odeHXTKtqbHbjbwLLEqyfWAcH7DdgL00chs7Re1kdjQ/fjxU0Cp3Uj5tHyeH17JyS7ID
         C1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8rsbdVH+KC3/YgU90lgBBUyoDt5JRerD1kAjn5HbfQs=;
        b=kznguhEKzOBArFwgTRXubJm85ZYYQuyHC435I+az0wKJFwVAkYA7CML0PUPcIoMW0W
         Cw+X4m2t8OXOYKn/ePB5x92o26FoDYm9URTXHbXx5/lI5V+ncFj7SbM+dMDLHRwabKhQ
         98hZKsKlMEjiU+tNsCFOsSogralzqrLLHjxAtUu9ym0KsKNtLATzWtpjlrfqi3h33cyC
         AyPIr67vpv6VPVFb9bb7YKsVd5lrEMmVT23UUBBotGcoAIGwy5Nqa4XlXWJ6yVUzq4Lk
         njvsmphobzcdgzz+CgGmY7WJSWO+62m5QaN5eugd8Na8+X/uGJ2Jw5RQ+I0O/UrF9jgS
         A7nA==
X-Gm-Message-State: AOAM530slHSYPj4CcaocyzsxJggPa9/za0ia3Rikfd8MMIeid1zh+I1y
        KZakF+Tm8JlWvP8V/EOgxCzImBJCmaqUrSKP3KE=
X-Google-Smtp-Source: ABdhPJyTFomTiN5LAN3dbi6omIkKC0Vhggaje8SNAojm6FiDT0Chz6FUen2MmcFNya4Qv+poPI73rkEEjRB0nahH39M=
X-Received: by 2002:a92:290a:: with SMTP id l10mr9449309ilg.204.1594804346151;
 Wed, 15 Jul 2020 02:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-8-nivedita@alum.mit.edu> <CA+icZUX56cEjdkiuxOXtCgY1F0NWD5QxqMBRQxE5Li3=RUe-7w@mail.gmail.com>
In-Reply-To: <CA+icZUX56cEjdkiuxOXtCgY1F0NWD5QxqMBRQxE5Li3=RUe-7w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 11:12:14 +0200
Message-ID: <CA+icZUVJLreLhESAhd2AMyPOJF9bqUqqJ2PR6Qw5Y3ae4se1eQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] x86/boot: Check that there are no run-time relocations
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

On Wed, Jul 15, 2020 at 11:00 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jul 15, 2020 at 2:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Add a linker script check that there are no run-time relocations, and
> > remove the old one that tries to check via looking for specially-named
> > sections in the object files.
> >
> > Drop the tests for -fPIE compiler option and -pie linker option, as they
> > are available in all supported gcc and binutils versions (as well as
> > clang and lld).
> >
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Here I reported the breakage with LLD and tested the move to
> LDFLAGS_vmlinux with a previous version of the patch.
>

Feel free to also add my:

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Fangrui Song <maskray@google.com>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
> >  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
> >  2 files changed, 11 insertions(+), 25 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index ae2c0dc98a6a..a9e082b8c720 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -29,7 +29,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
> >         vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
> >
> >  KBUILD_CFLAGS := -m$(BITS) -O2
> > -KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
> > +KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> >  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> >  cflags-$(CONFIG_X86_32) := -march=i386
> >  cflags-$(CONFIG_X86_64) := -mcmodel=small
> > @@ -51,7 +51,7 @@ UBSAN_SANITIZE :=n
> >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >  # address by the bootloader.
> > -LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> > +LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
> >  LDFLAGS_vmlinux += -T
> >
> >  hostprogs      := mkpiggy
> > @@ -86,30 +86,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> >  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> >
> > -# The compressed kernel is built with -fPIC/-fPIE so that a boot loader
> > -# can place it anywhere in memory and it will still run. However, since
> > -# it is executed as-is without any ELF relocation processing performed
> > -# (and has already had all relocation sections stripped from the binary),
> > -# none of the code can use data relocations (e.g. static assignments of
> > -# pointer values), since they will be meaningless at runtime. This check
> > -# will refuse to link the vmlinux if any of these relocations are found.
> > -quiet_cmd_check_data_rel = DATAREL $@
> > -define cmd_check_data_rel
> > -       for obj in $(filter %.o,$^); do \
> > -               $(READELF) -S $$obj | grep -qF .rel.local && { \
> > -                       echo "error: $$obj has data relocations!" >&2; \
> > -                       exit 1; \
> > -               } || true; \
> > -       done
> > -endef
> > -
> > -# We need to run two commands under "if_changed", so merge them into a
> > -# single invocation.
> > -quiet_cmd_check-and-link-vmlinux = LD      $@
> > -      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
> > -
> >  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> > -       $(call if_changed,check-and-link-vmlinux)
> > +       $(call if_changed,ld)
> >
> >  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
> >  $(obj)/vmlinux.bin: vmlinux FORCE
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index a4a4a59a2628..29df99b6cc64 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -42,6 +42,12 @@ SECTIONS
> >                 *(.rodata.*)
> >                 _erodata = . ;
> >         }
> > +       .rel.dyn : {
> > +               *(.rel.*)
> > +       }
> > +       .rela.dyn : {
> > +               *(.rela.*)
> > +       }
> >         .got : {
> >                 *(.got)
> >         }
> > @@ -85,3 +91,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
> >  #else
> >  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> >  #endif
> > +
> > +ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > --
> > 2.26.2
> >
