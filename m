Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E3BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE68C2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591031601;
	bh=igB7PkxgJiC4wmJhq6yybNQV6XQP56cov100yzZhT5A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=utgXE+Gzko8zqnCWA5JC/NI9C0MSPh3e1yTsMF35uBaGxZR8p0r/JqF8tz0xq+GOQ
	 VH3O8iLCFq18d54cJYyMhLw6IaZZbOHvSqjz5tegKOBYN8njtJCovjigZSLDHsvwEI
	 VATIOIcJ+GP3sDlafoMDjz7E2FbTgKRE6rQdiIWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFARNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgFARNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:13:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F37E20734;
        Mon,  1 Jun 2020 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591031595;
        bh=igB7PkxgJiC4wmJhq6yybNQV6XQP56cov100yzZhT5A=;
        h=Date:From:To:Cc:Subject:From;
        b=bnk0SX076J4ppdkgdbIcVQRTMx+UYQeJWmUxCGkqb0jThxG5r9psrIOIUYvL47EB6
         UMHgUkydEusQtg7yKO5zCFI4MnyqyCAbMU+ZKqQBkSvNagTSj9nqbbrkvDcdqqoe26
         sMSaOcOQ3tcN3i5LRI0DEq2/pVffy+IXDWCDBP1U=
Date:   Mon, 1 Jun 2020 18:13:10 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, peterz@infradead.org, bp@alien8.de,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.8
Message-ID: <20200601171309.GA6390@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this sizeable pile of arm64 updates for 5.8. Summary in the tag,
but the big two features are support for Branch Target Identification and
Clang's Shadow Call stack. The latter is currently arm64-only, but the
high-level parts are all in core code so it could easily be adopted by
other architectures pending toolchain support.

Please note that this includes the x86/asm branch from -tip due to a
dependency from the BTI code on the new 'CONFIG_ARCH_USE_SYM_ANNOTATIONS'
option. I've left that in the diffstat below because it's only two commits.

Cheers,

Will

--->8

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 082af5ec5080b028f7d0846a6c27cbb87f288205:

  Merge branch 'for-next/scs' into for-next/core (2020-05-28 18:03:40 +0100)

----------------------------------------------------------------
arm64 updates for 5.8

- Branch Target Identification (BTI)
	* Support for ARMv8.5-BTI in both user- and kernel-space. This
	  allows branch targets to limit the types of branch from which
	  they can be called and additionally prevents branching to
	  arbitrary code, although kernel support requires a very recent
	  toolchain.

	* Function annotation via SYM_FUNC_START() so that assembly
	  functions are wrapped with the relevant "landing pad"
	  instructions.

	* BPF and vDSO updates to use the new instructions.

	* Addition of a new HWCAP and exposure of BTI capability to
	  userspace via ID register emulation, along with ELF loader
	  support for the BTI feature in .note.gnu.property.

	* Non-critical fixes to CFI unwind annotations in the sigreturn
	  trampoline.

- Shadow Call Stack (SCS)
	* Support for Clang's Shadow Call Stack feature, which reserves
	  platform register x18 to point at a separate stack for each
	  task that holds only return addresses. This protects function
	  return control flow from buffer overruns on the main stack.

	* Save/restore of x18 across problematic boundaries (user-mode,
	  hypervisor, EFI, suspend, etc).

	* Core support for SCS, should other architectures want to use it
	  too.

	* SCS overflow checking on context-switch as part of the existing
	  stack limit check if CONFIG_SCHED_STACK_END_CHECK=y.

- CPU feature detection
	* Removed numerous "SANITY CHECK" errors when running on a system
	  with mismatched AArch32 support at EL1. This is primarily a
	  concern for KVM, which disabled support for 32-bit guests on
	  such a system.

	* Addition of new ID registers and fields as the architecture has
	  been extended.

- Perf and PMU drivers
	* Minor fixes and cleanups to system PMU drivers.

- Hardware errata
	* Unify KVM workarounds for VHE and nVHE configurations.

	* Sort vendor errata entries in Kconfig.

- Secure Monitor Call Calling Convention (SMCCC)
	* Update to the latest specification from Arm (v1.2).

	* Allow PSCI code to query the SMCCC version.

- Software Delegated Exception Interface (SDEI)
	* Unexport a bunch of unused symbols.

	* Minor fixes to handling of firmware data.

- Pointer authentication
	* Add support for dumping the kernel PAC mask in vmcoreinfo so
	  that the stack can be unwound by tools such as kdump.

	* Simplification of key initialisation during CPU bringup.

