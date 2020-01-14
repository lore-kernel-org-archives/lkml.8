Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF07EC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EF12465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qd0qrayg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgANRyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:54:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32624 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgANRyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:54:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47xykf3hsjz9txh0;
        Tue, 14 Jan 2020 18:54:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qd0qrayg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GrcxG9YlSurd; Tue, 14 Jan 2020 18:54:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47xykf2YX9z9txgv;
        Tue, 14 Jan 2020 18:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579024442; bh=Yr+rOwjm12MPfnMrRm677aZjNlYzK/jKvcaQ0UIMbBU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qd0qraygO7Uzlqxdi6TBN3BTtA9YqypOdVs/19BhysOWnlAKXjxfUe0eTHxN9BWmE
         sMNXox3q7VwR2hQGM3lnE/kcFf4wwumncPweZYdNZw3RyIx5/0v5y5R24DrSBcgePI
         It8QiEeY87b4SEJeggn/ZXsgdvDnRHfg7iHcAQ64=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 153758B7EB;
        Tue, 14 Jan 2020 18:54:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EWujLzpkxmUv; Tue, 14 Jan 2020 18:54:04 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D32788B7E8;
        Tue, 14 Jan 2020 18:54:03 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AC0A36381C; Tue, 14 Jan 2020 17:54:03 +0000 (UTC)
Message-Id: <84b27bf08b41c8343efd88e10f2eccd8e9f85593.1579024426.git.christophe.leroy@c-s.fr>
In-Reply-To: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
References: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/5] powerpc/32: Simplify KASAN init
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Jan 2020 17:54:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kasan_init_region() is not used anymore for modules,
KASAN init is done while slab_is_available() is false.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index b782d92622b4..c4bf9ed04f88 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -34,7 +34,6 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
 {
 	pmd_t *pmd;
 	unsigned long k_cur, k_next;
-	pgprot_t prot = slab_is_available() ? kasan_prot_ro() : PAGE_KERNEL;
 
 	pmd = pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_start);
 
@@ -45,14 +44,11 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
-		if (slab_is_available())
-			new = pte_alloc_one_kernel(&init_mm);
-		else
-			new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
+		new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
 
 		if (!new)
 			return -ENOMEM;
-		kasan_populate_pte(new, prot);
+		kasan_populate_pte(new, PAGE_KERNEL);
 
 		smp_wmb(); /* See comment in __pte_alloc */
 
@@ -63,39 +59,27 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
 			new = NULL;
 		}
 		spin_unlock(&init_mm.page_table_lock);
-
-		if (new && slab_is_available())
-			pte_free_kernel(&init_mm, new);
 	}
 	return 0;
 }
 
-static void __init *kasan_get_one_page(void)
-{
-	if (slab_is_available())
-		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-
-	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-}
-
 static int __init kasan_init_region(void *start, size_t size)
 {
 	unsigned long k_start = (unsigned long)kasan_mem_to_shadow(start);
 	unsigned long k_end = (unsigned long)kasan_mem_to_shadow(start + size);
 	unsigned long k_cur;
 	int ret;
-	void *block = NULL;
+	void *block;
 
 	ret = kasan_init_shadow_page_tables(k_start, k_end);
 	if (ret)
 		return ret;
 
-	if (!slab_is_available())
-		block = memblock_alloc(k_end - k_start, PAGE_SIZE);
+	block = memblock_alloc(k_end - k_start, PAGE_SIZE);
 
 	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
 		pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
-		void *va = block ? block + k_cur - k_start : kasan_get_one_page();
+		void *va = block + k_cur - k_start;
 		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
 
 		if (!va)
-- 
2.13.3

