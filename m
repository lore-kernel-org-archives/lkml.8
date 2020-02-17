Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B51C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7C20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UJxqMGDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBQJlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:41:39 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:50385 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgBQJli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:41:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48LfBg69m7z9tyTr;
        Mon, 17 Feb 2020 10:41:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UJxqMGDH; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NDVWCe0dW54M; Mon, 17 Feb 2020 10:41:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48LfBg4klRz9tyTq;
        Mon, 17 Feb 2020 10:41:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581932491; bh=pPgFScNnDvMzWiWK3BAW5yxVzX68NYNcZ2y50+wdHoI=;
        h=From:Subject:To:Cc:Date:From;
        b=UJxqMGDH/uJuSWSqvP+dmsTn+CSRSw4rXU6cwmjAicj6aiaDNhc0qImOlDNBJIs0F
         r/8f/2EjG5JClfTKLTxsPJDutnaEReojhKSyGcBMFl/do0QFF5D8Te1Wb2szd/1SZM
         NACXw3z8Pejc+ggq9j1uXagRxEszz5tV0/W6UMQ8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54AF48B7A4;
        Mon, 17 Feb 2020 10:41:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fxe7wlpWMKHM; Mon, 17 Feb 2020 10:41:36 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 370CA8B755;
        Mon, 17 Feb 2020 10:41:36 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E6B70652F5; Mon, 17 Feb 2020 09:41:35 +0000 (UTC)
Message-Id: <03c97f0f6b3790d164822563be80f2fd4713a955.1581932480.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Don't kmap_atomic() in pte_offset_map() on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Feb 2020 09:41:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PPC32, pte_offset_map() does a kmap_atomic() in order to support
page tables allocated in high memory, just like ARM and x86/32.

But since at least 2008 and commit 8054a3428fbe ("powerpc: Remove dead
CONFIG_HIGHPTE"), page tables are never allocated in high memory.

When the page is in low mem, kmap_atomic() just returns the page
address but still disable preemption and pagefault. And it is
not an inlined function, so we suffer function call for no reason.

Make pte_offset_map() the same as pte_offset_kernel() and make
pte_unmap() void, in the same way as PPC64 which doesn't have HIGHMEM.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 6 ++----
 arch/powerpc/include/asm/nohash/32/pgtable.h | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 8bf8cdd92ea5..e490c1012c27 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -367,10 +367,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, addr)	\
 	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
-#define pte_offset_map(dir, addr)		\
-	((pte_t *)(kmap_atomic(pmd_page(*(dir))) + \
-		   (pmd_page_vaddr(*(dir)) & ~PAGE_MASK)) + pte_index(addr))
-#define pte_unmap(pte)		kunmap_atomic(pte)
+#define pte_offset_map(dir, addr)	pte_offset_kernel((dir), (addr))
+static inline void pte_unmap(pte_t *pte) { }
 
 /*
  * Encode and decode a swap entry.
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 5ad7e439dcf4..fcd22737eb5b 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -373,10 +373,8 @@ static inline int pte_young(pte_t pte)
 #define pte_offset_kernel(dir, addr)	\
 	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
 				  pte_index(addr))
-#define pte_offset_map(dir, addr)		\
-	((pte_t *)(kmap_atomic(pmd_page(*(dir))) + \
-		   (pmd_page_vaddr(*(dir)) & ~PAGE_MASK)) + pte_index(addr))
-#define pte_unmap(pte)		kunmap_atomic(pte)
+#define pte_offset_map(dir, addr)	pte_offset_kernel((dir), (addr))
+static inline void pte_unmap(pte_t *pte) { }
 
 /*
  * Encode and decode a swap entry.
-- 
2.25.0

