Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1A3C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116FD2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580197738;
	bh=LEfNTguCG+k83RiFA54mWj5mYg8HAFNm3WeDrdXwqTI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sHk2RE7fTk4CDb34rKMOnntrznS1pxHVeX8HwCUeD5pZ8BnKRADsoEStidRNwgYAm
	 tZNI8JeUSrbpxBUvq5HOEnHCLkmhGvizAjRoS1ls9a/ciawWpcjnkBt7hBIH6g71bj
	 a8/H5sVblPvNrzyWqtwxcSLaM8GSC8SFTp/UlGvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgA1Hs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:48:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41665 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgA1Hs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:48:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so14807249wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hPRSx8qzUZZdULRrUzzwpcfJCMrhpaZU+g4sJTFkO8k=;
        b=HC7PPfrkLPCbYdINQRjgv19kowWNfVhL4Y0Gvkk16KNMVnmUrf4FAGZF4d/5U4mZCg
         aI/gtBvoiSApIrHsmiwqvoghdkxmn9AtpI+NicnnxnA4lqG20U7XxEsREsa8wtXRk8GN
         XTl03xUh+r1IsULeGyftQmXLfOEOMn7Kb83dEOoIqTuHvrbuZ1C+SLAq9cu5mu4LzmZx
         sXQ4lCkSI5g7XkB490Wh/QlAvAEnd2HNxpYGal6v2o8+tLenlxi/KFcDsEmuyzmXLY2Q
         E33QCVQKYkTj4IcQfTTDRlX5A/NbiuQsXk1M8B2bBndUAtLqpDdaJy1G5zMc9VUCoxOq
         6WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hPRSx8qzUZZdULRrUzzwpcfJCMrhpaZU+g4sJTFkO8k=;
        b=qX7L32lYQAx4SuHKJw4saF1a4IV9kHWuuaW8J+RAhpMSsssea8XTjn+SxqM2WgB9FJ
         FSroye2rzNRIrhf2IZKHFyqfpLZgVpoatnllPCxAYopDRT3t7jpPqpUu3xeQ0rqVlhXT
         IN25pr7Juix+cZBjG3u1fIYJQE5cwxE64r5CSAvYZiX9XWy0P+Z68rYUAEEvFjRwcwK+
         wuGHu6EzPMxNxDQjB4bsCteLeQ2YI6XKOiiPXslmiv5R5Wd9s52q4Qrc4JBPFatCOkpx
         Tn2T4hYv8k0g+TaIX3pk9q3Qn5WAyvhuqaoC2R807Ot0BIQ+CDhYVmXAF08ZrGm7hfy9
         YY2A==
X-Gm-Message-State: APjAAAWBlXMAHIrCnQ2Zoe0bw5ym9Tbfw8VW5iTr1B2hik/L5EJzWY9g
        Lk96fzgCWdG4ACsOBJ5EUGL2mJKT
X-Google-Smtp-Source: APXvYqzEj5DdZbnrfiH8A4/nCF52bRaMzZp1nc4ZHkQJpA3Vj3++1DfVGRxejGpXIjacmrpV/FbDEQ==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr26540080wrp.321.1580197732641;
        Mon, 27 Jan 2020 23:48:52 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f1sm24386716wrp.93.2020.01.27.23.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 23:48:52 -0800 (PST)
Date:   Tue, 28 Jan 2020 08:48:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI changes for v5.6
Message-ID: <20200128074850.GA27168@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: ac6119e7f25b842fc061e8aec88c4f32d3bc28ef efi/x86: Disable instrumentation in the EFI runtime handling code

The main changes in this cycle were:

 - Cleanup of the GOP [graphics output] handling code in the EFI stub
 - Complete refactoring of the mixed mode handling in the x86 EFI stub
 - Overhaul of the x86 EFI boot/runtime code
 - Increase robustness for mixed mode code
 - Add the ability to disable DMA at the root port level in the EFI stub
 - Get rid of RWX mappings in the EFI memory map and page tables, where possible
 - Move the support code for the old EFI memory mapping style into its only
   user, the SGI UV1+ support code.
 - plus misc fixes, updates, smaller cleanups.

 - And due to interactions with the RWX changes, another round of PAT 
   cleanups make a guest appearance via the EFI tree - with no side 
   effects intended.

 Thanks,

	Ingo

