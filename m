Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA9EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EC3206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597528603;
	bh=0KQOK61BZj5gPir/ttgkpkmif5KClJjku1jULJIEJEw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=091eObo+sHyS9nl5UeTg21dDn8KNIzQm3KCebk83yF5rrwtwSEPrjID8wVQnwG9+k
	 pI6d2ZkXHqPKrPqfyOVEiqA1l+PZYO7m/LwqS1u3NOMm9VhA9u3m0nsuQphjuCPGsJ
	 LwImlLGkeVTjEaXfOofe5rUISZr5TGj2VB/CUmVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgHOV4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgHOVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E666C02B8E6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:45:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id m22so12563580eje.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qfqXeLtAPq7ysi/M1Fb6f+piBvRFtAh+o68LnbAbft0=;
        b=ghHk+oMK7HFUpus3Gil33UfRLaJ35slUEmtpKVqi2wbPTYpElRL1veDhv68JQqgkCm
         Z0d4SJTIqrCg8qqUvglzaZjIYytS/nhh2CgEuQUo0VUHoShjgmgmFww6MqYrB6aSgt3/
         CDxrRYWARJEr6N7yF62spbu0J4LeaK80UJ/BtPl6ygGtMrXk4WT4AOC+Q1TKLIh3sygw
         fz6HQ1ikPOvYMMv3tnFQqSM5jutE+8uUzcxcfhWmC/xIxlAkMFPEHtU+yvz4eyn4x+1n
         PMW3lxYDo3YtQbg6kodppcAI90bHKpD6IW9VMw/KVBCin3gtbmg6xO4ZMSFxYHrwRFwL
         Np9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=qfqXeLtAPq7ysi/M1Fb6f+piBvRFtAh+o68LnbAbft0=;
        b=C7rH0rqrnstiQPBSmeTRNZerZta9PaN52MxoJprxK+45yErP5S4C74flXG8ElZzB0l
         l2Jz2JweVVzovyMF+oi3wP8Zb8GYJBYSQcOdgH7aVuiF8+qhmCvWKz6mf9eYYJv7Vjd7
         o/tehRgw8tk/cdQb/PfyC6YRjWr8FvpI5leGFYLQhwhExlN1ZJgwmXRUM3xn+ws+N/bs
         se1fmPsAn7vloMAKeE8acXPwVMt4RdVOYhUeeEBpexxacWKy6Ledm3t5rHTIWZ6z6dQD
         S4aa8xacfkcQL+KR+Sx+9IefnzLXU17KWWhr+aHFfwDqkRfskN6BtnAf6Ho8ESyBBZOp
         DzdA==
X-Gm-Message-State: AOAM530nes4ZA5YJexEaCRFWcU9wDpaGsAv4P8+Z1ab36CIH4hWZgobY
        nVgJIOwVsWW+6+mm0nytJ+M=
X-Google-Smtp-Source: ABdhPJyrvGZxXgcRzi4X/EXw/3EuySGNae9KIuvmU3Gshc7BHjya1U2K/kmofwSy/kuOnh4QdPcqiA==
X-Received: by 2002:a17:906:819:: with SMTP id e25mr6908061ejd.95.1597491955136;
        Sat, 15 Aug 2020 04:45:55 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id op15sm9057283ejb.42.2020.08.15.04.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:45:54 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:45:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20200815114552.GA2643023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-15

   # HEAD: a6d996cbd38b42341ad3fce74506b9fdc280e395 x86/alternatives: Acquire pte lock with interrupts enabled

Misc fixes and small updates all around the place:

 - Fix mitigation state sysfs output
 - Fix an FPU xstate/sxave code assumption bug triggered by Architectural LBR support
 - Fix Lightning Mountain SoC TSC frequency enumeration bug
 - Fix kexec debug output
 - Fix kexec memory range assumption bug
 - Fix a boundary condition in the crash kernel code

 - Optimize porgatory.ro generation a bit
 - Enable ACRN guests to use X2APIC mode
 - Reduce a __text_poke() IRQs-off critical section for the benefit of PREEMPT_RT

 Thanks,

	Ingo

------------------>
Dilip Kota (1):
      x86/tsr: Fix tsc frequency enumeration bug on Lightning Mountain SoC

Kan Liang (1):
      x86/fpu/xstate: Fix an xstate size check warning with architectural LBRs

Lianbo Jiang (3):
      x86/crash: Correct the address boundary of function parameters
      kexec: Improve & fix crash_exclude_mem_range() to handle overlapping ranges
      kexec_file: Correctly output debugging information for the PT_LOAD ELF header

Pawan Gupta (1):
      x86/bugs/multihit: Fix mitigation reporting when VMX is not in use

Pingfan Liu (1):
      x86/purgatory: Don't generate debug info for purgatory.ro

