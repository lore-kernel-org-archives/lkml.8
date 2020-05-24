Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA36C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6F22076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEXJMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 05:12:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48937 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgEXJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 05:12:17 -0400
X-Originating-IP: 90.112.45.105
Received: from localhost.localdomain (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0F5F320002;
        Sun, 24 May 2020 09:12:13 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 2/8] riscv: Allow to dynamically define VA_BITS
Date:   Sun, 24 May 2020 05:10:02 -0400
Message-Id: <20200524091008.25587-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200524091008.25587-1-alex@ghiti.fr>
References: <20200524091008.25587-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 4-level page table folding at runtime, we don't know at compile time
the size of the virtual address space so we must set VA_BITS dynamically
so that sparsemem reserves the right amount of memory for struct pages.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig                 | 10 ----------
 arch/riscv/include/asm/pgtable.h   | 12 ++++++++++--
 arch/riscv/include/asm/sparsemem.h |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 93127d5913fe..64b25a90d60f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -101,16 +101,6 @@ config ZONE_DMA32
 	bool
 	default y if 64BIT
 
-config VA_BITS
-	int
-	default 32 if 32BIT
-	default 39 if 64BIT
-
-config PA_BITS
-	int
-	default 34 if 32BIT
-	default 56 if 64BIT
-
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 25213cfaf680..8e96315b3366 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -41,7 +41,7 @@
  * position vmemmap directly below the VMALLOC region.
  */
 #define VMEMMAP_SHIFT \
-	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
+	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
 #define VMEMMAP_END	(VMALLOC_START - 1)
 #define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
@@ -80,6 +80,14 @@
 #endif /* CONFIG_64BIT */
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_64BIT
+#define VA_BITS		39
+#define PA_BITS		56
+#else
+#define VA_BITS		32
+#define PA_BITS		34
+#endif
+
 /* Number of entries in the page global directory */
 #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
 /* Number of entries in the page table */
@@ -466,7 +474,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
  * and give the kernel the other (upper) half.
  */
 #ifdef CONFIG_64BIT
-#define KERN_VIRT_START	(-(BIT(CONFIG_VA_BITS)) + TASK_SIZE)
+#define KERN_VIRT_START	(-(BIT(VA_BITS)) + TASK_SIZE)
 #else
 #define KERN_VIRT_START	FIXADDR_START
 #endif
diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
index 45a7018a8118..f08d72155bc8 100644
--- a/arch/riscv/include/asm/sparsemem.h
+++ b/arch/riscv/include/asm/sparsemem.h
@@ -4,7 +4,7 @@
 #define _ASM_RISCV_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
+#define MAX_PHYSMEM_BITS	PA_BITS
 #define SECTION_SIZE_BITS	27
 #endif /* CONFIG_SPARSEMEM */
 
-- 
2.20.1

