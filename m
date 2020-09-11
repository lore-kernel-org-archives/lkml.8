Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A8FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FD420719
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKFFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:05:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32062 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgIKFFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:05:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BnkGq5Rzbz9tynY;
        Fri, 11 Sep 2020 07:05:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dI0xBi-CVjY0; Fri, 11 Sep 2020 07:05:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BnkGq2Bbrz9tynX;
        Fri, 11 Sep 2020 07:05:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DBFAF8B832;
        Fri, 11 Sep 2020 07:05:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZU5cwRNYUVST; Fri, 11 Sep 2020 07:05:39 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 413958B75E;
        Fri, 11 Sep 2020 07:05:39 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0D0E265728; Fri, 11 Sep 2020 05:05:38 +0000 (UTC)
Message-Id: <8ae4554357da4882612644a74387ae05525b2aaa.1599800716.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/kasan: Fix CONFIG_KASAN_VMALLOC for 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 11 Sep 2020 05:05:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the commit identified below, pages tables allocation was
performed after the allocation of final shadow area for linear memory.
But that commit switched the order, leading to page tables being
already allocated at the time 8xx kasan_init_shadow_8M() is called.
Due to this, kasan_init_shadow_8M() doesn't map the needed
shadow entries because there are already page tables.

kasan_init_shadow_8M() installs huge PMD entries instead of page
tables. We could at that time free the page tables, but there is no
point in creating page tables that get freed before being used.

Only book3s/32 hash needs early allocation of page tables. For other
variants, we can keep the initial order and create remaining page
tables after the allocation of final shadow memory for linear mem.

Move back the allocation of shadow page tables for
CONFIG_KASAN_VMALLOC into kasan_init() after the loop which creates
final shadow memory for linear mem.

Fixes: 41ea93cf7ba4 ("powerpc/kasan: Fix shadow pages allocation failure")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index fb294046e00e..929716ea21e9 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -127,8 +127,7 @@ void __init kasan_mmu_init(void)
 {
 	int ret;
 
-	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE) ||
-	    IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
 		ret = kasan_init_shadow_page_tables(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 		if (ret)
@@ -139,11 +138,11 @@ void __init kasan_mmu_init(void)
 void __init kasan_init(void)
 {
 	struct memblock_region *reg;
+	int ret;
 
 	for_each_memblock(memory, reg) {
 		phys_addr_t base = reg->base;
 		phys_addr_t top = min(base + reg->size, total_lowmem);
-		int ret;
 
 		if (base >= top)
 			continue;
@@ -153,6 +152,13 @@ void __init kasan_init(void)
 			panic("kasan: kasan_init_region() failed");
 	}
 
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+		ret = kasan_init_shadow_page_tables(KASAN_SHADOW_START, KASAN_SHADOW_END);
+
+		if (ret)
+			panic("kasan: kasan_init_shadow_page_tables() failed");
+	}
+
 	kasan_remap_early_shadow_ro();
 
 	clear_page(kasan_early_shadow_page);
-- 
2.25.0

