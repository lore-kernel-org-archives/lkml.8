Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF68C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7703720679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgFCPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:37:21 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37783 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFCPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:37:19 -0400
X-Originating-IP: 90.112.45.105
Received: from debian.home (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BB59E2000F;
        Wed,  3 Jun 2020 15:37:16 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 1/2] riscv: Get memory below load_pa while ensuring linear mapping is PMD aligned
Date:   Wed,  3 Jun 2020 11:36:07 -0400
Message-Id: <20200603153608.30056-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200603153608.30056-1-alex@ghiti.fr>
References: <20200603153608.30056-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early page table uses the kernel load address as mapping for PAGE_OFFSET:
that makes memblock remove any memory below the kernel which results in
using only PMD entries for the linear mapping.

By setting MIN_MEMBLOCK_ADDR to 0, we allow this memory to be present
when creating the kernel page table: that potentially allows to use
PUD/PGDIR entries for the linear mapping.

But as the firmware might ask the kernel to remove some part of this
memory, we need to ensure that the physical address targeted by
PAGE_OFFSET is at least aligned on PMD size since otherwise the linear
mapping would use only PTE entries.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/asm/page.h |  8 ++++++++
 arch/riscv/mm/init.c          | 24 +++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 5e77fe7f0d6d..b416396fc357 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -100,6 +100,14 @@ typedef struct page *pgtable_t;
 #define PTE_FMT "%08lx"
 #endif
 
+/*
+ * Early page table maps PAGE_OFFSET to load_pa, which may not be the memory
+ * base address and by default MIN_MEMBLOCK_ADDR is equal to __pa(PAGE_OFFSET)
+ * then memblock ignores memory below load_pa: we want this memory to get mapped
+ * as it may allow to use hugepages for linear mapping.
+ */
+#define MIN_MEMBLOCK_ADDR	0
+
 #ifdef CONFIG_MMU
 extern unsigned long va_pa_offset;
 extern unsigned long va_kernel_pa_offset;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4064639b24e4..9a5c97e091c1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -664,7 +664,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 static void __init setup_vm_final(void)
 {
 	uintptr_t va, map_size;
-	phys_addr_t pa, start, end;
+	phys_addr_t pa, start, end, dram_start;
 	struct memblock_region *reg;
 	static struct vm_struct vm_kernel = { 0 };
 
@@ -676,6 +676,28 @@ static void __init setup_vm_final(void)
 			   __pa_symbol(fixmap_pgd_next),
 			   PGDIR_SIZE, PAGE_TABLE);
 
+	/*
+	 * Make sure that virtual and physical addresses are at least aligned
+	 * on PMD_SIZE, even if we have to lose some memory (< PMD_SIZE)
+	 * otherwise the linear mapping would get mapped using PTE entries.
+	 */
+	dram_start = memblock_start_of_DRAM();
+	if (dram_start & (PMD_SIZE - 1)) {
+		uintptr_t next_dram_start;
+
+		next_dram_start	= (dram_start + PMD_SIZE - 1) & ~(PMD_SIZE - 1);
+		memblock_remove(dram_start, next_dram_start - dram_start);
+		dram_start = next_dram_start;
+	}
+
+	/*
+	 * We started considering PAGE_OFFSET would start at load_pa because
+	 * it was the only piece of information we had, but now make PAGE_OFFSET
+	 * point to the real beginning of the memory area.
+	 */
+	va_pa_offset = PAGE_OFFSET - dram_start;
+	pfn_base = PFN_DOWN(dram_start);
+
 	/* Map all memory banks */
 	for_each_memblock(memory, reg) {
 		start = reg->base;
-- 
2.20.1

