Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F5BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6AE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594803802;
	bh=poczFf7CqUFWvL7FNd840Tc+lzWEfFi1Rxkryl5iWeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sTPVtd5huVfPcluAlZ6dmqgArEdWlRGV6tPmQDxwnWbygCRgoZeDL2ngm1u7MCbam
	 gm8tF32ims7ZSIeavKBAu4PP8f69gvdXkK2jjtlpevAdofsY60eSA/mN4XhDWZGujs
	 r1RxKFd/7CoPaLGJI3GLYAZG9nttP1JURRKVcDHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgGOJDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgGOJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:03:21 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4852074B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594803800;
        bh=poczFf7CqUFWvL7FNd840Tc+lzWEfFi1Rxkryl5iWeA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ax3kA4fbt5FhtkQTxzF/eWpDLnDypceGR1x37XtPEMU5u7H4JtlM4NkAtxeLDPHxE
         GVhFt1pDX/Z5lDSP2YQZJUEQhWvgk3KQl48TBeh7eMfIrh0EopEaq1hGW6BuIqzR0z
         TnI9CxhfgoARY78w6rae6CWnIfsTfUcJRf44r9p4=
Received: by mail-oo1-f41.google.com with SMTP id a9so312539oof.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:03:20 -0700 (PDT)
X-Gm-Message-State: AOAM530H/EHTLqrSrz0qaKVtBnbHQs0QtPE6Cn7z6UuCZkhRj/Pq93p8
        ZwabC7lXbTbn7jiH8fnRp2zbjaizkibOae0ntyE=
X-Google-Smtp-Source: ABdhPJw5kqOx5AW3Z0sCElNpu6zFWnmM/+RGtfLq2gpVg/UzeYiV2RrzHqFJgcVO4ugWF5SJCPaKu0Y0NfAtFTWQs14=
X-Received: by 2002:a4a:de8d:: with SMTP id v13mr8412492oou.45.1594803799213;
 Wed, 15 Jul 2020 02:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <20200715004133.1430068-7-nivedita@alum.mit.edu> <CA+icZUXDoeHEcFurBVTv-JMR2xR6oj500n=fVSrN56_KOHiHcw@mail.gmail.com>
In-Reply-To: <CA+icZUXDoeHEcFurBVTv-JMR2xR6oj500n=fVSrN56_KOHiHcw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jul 2020 12:03:07 +0300
X-Gmail-Original-Message-ID: <CAMj1kXE2D_iWGQODd2t=9-URE1T2N4+hgrTn7OQa-=ma=kncvg@mail.gmail.com>
Message-ID: <CAMj1kXE2D_iWGQODd2t=9-URE1T2N4+hgrTn7OQa-=ma=kncvg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] x86/boot: Remove run-time relocations from head_{32,64}.S
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 at 11:58, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jul 15, 2020 at 2:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > The BFD linker generates run-time relocations for z_input_len and
> > z_output_len, even though they are absolute symbols.
> >
> > This is fixed for binutils-2.35 [1]. Work around this for earlier
> > versions by defining two variables input_len and output_len in addition
> > to the symbols, and use them via position-independent references.
> >
> > This eliminates the last two run-time relocations in the head code and
> > allows us to drop the -z noreloc-overflow flag to the linker.
> >
> > Move the -pie and --no-dynamic-linker LDFLAGS to LDFLAGS_vmlinux instead
> > of KBUILD_LDFLAGS. There shouldn't be anything else getting linked, but
> > this is the more logical location for these flags, and modversions might
> > call the linker if an EXPORT_SYMBOL is left over accidentally in one of
> > the decompressors.
> >
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Reported breakage with LLD in previous patchset version.
>

Please drop the bogus reported-bys. The patch does *not* address an
issue you reported, so recording this in the commit log would be
incorrect.

Your review and testing is appreciated, and resulted in substantial
improvements. So feel free to give your reviewed-by in addition to
your tested-by. But reported-by is inappropriate here.