- BPF backend
	* Improve immediate generation for logical and add/sub
	  instructions.

- vDSO
	- Minor fixes to the linker flags for consistency with other
	  architectures and support for LLVM's unwinder.

	- Clean up logic to initialise and map the vDSO into userspace.

- ACPI
	- Work around for an ambiguity in the IORT specification relating
	  to the "num_ids" field.

	- Support _DMA method for all named components rather than only
	  PCIe root complexes.

	- Minor other IORT-related fixes.

- Miscellaneous
	* Initialise debug traps early for KGDB and fix KDB cacheflushing
	  deadlock.

	* Minor tweaks to early boot state (documentation update, set
	  TEXT_OFFSET to 0x0, increase alignment of PE/COFF sections).

	* Refactoring and cleanup

----------------------------------------------------------------
Amit Daniel Kachhap (2):
      arm64/crash_core: Export KERNELPACMASK in vmcoreinfo
      Documentation/vmcoreinfo: Add documentation for 'KERNELPACMASK'

Andrew Scull (1):
      arm64: Unify WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}

Anshuman Khandual (16):
      arm64/cpuinfo: Move device_initcall() near cpuinfo_regs_init()
      arm64/cpufeature: Validate hypervisor capabilities during CPU hotplug
      arm64/cpufeature: Drop open encodings while extracting parange
      arm64/cpufeature: Add explicit ftr_id_isar0[] for ID_ISAR0 register
      arm64/cpufeature: Drop TraceFilt feature exposure from ID_DFR0 register
      arm64/cpufeature: Make doublelock a signed feature in ID_AA64DFR0
      arm64/cpufeature: Introduce ID_PFR2 CPU register
      arm64/cpufeature: Introduce ID_DFR1 CPU register
      arm64/cpufeature: Introduce ID_MMFR5 CPU register
      arm64/cpufeature: Add remaining feature bits in ID_PFR0 register
      arm64/cpufeature: Add remaining feature bits in ID_MMFR4 register
      arm64/cpufeature: Add remaining feature bits in ID_AA64ISAR0 register
      arm64/cpufeature: Add remaining feature bits in ID_AA64PFR0 register
      arm64/cpufeature: Add remaining feature bits in ID_AA64PFR1 register
      arm64/cpuinfo: Add ID_MMFR4_EL1 into the cpuinfo_arm64 context
      arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()

Ard Biesheuvel (9):
      arm64: rename stext to primary_entry
      arm64: drop GZFLAGS definition and export
      arm64/kernel: vmlinux.lds: drop redundant discard/keep macros
      arm64: set TEXT_OFFSET to 0x0 in preparation for removing it entirely
      arm64: drop duplicate definitions of ID_AA64MMFR0_TGRAN constants
      efi/libstub/arm64: align PE/COFF sections to segment alignment
      ACPI/IORT: take _DMA methods into account for named components
      Revert "ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()"
      ACPI/IORT: work around num_ids ambiguity

Borislav Petkov (1):
      x86/32: Remove CONFIG_DOUBLEFAULT

Catalin Marinas (1):
      arm64: Reorder the macro arguments in the copy routines

Christoph Hellwig (1):
      firmware: arm_sdei: remove unused interfaces

Daniel Kiss (1):
      mm: smaps: Report arm64 guarded pages in smaps

Daniel Thompson (1):
      arm64: cacheflush: Fix KGDB trap detection

Dave Martin (11):
      ELF: UAPI and Kconfig additions for ELF program properties
      ELF: Add ELF program property parsing support
      arm64: Basic Branch Target Identification support
      elf: Allow arch to tweak initial mmap prot flags
      arm64: elf: Enable BTI at exec based on ELF program properties
      arm64: BTI: Decode BYTPE bits when printing PSTATE
      arm64: unify native/compat instruction skipping
      arm64: traps: Shuffle code to eliminate forward declarations
      arm64: BTI: Reset BTYPE when skipping emulated instructions
      KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions
      arm64: BTI: Add Kconfig entry for userspace BTI

Douglas Anderson (1):
      arm64: Call debug_traps_init() from trap_init() to help early kgdb

Gavin Shan (2):
      arm64/mm: Use phys_to_page() to access pgtable memory
      arm64/kernel: Fix range on invalidating dcache for boot page tables

Geert Uytterhoeven (2):
      arm64: Sort vendor-specific errata
      arm64: cpufeature: Add "or" to mitigations for multiple errata

