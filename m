Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88696C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475BC24686
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579798715;
	bh=e8i1z5xIawCD0bKdr3G/MvvmQxsn3awofKBh6b/ORl4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mnMYtVd4gWC3x9KppE8venEkRHJyxXlNZCkPC9osr1yjZsc1xUSq55XbwONv7qDEC
	 Bfsm4vDv+DTKxB4tH95jZAMydqH8WvjrqTXJ26YNu5BvkTYrFHy2MC4HAmGN9vCX9W
	 ACYz6KiMmbddZJ8o+0ruHGwvu7XEHK151FmZOi3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgAWQ6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgAWQ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:58:34 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F3221D7E;
        Thu, 23 Jan 2020 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579798712;
        bh=e8i1z5xIawCD0bKdr3G/MvvmQxsn3awofKBh6b/ORl4=;
        h=Date:From:To:Cc:Subject:From;
        b=tptI3U2G15NsUJYDaJ7gytohQVDnl2lSWEfL527GR0Ajt+I/QRye2rHpltq2q7Z28
         E4XOb/HUAYIQCBSO+5NDcS3vsekJQgPVfdeDv9TMN+sFXs0UVvogSeQRKoEWCdZu4G
         3d+vaKkrvDxwqHOTLRFluY0N0OOCCuShybI8T50s=
Date:   Thu, 23 Jan 2020 16:58:28 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Subject: [GIT PULL] arm64 updates for 5.6
Message-ID: <20200123165828.GB20126@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull these arm64 updates for 5.6. I'm sending this now because
I'm away from tomorrow until Monday and, since the branch is tagged and
ready to go, why wait?

There's a summary in the tag, although the changes are a real mixed bag
this time around. The only scary looking one from the diffstat is the
uapi change to asm-generic/mman-common.h, but this has been acked by
Arnd and is actually just adding a pair of comments in an attempt to
prevent allocation of some PROT values which tend to get used for
arch-specific purposes. We'll be using them for Branch Target
Identification (a CFI-like hardening feature), which is currently under
review on the mailing list.

There was a trivial conflict in -next for a couple of entries in the
arm64 Kconfig fighting over context, but apart from that it's been
unusually smooth.

Cheers,

Will

--->8

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to e533dbe9dcb199bb637a2c465f3a6e70564994fe:

  arm64: acpi: fix DAIF manipulation with pNMI (2020-01-22 14:41:22 +0000)

----------------------------------------------------------------
arm64 updates for 5.6

- New architecture features
	* Support for Armv8.5 E0PD, which benefits KASLR in the same way as
	  KPTI but without the overhead. This allows KPTI to be disabled on
	  CPUs that are not affected by Meltdown, even is KASLR is enabled.

	* Initial support for the Armv8.5 RNG instructions, which claim to
	  provide access to a high bandwidth, cryptographically secure hardware
	  random number generator. As well as exposing these to userspace, we
	  also use them as part of the KASLR seed and to seed the crng once
	  all CPUs have come online.

	* Advertise a bunch of new instructions to userspace, including support
	  for Data Gathering Hint, Matrix Multiply and 16-bit floating point.

- Kexec
	* Cleanups in preparation for relocating with the MMU enabled
	* Support for loading crash dump kernels with kexec_file_load()

- Perf and PMU drivers
	* Cleanups and non-critical fixes for a couple of system PMU drivers

- FPU-less (aka broken) CPU support
	* Considerable fixes to support CPUs without the FP/SIMD extensions,
	  including their presence in heterogeneous systems. Good luck finding
	  a 64-bit userspace that handles this.

- Modern assembly function annotations
	* Start migrating our use of ENTRY() and ENDPROC() over to the
	  new-fangled SYM_{CODE,FUNC}_{START,END} macros, which are intended to
	  aid debuggers

- Kbuild
	* Cleanup detection of LSE support in the assembler by introducing
	  'as-instr'

	* Remove compressed Image files when building clean targets

- IP checksumming
	* Implement optimised IPv4 checksumming routine when hardware offload
	  is not in use. An IPv6 version is in the works, pending testing.

- Hardware errata
	* Work around Cortex-A55 erratum #1530923

- Shadow call stack
	* Work around some issues with Clang's integrated assembler not liking
	  our perfectly reasonable assembly code

	* Avoid allocating the X18 register, so that it can be used to hold the
	  shadow call stack pointer in future

