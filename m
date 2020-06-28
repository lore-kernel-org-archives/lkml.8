Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9688C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E67207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgF1Iat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 04:30:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgF1Iar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:30:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1A0F180360D7FB836549;
        Sun, 28 Jun 2020 16:30:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 16:30:35 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>, <bhsharma@redhat.com>,
        <horms@verge.net.au>
CC:     <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH v9 3/5] arm64: kdump: add memory for devices by DT property linux,usable-memory-range
Date:   Sun, 28 Jun 2020 16:34:56 +0800
Message-ID: <20200628083458.40066-4-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628083458.40066-1-chenzhou10@huawei.com>
References: <20200628083458.40066-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to reserve crashkernel above 4G, we could use parameters
"crashkernel=X crashkernel=Y,low", in this case, specified size low
memory is reserved for crash dump kernel devices and never mapped by
the first kernel. This memory range is advertised to crash dump kernel
via DT property under /chosen,
	linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>

We reused the DT property linux,usable-memory-range and made the low
memory region as the second range "BASE2 SIZE2", which keeps compatibility
with existing user-space and older kdump kernels.

Crash dump kernel reads this property at boot time and call memblock_add()
to add the low memory region after memblock_cap_memory_range() has been
called.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 arch/arm64/mm/init.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ce7ced85f5fb..f5b31e8f1f34 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -69,6 +69,15 @@ EXPORT_SYMBOL(vmemmap);
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
+/*
+ * The main usage of linux,usable-memory-range is for crash dump kernel.
+ * Originally, the number of usable-memory regions is one. Now crash dump
+ * kernel support at most two regions, low region and high region.
+ * To make compatibility with existing user-space and older kdump, the low
+ * region is always the last range of linux,usable-memory-range if exist.
+ */
+#define MAX_USABLE_RANGES	2
+
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
@@ -272,9 +281,9 @@ early_param("mem", early_mem);
 static int __init early_init_dt_scan_usablemem(unsigned long node,
 		const char *uname, int depth, void *data)
 {
-	struct memblock_region *usablemem = data;
-	const __be32 *reg;
-	int len;
+	struct memblock_region *usable_rgns = data;
+	const __be32 *reg, *endp;
+	int len, nr = 0;
 
 	if (depth != 1 || strcmp(uname, "chosen") != 0)
 		return 0;
@@ -283,22 +292,36 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
 	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
 		return 1;
 
-	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+	endp = reg + (len / sizeof(__be32));
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		usable_rgns[nr].base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		usable_rgns[nr].size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+		if (++nr >= MAX_USABLE_RANGES)
+			break;
+	}
 
 	return 1;
 }
 
 static void __init fdt_enforce_memory_region(void)
 {
-	struct memblock_region reg = {
-		.size = 0,
+	struct memblock_region usable_rgns[MAX_USABLE_RANGES] = {
+		{ .size = 0 },
+		{ .size = 0 }
 	};
 
-	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+	of_scan_flat_dt(early_init_dt_scan_usablemem, &usable_rgns);
 
-	if (reg.size)
-		memblock_cap_memory_range(reg.base, reg.size);
+	/*
+	 * The first range of usable-memory regions is for crash dump
+	 * kernel with only one region or for high region with two regions,
+	 * the second range is dedicated for low region if exist.
+	 */
+	if (usable_rgns[0].size)
+		memblock_cap_memory_range(usable_rgns[0].base, usable_rgns[0].size);
+	if (usable_rgns[1].size)
+		memblock_add(usable_rgns[1].base, usable_rgns[1].size);
 }
 
 void __init arm64_memblock_init(void)
-- 
2.20.1

