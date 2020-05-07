Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF6C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 02:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A49F20736
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 02:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgEGCwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 22:52:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:21336 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgEGCwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 22:52:08 -0400
IronPort-SDR: XQ9VO9Euss9nueAz7yAQycDUnDwyVcpg/Oj7KSbmo/lXigozOkywDnRoHSVy0pcssIAF21TbUV
 fVv5ibIeV/gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 19:52:06 -0700
IronPort-SDR: OqTszefPrIFgDuUpA9hn50M1ivfdyuTzITbjP3rBuWlGkvc/A/vtDG7Y0a0lx/yYZkQ0BAsdka
 C/jnVXyiiRWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="304988164"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2020 19:52:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWWdo-0005Qa-7j; Thu, 07 May 2020 10:52:04 +0800
Date:   Thu, 07 May 2020 10:51:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:tglx.2020.05.05a] BUILD REGRESSION
 e6d36eed49b863bbe393e3c07cae737cd9c475e3
Message-ID: <5eb3779c.HW3KBITqhspDLfd7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  tglx.2020.05.05a
branch HEAD: e6d36eed49b863bbe393e3c07cae737cd9c475e3  x86/entry: Remove the TRACE_IRQS cruft

Error/Warning in current branch:

arch/um/include/asm/irqflags.h:11: Error: no such instruction: `static inline unsigned long arch_local_save_flags(void)'
arch/um/include/asm/irqflags.h:12: Error: no such instruction: `{'
arch/um/include/asm/irqflags.h:13: Error: no such instruction: `return get_signals()'
arch/um/include/asm/irqflags.h:14: Error: junk at end of line, first unrecognized character is `}'
arch/um/include/asm/irqflags.h:17: Error: no such instruction: `static inline void arch_local_irq_restore(unsigned long flags)'
arch/um/include/asm/irqflags.h:19: Error: invalid character '(' in mnemonic
arch/um/include/asm/irqflags.h:23: Error: no such instruction: `static inline void arch_local_irq_enable(void)'
arch/um/include/asm/irqflags.h:29: Error: no such instruction: `static inline void arch_local_irq_disable(void)'
arch/um/include/asm/irqflags.h:5: Error: no such instruction: `extern int get_signals(void)'
arch/um/include/asm/irqflags.h:6: Error: no such instruction: `extern int set_signals(int enable)'
arch/um/include/asm/irqflags.h:7: Error: no such instruction: `extern void block_signals(void)'
arch/um/include/asm/irqflags.h:8: Error: no such instruction: `extern void unblock_signals(void)'
arch/x86/entry/common.o: warning: objtool: run_on_irqstack()+0x4e: undefined stack state
arch/x86/kernel/apic/vector.o: warning: objtool: irqst_sysvec_irq_move_cleanup()+0x1e: undefined stack state
arch/x86/kernel/cpu/acrn.o: warning: objtool: irqst_sysvec_acrn_hv_callback()+0x1e: undefined stack state
arch/x86/kernel/cpu/acrn.o: warning: objtool: irqst_sysvec_acrn_hv_callback()+0x3d: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_ipi()+0x1c: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_ipi()+0x1e: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_ipi()+0x3d: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_nested_ipi()+0x1c: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_nested_ipi()+0x1e: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_nested_ipi()+0x3d: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_wakeup_ipi()+0x1c: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_wakeup_ipi()+0x1e: undefined stack state
arch/x86/kernel/irq.o: warning: objtool: irqst_sysvec_kvm_posted_intr_wakeup_ipi()+0x3d: undefined stack state
arch/x86/kernel/irq_work.o: warning: objtool: irqst_sysvec_irq_work()+0x1c: undefined stack state
arch/x86/kernel/irq_work.o: warning: objtool: irqst_sysvec_irq_work()+0x1e: undefined stack state
arch/x86/kernel/irq_work.o: warning: objtool: irqst_sysvec_irq_work()+0x3d: undefined stack state
arch/x86/kernel/smp.o: warning: objtool: irqst_sysvec_call_function()+0x1e: undefined stack state
arch/x86/kernel/smp.o: warning: objtool: irqst_sysvec_call_function_single()+0x1e: undefined stack state
arch/x86/kernel/smp.o: warning: objtool: irqst_sysvec_reboot()+0x1e: undefined stack state
arch/x86/kernel/traps.c:707:16: warning: Using argument dr7 that points at uninitialized variable dr7 [ctuuninitvar]
arch/x86/kernel/traps.c:721:16: warning: Using argument dr6 that points at uninitialized variable dr6 [ctuuninitvar]
include/asm-generic/irqflags.h:26: Error: no such instruction: `static inline unsigned long arch_local_irq_save(void)'
include/asm-generic/irqflags.h:27: Error: no such instruction: `{'
include/asm-generic/irqflags.h:28: Error: no such instruction: `unsigned long flags'
include/asm-generic/irqflags.h:29: Error: junk at end of line, first unrecognized character is `('
include/asm-generic/irqflags.h:30: Error: no such instruction: `arch_local_irq_restore(0)'
include/asm-generic/irqflags.h:31: Error: no such instruction: `return flags'
include/asm-generic/irqflags.h:32: Error: junk at end of line, first unrecognized character is `}'
include/asm-generic/irqflags.h:37: Error: no such instruction: `static inline int arch_irqs_disabled_flags(unsigned long flags)'
include/asm-generic/irqflags.h:61: Error: no such instruction: `static inline int arch_irqs_disabled(void)'
include/asm-generic/irqflags.h:63: Error: no such instruction: `return arch_irqs_disabled_flags(arch_local_save_flags())'
powerpc64-linux-ld: kernel/kprobes.o:(.toc+0x0): undefined reference to `__noinstr_text_start'
powerpc64-linux-ld: kernel/kprobes.o:(.toc+0x8): undefined reference to `__noinstr_text_end'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- powerpc-defconfig
|   |-- powerpc64-linux-ld:kernel-kprobes.o:(.toc):undefined-reference-to-__noinstr_text_end
|   `-- powerpc64-linux-ld:kernel-kprobes.o:(.toc):undefined-reference-to-__noinstr_text_start
|-- powerpc-ppc64_defconfig
|   |-- powerpc64-linux-ld:kernel-kprobes.o:(.toc):undefined-reference-to-__noinstr_text_end
|   `-- powerpc64-linux-ld:kernel-kprobes.o:(.toc):undefined-reference-to-__noinstr_text_start
|-- um-allmodconfig
|   |-- arch-um-include-asm-irqflags.h:Error:invalid-character-(-in-mnemonic
|   |-- arch-um-include-asm-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-get_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-set_signals(int-enable)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-block_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-unblock_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:return-get_signals()
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_save_flags(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_disable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_enable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_restore(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is-(
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:arch_local_irq_restore()
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-arch_irqs_disabled_flags(arch_local_save_flags())
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-flags
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled(void)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled_flags(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_irq_save(void)
|   `-- include-asm-generic-irqflags.h:Error:no-such-instruction:unsigned-long-flags
|-- um-allyesconfig
|   |-- arch-um-include-asm-irqflags.h:Error:invalid-character-(-in-mnemonic
|   |-- arch-um-include-asm-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-get_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-set_signals(int-enable)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-block_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-unblock_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:return-get_signals()
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_save_flags(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_disable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_enable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_restore(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is-(
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:arch_local_irq_restore()
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-arch_irqs_disabled_flags(arch_local_save_flags())
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-flags
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled(void)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled_flags(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_irq_save(void)
|   `-- include-asm-generic-irqflags.h:Error:no-such-instruction:unsigned-long-flags
|-- um-defconfig
|   |-- arch-um-include-asm-irqflags.h:Error:invalid-character-(-in-mnemonic
|   |-- arch-um-include-asm-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-get_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-set_signals(int-enable)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-block_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-unblock_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:return-get_signals()
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_save_flags(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_disable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_enable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_restore(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is-(
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:arch_local_irq_restore()
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-arch_irqs_disabled_flags(arch_local_save_flags())
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-flags
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled(void)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled_flags(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_irq_save(void)
|   `-- include-asm-generic-irqflags.h:Error:no-such-instruction:unsigned-long-flags
|-- um-kunit_defconfig
|   |-- arch-um-include-asm-irqflags.h:Error:invalid-character-(-in-mnemonic
|   |-- arch-um-include-asm-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-get_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-set_signals(int-enable)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-block_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-unblock_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:return-get_signals()
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_save_flags(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_disable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_enable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_restore(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is-(
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:arch_local_irq_restore()
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-arch_irqs_disabled_flags(arch_local_save_flags())
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-flags
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled(void)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled_flags(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_irq_save(void)
|   `-- include-asm-generic-irqflags.h:Error:no-such-instruction:unsigned-long-flags
|-- um-x86_64_defconfig
|   |-- arch-um-include-asm-irqflags.h:Error:invalid-character-(-in-mnemonic
|   |-- arch-um-include-asm-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-get_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-int-set_signals(int-enable)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-block_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:extern-void-unblock_signals(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:return-get_signals()
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_save_flags(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_disable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_enable(void)
|   |-- arch-um-include-asm-irqflags.h:Error:no-such-instruction:static-inline-void-arch_local_irq_restore(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is
|   |-- include-asm-generic-irqflags.h:Error:junk-at-end-of-line-first-unrecognized-character-is-(
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:arch_local_irq_restore()
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-arch_irqs_disabled_flags(arch_local_save_flags())
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:return-flags
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled(void)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-int-arch_irqs_disabled_flags(unsigned-long-flags)
|   |-- include-asm-generic-irqflags.h:Error:no-such-instruction:static-inline-unsigned-long-arch_local_irq_save(void)
|   `-- include-asm-generic-irqflags.h:Error:no-such-instruction:unsigned-long-flags
|-- x86_64-allyesconfig
|   |-- arch-x86-kernel-traps.c:warning:Using-argument-dr6-that-points-at-uninitialized-variable-dr6-ctuuninitvar
|   `-- arch-x86-kernel-traps.c:warning:Using-argument-dr7-that-points-at-uninitialized-variable-dr7-ctuuninitvar
|-- x86_64-randconfig-b001-20200503
|   |-- arch-x86-kernel-apic-vector.o:warning:objtool:irqst_sysvec_irq_move_cleanup():undefined-stack-state
|   |-- arch-x86-kernel-cpu-acrn.o:warning:objtool:irqst_sysvec_acrn_hv_callback():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_nested_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_wakeup_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq_work.o:warning:objtool:irqst_sysvec_irq_work():undefined-stack-state
|   |-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_call_function():undefined-stack-state
|   |-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_call_function_single():undefined-stack-state
|   `-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_reboot():undefined-stack-state
|-- x86_64-randconfig-e002-20200503
|   |-- arch-x86-kernel-apic-vector.o:warning:objtool:irqst_sysvec_irq_move_cleanup():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_nested_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_wakeup_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq_work.o:warning:objtool:irqst_sysvec_irq_work():undefined-stack-state
|   |-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_call_function():undefined-stack-state
|   |-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_call_function_single():undefined-stack-state
|   `-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_reboot():undefined-stack-state
|-- x86_64-randconfig-e003-20200503
|   |-- arch-x86-entry-common.o:warning:objtool:run_on_irqstack():undefined-stack-state
|   |-- arch-x86-kernel-apic-vector.o:warning:objtool:irqst_sysvec_irq_move_cleanup():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_nested_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_wakeup_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq_work.o:warning:objtool:irqst_sysvec_irq_work():undefined-stack-state
|   |-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_call_function():undefined-stack-state
|   |-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_call_function_single():undefined-stack-state
|   `-- arch-x86-kernel-smp.o:warning:objtool:irqst_sysvec_reboot():undefined-stack-state
|-- x86_64-randconfig-f001-20200505
|   |-- arch-x86-kernel-cpu-acrn.o:warning:objtool:irqst_sysvec_acrn_hv_callback():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_nested_ipi():undefined-stack-state
|   |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_wakeup_ipi():undefined-stack-state
|   `-- arch-x86-kernel-irq_work.o:warning:objtool:irqst_sysvec_irq_work():undefined-stack-state
`-- x86_64-randconfig-h002-20200503
    |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_ipi():undefined-stack-state
    |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_nested_ipi():undefined-stack-state
    |-- arch-x86-kernel-irq.o:warning:objtool:irqst_sysvec_kvm_posted_intr_wakeup_ipi():undefined-stack-state
    `-- arch-x86-kernel-irq_work.o:warning:objtool:irqst_sysvec_irq_work():undefined-stack-state

elapsed time: 2138m

configs tested: 166
configs skipped: 0

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
um                           x86_64_defconfig
ia64                              allnoconfig
um                               allyesconfig
nds32                               defconfig
c6x                               allnoconfig
microblaze                       allyesconfig
csky                                defconfig
ia64                             alldefconfig
m68k                           sun3_defconfig
microblaze                        allnoconfig
i386                                defconfig
mips                              allnoconfig
xtensa                              defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                          multi_defconfig
m68k                                defconfig
c6x                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
csky                             allyesconfig
alpha                            allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
openrisc                         allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          alldefconfig
powerpc                          allmodconfig
m68k                 randconfig-a001-20200506
mips                 randconfig-a001-20200506
nds32                randconfig-a001-20200506
parisc               randconfig-a001-20200506
alpha                randconfig-a001-20200506
riscv                randconfig-a001-20200506
m68k                 randconfig-a001-20200505
mips                 randconfig-a001-20200505
nds32                randconfig-a001-20200505
parisc               randconfig-a001-20200505
alpha                randconfig-a001-20200505
riscv                randconfig-a001-20200505
h8300                randconfig-a001-20200506
nios2                randconfig-a001-20200506
microblaze           randconfig-a001-20200506
c6x                  randconfig-a001-20200506
sparc64              randconfig-a001-20200506
s390                 randconfig-a001-20200505
xtensa               randconfig-a001-20200505
sh                   randconfig-a001-20200505
openrisc             randconfig-a001-20200505
csky                 randconfig-a001-20200505
s390                 randconfig-a001-20200430
xtensa               randconfig-a001-20200430
csky                 randconfig-a001-20200430
openrisc             randconfig-a001-20200430
sh                   randconfig-a001-20200430
xtensa               randconfig-a001-20200503
openrisc             randconfig-a001-20200503
csky                 randconfig-a001-20200503
i386                 randconfig-b003-20200503
x86_64               randconfig-b002-20200503
i386                 randconfig-b001-20200503
x86_64               randconfig-b003-20200503
x86_64               randconfig-b001-20200503
i386                 randconfig-b002-20200503
i386                 randconfig-b003-20200507
x86_64               randconfig-b002-20200507
i386                 randconfig-b001-20200507
x86_64               randconfig-b001-20200507
x86_64               randconfig-b003-20200507
i386                 randconfig-b002-20200507
i386                 randconfig-e003-20200506
x86_64               randconfig-e003-20200506
x86_64               randconfig-e001-20200506
i386                 randconfig-e002-20200506
i386                 randconfig-e001-20200506
x86_64               randconfig-e003-20200503
x86_64               randconfig-e002-20200503
i386                 randconfig-e003-20200503
x86_64               randconfig-e001-20200503
i386                 randconfig-e002-20200503
i386                 randconfig-e001-20200503
i386                 randconfig-f003-20200503
x86_64               randconfig-f002-20200503
i386                 randconfig-f001-20200503
i386                 randconfig-f002-20200503
i386                 randconfig-f003-20200505
x86_64               randconfig-f001-20200505
x86_64               randconfig-f003-20200505
i386                 randconfig-f001-20200505
i386                 randconfig-f002-20200505
i386                 randconfig-f003-20200506
x86_64               randconfig-f001-20200506
x86_64               randconfig-f003-20200506
x86_64               randconfig-f002-20200506
i386                 randconfig-f001-20200506
i386                 randconfig-f002-20200506
x86_64               randconfig-a003-20200505
x86_64               randconfig-a001-20200505
i386                 randconfig-a001-20200505
i386                 randconfig-a003-20200505
i386                 randconfig-a002-20200505
i386                 randconfig-h002-20200506
i386                 randconfig-h001-20200506
i386                 randconfig-h003-20200506
x86_64               randconfig-h002-20200506
x86_64               randconfig-h003-20200506
x86_64               randconfig-h001-20200506
ia64                 randconfig-a001-20200505
powerpc              randconfig-a001-20200505
arm                  randconfig-a001-20200505
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