- ACPI
	* Fix ID count checking in IORT code. This may regress broken firmware
	  that happened to work with the old implementation, in which case we'll
	  have to revert it and try something else

	* Fix DAIF corruption on return from GHES handler with pseudo-NMIs

- Miscellaneous
	* Whitelist some CPUs that are unaffected by Spectre-v2

	* Reduce frequency of ASID rollover when KPTI is compiled in but
	  inactive

	* Reserve a couple of arch-specific PROT flags that are already used by
	  Sparc and PowerPC and are planned for later use with BTI on arm64

	* Preparatory cleanup of our entry assembly code in preparation for
	  moving more of it into C later on

	* Refactoring and cleanup

----------------------------------------------------------------
AKASHI Takahiro (2):
      libfdt: include fdt_addresses.c
      arm64: kexec_file: add crash dump support

Anshuman Khandual (1):
      arm64: Introduce ID_ISAR6 CPU register

Anthony Steinhauser (1):
      Return ENODEV when the selected speculation misfeature is unsupported

Ard Biesheuvel (3):
      arm64/lib: copy_page: avoid x18 register in assembler code
      arm64: kvm: stop treating register x18 as caller save
      arm64: kernel: avoid x18 in __cpu_soft_restart

Catalin Marinas (3):
      kbuild: Add support for 'as-instr' to be used in Kconfig files
      arm64: Move the LSE gas support detection to Kconfig
      arm64: Use macros instead of hard-coded constants for MAIR_EL1

Dave Martin (1):
      mm: Reserve asm-generic prot flags 0x10 and 0x20 for arch use

Dirk Behme (1):
      arm64: kbuild: remove compressed images on 'make ARCH=arm64 (dist)clean'

Florian Fainelli (1):
      arm64: kpti: Add Broadcom Brahma-B53 core to the KPTI whitelist

Hanjun Guo (2):
      arm64: armv8_deprecated: update the comments of armv8_deprecated_init()
      ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()

Joe Perches (1):
      arm64: Kconfig: Remove CONFIG_ prefix from ARM64_PSEUDO_NMI section

Julien Thierry (1):
      arm64: entry: Avoid empty alternatives entries

Leonard Crestez (1):
      perf/imx_ddr: Fix cpu hotplug state cleanup

Mark Brown (11):
      arm64: asm: Add new-style position independent function annotations
      arm64: lib: Use modern annotations for assembly functions
      arm64: mm: Use modern annotations for assembly functions
      arm64: asm: Remove ENDPIPROC()
      arm64: xen: Use modern annotations for assembly functions
      arm64: kernel: Correct annotation of end of el0_sync
      arm64: Add initial support for E0PD
      arm64: Factor out checks for KASLR in KPTI code into separate function
      arm64: Don't use KPTI where we have E0PD
      arm64: Use a variable to store non-global mappings decision
      arm64: Use v8.5-RNG entropy for KASLR seed

Mark Rutland (6):
      arm64: assembler: remove inherit_daif macro
      arm64: assembler: remove smp_dmb macro
      arm64: entry: mark all entry code as notrace
      arm64: entry: cleanup el0 svc handler naming
      arm64: entry: cleanup sp_el0 manipulation
      arm64: acpi: fix DAIF manipulation with pNMI

Pan Zhang (1):
      mm: change_memory_common: add spaces for `*` operator

Pavel Tatashin (10):
      kexec: quiet down kexec reboot
      kexec: add machine_kexec_post_load()
      arm64: kexec: remove unnecessary debug prints
      arm64: kexec: make dtb_mem always enabled
      arm64: hibernate: pass the allocated pgdp to ttbr0
      arm64: hibernate: use get_safe_page directly
      arm64: hibernate: remove gotos as they are not needed
      arm64: hibernate: rename dst to page in create_safe_exec_page
      arm64: hibernate: add PUD_SECT_RDONLY
      arm64: hibernate: add trans_pgd public functions

Prabhakar Kushwaha (1):
      arm64: Remove __exception_text_start and __exception_text_end from asm/section.h

Richard Henderson (1):
      arm64: Implement archrandom.h for ARMv8.5-RNG

Robin Murphy (2):
      arm64: Implement optimised checksum routine
      arm64: csum: Fix pathological zero-length calls

Sai Prakash Ranjan (1):
      arm64: Add KRYO{3,4}XX CPU cores to spectre-v2 safe list

