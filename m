Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2837EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E791E2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgCaPLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:11:47 -0400
Received: from foss.arm.com ([217.140.110.172]:54910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgCaPLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:11:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA13631B;
        Tue, 31 Mar 2020 08:11:45 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13D293F71E;
        Tue, 31 Mar 2020 08:11:44 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:11:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.7
Message-ID: <20200331151131.GA17516@mbp>
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

Please pull the arm64 updates below. The bulk is in-kernel pointer
authentication, activity monitors and lots of asm symbol annotations. I
also queued the sys_mremap() patch commenting the asymmetry in the
address untagging.

Thanks.

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to b2a84de2a2deb76a6a51609845341f508c518c03:

  mm/mremap: Add comment explaining the untagging behaviour of mremap() (2020-03-26 11:28:57 +0000)

----------------------------------------------------------------
arm64 updates for 5.7:

- In-kernel Pointer Authentication support (previously only offered to
  user space).

- ARM Activity Monitors (AMU) extension support allowing better CPU
  utilisation numbers for the scheduler (frequency invariance).

- Memory hot-remove support for arm64.

- Lots of asm annotations (SYM_*) in preparation for the in-kernel
  Branch Target Identification (BTI) support.

- arm64 perf updates: ARMv8.5-PMU 64-bit counters, refactoring the PMU
  init callbacks, support for new DT compatibles.

- IPv6 header checksum optimisation.

- Fixes: SDEI (software delegated exception interface) double-lock on
  hibernate with shared events.

- Minor clean-ups and refactoring: cpu_ops accessor, cpu_do_switch_mm()
  converted to C, cpufeature finalisation helper.

- sys_mremap() comment explaining the asymmetric address untagging
  behaviour.

----------------------------------------------------------------
Amit Daniel Kachhap (8):
      arm64: cpufeature: Fix meta-capability cpufeature check
      arm64: ptrauth: Add bootup/runtime flags for __cpu_setup
      arm64: cpufeature: Move cpu capability helpers inside C file
      arm64: initialize ptrauth keys for kernel booting task
      arm64: mask PAC bits of __builtin_return_address
      arm64: __show_regs: strip PAC from lr in printk
      arm64: suspend: restore the kernel ptrauth keys
      lkdtm: arm64: test kernel pointer authentication

Andrew Murray (3):
      arm64: cpufeature: Extract capped perfmon fields
      KVM: arm64: limit PMU version to PMUv3 for ARMv8.1
      arm64: perf: Add support for ARMv8.5-PMU 64-bit counters

Anshuman Khandual (2):
      arm64/mm: Hold memory hotplug lock while walking for kernel page table dump
      arm64/mm: Enable memory hot remove

Catalin Marinas (4):
      Merge branches 'for-next/memory-hotremove', 'for-next/arm_sdei', 'for-next/amu', 'for-next/final-cap-helper', 'for-next/cpu_ops-cleanup', 'for-next/misc' and 'for-next/perf' into for-next/core
      Merge branch 'for-next/asm-annotations' into for-next/core
      Merge branch 'for-next/asm-cleanups' into for-next/core
      Merge branch 'for-next/kernel-ptrauth' into for-next/core

Gavin Shan (4):
      arm64/kernel: Simplify __cpu_up() by bailing out early
      arm64: Declare ACPI parking protocol CPU operation if needed
      arm64: Rename cpu_read_ops() to init_cpu_ops()
      arm64: Introduce get_cpu_ops() helper function

Ionela Voinescu (7):
      arm64: add support for the AMU extension v1
      arm64: trap to EL1 accesses to AMU counters from EL0
      arm64/kvm: disable access to AMU registers from kvm guests
      Documentation: arm64: document support for the AMU extension
      cpufreq: add function to get the hardware max frequency
      arm64: use activity monitors for frequency invariance
      clocksource/drivers/arm_arch_timer: validate arch_timer_rate

James Morse (2):
      firmware: arm_sdei: fix double-lock on hibernate with shared events
      firmware: arm_sdei: Use cpus_read_lock() to avoid races with cpuhp

Kristina Martsenko (7):
      arm64: cpufeature: add pointer auth meta-capabilities
      arm64: rename ptrauth key structures to be user-specific
      arm64: install user ptrauth keys at kernel exit time
      arm64: cpufeature: handle conflicts based on capability
      arm64: enable ptrauth earlier
      arm64: initialize and switch ptrauth kernel keys
      arm64: compile the kernel with ptrauth return address signing

Kunihiko Hayashi (1):
      arm64: entry-ftrace.S: Fix missing argument for CONFIG_FUNCTION_GRAPH_TRACER=y

Li Tao (1):
      arm64: kexec_file: Fixed code style.

Liguang Zhang (2):
      firmware: arm_sdei: fix possible double-lock on hibernate error path
      firmware: arm_sdei: clean up sdei_event_create()

Mark Brown (18):
      arm64: crypto: Modernize some extra assembly annotations
      arm64: crypto: Modernize names for AES function macros
      arm64: entry: Annotate vector table and handlers as code
      arm64: entry: Annotate ret_from_fork as code
      arm64: entry: Additional annotation conversions for entry.S
      arm64: entry-ftrace.S: Convert to modern annotations for assembly functions
      arm64: ftrace: Correct annotation of ftrace_caller assembly
      arm64: ftrace: Modernise annotation of return_to_handler
      arm64: head.S: Convert to modern annotations for assembly functions
      arm64: head: Annotate stext and preserve_boot_args as code
      arm64: kernel: Convert to modern annotations for assembly data
      arm64: kvm: Annotate assembly using modern annoations
      arm64: kvm: Modernize annotation for __bp_harden_hyp_vecs
      arm64: kvm: Modernize __smccc_workaround_1_smc_start annotations
      arm64: sdei: Annotate SDEI entry points using new style annotations
      arm64: vdso: Convert to modern assembler annotations
      arm64: vdso32: Convert to modern assembler annotations
      arm64: head: Convert install_el2_stub to SYM_INNER_LABEL

Mark Rutland (5):
      arm64: mm: convert cpu_do_switch_mm() to C
      arm64: entry: unmask IRQ in el0_sp()
      arm64: cpufeature: add cpus_have_final_cap()
      arm64: kvm: hyp: use cpus_have_final_cap()
      arm64: unwind: strip PAC from kernel addresses

Masahiro Yamada (1):
      arm64: efi: add efi-entry.o to targets instead of extra-$(CONFIG_EFI)

Nathan Chancellor (1):
      arm64: Mark call_smc_arch_workaround_1 as __maybe_unused

Nick Desaulniers (1):
      arm64: Kconfig: verify binutils support for ARM64_PTR_AUTH

Randy Dunlap (1):
      arm64: fix NUMA Kconfig typos

Remi Denis-Courmont (3):
      arm64: remove gratuitious/stray .ltorg stanzas
      arm64: use mov_q instead of literal ldr
      arm64: move kimage_vaddr to .rodata

Robin Murphy (4):
      arm64: perf: Refactor PMU init callbacks
      arm64: perf: Support new DT compatibles
      arm64: csum: Optimise IPv6 header checksum
      arm64: perf: Clean up enable/disable calls

Takashi Iwai (1):
      perf: arm-ccn: Use scnprintf() for robustness

Vincenzo Frascino (1):
      kconfig: Add support for 'as-option'

Will Deacon (2):
      arm64: Update comment for ASID() macro
      mm/mremap: Add comment explaining the untagging behaviour of mremap()

Zheng Wei (1):
      arm64: add blank after 'if'

glider@google.com (1):
      arm64: define __alloc_zeroed_user_highpage

luanshi (1):
      perf: arm_spe: Remove unnecessary zero check on 'nr_pages'

王程刚 (1):
      arch/arm64: fix typo in a comment

韩科才 (2):
      arm64: fix spelling mistake "ca not" -> "cannot"
      arm64: remove redundant blank for '=' operator

 Documentation/arm64/amu.rst               | 112 +++++++++
 Documentation/arm64/booting.rst           |  14 ++
 Documentation/arm64/index.rst             |   1 +
 arch/arm64/Kconfig                        |  69 +++++-
 arch/arm64/Makefile                       |  11 +
 arch/arm64/crypto/aes-ce.S                |   4 +-
 arch/arm64/crypto/aes-modes.S             |  48 ++--
 arch/arm64/crypto/aes-neon.S              |   4 +-
 arch/arm64/crypto/ghash-ce-core.S         |  16 +-
 arch/arm64/include/asm/asm_pointer_auth.h |  65 +++++
 arch/arm64/include/asm/assembler.h        |  16 +-
 arch/arm64/include/asm/checksum.h         |   7 +-
 arch/arm64/include/asm/compiler.h         |  24 ++
 arch/arm64/include/asm/cpu_ops.h          |   8 +-
 arch/arm64/include/asm/cpucaps.h          |   5 +-
 arch/arm64/include/asm/cpufeature.h       | 125 +++++++---
 arch/arm64/include/asm/esr.h              |   2 +-
 arch/arm64/include/asm/kvm_arm.h          |   1 +
 arch/arm64/include/asm/kvm_asm.h          |   4 +
 arch/arm64/include/asm/kvm_mmu.h          |   9 +-
 arch/arm64/include/asm/memory.h           |   1 +
 arch/arm64/include/asm/mmu.h              |  10 +-
 arch/arm64/include/asm/mmu_context.h      |   2 +
 arch/arm64/include/asm/page.h             |   4 +
 arch/arm64/include/asm/perf_event.h       |   3 +-
 arch/arm64/include/asm/pointer_auth.h     |  50 ++--
 arch/arm64/include/asm/proc-fns.h         |   2 -
 arch/arm64/include/asm/processor.h        |   3 +-
 arch/arm64/include/asm/smp.h              |  12 +
 arch/arm64/include/asm/stackprotector.h   |   5 +
 arch/arm64/include/asm/sysreg.h           |  48 ++++
 arch/arm64/include/asm/topology.h         |   9 +
 arch/arm64/kernel/Makefile                |   2 +-
 arch/arm64/kernel/armv8_deprecated.c      |   2 +-
 arch/arm64/kernel/asm-offsets.c           |  16 ++
 arch/arm64/kernel/cpu-reset.S             |   2 +-
 arch/arm64/kernel/cpu_errata.c            |  18 +-
 arch/arm64/kernel/cpu_ops.c               |  11 +-
 arch/arm64/kernel/cpufeature.c            | 165 +++++++++++--
 arch/arm64/kernel/cpuidle.c               |   9 +-
 arch/arm64/kernel/entry-common.c          |   2 +-
 arch/arm64/kernel/entry-ftrace.S          |  48 ++--
 arch/arm64/kernel/entry.S                 | 121 +++++-----
 arch/arm64/kernel/head.S                  |  86 +++----
 arch/arm64/kernel/hibernate-asm.S         |   2 -
 arch/arm64/kernel/hyp-stub.S              |   2 +-
 arch/arm64/kernel/machine_kexec_file.c    |   2 +-
 arch/arm64/kernel/perf_event.c            | 338 +++++++++++++-------------
 arch/arm64/kernel/pointer_auth.c          |   7 +-
 arch/arm64/kernel/process.c               |   5 +-
 arch/arm64/kernel/ptrace.c                |  16 +-
 arch/arm64/kernel/relocate_kernel.S       |   4 +-
 arch/arm64/kernel/setup.c                 |   8 +-
 arch/arm64/kernel/sleep.S                 |   2 +
 arch/arm64/kernel/smp.c                   | 159 +++++++------
 arch/arm64/kernel/stacktrace.c            |   5 +-
 arch/arm64/kernel/topology.c              | 180 ++++++++++++++
 arch/arm64/kernel/vdso/sigreturn.S        |   4 +-
 arch/arm64/kernel/vdso32/sigreturn.S      |  23 +-
 arch/arm64/kvm/hyp-init.S                 |  18 +-
 arch/arm64/kvm/hyp.S                      |   4 +-
 arch/arm64/kvm/hyp/fpsimd.S               |   8 +-
 arch/arm64/kvm/hyp/hyp-entry.S            |  27 ++-
 arch/arm64/kvm/hyp/switch.c               |  28 ++-
 arch/arm64/kvm/hyp/sysreg-sr.c            |   8 +-
 arch/arm64/kvm/hyp/tlb.c                  |   8 +-
 arch/arm64/kvm/sys_regs.c                 | 103 +++++++-
 arch/arm64/lib/csum.c                     |  27 +++
 arch/arm64/lib/strcmp.S                   |   2 +-
 arch/arm64/mm/context.c                   |  32 ++-
 arch/arm64/mm/mmu.c                       | 379 +++++++++++++++++++++++++++++-
 arch/arm64/mm/proc.S                      | 104 ++++----
 arch/arm64/mm/ptdump_debugfs.c            |   4 +
 drivers/base/arch_topology.c              |  12 +
 drivers/clocksource/arm_arch_timer.c      |  18 +-
 drivers/cpufreq/cpufreq.c                 |  20 ++
 drivers/firmware/arm_sdei.c               |  71 +++---
 drivers/misc/lkdtm/bugs.c                 |  36 +++
 drivers/misc/lkdtm/core.c                 |   1 +
 drivers/misc/lkdtm/lkdtm.h                |   1 +
 drivers/perf/arm-ccn.c                    |  20 +-
 drivers/perf/arm_spe_pmu.c                |   2 +-
 include/linux/arch_topology.h             |   2 +
 include/linux/cpufreq.h                   |   5 +
 include/linux/perf/arm_pmu.h              |   1 +
 include/linux/stackprotector.h            |   2 +-
 mm/mremap.c                               |  10 +
 scripts/Kconfig.include                   |   6 +
 88 files changed, 2192 insertions(+), 700 deletions(-)
 create mode 100644 Documentation/arm64/amu.rst
 create mode 100644 arch/arm64/include/asm/asm_pointer_auth.h
 create mode 100644 arch/arm64/include/asm/compiler.h

-- 
Catalin
