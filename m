Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CD6C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6DA20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="s0VYeDJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgCFPKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:10:31 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6066 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbgCFPKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:10:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Yrdt6rQqz9tyYm;
        Fri,  6 Mar 2020 16:10:26 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=s0VYeDJe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0niPkSTPuNiT; Fri,  6 Mar 2020 16:10:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Yrdt5nKwz9tyYk;
        Fri,  6 Mar 2020 16:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583507426; bh=aDK1e7FYy59QCUEdL2K+aoBvtVqBevoWFwewV5saeMs=;
        h=From:Subject:To:Cc:Date:From;
        b=s0VYeDJeOHwaexT6bebCWLb04Te4emsvZiMBqIiE25Ztbs3EDtWb5FBd1SA8U+fZY
         65481+x30ZM+kLkXYUe1gHQ7/iGyz7IzxEjDqpx19MGcdw69r5a/cHHaMaukogVDSG
         q70YZfQ+6liFw4edTaxu9Rnp3u5QGjtynxA+TUeA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 47CA38B895;
        Fri,  6 Mar 2020 16:10:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hnZq2hZX3ae0; Fri,  6 Mar 2020 16:10:28 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2835B8B88B;
        Fri,  6 Mar 2020 16:10:28 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1568C65470; Fri,  6 Mar 2020 15:10:28 +0000 (UTC)
Message-Id: <18c283df507b183474cdeae042ef69e7011a5e24.1583507397.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/kasan: Fix shadow memory protection with
 CONFIG_KASAN_VMALLOC
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  6 Mar 2020 15:10:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_KASAN_VMALLOC, new page tables are created at the time
shadow memory for vmalloc area in unmapped. If some parts of the
page table still has entries to the zero page shadow memory, the
entries are wrongly marked RW.

With CONFIG_KASAN_VMALLOC, almost the entire kernel address space
is managed by KASAN. To make it simple, just create KASAN page tables
for the entire kernel space at kasan_init(). That doesn't use much
more space, and that's anyway already done for hash platforms.

Fixes: 3d4247fcc938 ("powerpc/32: Add support of KASAN_VMALLOC")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: Allocate all tables at init instead of doing it when
unmapping vmalloc space KASAN pages.
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 1a29cf469903..c9174d645652 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -120,12 +120,6 @@ static void __init kasan_unmap_early_shadow_vmalloc(void)
 	unsigned long k_cur;
 	phys_addr_t pa = __pa(kasan_early_shadow_page);
 
-	if (!early_mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
-		int ret = kasan_init_shadow_page_tables(k_start, k_end);
-
-		if (ret)
-			panic("kasan: kasan_init_shadow_page_tables() failed");
-	}
 	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
 		pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
 		pte_t *ptep = pte_offset_kernel(pmd, k_cur);
@@ -143,7 +137,7 @@ void __init kasan_mmu_init(void)
 	int ret;
 	struct memblock_region *reg;
 
-	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE) || IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
 		ret = kasan_init_shadow_page_tables(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 		if (ret)
-- 
2.25.0