------------------>
Anshuman Khandual (1):
      efi: Fix comment for efi_mem_type() wrt absent physical addresses

Ard Biesheuvel (46):
      efi/libstub: Remove unused __efi_call_early() macro
      efi/x86: Rename efi_is_native() to efi_is_mixed()
      efi/libstub: Use a helper to iterate over a EFI handle array
      efi/libstub: Extend native protocol definitions with mixed_mode aliases
      efi/libstub: Distinguish between native/mixed not 32/64 bit
      efi/libstub: Drop explicit 32/64-bit protocol definitions
      efi/libstub: Use stricter typing for firmware function pointers
      efi/libstub: Annotate firmware routines as __efiapi
      efi/libstub/x86: Avoid thunking for native firmware calls
      efi/libstub: Avoid protocol wrapper for file I/O routines
      efi/libstub: Get rid of 'sys_table_arg' macro parameter
      efi/libstub: Unify the efi_char16_printk implementations
      efi/libstub/x86: Drop __efi_early() export and efi_config struct
      efi/libstub: Drop sys_table_arg from printk routines
      efi/libstub: Remove 'sys_table_arg' from all function prototypes
      efi/libstub/x86: Work around page freeing issue in mixed mode
      efi/libstub: Drop protocol argument from efi_call_proto() macro
      efi/libstub: Drop 'table' argument from efi_table_attr() macro
      efi/libstub: Rename efi_call_early/_runtime macros to be more intuitive
      efi/libstub: Tidy up types and names of global cmdline variables
      efi/libstub/x86: Avoid globals to store context during mixed mode calls
      efi/libstub: Fix boot argument handling in mixed mode entry code
      efi/libstub/x86: Force 'hidden' visibility for extern declarations
      efi/x86: Re-disable RT services for 32-bit kernels running on 64-bit EFI
      efi/x86: Map the entire EFI vendor string before copying it
      efi/x86: Avoid redundant cast of EFI firmware service pointer
      efi/x86: Split off some old memmap handling into separate routines
      efi/x86: Split SetVirtualAddresMap() wrappers into 32 and 64 bit versions
      efi/x86: Simplify i386 efi_call_phys() firmware call wrapper
      efi/x86: Simplify 64-bit EFI firmware call wrapper
      efi/x86: Simplify mixed mode call wrapper
      efi/x86: Drop two near identical versions of efi_runtime_init()
      efi/x86: Clean up efi_systab_init() routine for legibility
      efi/x86: Don't panic or BUG() on non-critical error conditions
      efi/x86: Remove unreachable code in kexec_enter_virtual_mode()
      efi/libstub/x86: Use const attribute for efi_is_64bit()
      efi/libstub/x86: Use mandatory 16-byte stack alignment in mixed mode
      x86/mm: Fix NX bit clearing issue in kernel_map_pages_in_pgd
      efi/x86: Don't map the entire kernel text RW for mixed mode
      efi/x86: Avoid RWX mappings for all of DRAM
      efi/x86: Limit EFI old memory map to SGI UV machines
      efi/arm: Defer probe of PCIe backed efifb on DT systems
      efi/x86: avoid KASAN false positives when accessing the 1: 1 mapping
      x86/boot/compressed: Relax sed symbol type regex for LLVM ld.lld
      efi/x86: Disallow efi=old_map in mixed mode
      efi/x86: Disable instrumentation in the EFI runtime handling code

Arnd Bergmann (1):
      efi/libstub/x86: Fix unused-variable warning

Arvind Sankar (6):
      efi/gop: Remove bogus packed attribute from GOP structures
      efi/gop: Remove unused typedef
      efi/gop: Convert GOP structures to typedef and clean up some types
      efi/gop: Unify 32/64-bit functions
      efi/x86: Check number of arguments to variadic functions
      efi/x86: Allow translating 64-bit arguments for mixed mode calls

