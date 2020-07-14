Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16556C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E6222203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9vLiUrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgGNNQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgGNNQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:16:02 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B10C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:16:01 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so14153784ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=JcppHeuWEWp3uvCgDjwRJ0BnWulErceTXsEzD39nLZE=;
        b=c9vLiUrXUAWYv0FD++CVcZ1GAtiNRR7bSHgIM7lL4DbuHgbfcYJwnwva+prRCHC65Y
         Dyw+53n4/f1kNq8EV3G1kxBEiIT1XbIqlJocKGSnBuCUWTMNA2WSoNTbhCSMl8uc/D1D
         BiSJlZeQv/ehgMADDdypZGP03dImnwVce3FEViVstfWvv84nqiRQU+cP00vb3Rvi1Myv
         MFvoD01u2DejPmmU4TOnk0fZsAqwQaeY6cjz/iagEODUQdB/1ZbIti/V41Imti4ecgUc
         oE5GJXi2VYIpMEGSCgyW5H5wjgRCfpz7+lNGMSdG5y5EPFzTBOqCzDfxmhAZR1SLHjpn
         fxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=JcppHeuWEWp3uvCgDjwRJ0BnWulErceTXsEzD39nLZE=;
        b=rBdlFGVwPBiU4vM6zQOD4ogEvO27QZgYKLTyYCPLqzdwcRrieWJuavF+n35e0Fmvrx
         LbMmMifpR5voshn/ahwvxMH9+Tv1puUt98ZaiJJ6yGNzXeNYuJsnun5QDDFAT8+DFm56
         j2I5GX+03p/it0pZz4C0laAaA/La+F/Qbh89C/lPrxx1xVFYL7s85lFXhKdG0m0OagYJ
         yNcpuFMQmRfkngj2DCNxiQh5tnIDYvXeclUsFU+QsxAseqvX8y97ONMPaNUhQHW++vIr
         2TA/+LfWR6DHMA9Sca3nXmF+NjQWoyAtVNdhJGZfkOyprVwAbQ7whdmAmKTDitb/SDnM
         w1Wg==
X-Gm-Message-State: AOAM531YX2Mr7RkF2R4/0CAvFxXcB3vacteNt35Cqyw9yRRsRXSJk6mP
        R1ADB2Y0BGY+FNnZJMMhVKKzvI9MthS7haAvdUM=
X-Google-Smtp-Source: ABdhPJy6DFZ66PzdLA2OyG+j19wiB3LpMs/64BnF5TA4sDNPY5gnlt7QMd0Q91dcU6NDO9vsU9wVAMubBVAFR6a7oDM=
X-Received: by 2002:a92:dc09:: with SMTP id t9mr4830937iln.226.1594732561149;
 Tue, 14 Jul 2020 06:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu> <20200714023836.2310569-1-nivedita@alum.mit.edu>
