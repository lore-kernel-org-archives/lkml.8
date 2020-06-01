Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D68C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C825207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591022582;
	bh=+E2Fde2nOJjq0Z6UIxPsOBprt6fvXlqKZSi34sE7924=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gRgdNSPGyMjlKY6b9YFXTMJhQsDg4YiyrF93E3GtaFq3D/2Y/tApxG+9myR2siEgW
	 X+KxBGEKEYt4klYUEDDvi2Lt0adGnD88XdqNoHQuchrxDQR+6oV/oY4fMPK0Pu7W4u
	 eKNvMZJncQeIc3Ew73R8fg7hOyTTdkrQbb2v5yew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgFAOnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgFAOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:42:57 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703FD20823
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591022576;
        bh=+E2Fde2nOJjq0Z6UIxPsOBprt6fvXlqKZSi34sE7924=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TLPhHkepWjmLjH4gpf5UWMy4x7pyCaAmk8AqHuEnWGZX22bwqmyuM16e8kAdpllFz
         2K3FxW6fCuoZk8/eemrIlnrBLys+5wsnVMKcwJATmqWU2BOzw3ieL+VY+Hc8nml1yc
         f4V8x4e3M1ACMb2GQQXJgrvFzoUjtJBBnp0dAxdA=
Received: by mail-oo1-f51.google.com with SMTP id q188so1044556ooq.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 07:42:56 -0700 (PDT)
X-Gm-Message-State: AOAM530gYavXmPdtr2USA7KBzhE1q8LIj3hb8GwzWfMRLvImXi0Qyufj
        hYOAp6JpGeclJjlCVsyry/6tdh+yYjnd+R0FGyE=
X-Google-Smtp-Source: ABdhPJwmtq0NDHZvTiZl2dEkyql+2lOpJqUCAlA5L+Gvs47YFCTk5Y6eQNQjM5uSN6avIbhFEKfDTmzMvull5aYjqYQ=
X-Received: by 2002:a4a:91c2:: with SMTP id e2mr17136034ooh.45.1591022575713;
 Mon, 01 Jun 2020 07:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200601132443.GA796373@gmail.com>
In-Reply-To: <20200601132443.GA796373@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Jun 2020 16:42:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
Message-ID: <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
Subject: Re: [GIT PULL] EFI changes for v5.8
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020 at 15:24, Ingo Molnar <mingo@kernel.org> wrote:
>
> Linus,
>
> Please pull the latest efi/core git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-06-01
>
>    # HEAD: e9524fb97ab5b41b85e1d3408f8e513433798f3c efi/x86: Don't blow away existing initrd
>
> The EFI changes for this cycle are:
>
>  - preliminary changes for RISC-V
>  - Add support for setting the resolution on the EFI framebuffer
>  - Simplify kernel image loading for arm64
>  - Move .bss into .data via the linker script instead of relying on symbol
>    annotations.
>  - Get rid of __pure getters to access global variables
>  - Clean up the config table matching arrays
>  - Rename pr_efi/pr_efi_err to efi_info/efi_err, and use them consistently
>  - Simplify and unify initrd loading
>  - Parse the builtin command line on x86 (if provided)
>  - Implement printk() support, including support for wide character strings
>  - Simplify GDT handling in early mixed mode thunking code
>  - Some other minor fixes and cleanups
>
>  Thanks,
>
>         Ingo
>

Please note that Stephen reported a conflict with the ARM32 tree, due
to the replacement of all instances of pr_efi_err() with efi_err(),
including a couple in some ARM code that is being modified.

https://lore.kernel.org/linux-next/20200529152907.2205a298@canb.auug.org.au/



