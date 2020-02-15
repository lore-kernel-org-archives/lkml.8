Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF43C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25D5217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581756806;
	bh=bmZ4Q1SpOxRVEwOjKTWw+bn57TUN9THuCjGerJN2Hec=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SUtei/KACNQ7UoNKStQkK85K0YMbgklwNjCBiaNrjI/Xqh0uDJ9QdvJg1KNDe0rxq
	 slamWAJfmAOewacLlQUWCxIP1KDltzFDw1wYLZ+oyoYmIj6KGMZxOySkm/8kXtwt5T
	 fMtpdiAr0TI+Y5vkbPr1CK1yrE9kneD+a3L8bRds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgBOIxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:53:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37835 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgBOIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:53:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so13323631wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 00:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w/u/orKFjw1KxV0uK+DDR2zr7f8+s/aC4eRNx8fhu3w=;
        b=HIXreQgXQLaGR+sk6BJ6Etbx3jFHssKIil7Z08Ay6gInREBYnPBy1l50N+eWbkbcAU
         ipUu2YHr5d6aQbk27Wcn1w4dTSW3eu91ZcawbgmWV5CvwDgq8JCqYAeqsLzFw5KpfeiW
         q8ZRBXDrWDmBO0ubUhaBM8YROurGC9swEJv7ObgS8D4EvaNjvRijpX1fq/ZxSq7LFpBr
         HySEkJz+l6V0ALyJDEi7uFuoaZ/g4t8Ao+weGz07R8oyCb3UE9CRXbUFQv4TkEnesHXS
         exdmFzIRO9EZ2Y7NrplZdgzjwYsuTuJEqrFk4IwMUvV188WjMOl/JwuI4A+EqIXXKhrE
         mgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=w/u/orKFjw1KxV0uK+DDR2zr7f8+s/aC4eRNx8fhu3w=;
        b=a/LhPgx39ia0Pnslb7FTqgHmjCoEC3H8byuUzSh1xfbQjPC3H3c2N4qrJBo6JDQyLt
         RahAuxXiKswUEb5mqjPrcJXygARte/uiCg2uwklp2XAXitfFj1IYuD3IakWKDTCSBSt1
         ifW8K68In0iBZxsxgMvAEJbbFdk0MikdHCzqCbCigyLfxjpRcWeAZ9sV3Br+uVX1hGHj
         bL+OVFUE18Jry8tF23rBVh6mrXGEFs59rMxvDMcQ6V4rVYckxmBL9EyR7OH4ppJhks+N
         N2RZEMMPFV2zt60uxB7cxurkfFClz/PfZlbSoQ4RJWU9RRd+CWoqz7/aKs9HNJHGXn4S
         nAMg==
X-Gm-Message-State: APjAAAUUlzAN61Wb4caS+tZvqV+rkI9dFehEe2+E3815fl4yUyDodnVd
        m9pd1gif8ugcFVHs8o5EJ4oJnoGj
X-Google-Smtp-Source: APXvYqwlUILVbmMN5V+ZGT/3OQJ4psqPUrloWfPtDzUAOvab4y7bkEHIPiFcus7Exngy80LnEagkxA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr9939886wmk.172.1581756799558;
        Sat, 15 Feb 2020 00:53:19 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w11sm10542370wrt.35.2020.02.15.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 00:53:18 -0800 (PST)
Date:   Sat, 15 Feb 2020 09:53:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20200215085316.GA12477@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: dfb9b69e3b84791e4c6b954ac3cc0c4a545484f2 Merge tag 'perf-urgent-for-mingo-5.6-20200214' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Contains the following fixes and HW enablement patches:

 - Tooling fixes, most of which are tooling header synchronization with v5.6 changes

 - Fix kprobes fallout on ARM

 - Add Intel Elkhart Lake support and extend Tremont support, these are 
   relatively simple and should only affect those models

 - Fix the AMD family 17h generic event table

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (15):
      tools include UAPI: Sync x86's syscalls_64.tbl, generic unistd.h and fcntl.h to pick up openat2 and pidfd_getfd
      tools headers UAPI: Sync copy of arm64's asm/unistd.h with the kernel sources
      tools headers UAPI: Sync prctl.h with the kernel sources
      perf beauty prctl: Export the 'options' strarray
      perf trace: Resolve prctl's 'option' arg strings to numbers
      tools headers UAPI: Sync sched.h with the kernel
      tools headers uapi: Sync linux/fscrypt.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync asm-generic/mman-common.h with the kernel
      tools include UAPI: Sync sound/asound.h copy
      tools headers x86: Sync disabled-features.h
      tools arch x86: Sync asm/cpufeatures.h with the kernel sources
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers kvm: Sync linux/kvm.h with the kernel sources
      perf llvm: Fix script used to obtain kernel make directives to work with new kbuild

Jiri Olsa (4):
      perf maps: Mark module DSOs with kernel type
      perf maps: Mark ksymbol DSOs with kernel type
      perf maps: Fix map__clone() for struct kmap
      perf maps: Move kmap::kmaps setup to maps__insert()