Sami Tolvanen (3):
      arm64: lse: fix LSE atomics with LLVM's integrated assembler
      arm64: fix alternatives with LLVM's integrated assembler
      arm64: mm: avoid x18 in idmap_kpti_install_ng_mappings

Shaokun Zhang (1):
      drivers/perf: hisi: Simplify hisi_read_sccl_and_ccl_id and its comment

Steven Price (4):
      arm64: cpufeature: Export matrix and other features to userspace
      arm64: Rename WORKAROUND_1165522 to SPECULATIVE_AT_VHE
      arm64: Rename WORKAROUND_1319367 to SPECULATIVE_AT_NVHE
      arm64: Workaround for Cortex-A55 erratum 1530923

Suzuki K Poulose (7):
      arm64: Introduce system_capabilities_finalized() marker
      arm64: fpsimd: Make sure SVE setup is complete before SIMD is used
      arm64: cpufeature: Fix the type of no FP/SIMD capability
      arm64: cpufeature: Set the FP/SIMD compat HWCAP bits properly
      arm64: ptrace: nofpsimd: Fail FP/SIMD regset operations
      arm64: signal: nofpsimd: Handle fp/simd context for signal frames
      arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag cleanly

Vladimir Murzin (3):
      arm64: Turn "broken gas inst" into real config option
      arm64: context: Free up kernel ASIDs if KPTI is not in use
      arm64: Kconfig: select HAVE_FUTEX_CMPXCHG