Sebastian Andrzej Siewior (1):
      x86/alternatives: Acquire pte lock with interrupts enabled

Shuo Liu (2):
      x86/acrn: Allow ACRN guest to use X2APIC mode
      x86/acrn: Remove redundant chars from ACRN signature


 Documentation/admin-guide/hw-vuln/multihit.rst |  4 +++
 arch/x86/kernel/alternative.c                  |  6 ++--
 arch/x86/kernel/cpu/acrn.c                     | 12 +++-----
 arch/x86/kernel/cpu/bugs.c                     |  8 ++++-
 arch/x86/kernel/crash.c                        |  2 +-
 arch/x86/kernel/fpu/xstate.c                   | 33 ++++++++++++++++++++-
 arch/x86/kernel/tsc_msr.c                      |  9 ++++--
 arch/x86/purgatory/Makefile                    |  5 +++-
 kernel/kexec_file.c                            | 41 ++++++++++++++++----------
 9 files changed, 88 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/multihit.rst b/Documentation/admin-guide/hw-vuln/multihit.rst
index ba9988d8bce5..140e4cec38c3 100644
--- a/Documentation/admin-guide/hw-vuln/multihit.rst
+++ b/Documentation/admin-guide/hw-vuln/multihit.rst
@@ -80,6 +80,10 @@ The possible values in this file are:
        - The processor is not vulnerable.
      * - KVM: Mitigation: Split huge pages
        - Software changes mitigate this issue.
+     * - KVM: Mitigation: VMX unsupported
+       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is not supported.
+     * - KVM: Mitigation: VMX disabled
+       - KVM is not vulnerable because Virtual Machine Extensions (VMX) is disabled.
      * - KVM: Vulnerable
        - The processor is vulnerable, but no mitigation enabled
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c826cddae157..34a1b8562c31 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -874,8 +874,6 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
 