John Garry (1):
      perf tools: Add arm64 version of get_cpuid()

Kan Liang (4):
      perf/x86/intel: Add Elkhart Lake support
      perf/x86/cstate: Add Tremont support
      perf/x86/msr: Add Tremont support
      perf/x86/intel: Fix inaccurate period in context switch for auto-reload

Kim Phillips (4):
      perf stat: Don't report a null stalled cycles per insn metric
      perf symbols: Update the list of kernel idle symbols
      perf symbols: Convert symbol__is_idle() to use strlist
      perf/x86/amd: Add missing L2 misses event spec to AMD Family 17h's event map

Peter Zijlstra (2):
      arm/ftrace: Fix BE text poking
      arm/patch: Fix !MMU compile


 arch/arm/kernel/ftrace.c                          |   7 +-
 arch/arm/kernel/patch.c                           |  19 ++-
 arch/x86/events/amd/core.c                        |   1 +
 arch/x86/events/intel/core.c                      |   1 +
 arch/x86/events/intel/cstate.c                    |  22 +--
 arch/x86/events/intel/ds.c                        |   2 +
 arch/x86/events/msr.c                             |   3 +-
 tools/arch/arm64/include/uapi/asm/kvm.h           |  12 +-
 tools/arch/arm64/include/uapi/asm/unistd.h        |   1 +
 tools/arch/x86/include/asm/cpufeatures.h          |   2 +
 tools/arch/x86/include/asm/disabled-features.h    |   8 +-
 tools/include/uapi/asm-generic/mman-common.h      |   2 +
 tools/include/uapi/asm-generic/unistd.h           |   7 +-
 tools/include/uapi/drm/i915_drm.h                 |  32 +++++
 tools/include/uapi/linux/fcntl.h                  |   2 +-
 tools/include/uapi/linux/fscrypt.h                |  14 +-
 tools/include/uapi/linux/kvm.h                    |   5 +
 tools/include/uapi/linux/openat2.h                |  39 ++++++
 tools/include/uapi/linux/prctl.h                  |   4 +
 tools/include/uapi/linux/sched.h                  |   6 +
 tools/include/uapi/sound/asound.h                 | 155 ++++++++++++++++++----
 tools/perf/arch/arm64/util/header.c               |  63 ++++++---
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 tools/perf/builtin-trace.c                        |   4 +-
 tools/perf/check-headers.sh                       |   1 +
 tools/perf/trace/beauty/beauty.h                  |   2 +
 tools/perf/trace/beauty/prctl.c                   |   3 +-
 tools/perf/util/llvm-utils.c                      |   1 +
 tools/perf/util/machine.c                         |  26 ++--
 tools/perf/util/map.c                             |  17 ++-
 tools/perf/util/stat-shadow.c                     |   6 -
 tools/perf/util/symbol.c                          |  17 ++-
 32 files changed, 383 insertions(+), 103 deletions(-)
 create mode 100644 tools/include/uapi/linux/openat2.h

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 2a5ff69c28e6..10499d44964a 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -78,13 +78,10 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 {
 	unsigned long replaced;
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
 		old = __opcode_to_mem_thumb32(old);
-		new = __opcode_to_mem_thumb32(new);
-	} else {
+	else
 		old = __opcode_to_mem_arm(old);
-		new = __opcode_to_mem_arm(new);
-	}
 
 	if (validate) {
 		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index d0a05a3bdb96..e9e828b6bb30 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -16,10 +16,10 @@ struct patch {
 	unsigned int insn;
 };
 
+#ifdef CONFIG_MMU
 static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
-	__acquires(&patch_lock)
 {
 	unsigned int uintaddr = (uintptr_t) addr;
 	bool module = !core_kernel_text(uintaddr);
@@ -34,8 +34,6 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 
 	if (flags)
 		raw_spin_lock_irqsave(&patch_lock, *flags);
-	else
-		__acquire(&patch_lock);
 
 	set_fixmap(fixmap, page_to_phys(page));
 
@@ -43,15 +41,19 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 }
 
 static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
-	__releases(&patch_lock)
 {
 	clear_fixmap(fixmap);
 
 	if (flags)
 		raw_spin_unlock_irqrestore(&patch_lock, *flags);
-	else
-		__release(&patch_lock);
 }
+#else
+static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
+{
+	return addr;
+}
+static void __kprobes patch_unmap(int fixmap, unsigned long *flags) { }
+#endif
 
 void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 {
@@ -64,8 +66,6 @@ void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 
 	if (remap)
 		waddr = patch_map(addr, FIX_TEXT_POKE0, &flags);
-	else
-		__acquire(&patch_lock);
 
 	if (thumb2 && __opcode_is_thumb16(insn)) {
 		*(u16 *)waddr = __opcode_to_mem_thumb16(insn);
@@ -102,8 +102,7 @@ void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
 	if (waddr != addr) {
 		flush_kernel_vmap_range(waddr, twopage ? size / 2 : size);
 		patch_unmap(FIX_TEXT_POKE0, &flags);
-	} else
-		__release(&patch_lock);
+	}
 
 	flush_icache_range((uintptr_t)(addr),
 			   (uintptr_t)(addr) + size);
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 1f22b6bbda68..39eb276d0277 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -250,6 +250,7 @@ static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
 	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x0964,
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x0287,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3be51aa06e67..dff6623804c2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4765,6 +4765,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_TREMONT_D:
+	case INTEL_FAM6_ATOM_TREMONT:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e1daf4151e11..4814c964692c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,17 +40,18 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL
+ *			 Available model: SLM,AMT,GLM,CNL,TNT
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
- *						CNL,KBL,CML
+ *						CNL,KBL,CML,TNT
  *			       Scope: Core
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -60,17 +61,18 @@
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL
+ *						KBL,CML,ICL,TGL,TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML,ICL,TGL
+ *						GLM,CNL,KBL,CML,ICL,TGL,TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
- *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL
+ *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -87,7 +89,8 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL
+ *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
+ *						TNT
  *			       Scope: Package (physical package)
  *
  */
@@ -640,8 +643,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_D, glm_cstates),
-
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT_D, glm_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4b94ae4ae369..dc43cc124e09 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1714,6 +1714,8 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	old = ((s64)(prev_raw_count << shift) >> shift);
 	local64_add(new - old + count * period, &event->count);
 
+	local64_set(&hwc->period_left, -new);
+
 	perf_event_update_userpage(event);
 
 	return 0;
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 6f86650b3f77..a949f6f55991 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -75,8 +75,9 @@ static bool test_intel(int idx, void *data)
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:
-
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_TREMONT_D:
+	case INTEL_FAM6_ATOM_TREMONT:
 
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 820e5751ada7..ba85bb23f060 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -220,10 +220,18 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_PTIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 2, 2)
 #define KVM_REG_ARM_PTIMER_CNT		ARM64_SYS_REG(3, 3, 14, 0, 1)
 
