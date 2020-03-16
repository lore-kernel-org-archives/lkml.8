Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88992C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D73A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Fl1TPdNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgCPMh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:37:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7170 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbgCPMgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwl269JGz9v02g;
        Mon, 16 Mar 2020 13:35:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Fl1TPdNU; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id s0ivenQ9e08L; Mon, 16 Mar 2020 13:35:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwl256lqz9v02f;
        Mon, 16 Mar 2020 13:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362158; bh=Ri3yOfdiaLciYHtt4MZxIf0q2mfumVgCna8RRu4NpbQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Fl1TPdNU2qKlpzmtayYTl7ssLJG1eYnyWiyIajKUiURsW4cVTPCzENZSacJcWiWo7
         1dBdEVLXDf811cAM72CC08ZGWXeAMq3kW+q5AUOrSP/Lm5JVPSvuH1ujKzp+l/Z1Om
         rUhSScl1JHh54+DAUVbhkiNCO5dcev8JALFi+QGw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A94928B7D0;
        Mon, 16 Mar 2020 13:36:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tzfIxHZF9h8f; Mon, 16 Mar 2020 13:36:03 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B9FF8B7CB;
        Mon, 16 Mar 2020 13:36:03 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 81C5665595; Mon, 16 Mar 2020 12:36:03 +0000 (UTC)
Message-Id: <e6932fd4860bc3dad05fe406a207b329c6547bf9.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 18/46] powerpc/mm: PTE_ATOMIC_UPDATES is only for 40x
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only 40x still uses PTE_ATOMIC_UPDATES.
40x cannot not select CONFIG_PTE64_BIT.

Drop handling of PTE_ATOMIC_UPDATES:
- In nohash/64
- In nohash/32 for CONFIG_PTE_64BIT

Keep PTE_ATOMIC_UPDATES only for nohash/32 for !CONFIG_PTE_64BIT

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 17 ------------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 28 +-------------------
 2 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b04ba257fddb..523c4c3876c5 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -262,25 +262,8 @@ static inline unsigned long long pte_update(pte_t *p,
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
index 9a33b8bd842d..9c703b140d64 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -211,22 +211,9 @@ static inline unsigned long pte_update(struct mm_struct *mm,
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
+
 	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
@@ -310,21 +297,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
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