Dan Williams (4):
      efi: Add a flags parameter to efi_memory_map
      efi: Add tracking for dynamically allocated memmaps
      efi: Fix efi_memmap_alloc() leaks
      efi: Fix handling of multiple efi_fake_mem= entries

Ingo Molnar (16):
      x86/setup: Clean up the header portion of setup.c
      x86/setup: Enhance the comments
      x86/mm/pat: Update the comments in pat.c and pat_interval.c and refresh the code a bit
      x86/mm/pat: Disambiguate PAT-disabled boot messages
      x86/mm/pat: Create fixed width output in /sys/kernel/debug/x86/pat_memtype_list, similar to the E820 debug printouts
      x86/mm/pat: Simplify the free_memtype() control flow
      x86/mm/pat: Harmonize 'struct memtype *' local variable and function parameter use
      x86/mm/pat: Clean up PAT initialization flags
      x86/mm/pat: Move the memtype related files to arch/x86/mm/pat/
      x86/mm/pat: Standardize on memtype_*() prefix for APIs
      x86/mm/pat: Rename <asm/pat.h> => <asm/memtype.h>
      x86/mm/pat: Clean up <asm/memtype.h> externs
      x86/mm/pat: Fix typo in the Kconfig help text
      x86/mm: Tabulate the page table encoding definitions
      mm/vmalloc: Add empty <asm/vmalloc.h> headers and use them from <linux/vmalloc.h>
      mm, x86/mm: Untangle address space layout definitions from basic pgtable type definitions

Matthew Garrett (1):
      efi: Allow disabling PCI busmastering on bridges during boot

Qian Cai (1):
      efi/libstub/x86: Fix EFI server boot failure