-/* EL0 Virtual Timer Registers */
+/*
+ * EL0 Virtual Timer Registers
+ *
+ * WARNING:
+ *      KVM_REG_ARM_TIMER_CVAL and KVM_REG_ARM_TIMER_CNT are not defined
+ *      with the appropriate register encodings.  Their values have been
+ *      accidentally swapped.  As this is set API, the definitions here
+ *      must be used, rather than ones derived from the encodings.
+ */
 #define KVM_REG_ARM_TIMER_CTL		ARM64_SYS_REG(3, 3, 14, 3, 1)
-#define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
+#define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 
 /* KVM-as-firmware specific pseudo-registers */
 #define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index 4703d218663a..f83a70e07df8 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -19,5 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index e9b62498fe75..f3327cb56edf 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -220,6 +220,7 @@
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
+#define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -357,6 +358,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_FSRM		(18*32+ 4) /* Fast Short Rep Mov */
 #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 8e1d0bb46361..4ea8584682f9 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -10,12 +10,6 @@
  * cpu_feature_enabled().
  */
 
-#ifdef CONFIG_X86_INTEL_MPX
-# define DISABLE_MPX	0
-#else
-# define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
-#endif
-
 #ifdef CONFIG_X86_SMAP
 # define DISABLE_SMAP	0
 #else
@@ -74,7 +68,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
+#define DISABLED_MASK9	(DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index c160a5354eb6..f94f65d429be 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -11,6 +11,8 @@
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
 #define PROT_SEM	0x8		/* page may be used for atomic ops */
+/*			0x10		   reserved for arch-specific use */
+/*			0x20		   reserved for arch-specific use */
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 1fc8faa6e973..3a3201e4618e 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -851,8 +851,13 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
 
+#define __NR_openat2 437
+__SYSCALL(__NR_openat2, sys_openat2)
+#define __NR_pidfd_getfd 438
+__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 439
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 5400d7e057f1..829c0a48577f 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -395,6 +395,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_GEM_PWRITE	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_PWRITE, struct drm_i915_gem_pwrite)
 #define DRM_IOCTL_I915_GEM_MMAP		DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP, struct drm_i915_gem_mmap)
 #define DRM_IOCTL_I915_GEM_MMAP_GTT	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP_GTT, struct drm_i915_gem_mmap_gtt)
+#define DRM_IOCTL_I915_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_MMAP_GTT, struct drm_i915_gem_mmap_offset)
 #define DRM_IOCTL_I915_GEM_SET_DOMAIN	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_SET_DOMAIN, struct drm_i915_gem_set_domain)
 #define DRM_IOCTL_I915_GEM_SW_FINISH	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_SW_FINISH, struct drm_i915_gem_sw_finish)
 #define DRM_IOCTL_I915_GEM_SET_TILING	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_SET_TILING, struct drm_i915_gem_set_tiling)
@@ -793,6 +794,37 @@ struct drm_i915_gem_mmap_gtt {
 	__u64 offset;
 };
 
