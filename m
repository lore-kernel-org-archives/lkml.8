Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E7C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F53020722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgEKLZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:25:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5263 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgEKLZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJWw5vFBz9ty3k;
        Mon, 11 May 2020 13:25:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id o3X9Engyv6SV; Mon, 11 May 2020 13:25:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJWw5BVVz9ty3g;
        Mon, 11 May 2020 13:25:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C3BA8B7AE;
        Mon, 11 May 2020 13:25:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LvE9-42OSqfz; Mon, 11 May 2020 13:25:39 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 385ED8B7AD;
        Mon, 11 May 2020 13:25:39 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1F4A365A09; Mon, 11 May 2020 11:25:39 +0000 (UTC)
Message-Id: <1809d812016386a5a5f493f92118659dcda70646.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 13/45] powerpc/ptdump: Handle hugepd at PGD level
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:25:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8xx is about to map kernel linear space and IMMR using huge
pages.

In order to display those pages properly, ptdump needs to handle
hugepd tables at PGD level.

For the time being do it only at PGD level. Further patches may
add handling of hugepd tables at lower level for other platforms
when needed in the future.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: notepage() now takes page size instead of page shift
---
 arch/powerpc/mm/ptdump/ptdump.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 98d82dcf6f0b..5fc880e30175 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -23,6 +23,7 @@
 #include <linux/const.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
+#include <asm/hugetlb.h>
 
 #include <mm/mmu_decl.h>
 
@@ -269,6 +270,26 @@ static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
 	}
 }
 
+static void walk_hugepd(struct pg_state *st, hugepd_t *phpd, unsigned long start,
+			int pdshift, int level)
+{
+#ifdef CONFIG_ARCH_HAS_HUGEPD
+	unsigned int i;
+	int shift = hugepd_shift(*phpd);
+	int ptrs_per_hpd = pdshift - shift > 0 ? 1 << (pdshift - shift) : 1;
+
+	if (start & ((1 << shift) - 1))
+		return;
+
+	for (i = 0; i < ptrs_per_hpd; i++) {
+		unsigned long addr = start + (i << shift);
+		pte_t *pte = hugepte_offset(*phpd, addr, pdshift);
+
+		note_page(st, addr, level + 1, pte_val(*pte), 1 << shift);
+	}
+#endif
+}
+
 static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 {
 	pmd_t *pmd = pmd_offset(pud, 0);
@@ -312,11 +333,13 @@ static void walk_pagetables(struct pg_state *st)
 	 * the hash pagetable.
 	 */
 	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
-		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
+		if (pgd_none(*pgd) || pgd_is_leaf(*pgd))
+			note_page(st, addr, 1, pgd_val(*pgd), PGDIR_SIZE);
+		else if (is_hugepd(__hugepd(pgd_val(*pgd))))
+			walk_hugepd(st, (hugepd_t *)pgd, addr, PGDIR_SHIFT, 1);
+		else
 			/* pgd exists */
 			walk_pud(st, pgd, addr);
-		else
-			note_page(st, addr, 1, pgd_val(*pgd), PGDIR_SIZE);
 	}
 }
 
-- 
2.25.0

