Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187FCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD9E20674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvWVUzBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGOBrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:47:11 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:47:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so552575iox.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Zp7+jVCuD5gVLLy8V7whgbSKWVLGF7ae9FJiNKpjaE8=;
        b=NvWVUzBkZJ5mgwJX4oR607cA76LKD0JfRGsIiTkPvRLSZ+mp5yMw5DzsHnQMlMQ3P1
         lgM05pjtfQeN2rqaNCnsYJR+tCwjHoTepSM7KXvJQDLeXH5RmZvcyP0ZIZhOG30Ux4Fu
         kK+GU6W5QlnpJHt7mTF/LwexQMaKYhrayaUj5VQwDSfK6XbIth9sRmDClmwVdMYuiqut
         +7xa3Ba/yFY33x3fKmHamFACyx7cgMrxqFr9nxXEj8OT3FO9RuHBeZLCob+ird3NP5Wb
         KeOAOMw011qxpCAw/A8yTwwUkGXEXqngGR3dV7eJYK/MfM/m/2MZr7riDZS3LKph6bUJ
         C3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Zp7+jVCuD5gVLLy8V7whgbSKWVLGF7ae9FJiNKpjaE8=;
        b=atWAbd4QcE6tWouwq0xgSzCI+Dn2eFHKRnFIVL7JJrkvvn9cE3SV+qGWEKRvK7BzGB
         Nc0OkoPqlttD9nn1SBEjqjUQPNREVm5E4MwY0jM6ceU3DDbVamv4Q2bN5cKNHjSycZ0+
         sGGGHRphsC35pvXqUUjESsY8b025jth1sCdl0VsvuQPpE1qF1/h4zwmVvUuJ4zM8Zkgg
         c2ElzCobQ9o+X5mQ/PemEoIHEHemhqmbTLgo1RvsCTLbqCFk6QImiBxwWMG2MYK15YUz
         T/B5vsH3/ZuGpYhCvWzpVPn+qlNEDGRblrWc/bUgtqL24HvrPS5H+/cbEvfqfBFR7YC+
         qSyg==
X-Gm-Message-State: AOAM533M+ysvX3PPHt6W6oY0Lg7ec0OVm54EKrMJdqqMyc6SKCikcfDx
        qgXMWl4YNr6Hjuu3/qfmiymxZQUQD/Ps4LfMfno=
X-Google-Smtp-Source: ABdhPJxRiVNghanBe1X/1r+rjdz1hGE+ICnmzTM0ywOfi1yBQFUzHhvl2w4uvSiNu+wcJaPm6YPDZJGpE/7uJ/NYTqc=
X-Received: by 2002:a5e:dd0a:: with SMTP id t10mr7594707iop.80.1594777630279;
 Tue, 14 Jul 2020 18:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu> <20200715004133.1430068-1-nivedita@alum.mit.edu>
In-Reply-To: <20200715004133.1430068-1-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 03:46:58 +0200
Message-ID: <CA+icZUU7xXgDSc4ApF2ffyDCygu_N42tP6iF-XAvJAAVrD_B9A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] x86/boot: Remove run-time relocations from
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

On Wed, Jul 15, 2020 at 2:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The compressed kernel currently contains bogus run-time relocations in
> the startup code in head_{32,64}.S, which are generated by the linker,
> but must not actually be processed at run-time.
>
> This generates warnings when linking with the BFD linker, and errors
> with LLD, which defaults to erroring on run-time relocations in read-only
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
> generates run-time relocations for absolute symbols. We use z_input_len
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
> run-time relocations get reintroduced.
>
> [0] https://lore.kernel.org/lkml/20200504230309.237398-1-ndesaulniers@google.com/
>
> Changes from v4:
> - Move -pie --no-dynamic-linker from KBUILD_LDFLAGS to LDFLAGS_vmlinux
>   Sedat: I'm not clear on whether you tested with the final LDFLAGS,
>   could you confirm: i.e. if you tested with -pie passed to LLD?
> - Replace runtime -> run-time to be consistent in wording
>

Hi Arvind,