+struct drm_i915_gem_mmap_offset {
+	/** Handle for the object being mapped. */
+	__u32 handle;
+	__u32 pad;
+	/**
+	 * Fake offset to use for subsequent mmap call
+	 *
+	 * This is a fixed-size type for 32/64 compatibility.
+	 */
+	__u64 offset;
+
+	/**
+	 * Flags for extended behaviour.
+	 *
+	 * It is mandatory that one of the MMAP_OFFSET types
+	 * (GTT, WC, WB, UC, etc) should be included.
+	 */
+	__u64 flags;
+#define I915_MMAP_OFFSET_GTT 0
+#define I915_MMAP_OFFSET_WC  1
+#define I915_MMAP_OFFSET_WB  2
+#define I915_MMAP_OFFSET_UC  3
+
+	/*
+	 * Zero-terminated chain of extensions.
+	 *
+	 * No current extensions defined; mbz.
+	 */
+	__u64 extensions;
+};
+
 struct drm_i915_gem_set_domain {
 	/** Handle for the object */
 	__u32 handle;
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 1f97b33c840e..ca88b7bce553 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FCNTL_H
 
 #include <asm/fcntl.h>
+#include <linux/openat2.h>
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
@@ -100,5 +101,4 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
-
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 1beb174ad950..0d8a6f47711c 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -8,6 +8,7 @@
 #ifndef _UAPI_LINUX_FSCRYPT_H
 #define _UAPI_LINUX_FSCRYPT_H
 
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
 /* Encryption policy flags */
@@ -109,11 +110,22 @@ struct fscrypt_key_specifier {
 	} u;
 };
 
+/*
+ * Payload of Linux keyring key of type "fscrypt-provisioning", referenced by
+ * fscrypt_add_key_arg::key_id as an alternative to fscrypt_add_key_arg::raw.
+ */
+struct fscrypt_provisioning_key_payload {
+	__u32 type;
+	__u32 __reserved;
+	__u8 raw[];
+};
+
 /* Struct passed to FS_IOC_ADD_ENCRYPTION_KEY */
 struct fscrypt_add_key_arg {
 	struct fscrypt_key_specifier key_spec;
 	__u32 raw_size;
-	__u32 __reserved[9];
+	__u32 key_id;
+	__u32 __reserved[8];
 	__u8 raw[];
 };
 
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index f0a16b4adbbd..4b95f9a31a2f 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1009,6 +1009,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_S390_VCPU_RESETS 179
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1473,6 +1474,10 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+/* Available with  KVM_CAP_S390_VCPU_RESETS */
+#define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
+#define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
diff --git a/tools/include/uapi/linux/openat2.h b/tools/include/uapi/linux/openat2.h
new file mode 100644
index 000000000000..58b1eb711360
--- /dev/null
+++ b/tools/include/uapi/linux/openat2.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_OPENAT2_H
+#define _UAPI_LINUX_OPENAT2_H
+
+#include <linux/types.h>
+
+/*
+ * Arguments for how openat2(2) should open the target path. If only @flags and
+ * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
+ *
+ * However, unlike openat(2), unknown or invalid bits in @flags result in
+ * -EINVAL rather than being silently ignored. @mode must be zero unless one of
+ * {O_CREAT, O_TMPFILE} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @resolve: RESOLVE_* flags.
+ */
+struct open_how {
+	__u64 flags;
+	__u64 mode;
+	__u64 resolve;
+};
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+
+#endif /* _UAPI_LINUX_OPENAT2_H */
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 7da1b37b27aa..07b4f8131e36 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -234,4 +234,8 @@ struct prctl_mm_map {
 #define PR_GET_TAGGED_ADDR_CTRL		56
 # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
 
+/* Control reclaim behavior when allocating memory */
+#define PR_SET_IO_FLUSHER		57
+#define PR_GET_IO_FLUSHER		58
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 4a0217832464..2e3bc22c6f20 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -36,6 +36,12 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 
+/*
+ * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
+ * syscalls only:
+ */
+#define CLONE_NEWTIME	0x00000080	/* New time namespace */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index df1153cea0b7..535a7229e1d9 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -26,7 +26,9 @@
 
 #if defined(__KERNEL__) || defined(__linux__)
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #else
+#include <endian.h>
 #include <sys/ioctl.h>
 #endif
 
@@ -154,7 +156,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 15)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -301,7 +303,9 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
-
+#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)) || defined __KERNEL__
+#define __SND_STRUCT_TIME64
+#endif
 
 typedef int __bitwise snd_pcm_state_t;
 #define	SNDRV_PCM_STATE_OPEN		((__force snd_pcm_state_t) 0) /* stream is open */