kbuild test robot (1):
      x86/mm/pat: Mark __cpa_flush_tlb() as static


 Documentation/admin-guide/kernel-parameters.txt |  10 +-
 arch/alpha/include/asm/vmalloc.h                |   4 +
 arch/arc/include/asm/vmalloc.h                  |   4 +
 arch/arm/include/asm/efi.h                      |  17 +-
 arch/arm/include/asm/vmalloc.h                  |   4 +
 arch/arm64/include/asm/efi.h                    |  16 +-
 arch/arm64/include/asm/vmalloc.h                |   4 +
 arch/c6x/include/asm/vmalloc.h                  |   4 +
 arch/csky/include/asm/vmalloc.h                 |   4 +
 arch/h8300/include/asm/vmalloc.h                |   4 +
 arch/hexagon/include/asm/vmalloc.h              |   4 +
 arch/ia64/include/asm/vmalloc.h                 |   4 +
 arch/m68k/include/asm/vmalloc.h                 |   4 +
 arch/microblaze/include/asm/vmalloc.h           |   4 +
 arch/mips/include/asm/vmalloc.h                 |   4 +
 arch/nds32/include/asm/vmalloc.h                |   4 +
 arch/nios2/include/asm/vmalloc.h                |   4 +
 arch/openrisc/include/asm/vmalloc.h             |   4 +
 arch/parisc/include/asm/vmalloc.h               |   4 +
 arch/powerpc/include/asm/vmalloc.h              |   4 +
 arch/riscv/include/asm/vmalloc.h                |   4 +
 arch/s390/include/asm/vmalloc.h                 |   4 +
 arch/sh/include/asm/vmalloc.h                   |   4 +
 arch/sparc/include/asm/vmalloc.h                |   4 +
 arch/um/include/asm/vmalloc.h                   |   4 +
 arch/unicore32/include/asm/vmalloc.h            |   4 +
 arch/x86/Kconfig                                |  13 +-
 arch/x86/boot/Makefile                          |   2 +-
 arch/x86/boot/compressed/Makefile               |   2 +-
 arch/x86/boot/compressed/eboot.c                | 278 ++++-----
 arch/x86/boot/compressed/eboot.h                |  30 +-
 arch/x86/boot/compressed/efi_stub_32.S          |  87 ---
 arch/x86/boot/compressed/efi_stub_64.S          |   5 -
 arch/x86/boot/compressed/efi_thunk_64.S         |  65 +-
 arch/x86/boot/compressed/head_32.S              |  64 +-
 arch/x86/boot/compressed/head_64.S              |  97 +--
 arch/x86/include/asm/cpu_entry_area.h           |  10 +-
 arch/x86/include/asm/efi.h                      | 244 +++++---
 arch/x86/include/asm/memtype.h                  |  27 +
 arch/x86/include/asm/mmu_context.h              |  86 +--
 arch/x86/include/asm/mtrr.h                     |   4 +-
 arch/x86/include/asm/pat.h                      |  27 -
 arch/x86/include/asm/pci.h                      |   2 +-
 arch/x86/include/asm/pgtable_32_areas.h         |  53 ++
 arch/x86/include/asm/pgtable_32_types.h         |  57 +-
 arch/x86/include/asm/pgtable_areas.h            |  16 +
 arch/x86/include/asm/pgtable_types.h            | 143 ++---
 arch/x86/include/asm/vmalloc.h                  |   6 +
 arch/x86/kernel/cpu/common.c                    |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c              |   2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c                 |   2 +-
 arch/x86/kernel/cpu/scattered.c                 |   2 +-
 arch/x86/kernel/cpu/topology.c                  |   2 +-
 arch/x86/kernel/kexec-bzimage64.c               |   2 +-
 arch/x86/kernel/ldt.c                           |  83 +++
 arch/x86/kernel/setup.c                         | 164 ++---
 arch/x86/kernel/x86_init.c                      |   2 +-
 arch/x86/kvm/mmu/mmu.c                          |   2 +-
 arch/x86/mm/Makefile                            |   8 +-
 arch/x86/mm/fault.c                             |   1 +
 arch/x86/mm/init_32.c                           |   1 +
 arch/x86/mm/iomap_32.c                          |   6 +-
 arch/x86/mm/ioremap.c                           |  12 +-
 arch/x86/mm/pat/Makefile                        |   5 +
 arch/x86/mm/{pageattr-test.c => pat/cpa-test.c} |   0
 arch/x86/mm/{pat.c => pat/memtype.c}            | 203 ++++---
 arch/x86/mm/{pat_internal.h => pat/memtype.h}   |  12 +-
 arch/x86/mm/pat/memtype_interval.c              | 194 ++++++
 arch/x86/mm/{pageattr.c => pat/set_memory.c}    |  32 +-
 arch/x86/mm/pat_interval.c                      | 185 ------
 arch/x86/mm/pgtable_32.c                        |   1 +
 arch/x86/mm/physaddr.c                          |   1 +
 arch/x86/pci/i386.c                             |   2 +-
 arch/x86/platform/efi/Makefile                  |   3 +-
 arch/x86/platform/efi/efi.c                     | 398 ++++--------
 arch/x86/platform/efi/efi_32.c                  |  22 +-
 arch/x86/platform/efi/efi_64.c                  | 317 ++++------
 arch/x86/platform/efi/efi_stub_32.S             | 109 +---
 arch/x86/platform/efi/efi_stub_64.S             |  43 +-
 arch/x86/platform/efi/efi_thunk_64.S            | 121 +---
 arch/x86/platform/efi/quirks.c                  |  46 +-
 arch/x86/platform/uv/bios_uv.c                  | 169 +++++-
 arch/x86/xen/efi.c                              |   2 +-
 arch/x86/xen/mmu_pv.c                           |   2 +-
 arch/xtensa/include/asm/vmalloc.h               |   4 +
 drivers/firmware/efi/Kconfig                    |  22 +
 drivers/firmware/efi/arm-init.c                 | 107 +++-
 drivers/firmware/efi/efi.c                      |   2 +-
 drivers/firmware/efi/fake_mem.c                 |  43 +-
 drivers/firmware/efi/libstub/Makefile           |   2 +-
 drivers/firmware/efi/libstub/arm-stub.c         | 110 ++--
 drivers/firmware/efi/libstub/arm32-stub.c       |  70 +--
 drivers/firmware/efi/libstub/arm64-stub.c       |  32 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 290 +++++----
 drivers/firmware/efi/libstub/efistub.h          |  48 +-
 drivers/firmware/efi/libstub/fdt.c              |  53 +-
 drivers/firmware/efi/libstub/gop.c              | 163 +----
 drivers/firmware/efi/libstub/pci.c              | 114 ++++
 drivers/firmware/efi/libstub/random.c           |  77 ++-
 drivers/firmware/efi/libstub/secureboot.c       |  11 +-
 drivers/firmware/efi/libstub/tpm.c              |  48 +-
 drivers/firmware/efi/memmap.c                   |  95 ++-
 drivers/infiniband/hw/mlx5/main.c               |   2 +-
 drivers/media/pci/ivtv/ivtvfb.c                 |   2 +-
 include/linux/efi.h                             | 772 ++++++++++--------------
 include/linux/mm.h                              |  15 +-
 include/linux/vmalloc.h                         |   2 +
 mm/highmem.c                                    |   2 +-
 mm/vmalloc.c                                    |   8 +
 109 files changed, 2697 insertions(+), 3008 deletions(-)
 create mode 100644 arch/alpha/include/asm/vmalloc.h
 create mode 100644 arch/arc/include/asm/vmalloc.h
 create mode 100644 arch/arm/include/asm/vmalloc.h
 create mode 100644 arch/arm64/include/asm/vmalloc.h
 create mode 100644 arch/c6x/include/asm/vmalloc.h
 create mode 100644 arch/csky/include/asm/vmalloc.h
 create mode 100644 arch/h8300/include/asm/vmalloc.h
 create mode 100644 arch/hexagon/include/asm/vmalloc.h
 create mode 100644 arch/ia64/include/asm/vmalloc.h
 create mode 100644 arch/m68k/include/asm/vmalloc.h
 create mode 100644 arch/microblaze/include/asm/vmalloc.h
 create mode 100644 arch/mips/include/asm/vmalloc.h
 create mode 100644 arch/nds32/include/asm/vmalloc.h
 create mode 100644 arch/nios2/include/asm/vmalloc.h
 create mode 100644 arch/openrisc/include/asm/vmalloc.h
 create mode 100644 arch/parisc/include/asm/vmalloc.h
 create mode 100644 arch/powerpc/include/asm/vmalloc.h
 create mode 100644 arch/riscv/include/asm/vmalloc.h
 create mode 100644 arch/s390/include/asm/vmalloc.h
 create mode 100644 arch/sh/include/asm/vmalloc.h
 create mode 100644 arch/sparc/include/asm/vmalloc.h
 create mode 100644 arch/um/include/asm/vmalloc.h
 create mode 100644 arch/unicore32/include/asm/vmalloc.h
 delete mode 100644 arch/x86/boot/compressed/efi_stub_32.S
 delete mode 100644 arch/x86/boot/compressed/efi_stub_64.S
 create mode 100644 arch/x86/include/asm/memtype.h
 delete mode 100644 arch/x86/include/asm/pat.h
 create mode 100644 arch/x86/include/asm/pgtable_32_areas.h
 create mode 100644 arch/x86/include/asm/pgtable_areas.h
 create mode 100644 arch/x86/include/asm/vmalloc.h
 create mode 100644 arch/x86/mm/pat/Makefile
 rename arch/x86/mm/{pageattr-test.c => pat/cpa-test.c} (100%)
 rename arch/x86/mm/{pat.c => pat/memtype.c} (84%)
 rename arch/x86/mm/{pat_internal.h => pat/memtype.h} (81%)
 create mode 100644 arch/x86/mm/pat/memtype_interval.c
 rename arch/x86/mm/{pageattr.c => pat/set_memory.c} (98%)
 delete mode 100644 arch/x86/mm/pat_interval.c
 create mode 100644 arch/xtensa/include/asm/vmalloc.h
 create mode 100644 drivers/firmware/efi/libstub/pci.c