>
> > [1] https://sourceware.org/bugzilla/show_bug.cgi?id=25754
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Fangrui Song <maskray@google.com>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/boot/compressed/Makefile  | 12 ++----------
> >  arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
> >  arch/x86/boot/compressed/head_64.S |  4 ++--
> >  arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
> >  4 files changed, 18 insertions(+), 21 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index c829d874dcac..ae2c0dc98a6a 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -51,16 +51,8 @@ UBSAN_SANITIZE :=n
> >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >  # address by the bootloader.
> > -ifeq ($(CONFIG_X86_32),y)
> > -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> > -else
> > -# To build 64-bit compressed kernel as PIE, we disable relocation
> > -# overflow check to avoid relocation overflow error with a new linker
> > -# command-line option, -z noreloc-overflow.
> > -KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> > -       && echo "-z noreloc-overflow -pie --no-dynamic-linker")
> > -endif
> > -LDFLAGS_vmlinux := -T
> > +LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> > +LDFLAGS_vmlinux += -T
> >
> >  hostprogs      := mkpiggy
> >  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> > diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> > index 8c1a4f5610f5..659fad53ca82 100644
> > --- a/arch/x86/boot/compressed/head_32.S
> > +++ b/arch/x86/boot/compressed/head_32.S
> > @@ -178,18 +178,17 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> >  /*
> >   * Do the extraction, and jump to the new kernel..
> >   */
> > -                               /* push arguments for extract_kernel: */
> > -       pushl   $z_output_len   /* decompressed length, end of relocs */
> > +       /* push arguments for extract_kernel: */
> >
> > -       pushl   %ebp            /* output address */
> > -
> > -       pushl   $z_input_len    /* input_len */
> > +       pushl   output_len@GOTOFF(%ebx) /* decompressed length, end of relocs */
> > +       pushl   %ebp                    /* output address */
> > +       pushl   input_len@GOTOFF(%ebx)  /* input_len */
> >         leal    input_data@GOTOFF(%ebx), %eax
> > -       pushl   %eax            /* input_data */
> > +       pushl   %eax                    /* input_data */
> >         leal    boot_heap@GOTOFF(%ebx), %eax
> > -       pushl   %eax            /* heap area */
> > -       pushl   %esi            /* real mode pointer */
> > -       call    extract_kernel  /* returns kernel location in %eax */
> > +       pushl   %eax                    /* heap area */
> > +       pushl   %esi                    /* real mode pointer */
> > +       call    extract_kernel          /* returns kernel location in %eax */
> >         addl    $24, %esp
> >
> >  /*
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index 11429092c224..9e46729cf162 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -534,9 +534,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> >         movq    %rsi, %rdi              /* real mode address */
> >         leaq    boot_heap(%rip), %rsi   /* malloc area for uncompression */
> >         leaq    input_data(%rip), %rdx  /* input_data */
> > -       movl    $z_input_len, %ecx      /* input_len */
> > +       movl    input_len(%rip), %ecx   /* input_len */
> >         movq    %rbp, %r8               /* output target address */
> > -       movl    $z_output_len, %r9d     /* decompressed length, end of relocs */
> > +       movl    output_len(%rip), %r9d  /* decompressed length, end of relocs */
> >         call    extract_kernel          /* returns kernel location in %rax */
> >         popq    %rsi
> >
> > diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
> > index 7e01248765b2..52aa56cdbacc 100644
> > --- a/arch/x86/boot/compressed/mkpiggy.c
> > +++ b/arch/x86/boot/compressed/mkpiggy.c
> > @@ -60,6 +60,12 @@ int main(int argc, char *argv[])
> >         printf(".incbin \"%s\"\n", argv[1]);
> >         printf("input_data_end:\n");
> >
> > +       printf(".section \".rodata\",\"a\",@progbits\n");
> > +       printf(".globl input_len\n");
> > +       printf("input_len:\n\t.long %lu\n", ilen);
> > +       printf(".globl output_len\n");
> > +       printf("output_len:\n\t.long %lu\n", (unsigned long)olen);
> > +
> >         retval = 0;
> >  bail:
> >         if (f)
> > --
> > 2.26.2
> >