@@ -317,8 +321,17 @@ typedef int __bitwise snd_pcm_state_t;
 
 enum {
 	SNDRV_PCM_MMAP_OFFSET_DATA = 0x00000000,
-	SNDRV_PCM_MMAP_OFFSET_STATUS = 0x80000000,
-	SNDRV_PCM_MMAP_OFFSET_CONTROL = 0x81000000,
+	SNDRV_PCM_MMAP_OFFSET_STATUS_OLD = 0x80000000,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD = 0x81000000,
+	SNDRV_PCM_MMAP_OFFSET_STATUS_NEW = 0x82000000,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW = 0x83000000,
+#ifdef __SND_STRUCT_TIME64
+	SNDRV_PCM_MMAP_OFFSET_STATUS = SNDRV_PCM_MMAP_OFFSET_STATUS_NEW,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL = SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW,
+#else
+	SNDRV_PCM_MMAP_OFFSET_STATUS = SNDRV_PCM_MMAP_OFFSET_STATUS_OLD,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL = SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD,
+#endif
 };
 
 union snd_pcm_sync_id {
@@ -456,8 +469,13 @@ enum {
 	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
 };
 
+#ifndef __KERNEL__
+/* explicit padding avoids incompatibility between i386 and x86-64 */
+typedef struct { unsigned char pad[sizeof(time_t) - sizeof(int)]; } __time_pad;
+
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
+	__time_pad pad1;		/* align to timespec */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
 	struct timespec tstamp;		/* reference timestamp */
 	snd_pcm_uframes_t appl_ptr;	/* appl ptr */
@@ -473,17 +491,48 @@ struct snd_pcm_status {
 	__u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
 	unsigned char reserved[52-2*sizeof(struct timespec)]; /* must be filled with zero */
 };
+#endif
+
+/*
+ * For mmap operations, we need the 64-bit layout, both for compat mode,
+ * and for y2038 compatibility. For 64-bit applications, the two definitions
+ * are identical, so we keep the traditional version.
+ */
+#ifdef __SND_STRUCT_TIME64
+#define __snd_pcm_mmap_status64		snd_pcm_mmap_status
+#define __snd_pcm_mmap_control64	snd_pcm_mmap_control
+#define __snd_pcm_sync_ptr64		snd_pcm_sync_ptr
+#ifdef __KERNEL__
+#define __snd_timespec64		__kernel_timespec
+#else
+#define __snd_timespec64		timespec
+#endif
+struct __snd_timespec {
+	__s32 tv_sec;
+	__s32 tv_nsec;
+};
+#else
+#define __snd_pcm_mmap_status		snd_pcm_mmap_status
+#define __snd_pcm_mmap_control		snd_pcm_mmap_control
+#define __snd_pcm_sync_ptr		snd_pcm_sync_ptr
+#define __snd_timespec			timespec
+struct __snd_timespec64 {
+	__s64 tv_sec;
+	__s64 tv_nsec;
+};
 
-struct snd_pcm_mmap_status {
+#endif
+
+struct __snd_pcm_mmap_status {
 	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
 	int pad1;			/* Needed for 64 bit alignment */
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
-	struct timespec tstamp;		/* Timestamp */
+	struct __snd_timespec tstamp;	/* Timestamp */
 	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
-	struct timespec audio_tstamp;	/* from sample counter or wall clock */
+	struct __snd_timespec audio_tstamp; /* from sample counter or wall clock */
 };
 
-struct snd_pcm_mmap_control {
+struct __snd_pcm_mmap_control {
 	snd_pcm_uframes_t appl_ptr;	/* RW: appl ptr (0...boundary-1) */
 	snd_pcm_uframes_t avail_min;	/* RW: min available frames for wakeup */
 };
@@ -492,14 +541,59 @@ struct snd_pcm_mmap_control {
 #define SNDRV_PCM_SYNC_PTR_APPL		(1<<1)	/* get appl_ptr from driver (r/w op) */
 #define SNDRV_PCM_SYNC_PTR_AVAIL_MIN	(1<<2)	/* get avail_min from driver */
 
-struct snd_pcm_sync_ptr {
+struct __snd_pcm_sync_ptr {
 	unsigned int flags;
 	union {
-		struct snd_pcm_mmap_status status;
+		struct __snd_pcm_mmap_status status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct __snd_pcm_mmap_control control;
+		unsigned char reserved[64];
+	} c;
+};
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
+typedef char __pad_after_uframe[0];
+#endif
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+typedef char __pad_before_uframe[0];
+typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
+#endif
+
+struct __snd_pcm_mmap_status64 {
+	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
+	__u32 pad1;			/* Needed for 64 bit alignment */
+	__pad_before_uframe __pad1;
+	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
+	__pad_after_uframe __pad2;
+	struct __snd_timespec64 tstamp;	/* Timestamp */
+	snd_pcm_state_t suspended_state;/* RO: suspended stream state */
+	__u32 pad3;			/* Needed for 64 bit alignment */
+	struct __snd_timespec64 audio_tstamp; /* sample counter or wall clock */
+};
+
+struct __snd_pcm_mmap_control64 {
+	__pad_before_uframe __pad1;
+	snd_pcm_uframes_t appl_ptr;	 /* RW: appl ptr (0...boundary-1) */
+	__pad_before_uframe __pad2;
+
+	__pad_before_uframe __pad3;
+	snd_pcm_uframes_t  avail_min;	 /* RW: min available frames for wakeup */
+	__pad_after_uframe __pad4;
+};
+
+struct __snd_pcm_sync_ptr64 {
+	__u32 flags;
+	__u32 pad1;
+	union {
+		struct __snd_pcm_mmap_status64 status;
 		unsigned char reserved[64];
 	} s;
 	union {
-		struct snd_pcm_mmap_control control;
+		struct __snd_pcm_mmap_control64 control;
 		unsigned char reserved[64];
 	} c;
 };
@@ -584,6 +678,8 @@ enum {
 #define SNDRV_PCM_IOCTL_STATUS		_IOR('A', 0x20, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_DELAY		_IOR('A', 0x21, snd_pcm_sframes_t)
 #define SNDRV_PCM_IOCTL_HWSYNC		_IO('A', 0x22)
+#define __SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct __snd_pcm_sync_ptr)
+#define __SNDRV_PCM_IOCTL_SYNC_PTR64	_IOWR('A', 0x23, struct __snd_pcm_sync_ptr64)
 #define SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct snd_pcm_sync_ptr)
 #define SNDRV_PCM_IOCTL_STATUS_EXT	_IOWR('A', 0x24, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_CHANNEL_INFO	_IOR('A', 0x32, struct snd_pcm_channel_info)
@@ -614,7 +710,7 @@ enum {
  *  Raw MIDI section - /dev/snd/midi??
  */
 
-#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 0)
+#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 1)
 
 enum {
 	SNDRV_RAWMIDI_STREAM_OUTPUT = 0,
@@ -648,13 +744,16 @@ struct snd_rawmidi_params {
 	unsigned char reserved[16];	/* reserved for future use */
 };
 
+#ifndef __KERNEL__
 struct snd_rawmidi_status {
 	int stream;
+	__time_pad pad1;
 	struct timespec tstamp;		/* Timestamp */
 	size_t avail;			/* available bytes */
 	size_t xruns;			/* count of overruns since last status (in bytes) */
 	unsigned char reserved[16];	/* reserved for future use */
 };
+#endif
 
 #define SNDRV_RAWMIDI_IOCTL_PVERSION	_IOR('W', 0x00, int)
 #define SNDRV_RAWMIDI_IOCTL_INFO	_IOR('W', 0x01, struct snd_rawmidi_info)
@@ -667,7 +766,7 @@ struct snd_rawmidi_status {
  *  Timer section - /dev/snd/timer
  */
 
-#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 6)
+#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
 
 enum {
 	SNDRV_TIMER_CLASS_NONE = -1,
@@ -761,6 +860,7 @@ struct snd_timer_params {
 	unsigned char reserved[60];	/* reserved */
 };
 
+#ifndef __KERNEL__
 struct snd_timer_status {
 	struct timespec tstamp;		/* Timestamp - last update */
 	unsigned int resolution;	/* current period resolution in ns */
@@ -769,10 +869,11 @@ struct snd_timer_status {
 	unsigned int queue;		/* used queue size */
 	unsigned char reserved[64];	/* reserved */
 };
+#endif
 
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
-#define SNDRV_TIMER_IOCTL_TREAD		_IOW('T', 0x02, int)
+#define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
 #define SNDRV_TIMER_IOCTL_GINFO		_IOWR('T', 0x03, struct snd_timer_ginfo)
 #define SNDRV_TIMER_IOCTL_GPARAMS	_IOW('T', 0x04, struct snd_timer_gparams)
 #define SNDRV_TIMER_IOCTL_GSTATUS	_IOWR('T', 0x05, struct snd_timer_gstatus)
@@ -785,6 +886,15 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_STOP		_IO('T', 0xa1)
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
+#define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+
+#if __BITS_PER_LONG == 64
+#define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
+#else
+#define SNDRV_TIMER_IOCTL_TREAD ((sizeof(__kernel_long_t) >= sizeof(time_t)) ? \
+				 SNDRV_TIMER_IOCTL_TREAD_OLD : \
+				 SNDRV_TIMER_IOCTL_TREAD64)
+#endif
 
 struct snd_timer_read {
 	unsigned int resolution;
@@ -810,11 +920,15 @@ enum {
 	SNDRV_TIMER_EVENT_MRESUME = SNDRV_TIMER_EVENT_RESUME + 10,
 };
 
+#ifndef __KERNEL__
 struct snd_timer_tread {
 	int event;
+	__time_pad pad1;
 	struct timespec tstamp;
 	unsigned int val;
+	__time_pad pad2;
 };
+#endif
 
 /****************************************************************************
  *                                                                          *
@@ -822,7 +936,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/
 
-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 8)
 
 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -860,7 +974,7 @@ typedef int __bitwise snd_ctl_elem_iface_t;
 #define SNDRV_CTL_ELEM_ACCESS_WRITE		(1<<1)
 #define SNDRV_CTL_ELEM_ACCESS_READWRITE		(SNDRV_CTL_ELEM_ACCESS_READ|SNDRV_CTL_ELEM_ACCESS_WRITE)
 #define SNDRV_CTL_ELEM_ACCESS_VOLATILE		(1<<2)	/* control value may be changed without a notification */
-#define SNDRV_CTL_ELEM_ACCESS_TIMESTAMP		(1<<3)	/* when was control changed */
+// (1 << 3) is unused.
 #define SNDRV_CTL_ELEM_ACCESS_TLV_READ		(1<<4)	/* TLV read is possible */
 #define SNDRV_CTL_ELEM_ACCESS_TLV_WRITE		(1<<5)	/* TLV write is possible */
 #define SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE	(SNDRV_CTL_ELEM_ACCESS_TLV_READ|SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
@@ -926,11 +1040,7 @@ struct snd_ctl_elem_info {
 		} enumerated;
 		unsigned char reserved[128];
 	} value;
-	union {
-		unsigned short d[4];		/* dimensions */
-		unsigned short *d_ptr;		/* indirect - obsoleted */
-	} dimen;
-	unsigned char reserved[64-4*sizeof(unsigned short)];
+	unsigned char reserved[64];
 };
 
 struct snd_ctl_elem_value {
@@ -955,8 +1065,7 @@ struct snd_ctl_elem_value {
 		} bytes;
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
-	struct timespec tstamp;
-	unsigned char reserved[128-sizeof(struct timespec)];
+	unsigned char reserved[128];
 };
 
 struct snd_ctl_tlv {
diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index a32e4b72a98f..d730666ab95d 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,8 +1,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
+#include <util/cpumap.h>
 #include <internal/cpumap.h>
 #include <api/fs/fs.h>
+#include <errno.h>
 #include "debug.h"
 #include "header.h"
 
@@ -12,26 +14,21 @@
 #define MIDR_VARIANT_SHIFT      20
 #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
 
-char *get_cpuid_str(struct perf_pmu *pmu)
+static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 {
-	char *buf = NULL;
-	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
-	int cpu;
 	u64 midr = 0;
-	struct perf_cpu_map *cpus;
-	FILE *file;
+	int cpu;
 
-	if (!sysfs || !pmu || !pmu->cpus)
-		return NULL;
+	if (!sysfs || sz < MIDR_SIZE)
+		return EINVAL;
 
-	buf = malloc(MIDR_SIZE);
-	if (!buf)
-		return NULL;
+	cpus = perf_cpu_map__get(cpus);
 
-	/* read midr from list of cpus mapped to this pmu */
-	cpus = perf_cpu_map__get(pmu->cpus);
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
+		char path[PATH_MAX];
+		FILE *file;
+
 		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
 				sysfs, cpus->map[cpu]);
 
@@ -57,12 +54,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		break;
 	}
 
-	if (!midr) {
+	perf_cpu_map__put(cpus);
+
+	if (!midr)
+		return EINVAL;
+
+	return 0;
+}
+
+int get_cpuid(char *buf, size_t sz)
+{
+	struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
+	int ret;
+
+	if (!cpus)
+		return EINVAL;
+
+	ret = _get_cpuid(buf, sz, cpus);
+
+	perf_cpu_map__put(cpus);
+
+	return ret;
+}
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = NULL;
+	int res;
+
+	if (!pmu || !pmu->cpus)
+		return NULL;
+
+	buf = malloc(MIDR_SIZE);
+	if (!buf)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	res = _get_cpuid(buf, MIDR_SIZE, pmu->cpus);
+	if (res) {
 		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
 		free(buf);
 		buf = NULL;
 	}
 
-	perf_cpu_map__put(cpus);
 	return buf;
 }
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c29976eca4a8..44d510bc9b78 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,8 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+437	common	openat2			__x64_sys_openat2
+438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 46a72ecac427..01d542007c8b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1065,7 +1065,9 @@ static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
 	{ .name	    = "prctl",
-	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */ },
+	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */
+			   .strtoul   = STUL_STRARRAY,
+			   .parm      = &strarray__prctl_options, },
 		   [1] = { .scnprintf = SCA_PRCTL_ARG2, /* arg2 */ },
 		   [2] = { .scnprintf = SCA_PRCTL_ARG3, /* arg3 */ }, }, },
 	{ .name	    = "pread", .alias = "pread64", },
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 68039a96c1dc..bfb21d049e6c 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -13,6 +13,7 @@ include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
 include/uapi/linux/mount.h
+include/uapi/linux/openat2.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 5a61043c2ff7..d6dfe68a7612 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -213,6 +213,8 @@ size_t syscall_arg__scnprintf_x86_arch_prctl_code(char *bf, size_t size, struct
 size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_OPTION syscall_arg__scnprintf_prctl_option
 
+extern struct strarray strarray__prctl_options;
+
 size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG2 syscall_arg__scnprintf_prctl_arg2
 
diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
index ba2179abed00..6fe5ad5f5d3a 100644
--- a/tools/perf/trace/beauty/prctl.c
+++ b/tools/perf/trace/beauty/prctl.c
@@ -11,9 +11,10 @@
 
 #include "trace/beauty/generated/prctl_option_array.c"
 
+DEFINE_STRARRAY(prctl_options, "PR_");
+
 static size_t prctl__scnprintf_option(int option, char *bf, size_t size, bool show_prefix)
 {
-	static DEFINE_STRARRAY(prctl_options, "PR_");
 	return strarray__scnprintf(&strarray__prctl_options, bf, size, "%d", show_prefix, option);
 }
 
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index eae47c2509eb..b5af680fc667 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -288,6 +288,7 @@ static const char *kinc_fetch_script =
 "obj-y := dummy.o\n"
 "\\$(obj)/%.o: \\$(src)/%.c\n"
 "\t@echo -n \"\\$(NOSTDINC_FLAGS) \\$(LINUXINCLUDE) \\$(EXTRA_CFLAGS)\"\n"
+"\t\\$(CC) -c -o \\$@ \\$<\n"
 "EOF\n"
 "touch $TMPDIR/dummy.c\n"
 "make -s -C $KBUILD_DIR M=$TMPDIR $KBUILD_OPTS dummy.o 2>/dev/null\n"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..fb5c2cd44d30 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -686,6 +686,7 @@ static struct dso *machine__findnew_module_dso(struct machine *machine,
 
 		dso__set_module_info(dso, m, machine);
 		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_TYPE_KERNEL;
 	}
 
 	dso__get(dso);
@@ -726,9 +727,17 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
 	if (!map) {
-		map = dso__new_map(event->ksymbol.name);
-		if (!map)
+		struct dso *dso = dso__new(event->ksymbol.name);
+
+		if (dso) {
+			dso->kernel = DSO_TYPE_KERNEL;
+			map = map__new2(0, dso);
+		}
+
+		if (!dso || !map) {
+			dso__put(dso);
 			return -ENOMEM;
+		}
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
@@ -972,7 +981,6 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	kmap = map__kmap(map);
 
-	kmap->kmaps = &machine->kmaps;
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
 	maps__insert(&machine->kmaps, map);
@@ -1082,9 +1090,6 @@ int __weak machine__create_extra_kernel_maps(struct machine *machine __maybe_unu
 static int
 __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
-	struct kmap *kmap;
-	struct map *map;
-
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
@@ -1093,14 +1098,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 		return -1;
 
 	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
-	map = machine__kernel_map(machine);
-	kmap = map__kmap(map);
-	if (!kmap)
-		return -1;
-
-	kmap->kmaps = &machine->kmaps;
-	maps__insert(&machine->kmaps, map);
-
+	maps__insert(&machine->kmaps, machine->vmlinux_map);
 	return 0;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f67960bedebb..a08ca276098e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -375,8 +375,13 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 
 struct map *map__clone(struct map *from)
 {
-	struct map *map = memdup(from, sizeof(*map));
+	size_t size = sizeof(struct map);
+	struct map *map;
+
+	if (from->dso && from->dso->kernel)
+		size += sizeof(struct kmap);
 
+	map = memdup(from, size);
 	if (map != NULL) {
 		refcount_set(&map->refcnt, 1);
 		RB_CLEAR_NODE(&map->rb_node);
@@ -538,6 +543,16 @@ void maps__insert(struct maps *maps, struct map *map)
 	__maps__insert(maps, map);
 	++maps->nr_maps;
 
+	if (map->dso && map->dso->kernel) {
+		struct kmap *kmap = map__kmap(map);
+
+		if (kmap)
+			kmap->kmaps = maps;
+		else
+			pr_err("Internal error: kernel dso with non kernel map\n");
+	}
+
+
 	/*
 	 * If we already performed some search by name, then we need to add the just
 	 * inserted map and resort.
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47f6f83..90d23cc3c8d4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -18,7 +18,6 @@
  * AGGR_NONE: Use matching CPU
  * AGGR_THREAD: Not supported?
  */
-static bool have_frontend_stalled;
 
 struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
@@ -144,7 +143,6 @@ void runtime_stat__exit(struct runtime_stat *st)
 
 void perf_stat__init_shadow_stats(void)
 {
-	have_frontend_stalled = pmu_have_event("cpu", "stalled-cycles-frontend");
 	runtime_stat__init(&rt_stat);
 }
 
@@ -853,10 +851,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, "%7.2f ",
 					"stalled cycles per insn",
 					ratio);
-		} else if (have_frontend_stalled) {
-			out->new_line(config, ctxp);
-			print_metric(config, ctxp, NULL, "%7.2f ",
-				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
 		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3b379b1296f1..1077013d8ce2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -635,9 +635,12 @@ int modules__parse(const char *filename, void *arg,
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"acpi_idle_do_entry",
+		"acpi_processor_ffh_cstate_enter",
 		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
+		"idle_cpu",
 		"intel_idle",
 		"default_idle",
 		"native_safe_halt",
@@ -651,13 +654,17 @@ static bool symbol__is_idle(const char *name)
 		NULL
 	};
 	int i;
+	static struct strlist *idle_symbols_list;
 
-	for (i = 0; idle_symbols[i]; i++) {
-		if (!strcmp(idle_symbols[i], name))
-			return true;
-	}
+	if (idle_symbols_list)
+		return strlist__has_entry(idle_symbols_list, name);
 
-	return false;
+	idle_symbols_list = strlist__new(NULL, NULL);
+
+	for (i = 0; idle_symbols[i]; i++)
+		strlist__add(idle_symbols_list, idle_symbols[i]);
+
+	return strlist__has_entry(idle_symbols_list, name);
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