-	local_irq_save(flags);
-
 	/*
 	 * Map the page without the global bit, as TLB flushing is done with
 	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
@@ -892,6 +890,8 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	VM_BUG_ON(!ptep);
 
+	local_irq_save(flags);
+
 	pte = mk_pte(pages[0], pgprot);
 	set_pte_at(poking_mm, poking_addr, ptep, pte);
 
@@ -941,8 +941,8 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(memcmp(addr, opcode, len));
 
-	pte_unmap_unlock(ptep, ptl);
 	local_irq_restore(flags);
+	pte_unmap_unlock(ptep, ptl);
 	return addr;
 }
 
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 1da9b1c9a2db..0b2c03943ac6 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -11,14 +11,15 @@
 
 #include <linux/interrupt.h>
 #include <asm/apic.h>
+#include <asm/cpufeatures.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
-static uint32_t __init acrn_detect(void)
+static u32 __init acrn_detect(void)
 {
-	return hypervisor_cpuid_base("ACRNACRNACRN\0\0", 0);
+	return hypervisor_cpuid_base("ACRNACRNACRN", 0);
 }
 
 static void __init acrn_init_platform(void)
@@ -29,12 +30,7 @@ static void __init acrn_init_platform(void)
 
 static bool acrn_x2apic_available(void)
 {
-	/*
-	 * x2apic is not supported for now. Future enablement will have to check
-	 * X86_FEATURE_X2APIC to determine whether x2apic is supported in the
-	 * guest.
-	 */
-	return false;
+	return boot_cpu_has(X86_FEATURE_X2APIC);
 }
 
 static void (*acrn_intr_handler)(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f0b743a2fe9c..d3f0db463f96 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -31,6 +31,7 @@
 #include <asm/intel-family.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
+#include <asm/tlbflush.h>
 
 #include "cpu.h"
 
@@ -1549,7 +1550,12 @@ static ssize_t l1tf_show_state(char *buf)
 
 static ssize_t itlb_multihit_show_state(char *buf)
 {
-	if (itlb_multihit_kvm_mitigation)
+	if (!boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
+	    !boot_cpu_has(X86_FEATURE_VMX))
+		return sprintf(buf, "KVM: Mitigation: VMX unsupported\n");
+	else if (!(cr4_read_shadow() & X86_CR4_VMXE))
+		return sprintf(buf, "KVM: Mitigation: VMX disabled\n");
+	else if (itlb_multihit_kvm_mitigation)
 		return sprintf(buf, "KVM: Mitigation: Split huge pages\n");
 	else
 		return sprintf(buf, "KVM: Vulnerable\n");
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fd87b59452a3..a8f3af257e26 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -230,7 +230,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	int ret = 0;
 
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, 1<<20);
+	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index be2a68a09d19..6073e342a1ed 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -611,6 +611,10 @@ static void check_xstate_against_struct(int nr)
  * This essentially double-checks what the cpu told us about
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
+ *
+ * Dynamic XSAVE features allocate their own buffers and are not
+ * covered by these checks. Only the size of the buffer for task->fpu
+ * is checked here.
  */
 static void do_extra_xstate_size_checks(void)
 {
@@ -673,6 +677,33 @@ static unsigned int __init get_xsaves_size(void)
 	return ebx;
 }
 
+/*
+ * Get the total size of the enabled xstates without the dynamic supervisor
+ * features.
+ */
+static unsigned int __init get_xsaves_size_no_dynamic(void)
+{
+	u64 mask = xfeatures_mask_dynamic();
+	unsigned int size;
+
+	if (!mask)
+		return get_xsaves_size();
+
+	/* Disable dynamic features. */
+	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
+
+	/*
+	 * Ask the hardware what size is required of the buffer.
+	 * This is the size required for the task->fpu buffer.
+	 */
+	size = get_xsaves_size();
+
+	/* Re-enable dynamic features so XSAVES will work on them again. */
+	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
+
+	return size;
+}
+
 static unsigned int __init get_xsave_size(void)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -710,7 +741,7 @@ static int __init init_xstate_size(void)
 	xsave_size = get_xsave_size();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size();
+		possible_xstate_size = get_xsaves_size_no_dynamic();
 	else
 		possible_xstate_size = xsave_size;
 
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3a1858..a654a9b4b77c 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -133,10 +133,15 @@ static const struct freq_desc freq_desc_ann = {
 	.mask = 0x0f,
 };
 
-/* 24 MHz crystal? : 24 * 13 / 4 = 78 MHz */
+/*
+ * 24 MHz crystal? : 24 * 13 / 4 = 78 MHz
+ * Frequency step for Lightning Mountain SoC is fixed to 78 MHz,
+ * so all the frequency entries are 78000.
+ */
 static const struct freq_desc freq_desc_lgm = {
 	.use_msr_plat = true,
-	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
+	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000,
+		   78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
 	.mask = 0x0f,
 };
 
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 088bd764e0b7..d24b43a4451a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
 
@@ -64,6 +64,9 @@ CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
 CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 
+AFLAGS_REMOVE_setup-x86_$(BITS).o	+= -Wa,-gdwarf-2
+AFLAGS_REMOVE_entry64.o			+= -Wa,-gdwarf-2
+
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 94661d2d13ad..3f7867c1820f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1157,24 +1157,26 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
 {
 	int i, j;
-	unsigned long long start, end;
+	unsigned long long start, end, p_start, p_end;
 	struct crash_mem_range temp_range = {0, 0};
 
 	for (i = 0; i < mem->nr_ranges; i++) {
 		start = mem->ranges[i].start;
 		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
 
 		if (mstart > end || mend < start)
 			continue;
 
 		/* Truncate any area outside of range */
 		if (mstart < start)
-			mstart = start;
+			p_start = start;
 		if (mend > end)
-			mend = end;
+			p_end = end;
 
 		/* Found completely overlapping range */
-		if (mstart == start && mend == end) {
+		if (p_start == start && p_end == end) {
 			mem->ranges[i].start = 0;
 			mem->ranges[i].end = 0;
 			if (i < mem->nr_ranges - 1) {
@@ -1185,20 +1187,29 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 					mem->ranges[j].end =
 							mem->ranges[j+1].end;
 				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
 			}
 			mem->nr_ranges--;
 			return 0;
 		}
 
-		if (mstart > start && mend < end) {
+		if (p_start > start && p_end < end) {
 			/* Split original range */
-			mem->ranges[i].end = mstart - 1;
-			temp_range.start = mend + 1;
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
 			temp_range.end = end;
-		} else if (mstart != start)
-			mem->ranges[i].end = mstart - 1;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
 		else
-			mem->ranges[i].start = mend + 1;
+			mem->ranges[i].start = p_end + 1;
 		break;
 	}
 
@@ -1235,7 +1246,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	unsigned long long notes_addr;
 	unsigned long mstart, mend;
 
-	/* extra phdr for vmcoreinfo elf note */
+	/* extra phdr for vmcoreinfo ELF note */
 	nr_phdr = nr_cpus + 1;
 	nr_phdr += mem->nr_ranges;
 
@@ -1243,7 +1254,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
 	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
 	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two elf headers. One will contain kernel
+	 * memory will be mapped in two ELF headers. One will contain kernel
 	 * text virtual addresses and other will have __va(physical) addresses.
 	 */
 
@@ -1270,7 +1281,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present cpu */
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
@@ -1312,10 +1323,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
 		phdr->p_align = 0;
 		ehdr->e_phnum++;
-		phdr++;
-		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
 			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
 			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
 	}
 
 	*addr = buf;
