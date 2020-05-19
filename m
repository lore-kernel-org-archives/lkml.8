Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF436207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgESFtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:49:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58079 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbgESFt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:49:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4hM4KxXz9txly;
        Tue, 19 May 2020 07:49:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rqvHMht99wJ3; Tue, 19 May 2020 07:49:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4hM3YLyz9txlx;
        Tue, 19 May 2020 07:49:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9903F8B7A7;
        Tue, 19 May 2020 07:49:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UAfL3ipXLUA4; Tue, 19 May 2020 07:49:24 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5965E8B767;
        Tue, 19 May 2020 07:49:24 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 34F9765A4A; Tue, 19 May 2020 05:49:24 +0000 (UTC)
Message-Id: <c44f0ab5510474f25123d904cd1f4e5c6aa3c1ac.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 40/45] powerpc/8xx: Map linear memory with huge pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:49:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map linear memory space with 512k and 8M pages whenever
possible.

Three mappings are performed:
- One for kernel text
- One for RO data
- One for the rest

Separating the mappings is done to be able to update the
protection later when using STRICT_KERNEL_RWX.

The ITLB miss handler now need to also handle huge TLBs
unless kernel text in pinned.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S |  4 +--
 arch/powerpc/mm/nohash/8xx.c   | 50 +++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 9a117b9f0998..abb71fad7d6a 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -224,7 +224,7 @@ InstructionTLBMiss:
 3:
 	mtcr	r11
 #endif
-#ifdef CONFIG_HUGETLBFS
+#if defined(CONFIG_HUGETLBFS) || !defined(CONFIG_PIN_TLB_TEXT)
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
 	mtspr	SPRN_MD_TWC, r11
 #else
@@ -234,7 +234,7 @@ InstructionTLBMiss:
 #endif
 	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
-#ifdef CONFIG_HUGETLBFS
+#if defined(CONFIG_HUGETLBFS) || !defined(CONFIG_PIN_TLB_TEXT)
 	rlwimi	r11, r10, 32 - 9, _PMD_PAGE_512K
 	mtspr	SPRN_MI_TWC, r11
 #endif
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index f8fff1fa72e3..ec3ef75895d8 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -127,20 +127,68 @@ void __init mmu_mapin_immr(void)
 				    PAGE_KERNEL_NCG, MMU_PAGE_512K, true);
 }
 
+static void __init mmu_mapin_ram_chunk(unsigned long offset, unsigned long top,
+				       pgprot_t prot, bool new)
+{
+	unsigned long v = PAGE_OFFSET + offset;
+	unsigned long p = offset;
+
+	WARN_ON(!IS_ALIGNED(offset, SZ_512K) || !IS_ALIGNED(top, SZ_512K));
+
+	for (; p < ALIGN(p, SZ_8M) && p < top; p += SZ_512K, v += SZ_512K)
+		__early_map_kernel_hugepage(v, p, prot, MMU_PAGE_512K, new);
+	for (; p < ALIGN_DOWN(top, SZ_8M) && p < top; p += SZ_8M, v += SZ_8M)
+		__early_map_kernel_hugepage(v, p, prot, MMU_PAGE_8M, new);
+	for (; p < ALIGN_DOWN(top, SZ_512K) && p < top; p += SZ_512K, v += SZ_512K)
+		__early_map_kernel_hugepage(v, p, prot, MMU_PAGE_512K, new);
+
+	if (!new)
+		flush_tlb_kernel_range(PAGE_OFFSET + v, PAGE_OFFSET + top);
+}
+
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
+	unsigned long etext8 = ALIGN(__pa(_etext), SZ_8M);
+	unsigned long sinittext = __pa(_sinittext);
+	unsigned long boundary = strict_kernel_rwx_enabled() ? sinittext : etext8;
+	unsigned long einittext8 = ALIGN(__pa(_einittext), SZ_8M);
+
+	WARN_ON(top < einittext8);
+
 	mmu_mapin_immr();
 
-	return 0;
+	if (__map_without_ltlbs)
+		return 0;
+
+	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, true);
+	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL_TEXT, true);
+	mmu_mapin_ram_chunk(einittext8, top, PAGE_KERNEL, true);
+
+	if (top > SZ_32M)
+		memblock_set_current_limit(top);
+
+	block_mapped_ram = top;
+
+	return top;
 }
 
 void mmu_mark_initmem_nx(void)
 {
+	unsigned long etext8 = ALIGN(__pa(_etext), SZ_8M);
+	unsigned long sinittext = __pa(_sinittext);
+	unsigned long boundary = strict_kernel_rwx_enabled() ? sinittext : etext8;
+	unsigned long einittext8 = ALIGN(__pa(_einittext), SZ_8M);
+
+	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, false);
+	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
 void mmu_mark_rodata_ro(void)
 {
+	unsigned long sinittext = __pa(_sinittext);
+
+	mmu_mapin_ram_chunk(0, sinittext, PAGE_KERNEL_ROX, false);
 }
 #endif
 
-- 
2.25.0