> ------------------>
> Ard Biesheuvel (20):
>       efi/libstub: Make initrd file loader configurable
>       efi/libstub: unify EFI call wrappers for non-x86
>       efi/libstub/random: Align allocate size to EFI_ALLOC_ALIGN
>       efi/libstub/random: Increase random alloc granularity
>       efi/libstub/arm64: Replace 'preferred' offset with alignment check
>       efi/libstub/arm64: Simplify randomized loading of kernel image
>       efi/libstub: Add API function to allocate aligned memory
>       efi/libstub/arm64: Switch to ordinary page allocator for kernel image
>       efi/libstub: Move efi_relocate_kernel() into separate source file
>       efi/libstub: Drop __pure getter for efi_system_table
>       efi/libstub: Drop __pure getters for EFI stub options
>       efi/libstub/x86: Avoid getter function for efi_is64
>       efi: Clean up config table description arrays
>       efi: Move arch_tables check to caller
>       efi/libstub: Re-enable command line initrd loading for x86
>       efi/libstub/x86: Work around LLVM ELF quirk build regression
>       efi/libstub: Make efi_printk() input argument const char*
>       efi/libstub: Use pool allocation for the command line
>       efi/efivars: Add missing kobject_put() in sysfs entry creation error path
>       efi/libstub: Add missing prototype for PE/COFF entry point
>
> Arvind Sankar (56):
>       efi/gop: Remove redundant current_fb_base
>       efi/gop: Move check for framebuffer before con_out
>       efi/gop: Get mode information outside the loop
>       efi/gop: Factor out locating the gop into a function
>       efi/gop: Slightly re-arrange logic of find_gop
>       efi/gop: Move variable declarations into loop block
>       efi/gop: Use helper macros for populating lfb_base
>       efi/gop: Use helper macros for find_bits
>       efi/gop: Remove unreachable code from setup_pixel_info
>       efi/gop: Add prototypes for query_mode and set_mode
>       efi/gop: Allow specifying mode number on command line
>       efi/gop: Allow specifying mode by <xres>x<yres>
>       efi/gop: Allow specifying depth as well as resolution
>       efi/gop: Allow automatically choosing the best mode
>       efi/arm: Remove __efistub_global annotation
>       efi/x86: Remove __efistub_global and add relocation check
>       efi: Kill __efistub_global
>       efi/x86: Use correct size for boot_params
>       efi/libstub: Add a helper function to split 64-bit values
>       efi/libstub: Move pr_efi/pr_efi_err into efi namespace
>       efi/x86: Use efi_err for error messages
>       efi/gop: Use efi_err for error messages
>       efi/tpm: Use efi_err for error messages
>       efi/libstub: Upgrade ignored dtb= argument message to error
>       efi/x86: Move command-line initrd loading to efi_main
>       efi/libstub: Unify initrd loading across architectures
>       efi/x86: Support builtin command line
>       efi/libstub: Check return value of efi_parse_options
>       efi/libstub: Fix mixed mode boot issue after macro refactor
>       efi/libstub: Include dependencies of efistub.h
>       efi/libstub: Rename efi_[char16_]printk to efi_[char16_]puts
>       efi/libstub: Buffer output of efi_puts
>       efi/libstub: Add a basic printf implementation
>       efi/libstub: Optimize for size instead of speed
>       efi/printf: Drop %n format and L qualifier
>       efi/printf: Add 64-bit and 8-bit integer support
>       efi/printf: Factor out flags parsing and handle '%' earlier
>       efi/printf: Fix minor bug in precision handling
>       efi/printf: Merge 'p' with the integer formats
>       efi/printf: Factor out width/precision parsing
>       efi/printf: Factor out integer argument retrieval
>       efi/printf: Handle null string input
>       efi/printf: Refactor code to consolidate padding and output
>       efi/printf: Abort on invalid format
>       efi/printf: Turn vsprintf into vsnprintf
>       efi/libstub: Implement printk-style logging
>       efi/libstub: Add definitions for console input and events
>       efi/gop: Add an option to list out the available GOP modes
>       efi/printf: Add support for wchar_t (UTF-16)
>       efi/libstub: Add UTF-8 decoding to efi_puts
>       efi/libstub: Use %ls for filename
>       efi/libstub: Get the exact UTF-8 length
>       efi/libstub: Use snprintf with %ls to convert the command line
>       efi/libstub: Don't parse overlong command lines
>       efi/x86: Drop the special GDT for the EFI thunk
>       efi/x86: Don't blow away existing initrd
>
> Atish Patra (1):
>       efi/libstub: Move arm-stub to a common file
>
> Joe Perches (1):
>       efi/libstub: Correct comment typos
>
> Zou Wei (1):
>       efi/libstub/arm: Make install_memreserve_table static
>
>
>  Documentation/fb/efifb.rst                         |  38 +-
>  arch/arm/Kconfig                                   |   2 +-
>  arch/arm/boot/compressed/efi-header.S              |   2 +-
>  arch/arm/boot/compressed/vmlinux.lds.S             |   2 +-
>  arch/arm/include/asm/efi.h                         |   8 -
>  arch/arm64/Kconfig                                 |   2 +-
>  arch/arm64/include/asm/efi.h                       |   8 -
>  arch/arm64/kernel/efi-entry.S                      |   2 +-
>  arch/arm64/kernel/efi-header.S                     |   2 +-
>  arch/ia64/kernel/efi.c                             |  12 +-
>  arch/x86/boot/compressed/efi_thunk_64.S            |  19 +-
>  arch/x86/boot/compressed/vmlinux.lds.S             |   1 +
>  arch/x86/include/asm/efi.h                         |  50 +-
>  arch/x86/platform/efi/efi.c                        |   8 +-
>  arch/x86/xen/efi.c                                 |   2 +-
>  drivers/firmware/efi/Kconfig                       |  15 +-
>  drivers/firmware/efi/arm-init.c                    |   4 +-
>  drivers/firmware/efi/efi.c                         |  44 +-
>  drivers/firmware/efi/efivars.c                     |   4 +-
>  drivers/firmware/efi/libstub/Makefile              |  47 +-
>  drivers/firmware/efi/libstub/alignedmem.c          |  57 ++
>  drivers/firmware/efi/libstub/arm32-stub.c          |  12 +-
>  drivers/firmware/efi/libstub/arm64-stub.c          | 106 ++--
>  drivers/firmware/efi/libstub/efi-stub-helper.c     | 381 +++++++++-----
>  .../efi/libstub/{arm-stub.c => efi-stub.c}         |  93 ++--
>  drivers/firmware/efi/libstub/efistub.h             | 191 +++++--
>  drivers/firmware/efi/libstub/fdt.c                 |  24 +-
>  drivers/firmware/efi/libstub/file.c                |  48 +-
>  drivers/firmware/efi/libstub/gop.c                 | 583 +++++++++++++++++----
>  drivers/firmware/efi/libstub/mem.c                 | 191 +------
>  drivers/firmware/efi/libstub/pci.c                 |  10 +-
>  drivers/firmware/efi/libstub/randomalloc.c         |   6 +-
>  drivers/firmware/efi/libstub/relocate.c            | 174 ++++++
>  drivers/firmware/efi/libstub/secureboot.c          |   4 +-
>  drivers/firmware/efi/libstub/tpm.c                 |   2 +-
>  drivers/firmware/efi/libstub/vsprintf.c            | 564 ++++++++++++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c            | 155 +++---
>  include/linux/efi.h                                |   6 +-
>  38 files changed, 2050 insertions(+), 829 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/alignedmem.c
>  rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (83%)
>  create mode 100644 drivers/firmware/efi/libstub/relocate.c
>  create mode 100644 drivers/firmware/efi/libstub/vsprintf.c