Will Deacon (8):
      Revert "arm64: kexec: make dtb_mem always enabled"
      arm64: Simplify early check for broken TX1 when KASLR is enabled
      arm64: Use register field helper in kaslr_requires_kpti()
      arm64: kconfig: Fix alignment of E0PD help text
      Merge branches 'for-next/acpi', 'for-next/cpufeatures', 'for-next/csum', 'for-next/e0pd', 'for-next/entry', 'for-next/kbuild', 'for-next/kexec/cleanup', 'for-next/kexec/file-kdump', 'for-next/misc', 'for-next/nofpsimd', 'for-next/perf' and 'for-next/scs' into for-next/core
      Merge branch 'for-next/asm-annotations' into for-next/core
      Merge branch 'for-next/errata' into for-next/core
      Merge branch 'for-next/rng' into for-next/core

 Documentation/arm64/cpu-feature-registers.rst |  16 +++
 Documentation/arm64/elf_hwcaps.rst            |  31 +++++
 Documentation/arm64/silicon-errata.rst        |   2 +
 arch/arm64/Kconfig                            |  56 +++++++-
 arch/arm64/Makefile                           |  17 +--
 arch/arm64/boot/Makefile                      |   2 +-
 arch/arm64/include/asm/alternative.h          |  32 +++--
 arch/arm64/include/asm/archrandom.h           |  75 ++++++++++
 arch/arm64/include/asm/assembler.h            |  24 ----
 arch/arm64/include/asm/atomic_ll_sc.h         |   2 +-
 arch/arm64/include/asm/atomic_lse.h           |  19 +++
 arch/arm64/include/asm/checksum.h             |   3 +
 arch/arm64/include/asm/cpu.h                  |   1 +
 arch/arm64/include/asm/cpucaps.h              |   8 +-
 arch/arm64/include/asm/cpufeature.h           |   5 +
 arch/arm64/include/asm/cputype.h              |   4 +
 arch/arm64/include/asm/daifflags.h            |  11 +-
 arch/arm64/include/asm/exception.h            |   4 +-
 arch/arm64/include/asm/hwcap.h                |   8 ++
 arch/arm64/include/asm/kexec.h                |   4 +
 arch/arm64/include/asm/kvm_host.h             |   4 +-
 arch/arm64/include/asm/kvm_hyp.h              |   6 +-
 arch/arm64/include/asm/linkage.h              |  16 +++
 arch/arm64/include/asm/lse.h                  |  12 +-
 arch/arm64/include/asm/mmu.h                  |  48 +------
 arch/arm64/include/asm/pgtable-hwdef.h        |   3 +
 arch/arm64/include/asm/pgtable-prot.h         |   4 +-
 arch/arm64/include/asm/sections.h             |   1 -
 arch/arm64/include/asm/simd.h                 |   8 +-
 arch/arm64/include/asm/sysreg.h               |  38 +++++
 arch/arm64/include/uapi/asm/hwcap.h           |   8 ++
 arch/arm64/kernel/acpi.c                      |   2 +-
 arch/arm64/kernel/armv8_deprecated.c          |   3 +-
 arch/arm64/kernel/cpu-reset.S                 |   4 +-
 arch/arm64/kernel/cpu_errata.c                |  27 +++-
 arch/arm64/kernel/cpufeature.c                | 191 ++++++++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c                   |   9 ++
 arch/arm64/kernel/entry-common.c              |   8 +-
 arch/arm64/kernel/entry.S                     |  26 ++--
 arch/arm64/kernel/fpsimd.c                    |  30 +++-
 arch/arm64/kernel/hibernate.c                 | 151 ++++++++++----------
 arch/arm64/kernel/kaslr.c                     |  11 ++
 arch/arm64/kernel/kexec_image.c               |   4 -
 arch/arm64/kernel/machine_kexec.c             |  12 --
 arch/arm64/kernel/machine_kexec_file.c        | 106 +++++++++++++-
 arch/arm64/kernel/process.c                   |   2 +-
 arch/arm64/kernel/ptrace.c                    |  21 +++
 arch/arm64/kernel/setup.c                     |   7 +
 arch/arm64/kernel/signal.c                    |   6 +-
 arch/arm64/kernel/signal32.c                  |   4 +-
 arch/arm64/kernel/ssbd.c                      |   4 +-
 arch/arm64/kernel/syscall.c                   |   4 +-
 arch/arm64/kvm/hyp/entry.S                    |  45 +++---
 arch/arm64/kvm/hyp/switch.c                   |  20 ++-
 arch/arm64/kvm/hyp/sysreg-sr.c                |   4 +-
 arch/arm64/kvm/hyp/tlb.c                      |  12 +-
 arch/arm64/kvm/sys_regs.c                     |   2 +-
 arch/arm64/lib/Makefile                       |   6 +-
 arch/arm64/lib/clear_page.S                   |   4 +-
 arch/arm64/lib/clear_user.S                   |   4 +-
 arch/arm64/lib/copy_from_user.S               |   4 +-
 arch/arm64/lib/copy_in_user.S                 |   4 +-
 arch/arm64/lib/copy_page.S                    |  42 +++---
 arch/arm64/lib/copy_to_user.S                 |   4 +-
 arch/arm64/lib/crc32.S                        |   8 +-
 arch/arm64/lib/csum.c                         | 126 +++++++++++++++++
 arch/arm64/lib/memchr.S                       |   4 +-
 arch/arm64/lib/memcmp.S                       |   4 +-
 arch/arm64/lib/memcpy.S                       |   8 +-
 arch/arm64/lib/memmove.S                      |   8 +-
 arch/arm64/lib/memset.S                       |   8 +-
 arch/arm64/lib/strchr.S                       |   4 +-
 arch/arm64/lib/strcmp.S                       |   4 +-
 arch/arm64/lib/strlen.S                       |   4 +-
 arch/arm64/lib/strncmp.S                      |   4 +-
 arch/arm64/lib/strnlen.S                      |   4 +-
 arch/arm64/lib/strrchr.S                      |   4 +-
 arch/arm64/lib/tishift.S                      |  12 +-
 arch/arm64/mm/cache.S                         |  52 +++----
 arch/arm64/mm/context.c                       |  38 +++--
 arch/arm64/mm/pageattr.c                      |   2 +-
 arch/arm64/mm/proc.S                          | 114 ++++++++-------
 arch/arm64/xen/hypercall.S                    |   8 +-
 drivers/acpi/arm64/iort.c                     |  57 +++++++-
 drivers/perf/fsl_imx8_ddr_perf.c              |  16 ++-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  58 ++++----
 include/uapi/asm-generic/mman-common.h        |   2 +
 kernel/kexec.c                                |   4 +
 kernel/kexec_core.c                           |   8 +-
 kernel/kexec_file.c                           |   4 +
 kernel/kexec_internal.h                       |   2 +
 lib/Makefile                                  |   2 +-
 lib/fdt_addresses.c                           |   2 +
 scripts/Kconfig.include                       |   4 +
 94 files changed, 1315 insertions(+), 515 deletions(-)
 create mode 100644 arch/arm64/include/asm/archrandom.h
 create mode 100644 arch/arm64/lib/csum.c
 create mode 100644 lib/fdt_addresses.c
