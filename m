Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5516208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgEFQu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:50:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34176 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbgEFQsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMwp4Ykyz9v4kF;
        Wed,  6 May 2020 18:48:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QpmbdnNseb6k; Wed,  6 May 2020 18:48:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMwp3RVZz9v4kD;
        Wed,  6 May 2020 18:48:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BD8D8B7C6;
        Wed,  6 May 2020 18:48:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gii5fd7UUS8T; Wed,  6 May 2020 18:48:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D02888B7C5;
        Wed,  6 May 2020 18:48:27 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 9CCAE65911; Wed,  6 May 2020 16:48:27 +0000 (UTC)
Message-Id: <4b51f0bfcc27a0ece0914cb2486c97ea7ae754f0.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 22/45] powerpc/mm: Create a dedicated pte_update() for 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_update() is a bit special for the 8xx. At the time
being, that's an #ifdef inside the nohash/32 pte_update().

As we are going to make it even more special in the coming
patches, create a dedicated version for pte_update() for 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 29 +++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 75880eb1cb91..272963a05ab2 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -221,7 +221,31 @@ static inline void pmd_clear(pmd_t *pmdp)
  * that an executable user mapping was modified, which is needed
  * to properly flush the virtually tagged instruction cache of
  * those implementations.
+ *
+ * On the 8xx, the page tables are a bit special. For 16k pages, we have
+ * 4 identical entries. For other page sizes, we have a single entry in the
+ * table.
  */
+#ifdef CONFIG_PPC_8xx
+static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
+				     unsigned long clr, unsigned long set, int huge)
+{
+	pte_basic_t *entry = &p->pte;
+	pte_basic_t old = pte_val(*p);
+	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
+	int num, i;
+
+	if (!huge)
+		num = PAGE_SIZE / SZ_4K;
+	else
+		num = 1;
+
+	for (i = 0; i < num; i++, entry++)
+		*entry = new;
+
+	return old;
+}
+#else
 static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
 				     unsigned long clr, unsigned long set, int huge)
 {
@@ -242,11 +266,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 	pte_basic_t old = pte_val(*p);
 	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
 
-#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
-	p->pte = p->pte1 = p->pte2 = p->pte3 = new;
-#else
 	*p = __pte(new);
-#endif
 #endif /* !PTE_ATOMIC_UPDATES */
 
 #ifdef CONFIG_44x
@@ -255,6 +275,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 #endif
 	return old;
 }
+#endif
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
-- 
2.25.0

