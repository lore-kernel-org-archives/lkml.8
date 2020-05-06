Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5334C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB905208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgEFQui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:50:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56659 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbgEFQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMwl30w6z9v4kJ;
        Wed,  6 May 2020 18:48:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RYSiBUilMn30; Wed,  6 May 2020 18:48:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMwl1CbRz9v4kF;
        Wed,  6 May 2020 18:48:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 012C38B7C5;
        Wed,  6 May 2020 18:48:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id r0rc0Ei-aZke; Wed,  6 May 2020 18:48:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8D5B8B7C3;
        Wed,  6 May 2020 18:48:24 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 87E6965911; Wed,  6 May 2020 16:48:24 +0000 (UTC)
Message-Id: <43d54becd07cdaca253858c9446bc51643846989.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 19/45] powerpc/mm: Refactor pte_update() on book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PTE_64BIT is set, pte_update() operates on
'unsigned long long'
When CONFIG_PTE_64BIT is not set, pte_update() operates on
'unsigned long'

In asm/page.h, we have pte_basic_t which is 'unsigned long long'
when CONFIG_PTE_64BIT is set and 'unsigned long' otherwise.

Refactor pte_update() using pte_basic_t.

While we are at it, drop the comment on 44x which is not applicable
to book3s version of pte_update().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 58 +++++++-------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7549393c4c43..d1108d25e2e5 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -253,53 +253,35 @@ extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
  * and the PTE may be either 32 or 64 bit wide. In the later case,
  * when using atomic updates, only the low part of the PTE is
  * accessed atomically.
- *
- * In addition, on 44x, we also maintain a global flag indicating
- * that an executable user mapping was modified, which is needed
- * to properly flush the virtually tagged instruction cache of
- * those implementations.
  */
-#ifndef CONFIG_PTE_64BIT
-static inline unsigned long pte_update(pte_t *p,
-				       unsigned long clr,
-				       unsigned long set)
+static inline pte_basic_t pte_update(pte_t *p, unsigned long clr, unsigned long set)
 {
-	unsigned long old, tmp;
-
-	__asm__ __volatile__("\
-1:	lwarx	%0,0,%3\n\
-	andc	%1,%0,%4\n\
-	or	%1,%1,%5\n"
-"	stwcx.	%1,0,%3\n\
-	bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*p)
-	: "r" (p), "r" (clr), "r" (set), "m" (*p)
-	: "cc" );
-
-	return old;
-}
-#else /* CONFIG_PTE_64BIT */
-static inline unsigned long long pte_update(pte_t *p,
-					    unsigned long clr,
-					    unsigned long set)
-{
-	unsigned long long old;
+	pte_basic_t old;
 	unsigned long tmp;
 
-	__asm__ __volatile__("\
-1:	lwarx	%L0,0,%4\n\
-	lwzx	%0,0,%3\n\
-	andc	%1,%L0,%5\n\
-	or	%1,%1,%6\n"
-"	stwcx.	%1,0,%4\n\
-	bne-	1b"
+	__asm__ __volatile__(
+#ifndef CONFIG_PTE_64BIT
+"1:	lwarx	%0, 0, %3\n"
+"	andc	%1, %0, %4\n"
+#else
+"1:	lwarx	%L0, 0, %3\n"
+"	lwz	%0, -4(%3)\n"
+"	andc	%1, %L0, %4\n"
+#endif
+"	or	%1, %1, %5\n"
+"	stwcx.	%1, 0, %3\n"
+"	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
-	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
+#ifndef CONFIG_PTE_64BIT
+	: "r" (p),
+#else
+	: "b" ((unsigned long)(p) + 4),
+#endif
+	  "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
 
 	return old;
 }
-#endif /* CONFIG_PTE_64BIT */
 
 /*
  * 2.6 calls this without flushing the TLB entry; this is wrong
-- 
2.25.0