George Spelvin (1):
      arm64: kexec_file: Avoid temp buffer for RNG seed

Guixiong Wei (1):
      arm: mm: use __pfn_to_section() to get mem_section

Hanjun Guo (4):
      ACPI: IORT: Add extra message "applying workaround" for off-by-1 issue
      ACPI: GTDT: Put GTDT table after parsing
      ACPI: IORT: Add comments for not calling acpi_put_table()
      firmware: arm_sdei: Put the SDEI table after using it

James Morse (1):
      firmware: arm_sdei: Document the motivation behind these set_fs() calls

Jason Yan (1):
      arm64: entry: remove unneeded semicolon in el1_sync_handler()

Jean-Philippe Brucker (2):
      pmu/smmuv3: Clear IRQ affinity hint on device removal
      arm64: mm: Add asid_gen_match() helper

Luke Nelson (3):
      arm64: insn: Fix two bugs in encoding 32-bit logical immediates
      bpf, arm64: Optimize AND,OR,XOR,JSET BPF_K using arm64 logical immediates
      bpf, arm64: Optimize ADD,SUB,JMP BPF_K using arm64 add/sub immediates

Marc Zyngier (2):
      KVM: arm64: Check advertised Stage-2 page size capability
      KVM: arm64: Move __load_guest_stage2 to kvm_mmu.h

Mark Brown (23):
      arm64: mm: Display guarded pages in ptdump
      arm64: bti: Document behaviour for dynamically linked binaries
      x86/asm: Provide a Kconfig symbol for disabling old assembly annotations
      arm64: lib: Consistently enable crc32 extension
      arm64: entry: Refactor and modernise annotation for ret_to_user
      arm64: kernel: Convert to modern annotations for assembly functions
      arm64: Disable old style assembly annotations
      arm64: insn: Add constants for new HINT instruction decode
      arm64: insn: Provide a better name for aarch64_insn_is_nop()
      arm64: insn: Don't assume unrecognized HINTs are skippable
      arm64: insn: Report PAC and BTI instructions as skippable
      arm64: Document why we enable PAC support for leaf functions
      arm64: bti: Support building kernel C code using BTI
      arm64: asm: Override SYM_FUNC_START when building the kernel with BTI
      arm64: Set GP bit in kernel page tables to enable BTI for the kernel
      arm64: bpf: Annotate JITed code for BTI
      arm64: mm: Mark executable text as guarded pages
      arm64: bti: Provide Kconfig for kernel mode BTI
      arm64: asm: Provide a mechanism for generating ELF note for BTI
      arm64: vdso: Annotate for BTI
      arm64: vdso: Force the vDSO to be linked as BTI when built for BTI
      arm64: vdso: Map the vDSO text with guarded pages when built for BTI
      arm64: bti: Fix support for userspace only BTI

Mark Rutland (6):
      arm64: remove ptrauth_keys_install_kernel sync arg
      arm64: simplify ptrauth initialization
      arm64: vdso: remove aarch32_vdso_pages[]
      arm64: vdso: simplify arch_vdso_type ifdeffery
      arm64: vdso: use consistent 'abi' nomenclature
      arm64: vdso: use consistent 'map' nomenclature

Rob Herring (1):
      arm64: silicon-errata.rst: Sort the Cortex-A55 entries

Sai Prakash Ranjan (1):
      arm64: cpufeature: Relax check for IESB support

Sami Tolvanen (12):
      scs: Add support for Clang's Shadow Call Stack (SCS)
      scs: Add page accounting for shadow call stack allocations
      scs: Add support for stack usage debugging
      scs: Disable when function graph tracing is enabled
      arm64: Reserve register x18 from general allocation with SCS
      arm64: Preserve register x18 when CPU is suspended
      arm64: efi: Restore register x18 if it was corrupted
      arm64: vdso: Disable Shadow Call Stack
      arm64: Disable SCS for hypervisor code
      arm64: Implement Shadow Call Stack
      arm64: scs: Add shadow stacks for SDEI
      efi/libstub: Disable Shadow Call Stack

Shaokun Zhang (1):
      drivers/perf: hisi: Fix typo in events attribute array

Sudeep Holla (8):
      firmware: arm_sdei: Drop check for /firmware/ node and always register driver
      firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
      firmware: smccc: Update link to latest SMCCC specification
      firmware: smccc: Add the definition for SMCCCv1.2 version/error codes
      firmware: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
      firmware: smccc: Refactor SMCCC specific bits into separate file
      firmware: smccc: Add function to fetch SMCCC version
      firmware: smccc: Fix missing prototype warning for arm_smccc_version_init

