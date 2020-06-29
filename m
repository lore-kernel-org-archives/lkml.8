Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F3EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3102D2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgF2SpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:45:02 -0400
Received: from foss.arm.com ([217.140.110.172]:35690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgF2Soz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:44:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AAB130E;
        Sun, 28 Jun 2020 21:39:15 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.83.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 159373F68F;
        Sun, 28 Jun 2020 21:39:12 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64/panic: Unify all three existing notifier blocks
Date:   Mon, 29 Jun 2020 10:08:31 +0530
Message-Id: <1593405511-7625-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are three different registered panic notifier blocks. This
unifies all of them into a single one i.e arm64_panic_block, hence reducing
code duplication and required calling sequence during panic. This preserves
the existing dump sequence. While here, just use device_initcall() directly
instead of __initcall() which has been a legacy alias for the earlier. This
replacement is a pure cleanup with no functional implications.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies on 5.8-rc3.

Changes in V3:

- Updated the commit message per Mark

Changes in V2: (https://patchwork.kernel.org/patch/11619601/)

- Replaced __initcall() directly with device_initcall()
- Added static for dump_kernel_offset()

Changes in V1: (https://patchwork.kernel.org/patch/11606291/)

 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/include/asm/memory.h     |  1 +
 arch/arm64/kernel/cpufeature.c      | 15 +--------------
 arch/arm64/kernel/setup.c           | 24 ++++++++++++++----------
 arch/arm64/mm/init.c                | 18 +-----------------
 5 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5d1f4ae42799..e375529ca9fc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -774,6 +774,7 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
 }
 
 u32 get_kvm_ipa_limit(void);
+void dump_cpu_features(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index a1871bb32bb1..2a88cb734d06 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -322,6 +322,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
 })
 
+void dump_mem_limit(void);
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f63053a63a9..9b79df930396 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -119,24 +119,11 @@ static inline void finalize_system_capabilities(void)
 	static_branch_enable(&arm64_const_caps_ready);
 }
 
-static int dump_cpu_hwcaps(struct notifier_block *self, unsigned long v, void *p)
+void dump_cpu_features(void)
 {
 	/* file-wide pr_fmt adds "CPU features: " prefix */
 	pr_emerg("0x%*pb\n", ARM64_NCAPS, &cpu_hwcaps);
-	return 0;
-}
-
-static struct notifier_block cpu_hwcaps_notifier = {
-	.notifier_call = dump_cpu_hwcaps
-};
-
-static int __init register_cpu_hwcaps_dumper(void)
-{
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &cpu_hwcaps_notifier);
-	return 0;
 }
-__initcall(register_cpu_hwcaps_dumper);
 
 DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcap_keys);
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 93b3844cf442..c793276ec7ad 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -400,11 +400,7 @@ static int __init topology_init(void)
 }
 subsys_initcall(topology_init);
 
-/*
- * Dump out kernel offset information on panic.
- */
-static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
-			      void *p)
+static void dump_kernel_offset(void)
 {
 	const unsigned long offset = kaslr_offset();
 
@@ -415,17 +411,25 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
 	} else {
 		pr_emerg("Kernel Offset: disabled\n");
 	}
+}
+
+static int arm64_panic_block_dump(struct notifier_block *self,
+				  unsigned long v, void *p)
+{
+	dump_kernel_offset();
+	dump_cpu_features();
+	dump_mem_limit();
 	return 0;
 }
 
-static struct notifier_block kernel_offset_notifier = {
-	.notifier_call = dump_kernel_offset
+static struct notifier_block arm64_panic_block = {
+	.notifier_call = arm64_panic_block_dump
 };
 
-static int __init register_kernel_offset_dumper(void)
+static int __init register_arm64_panic_block(void)
 {
 	atomic_notifier_chain_register(&panic_notifier_list,
-				       &kernel_offset_notifier);
+				       &arm64_panic_block);
 	return 0;
 }
-__initcall(register_kernel_offset_dumper);
+device_initcall(register_arm64_panic_block);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..6c3eb424c613 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -563,27 +563,11 @@ void free_initmem(void)
 	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
 }
 
-/*
- * Dump out memory limit information on panic.
- */
-static int dump_mem_limit(struct notifier_block *self, unsigned long v, void *p)
+void dump_mem_limit(void)
 {
 	if (memory_limit != PHYS_ADDR_MAX) {
 		pr_emerg("Memory Limit: %llu MB\n", memory_limit >> 20);
 	} else {
 		pr_emerg("Memory Limit: none\n");
 	}
-	return 0;
-}
-
-static struct notifier_block mem_limit_notifier = {
-	.notifier_call = dump_mem_limit,
-};
-
-static int __init register_mem_limit_dumper(void)
-{
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &mem_limit_notifier);
-	return 0;
 }
-__initcall(register_mem_limit_dumper);
-- 
2.20.1