thanks for v5.

With my diff applied against your patchset *v4*:

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

I was able to build/assemble with LLVM/Clang v11.0.0-git+ffee8040534
and boot on bare metal.

Note:
I have applied some additional patches to be compliant with LLVM_IAS=1
(Clang's Integrated Assembler) and LLVM=1 means LLVM utilities.
( As pointed out zstd-v7. )

- Sedat -

P.S.: Check my build-log

$ grep 'arch/x86/boot/compressed/vmlinux'
build-log_5.8.0-rc5-3-amd64-llvm11-ias.txt
make -f ./scripts/Makefile.build obj=arch/x86/boot/compressed
arch/x86/boot/compressed/vmlinux
  clang-11 -E -Wp,-MMD,arch/x86/boot/compressed/.vmlinux.lds.d
-nostdinc -isystem /usr/lib/llvm-11/lib/clang/11.0.0/include
-I./arch/x86/include -I./arch/x86/include/generated  -I./include
-I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include
./include/linux/kconfig.h -D__KERNEL__ -Qunused-arguments   -P -Ux86
-D__ASSEMBLY__ -DLINKER_SCRIPT -o arch/x86/boot/compressed/vmlinux.lds
arch/x86/boot/compressed/vmlinux.lds.S
  llvm-objcopy-11  -R .comment -S vmlinux arch/x86/boot/compressed/vmlinux.bin
  arch/x86/tools/relocs vmlinux >
arch/x86/boot/compressed/vmlinux.relocs;arch/x86/tools/relocs
--abs-relocs vmlinux
  { cat arch/x86/boot/compressed/vmlinux.bin
arch/x86/boot/compressed/vmlinux.relocs | zstd -22 --ultra; printf
\114\015\315\001; } > arch/x86/boot/compressed/vmlinux.bin.zst
  arch/x86/boot/compressed/mkpiggy
arch/x86/boot/compressed/vmlinux.bin.zst >
arch/x86/boot/compressed/piggy.S
  ld.lld-11 -m elf_x86_64  -pie  --no-dynamic-linker -T
arch/x86/boot/compressed/vmlinux.lds
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
  llvm-nm-11 arch/x86/boot/compressed/vmlinux | sed -n -e
's/^\([0-9a-fA-F]*\) [a-zA-Z]
\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$/#define
ZO_ 0x/p' > arch/x86/boot/zoffset.h
  llvm-objcopy-11  -O binary -R .note -R .comment -S
arch/x86/boot/compressed/vmlinux arch/x86/boot/vmlinux.bin

- EOT -

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
> Ard Biesheuvel (3):
>   x86/boot/compressed: Move .got.plt entries out of the .got section
>   x86/boot/compressed: Force hidden visibility for all symbol references
>   x86/boot/compressed: Get rid of GOT fixup code
>
> Arvind Sankar (4):
>   x86/boot: Add .text.* to setup.ld
>   x86/boot: Remove run-time relocations from .head.text code
>   x86/boot: Remove run-time relocations from head_{32,64}.S
>   x86/boot: Check that there are no run-time relocations
>
>  arch/x86/boot/compressed/Makefile      |  39 +-----
>  arch/x86/boot/compressed/head_32.S     |  99 +++++----------
>  arch/x86/boot/compressed/head_64.S     | 165 ++++++++++---------------
>  arch/x86/boot/compressed/mkpiggy.c     |   6 +
>  arch/x86/boot/compressed/vmlinux.lds.S |  24 +++-
>  arch/x86/boot/setup.ld                 |   2 +-
>  drivers/firmware/efi/libstub/Makefile  |   2 +-
>  drivers/firmware/efi/libstub/hidden.h  |   6 -
>  include/linux/hidden.h                 |  19 +++
>  9 files changed, 153 insertions(+), 209 deletions(-)
>  delete mode 100644 drivers/firmware/efi/libstub/hidden.h
>  create mode 100644 include/linux/hidden.h
>
>
> base-commit: e9919e11e219eaa5e8041b7b1a196839143e9125
> --
> 2.26.2
>