In-Reply-To: <20200714023836.2310569-1-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 15:15:49 +0200
Message-ID: <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 4:38 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The compressed kernel currently contains bogus runtime relocations in
> the startup code in head_{32,64}.S, which are generated by the linker,
> but must not actually be processed at runtime.
>
> This generates warnings when linking with the BFD linker, and errors
> with LLD, which defaults to erroring on runtime relocations in read-only
> sections. It also requires the -z noreloc-overflow hack for the 64-bit
> kernel, which prevents us from linking it as -pie on an older BFD linker
> (<= 2.26) or on LLD, because the locations that are to be apparently
> relocated are only 32-bits in size and so cannot really have
> R_X86_64_RELATIVE relocations.
>
> This series aims to get rid of these relocations. I've build- and
> boot-tested with combinations of clang/gcc-10 with lld/bfd-2.34, and
> gcc-4.9.0 with bfd-2.24, skipping clang on 32-bit because it currently
> has other issues [0].
>
> The first three patches by Ard remove indirection via the GOT from the
> compressed kernel code.
>
> The next patch is an independent fix for LLD, to avoid an orphan
> section in arch/x86/boot/setup.elf.
>
> The fifth patch gets rid of almost all the relocations. It uses
> standard PIC addressing technique for 32-bit, i.e. loading a register
> with the address of _GLOBAL_OFFSET_TABLE_ and then using GOTOFF
> references to access variables. For 64-bit, there is 32-bit code that
> cannot use RIP-relative addressing, and also cannot use the 32-bit
> method, since GOTOFF references are 64-bit only. This is instead handled
> using a macro to replace a reference like gdt with (gdt-startup_32)
> instead. The assembler will generate a PC32 relocation entry, with
> addend set to (.-startup_32), and these will be replaced with constants
> at link time. This works as long as all the code using such references
> lives in the same section as startup_32, i.e. in .head.text.
>
> The sixth patch addresses a remaining issue with the BFD linker, which
> generates runtime relocations for absolute symbols. We use z_input_len
> and z_output_len, defined in the generated piggy.S file, as symbols
> whose absolute "addresses" are actually the size of the compressed
> payload and the size of the decompressed kernel image respectively. LLD
> does not generate relocations for these two symbols, but the BFD linker
> does, prior to the upcoming 2.35. To get around this, piggy.S is
> extended to also define two u32 variables (in .rodata) with the lengths,
> and the head code is modified to use those instead of the symbol
> addresses.
>
> An alternative way to handle z_input_len/z_output_len would be to just
> include piggy.S in head_{32,64}.S instead of as a separate object file,
> since the GNU assembler doesn't generate relocations for symbols set to
> constants.
>
> The last patch adds a check in the linker script to ensure that no
> runtime relocations get reintroduced.
>
> [0] https://lore.kernel.org/lkml/20200504230309.237398-1-ndesaulniers@google.com/
>

How to test this series without building a full new kernel?

make $make_opts vmlinux

- Sedat -

> Changes from v3:
> - Move hidden.h to include/linux so the EFI stub and the compressed
>   kernel can share the same file
>
> Changes from v2:
> - Incorporate Ard's patches for eliminating GOT references into this
>   series
> - Rebase on v5.8-rc3
>
> v2: https://lore.kernel.org/lkml/20200525225918.1624470-1-nivedita@alum.mit.edu/
>
> Changes from v1:
> - Add .text.* to setup.ld instead of just .text.startup
> - Rename the la() macro introduced in the second patch for 64-bit to
>   rva(), and rework the explanatory comment.
> - In the last patch, check both .rel.dyn and .rela.dyn, instead of just
>   one per arch.
>
>
> Ard Biesheuvel (3):
>   x86/boot/compressed: Move .got.plt entries out of the .got section
>   x86/boot/compressed: Force hidden visibility for all symbol references
>   x86/boot/compressed: Get rid of GOT fixup code
>
> Arvind Sankar (4):
>   x86/boot: Add .text.* to setup.ld
>   x86/boot: Remove run-time relocations from .head.text code
>   x86/boot: Remove runtime relocations from head_{32,64}.S
>   x86/boot: Check that there are no runtime relocations
>
>  arch/x86/boot/compressed/Makefile      |  37 +-----
>  arch/x86/boot/compressed/head_32.S     |  99 +++++----------
>  arch/x86/boot/compressed/head_64.S     | 165 ++++++++++---------------
>  arch/x86/boot/compressed/mkpiggy.c     |   6 +
>  arch/x86/boot/compressed/vmlinux.lds.S |  24 +++-
>  arch/x86/boot/setup.ld                 |   2 +-
>  drivers/firmware/efi/libstub/Makefile  |   2 +-
>  drivers/firmware/efi/libstub/hidden.h  |   6 -
>  include/linux/hidden.h                 |  19 +++
>  9 files changed, 152 insertions(+), 208 deletions(-)
>  delete mode 100644 drivers/firmware/efi/libstub/hidden.h
>  create mode 100644 include/linux/hidden.h
>
>
> base-commit: 11ba468877bb23f28956a35e896356252d63c983
> --
> 2.26.2
>