Tang Bin (2):
      drivers/perf: arm_dsu_pmu: Avoid duplicate printouts
      drivers/perf: arm_spe_pmu: Avoid duplicate printouts

Tuan Phan (1):
      ACPI/IORT: Fix PMCG node single ID mapping handling

Vincenzo Frascino (2):
      arm64: vdso: Add '-Bsymbolic' to ldflags
      arm64: vdso: Add --eh-frame-hdr to ldflags

Will Deacon (28):
      arm64: elf: Fix allnoconfig kernel build with !ARCH_USE_GNU_PROPERTY
      arm64: cpufeature: Spell out register fields for ID_ISAR4 and ID_PFR1
      arm64: cpufeature: Add CPU capability for AArch32 EL1 support
      arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()
      arm64: cpufeature: Factor out checking of AArch32 features
      arm64: cpufeature: Relax AArch32 system checks if EL1 is 64-bit only
      arm64: cpufeature: Relax checks for AArch32 support at EL[0-2]
      arm64: cpufeature: Add an overview comment for the cpufeature framework
      arm64: docs: Mandate that the I-cache doesn't hold stale kernel text
      Merge branch 'x86/asm' of git://git.kernel.org/.../tip/tip into for-next/asm
      arm64: cpufeature: Extend comment to describe absence of field info
      arm64: cpufeature: Group indexed system register definitions by name
      Merge branch 'for-next/bti-user' into for-next/bti
      Merge branches 'for-next/asm' and 'for-next/insn' into for-next/bti
      arm64: kconfig: Update and comment GCC version check for kernel BTI
      arm64: scs: Store absolute SCS stack pointer value in thread_info
      scs: Move accounting into alloc/free functions
      arm64: scs: Use 'scs_sp' register alias for x18
      scs: Move scs_overflow_check() out of architecture code
      scs: Remove references to asm/scs.h from core code
      scs: Move DEFINE_SCS macro into core code
      arm64: entry-ftrace.S: Update comment to indicate that x18 is live
      arm64: vdso: Don't prefix sigreturn trampoline with a BTI C instruction
      arm64: vdso: Fix CFI directives in sigreturn trampoline
      Merge branches 'for-next/acpi', 'for-next/bpf', 'for-next/cpufeature', 'for-next/docs', 'for-next/kconfig', 'for-next/misc', 'for-next/perf', 'for-next/ptr-auth', 'for-next/sdei', 'for-next/smccc' and 'for-next/vdso' into for-next/core
      Merge branch 'for-next/bti' into for-next/core
      Merge branch 'for-next/kvm/errata' into for-next/core
      Merge branch 'for-next/scs' into for-next/core

Yunfeng Ye (1):
      arm64: stacktrace: Factor out some common code into on_stack()

Zenghui Yu (2):
      KVM: arm64: Drop PTE_S2_MEMATTR_MASK
      ACPI/IORT: Remove the unused __get_pci_rid()

Zhou Wang (1):
      drivers/perf: hisi: Permit modular builds of HiSilicon uncore drivers

Zou Wei (1):
      arm64: smp: Make cpus_stuck_in_kernel static

