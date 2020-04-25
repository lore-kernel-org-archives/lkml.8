Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF65C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE172071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WjhcTHul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDYIni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:43:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56811 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYInd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:43:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 498PhL6QfSz9txnZ;
        Sat, 25 Apr 2020 10:43:30 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WjhcTHul; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9D_FxaR5Mpci; Sat, 25 Apr 2020 10:43:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 498PhL53Gwz9txng;
        Sat, 25 Apr 2020 10:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587804210; bh=A8l6zV1WqeUvYxhf98emJX8J5sChmaXS6oSMuqzxy9w=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=WjhcTHulGaiQ/ZK8uMKEeM/T1SIb7rUSkakXB0Xf7jaJu9w8h9NWHaaZsmfYXaWrQ
         1p8uZT1i3B/2zB4odMKRDmnM8PKCUtQoFaV+syy5X6MLziq/RQ7Ra5e/Fj48SRmUp5
         yvBkgqA5TH1/Te6SZgbAVNynWuFcwyY1R6qvhoDg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D8FCC8B752;
        Sat, 25 Apr 2020 10:43:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0ATDHq8L_75T; Sat, 25 Apr 2020 10:43:31 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 957F08B776;
        Sat, 25 Apr 2020 10:43:31 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6846965875; Sat, 25 Apr 2020 08:43:31 +0000 (UTC)
Message-Id: <1179826f445a05b8a176d8be1e6ddb18186df0c4.1587804057.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1587804057.git.christophe.leroy@c-s.fr>
References: <cover.1587804057.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 03/13] powerpc/pgtable: Drop PTE_ATOMIC_UPDATES
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 25 Apr 2020 08:43:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

40x was the last user of PTE_ATOMIC_UPDATES.

Drop everything related to PTE_ATOMIC_UPDATES.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 32 --------------------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 27 -----------------
 2 files changed, 59 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b04ba257fddb..fdbfcc44fea8 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -227,20 +227,6 @@ static inline unsigned long pte_update(pte_t *p,
 				       unsigned long clr,
 				       unsigned long set)
 {
-#ifdef PTE_ATOMIC_UPDATES
-	unsigned long old, tmp;
-
-	__asm__ __volatile__("\
-1:	lwarx	%0,0,%3\n\
-	andc	%1,%0,%4\n\
-	or	%1,%1,%5\n"
-	PPC405_ERR77(0,%3)
-"	stwcx.	%1,0,%3\n\
-	bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*p)
-	: "r" (p), "r" (clr), "r" (set), "m" (*p)
-	: "cc" );
-#else /* PTE_ATOMIC_UPDATES */
 	unsigned long old = pte_val(*p);
 	unsigned long new = (old & ~clr) | set;
 
@@ -249,7 +235,6 @@ static inline unsigned long pte_update(pte_t *p,
 #else
 	*p = __pte(new);
 #endif
-#endif /* !PTE_ATOMIC_UPDATES */
 
 #ifdef CONFIG_44x
 	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
@@ -262,25 +247,8 @@ static inline unsigned long long pte_update(pte_t *p,
 					    unsigned long clr,
 					    unsigned long set)
 {
-#ifdef PTE_ATOMIC_UPDATES
-	unsigned long long old;
-	unsigned long tmp;
-
-	__asm__ __volatile__("\
-1:	lwarx	%L0,0,%4\n\
-	lwzx	%0,0,%3\n\
-	andc	%1,%L0,%5\n\
-	or	%1,%1,%6\n"
-	PPC405_ERR77(0,%3)
-"	stwcx.	%1,0,%4\n\
-	bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*p)
-	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
-	: "cc" );
-#else /* PTE_ATOMIC_UPDATES */
 	unsigned long long old = pte_val(*p);
 	*p = __pte((old & ~(unsigned long long)clr) | set);
-#endif /* !PTE_ATOMIC_UPDATES */
 
 #ifdef CONFIG_44x
 	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 9a33b8bd842d..3cacace9bfa0 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -211,22 +211,8 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 				       unsigned long set,
 				       int huge)
 {
-#ifdef PTE_ATOMIC_UPDATES
-	unsigned long old, tmp;
-
-	__asm__ __volatile__(
-	"1:	ldarx	%0,0,%3		# pte_update\n\
-	andc	%1,%0,%4 \n\
-	or	%1,%1,%6\n\
-	stdcx.	%1,0,%3 \n\
-	bne-	1b"
-	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	: "r" (ptep), "r" (clr), "m" (*ptep), "r" (set)
-	: "cc" );
-#else
 	unsigned long old = pte_val(*ptep);
 	*ptep = __pte((old & ~clr) | set);
-#endif
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
@@ -310,21 +296,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
-#ifdef PTE_ATOMIC_UPDATES
-	unsigned long old, tmp;
-
-	__asm__ __volatile__(
-	"1:	ldarx	%0,0,%4\n\
-		or	%0,%3,%0\n\
-		stdcx.	%0,0,%4\n\
-		bne-	1b"
-	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	:"r" (bits), "r" (ptep), "m" (*ptep)
-	:"cc");
-#else
 	unsigned long old = pte_val(*ptep);
 	*ptep = __pte(old | bits);
-#endif
 
 	flush_tlb_page(vma, address);
 }
-- 
2.25.0

