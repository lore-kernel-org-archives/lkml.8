Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E00C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4D52087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgHANGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 09:06:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728770AbgHANGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 09:06:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2F5C34CE450590F118BA;
        Sat,  1 Aug 2020 21:06:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 1 Aug 2020 21:05:59 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dyoung@redhat.com>, <bhe@redhat.com>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <chenzhou10@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <wangkefeng.wang@huawei.com>
Subject: [PATCH v11 3/5] arm64: kdump: reimplement crashkernel=X
Date:   Sat, 1 Aug 2020 21:08:54 +0800
Message-ID: <20200801130856.86625-4-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200801130856.86625-1-chenzhou10@huawei.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
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

To solve these issues, change the behavior of crashkernel=X.
crashkernel=X tries low allocation in ZONE_DMA, and fall back to
high allocation if it fails.

If requized size X is too large and leads to very little free memory
in ZONE_DMA after low allocation, the system may not work normally.
So add a threshold and go for high allocation directly if the required
size is too large. The value of threshold is set as the half of
the low memory.

If crash_base is outside ZONE_DMA, try to allocate at least 256M in
ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
specified size low memory.

For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.

Another minor change, there may be two regions reserved for crash
dump kernel, in order to distinct from the high region and make no
effect to the use of existing kexec-tools, rename the low region as
"Crash kernel (low)".

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/include/asm/kexec.h |  4 +++
 arch/arm64/kernel/setup.c      |  8 +++++-
 arch/arm64/mm/init.c           | 51 ++++++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 1a2f27f12794..92ed53d0bf21 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -28,7 +28,11 @@
 /* 2M alignment for crash kernel regions */
 #define CRASH_ALIGN	SZ_2M
 
+#ifdef CONFIG_ZONE_DMA
+#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
+#else
 #define CRASH_ADDR_LOW_MAX	arm64_dma32_phys_limit
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 93b3844cf442..4dc51a2ac012 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -238,7 +238,13 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 #ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		/*
+		 * Userspace will find "Crash kernel" region in /proc/iomem.
+		 * Note: the low region is renamed as Crash kernel (low).
+		 */
+		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
+				crashk_low_res.end <= res->end)
+			request_resource(res, &crashk_low_res);
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a3d0193f6a0a..53c8916fd32f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -70,6 +70,14 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
+
+/*
+ * Add a threshold for required memory size of crashkernel. If required memory
+ * size is greater than threshold, just go for high allocation directly. The
+ * value of threshold is set as half of the total low memory.
+ */
+#define REQUIRED_MEMORY_THRESHOLD	(memblock_mem_size(CRASH_ADDR_LOW_MAX >> \
+			PAGE_SHIFT) >> 1)
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -90,11 +98,22 @@ static void __init reserve_crashkernel(void)
 
 	crash_size = PAGE_ALIGN(crash_size);
 
-	if (crash_base == 0) {
-		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, CRASH_ADDR_LOW_MAX,
-				crash_size, CRASH_ALIGN);
-		if (crash_base == 0) {
+	if (!crash_base) {
+		/*
+		 * Current arm64 boot protocol requires 2MB alignment.
+		 * If required memory size is greater than threshold, just go
+		 * for high allocation directly.
+		 * If required memory size is less than or equal to threshold,
+		 * try low allocation firstly, and then fall back to high allocation
+		 * if it fails.
+		 */
+		if (crash_size <= REQUIRED_MEMORY_THRESHOLD)
+			crash_base = memblock_find_in_range(0, CRASH_ADDR_LOW_MAX,
+					crash_size, CRASH_ALIGN);
+		if (!crash_base)
+			crash_base = memblock_find_in_range(0, MEMBLOCK_ALLOC_ACCESSIBLE,
+					crash_size, SZ_2M);
+		if (!crash_base) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 				crash_size);
 			return;
@@ -118,6 +137,28 @@ static void __init reserve_crashkernel(void)
 	}
 	memblock_reserve(crash_base, crash_size);
 
+	if (crash_base >= CRASH_ADDR_LOW_MAX) {
+		const char *rename = "Crash kernel (low)";
+
+		if (reserve_crashkernel_low()) {
+			memblock_free(crash_base, crash_size);
+			return;
+		}
+
+		/*
+		 * In order to distinct from the high region and make no effect
+		 * to the use of existing kexec-tools, rename the low region as
+		 * "Crash kernel (low)".
+		 */
+		crashk_low_res.name = rename;
+		/*
+		 * The low region is intended to be used for crash dump kernel
+		 * devices, just mark the low region as "nomap" simply.
+		 */
+		memblock_mark_nomap(crashk_low_res.start,
+				    resource_size(&crashk_low_res));
+	}
+
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
 
-- 
2.20.1