Łukasz Stelmach (1):
      arm64: kexec_file: print appropriate variable

 Documentation/admin-guide/kdump/vmcoreinfo.rst     |   6 +
 Documentation/arm64/booting.rst                    |   3 +-
 Documentation/arm64/cpu-feature-registers.rst      |   2 +
 Documentation/arm64/elf_hwcaps.rst                 |   5 +
 Documentation/arm64/silicon-errata.rst             |   8 +-
 Documentation/filesystems/proc.rst                 |   1 +
 MAINTAINERS                                        |   9 +
 Makefile                                           |   6 +
 arch/Kconfig                                       |  25 ++
 arch/arm64/Kconfig                                 | 162 +++++---
 arch/arm64/Makefile                                |  16 +-
 arch/arm64/include/asm/asm_pointer_auth.h          |  43 +-
 arch/arm64/include/asm/assembler.h                 |  50 +++
 arch/arm64/include/asm/cacheflush.h                |   6 +-
 arch/arm64/include/asm/compiler.h                  |   4 -
 arch/arm64/include/asm/cpu.h                       |   4 +
 arch/arm64/include/asm/cpucaps.h                   |  17 +-
 arch/arm64/include/asm/cpufeature.h                |  30 ++
 arch/arm64/include/asm/debug-monitors.h            |   2 +
 arch/arm64/include/asm/elf.h                       |  50 +++
 arch/arm64/include/asm/esr.h                       |   2 +-
 arch/arm64/include/asm/exception.h                 |   1 +
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/insn.h                      |  30 +-
 arch/arm64/include/asm/kvm_emulate.h               |   6 +-
 arch/arm64/include/asm/kvm_host.h                  |   6 +-
 arch/arm64/include/asm/kvm_hyp.h                   |  20 +-
 arch/arm64/include/asm/kvm_mmu.h                   |  19 +-
 arch/arm64/include/asm/linkage.h                   |  46 +++
 arch/arm64/include/asm/mman.h                      |  37 ++
 arch/arm64/include/asm/pgtable-hwdef.h             |   2 +-
 arch/arm64/include/asm/pgtable-prot.h              |  11 +
 arch/arm64/include/asm/pgtable.h                   |   9 +-
 arch/arm64/include/asm/ptrace.h                    |   1 +
 arch/arm64/include/asm/scs.h                       |  29 ++
 arch/arm64/include/asm/smp.h                       |  11 -
 arch/arm64/include/asm/stacktrace.h                |  40 +-
 arch/arm64/include/asm/suspend.h                   |   2 +-
 arch/arm64/include/asm/sysreg.h                    |  77 +++-
 arch/arm64/include/asm/thread_info.h               |  13 +
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/mman.h                 |   9 +
 arch/arm64/include/uapi/asm/ptrace.h               |   9 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/asm-offsets.c                    |   7 +-
 arch/arm64/kernel/cpu-reset.S                      |   4 +-
 arch/arm64/kernel/cpu_errata.c                     |  29 +-
 arch/arm64/kernel/cpufeature.c                     | 455 +++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c                        |   9 +-
 arch/arm64/kernel/crash_core.c                     |   4 +
 arch/arm64/kernel/debug-monitors.c                 |   4 +-
 arch/arm64/kernel/efi-entry.S                      |   2 +-
 arch/arm64/kernel/efi-header.S                     |   2 +-
 arch/arm64/kernel/efi-rt-wrapper.S                 |  15 +-
 arch/arm64/kernel/entry-common.c                   |  13 +-
 arch/arm64/kernel/entry-fpsimd.S                   |  20 +-
 arch/arm64/kernel/entry-ftrace.S                   |   5 +-
 arch/arm64/kernel/entry.S                          |  69 +++-
 arch/arm64/kernel/head.S                           |  49 ++-
 arch/arm64/kernel/hibernate-asm.S                  |  16 +-
 arch/arm64/kernel/hyp-stub.S                       |  20 +-
 arch/arm64/kernel/image-vars.h                     |   2 +-
 arch/arm64/kernel/insn.c                           |  46 ++-
 arch/arm64/kernel/machine_kexec_file.c             |  14 +-
 arch/arm64/kernel/paravirt.c                       |   2 +-
 arch/arm64/kernel/probes/decode-insn.c             |   2 +-
 arch/arm64/kernel/probes/kprobes_trampoline.S      |   4 +-
 arch/arm64/kernel/process.c                        |  41 +-
 arch/arm64/kernel/ptrace.c                         |   2 +-
 arch/arm64/kernel/reloc_test_syms.S                |  44 +-
 arch/arm64/kernel/relocate_kernel.S                |   4 +-
 arch/arm64/kernel/scs.c                            |  16 +
 arch/arm64/kernel/sdei.c                           |  28 +-
 arch/arm64/kernel/signal.c                         |  16 +
 arch/arm64/kernel/sleep.S                          |  13 +-
 arch/arm64/kernel/smccc-call.S                     |   8 +-
 arch/arm64/kernel/smp.c                            |  10 +-
 arch/arm64/kernel/syscall.c                        |  18 +
 arch/arm64/kernel/traps.c                          | 133 +++---
 arch/arm64/kernel/vdso.c                           | 155 ++++---
 arch/arm64/kernel/vdso/Makefile                    |  12 +-
 arch/arm64/kernel/vdso/note.S                      |   3 +
 arch/arm64/kernel/vdso/sigreturn.S                 |  54 ++-
 arch/arm64/kernel/vdso/vdso.S                      |   3 +
 arch/arm64/kernel/vdso32/sigreturn.S               |  19 +-
 arch/arm64/kernel/vmlinux.lds.S                    |  18 +-
 arch/arm64/kvm/hyp/switch.c                        |   6 +-
 arch/arm64/kvm/hyp/sysreg-sr.c                     |   6 +-
 arch/arm64/kvm/hyp/tlb.c                           |  11 +-
 arch/arm64/kvm/reset.c                             |  65 ++-
 arch/arm64/kvm/sys_regs.c                          |   6 +-
 arch/arm64/lib/copy_from_user.S                    |  32 +-
 arch/arm64/lib/copy_in_user.S                      |  32 +-
 arch/arm64/lib/copy_to_user.S                      |  32 +-
 arch/arm64/lib/crc32.S                             |   2 +-
 arch/arm64/lib/memcpy.S                            |  32 +-
 arch/arm64/mm/context.c                            |   8 +-
 arch/arm64/mm/dump.c                               |   5 +
 arch/arm64/mm/init.c                               |   2 +-
 arch/arm64/mm/mmu.c                                |  24 ++
 arch/arm64/mm/pageattr.c                           |   4 +-
 arch/arm64/mm/proc.S                               |  60 +--
 arch/arm64/net/bpf_jit.h                           |  30 ++
 arch/arm64/net/bpf_jit_comp.c                      |  85 +++-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/Kconfig.debug                             |   9 -
 arch/x86/entry/entry_32.S                          |   2 -
 arch/x86/include/asm/doublefault.h                 |   2 +-
 arch/x86/include/asm/traps.h                       |   2 -
 arch/x86/kernel/Makefile                           |   4 +-
 arch/x86/kernel/dumpstack_32.c                     |   4 -
 arch/x86/kernel/traps.c                            |   2 -
 arch/x86/mm/cpu_entry_area.c                       |   4 +-
 drivers/acpi/arm64/gtdt.c                          |   4 +-
 drivers/acpi/arm64/iort.c                          | 126 +++---
 drivers/base/node.c                                |   6 +
 drivers/firmware/Kconfig                           |   6 +-
 drivers/firmware/Makefile                          |   3 +-
 drivers/firmware/arm_sdei.c                        |  49 +--
 drivers/firmware/efi/libstub/Makefile              |   3 +
 drivers/firmware/psci/psci.c                       |  21 +-
 drivers/firmware/smccc/Kconfig                     |  16 +
 drivers/firmware/smccc/Makefile                    |   3 +
 drivers/firmware/smccc/smccc.c                     |  31 ++
 drivers/perf/Kconfig                               |   9 +-
 drivers/perf/arm_dsu_pmu.c                         |   4 +-
 drivers/perf/arm_smmuv3_pmu.c                      |   5 +-
 drivers/perf/arm_spe_pmu.c                         |   4 +-
 drivers/perf/hisilicon/Kconfig                     |   7 +
 drivers/perf/hisilicon/Makefile                    |   3 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |  10 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |  12 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |  10 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |  23 +-
 fs/Kconfig.binfmt                                  |   6 +
 fs/binfmt_elf.c                                    | 145 ++++++-
 fs/compat_binfmt_elf.c                             |   4 +
 fs/proc/meminfo.c                                  |   4 +
 fs/proc/task_mmu.c                                 |   3 +
 include/linux/arm-smccc.h                          |  25 +-
 include/linux/compiler-clang.h                     |   4 +
 include/linux/compiler_types.h                     |   4 +
 include/linux/elf.h                                |  43 ++
 include/linux/linkage.h                            |   8 +-
 include/linux/mm.h                                 |   3 +
 include/linux/mmzone.h                             |   3 +
 include/linux/psci.h                               |   7 -
 include/linux/scs.h                                |  72 ++++
 include/uapi/linux/elf.h                           |  11 +
 init/init_task.c                                   |   8 +
 kernel/Makefile                                    |   1 +
 kernel/fork.c                                      |   9 +
 kernel/sched/core.c                                |   5 +
 kernel/scs.c                                       | 104 +++++
 lib/Kconfig                                        |   3 +
 mm/page_alloc.c                                    |   6 +
 mm/vmstat.c                                        |   3 +
 .../testing/selftests/wireguard/qemu/debug.config  |   1 -
 virt/kvm/arm/arm.c                                 |   4 +-
 159 files changed, 2559 insertions(+), 976 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/asm/scs.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h
 create mode 100644 arch/arm64/kernel/scs.c
 create mode 100644 drivers/firmware/smccc/Kconfig
 create mode 100644 drivers/firmware/smccc/Makefile
 create mode 100644 drivers/firmware/smccc/smccc.c
 create mode 100644 drivers/perf/hisilicon/Kconfig
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c
