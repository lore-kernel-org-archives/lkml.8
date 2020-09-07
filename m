Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B25C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74D620658
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgIGRUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:20:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10829 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729670AbgIGNrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:47:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A730AA4FFA204FA96CE3;
        Mon,  7 Sep 2020 21:46:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:46:52 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dyoung@redhat.com>, <bhe@redhat.com>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <chenzhou10@huawei.com>
Subject: [PATCH v12 6/9] arm64: kdump: reimplement crashkernel=X
Date:   Mon, 7 Sep 2020 21:47:42 +0800
Message-ID: <20200907134745.25732-7-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which
will fail when there is no enough low memory.
2. If reserving crashkernel above 4G, in this case, crash dump
kernel will boot failure because there is no low memory available
for allocation.
3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
if the memory reserved for crash dump kernel falled in ZONE_DMA32,
the devices in crash dump kernel need to use ZONE_DMA will alloc
fail.

To solve these issues, change the behavior of crashkernel=X and
introduce crashkernel=X,[high,low].
crashkernel=X tries low allocation in DMA zone, and fall back to
high allocation if it fails.
We can also use "crashkernel=X,high" to select a region above DMA zone,
which also tries to allocate at least 256M in DMA zone automatically.
"crashkernel=Y,low" can be used to allocate specified size low memory.

For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.

Another minor change, there may be two regions reserved for crash
dump kernel, in order to distinct from the high region and make no
effect to the use of existing kexec-tools, rename the low region as
"Crash kernel (low)".

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/include/asm/kexec.h |  9 +++++
 arch/arm64/kernel/setup.c      | 13 +++++++-
 arch/arm64/mm/init.c           | 60 ++--------------------------------
 arch/arm64/mm/mmu.c            |  4 +++
 kernel/crash_core.c            |  8 +++--
 5 files changed, 34 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 402d208265a3..79909ae5e22e 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -28,7 +28,12 @@
 /* 2M alignment for crash kernel regions */
 #define CRASH_ALIGN	SZ_2M
 
+#ifdef CONFIG_ZONE_DMA
+#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
+#else
 #define CRASH_ADDR_LOW_MAX	arm64_dma32_phys_limit
+#endif
+
 #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
 
 #ifndef __ASSEMBLY__
@@ -96,6 +101,10 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+extern void __init reserve_crashkernel(void);
+#endif
+
 #ifdef CONFIG_KEXEC_FILE
 #define ARCH_HAS_KIMAGE_ARCH
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 53acbeca4f57..1b24072f2bae 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -238,7 +238,18 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 #ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		/*
+		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
+		 * region in /proc/iomem.
+		 * In order to distinct from the high region and make no effect
+		 * to the use of existing kexec-tools, rename the low region as
+		 * "Crash kernel (low)".
+		 */
+		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
+				crashk_low_res.end <= res->end) {
+			crashk_low_res.name = "Crash kernel (low)";
+			request_resource(res, &crashk_low_res);
+		}
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ad27dc4cc55e..e56a0e5d5b77 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -35,6 +35,7 @@
 #include <asm/fixmap.h>
 #include <asm/kasan.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/numa.h>
 #include <asm/sections.h>
@@ -69,66 +70,11 @@ EXPORT_SYMBOL(vmemmap);
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
-#ifdef CONFIG_KEXEC_CORE
-/*
- * reserve_crashkernel() - reserves memory for crash kernel
- *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by dump capture kernel when
- * primary kernel is crashing.
- */
-static void __init reserve_crashkernel(void)
-{
-	unsigned long long crash_base, crash_size;
-	int ret;
-
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
-	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
-		return;
-
-	crash_size = PAGE_ALIGN(crash_size);
-
-	if (crash_base == 0) {
-		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX,
-				crash_size, CRASH_ALIGN);
-		if (crash_base == 0) {
-			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-				crash_size);
-			return;
-		}
-	} else {
-		/* User specifies base address explicitly. */
-		if (!memblock_is_region_memory(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region is not memory\n");
-			return;
-		}
-
-		if (memblock_is_region_reserved(crash_base, crash_size)) {
-			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
-			return;
-		}
-
-		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
-			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
-			return;
-		}
-	}
-	memblock_reserve(crash_base, crash_size);
-
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
-
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
-}
-#else
+#ifndef CONFIG_KEXEC_CORE
 static void __init reserve_crashkernel(void)
 {
 }
-#endif /* CONFIG_KEXEC_CORE */
+#endif
 
 #ifdef CONFIG_CRASH_DUMP
 static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..0b1b3ec18785 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -476,6 +476,10 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 #ifdef CONFIG_KEXEC_CORE
+	if (crashk_low_res.end)
+		memblock_mark_nomap(crashk_low_res.start,
+				    resource_size(&crashk_low_res));
+
 	if (crashk_res.end)
 		memblock_mark_nomap(crashk_res.start,
 				    resource_size(&crashk_res));
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d968ef268fb4..3f735cb37ace 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -321,7 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
 
 int __init reserve_crashkernel_low(void)
 {
-#if defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 	unsigned long long base, low_base = 0, low_size = 0;
 	unsigned long total_low_mem;
 	int ret;
@@ -370,12 +370,14 @@ int __init reserve_crashkernel_low(void)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
+#ifdef CONFIG_X86
 	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
 #endif
 	return 0;
 }
 
-#if defined(CONFIG_X86)
+#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
@@ -468,7 +470,9 @@ void __init reserve_crashkernel(void)
 
 	crashk_res.start = crash_base;
 	crashk_res.end   = crash_base + crash_size - 1;
+#ifdef CONFIG_X86
 	insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 #endif /* CONFIG_KEXEC_CORE */
 #endif
-- 
2.20.1

