Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812CDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6C820708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgESFs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:48:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55036 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgESFsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:48:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4gh6hLsz9txm5;
        Tue, 19 May 2020 07:48:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3uamqmJZV2oJ; Tue, 19 May 2020 07:48:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4gh5rw0z9txm4;
        Tue, 19 May 2020 07:48:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EFD48B767;
        Tue, 19 May 2020 07:48:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TUfPIjmjvjip; Tue, 19 May 2020 07:48:49 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE25F8B7A7;
        Tue, 19 May 2020 07:48:48 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8F68D65A4A; Tue, 19 May 2020 05:48:48 +0000 (UTC)
Message-Id: <3c1ce419fa1b5a4171b92d7fb16455ca17e1b96d.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 06/45] powerpc/kasan: Declare kasan_init_region() weak
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:48:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to alloc sub-arches to alloc KASAN regions using optimised
methods (Huge pages on 8xx, BATs on BOOK3S, ...), declare
kasan_init_region() weak.

Also make kasan_init_shadow_page_tables() accessible from outside,
so that it can be called from the specific kasan_init_region()
functions if needed.

And populate remaining KASAN address space only once performed
the region mapping, to allow 8xx to allocate hugepd instead of
standard page tables for mapping via 8M hugepages.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kasan.h      |  3 +++
 arch/powerpc/mm/kasan/kasan_init_32.c | 21 +++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 4769bbf7173a..107a24c3f7b3 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -34,5 +34,8 @@ static inline void kasan_init(void) { }
 static inline void kasan_late_init(void) { }
 #endif
 
+int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end);
+int kasan_init_region(void *start, size_t size);
+
 #endif /* __ASSEMBLY */
 #endif
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 10481d904fea..76d418af4ce8 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -28,7 +28,7 @@ static void __init kasan_populate_pte(pte_t *ptep, pgprot_t prot)
 		__set_pte_at(&init_mm, va, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
 }
 
-static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
+int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
 {
 	pmd_t *pmd;
 	unsigned long k_cur, k_next;
@@ -52,7 +52,7 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
 	return 0;
 }
 
-static int __init kasan_init_region(void *start, size_t size)
+int __init __weak kasan_init_region(void *start, size_t size)
 {
 	unsigned long k_start = (unsigned long)kasan_mem_to_shadow(start);
 	unsigned long k_end = (unsigned long)kasan_mem_to_shadow(start + size);
@@ -122,14 +122,6 @@ static void __init kasan_mmu_init(void)
 	int ret;
 	struct memblock_region *reg;
 
-	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE) ||
-	    IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
-		ret = kasan_init_shadow_page_tables(KASAN_SHADOW_START, KASAN_SHADOW_END);
-
-		if (ret)
-			panic("kasan: kasan_init_shadow_page_tables() failed");
-	}
-
 	for_each_memblock(memory, reg) {
 		phys_addr_t base = reg->base;
 		phys_addr_t top = min(base + reg->size, total_lowmem);
@@ -141,6 +133,15 @@ static void __init kasan_mmu_init(void)
 		if (ret)
 			panic("kasan: kasan_init_region() failed");
 	}
+
+	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE) ||
+	    IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+		ret = kasan_init_shadow_page_tables(KASAN_SHADOW_START, KASAN_SHADOW_END);
+
+		if (ret)
+			panic("kasan: kasan_init_shadow_page_tables() failed");
+	}
+
 }
 
 void __init kasan_init(void)
-- 
2.25.0

