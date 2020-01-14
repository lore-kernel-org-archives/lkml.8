Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11982C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED2C222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fjuY01xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgANPE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:04:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12205 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgANPE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:04:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47xtzX0GdfzB09ZS;
        Tue, 14 Jan 2020 16:04:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=fjuY01xO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id U22XGn8T1L52; Tue, 14 Jan 2020 16:04:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47xtzW6GF5zB09ZR;
        Tue, 14 Jan 2020 16:04:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579014295; bh=c8kuh8eL7dM0BHWgqw3dnxCyNoBITprJqspBRju8OzU=;
        h=From:Subject:To:Cc:Date:From;
        b=fjuY01xOnprqmnaOUbK5KqMpcMr1UY7T6t1CiWjzjKPd2dJsCS5McxDqEbNlgL3uh
         GdWMRDzptaoZLkotT8Xd/S4JZKtXv9aTWYpPVmPyQH88kXmwIArWdGMpiW1igC33lo
         vKvGdkE7PqkLuxmw9VCLpCDzPRqUpE6yYeTF/w80=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61B608B7EB;
        Tue, 14 Jan 2020 16:04:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id n5yqNtn2m_ho; Tue, 14 Jan 2020 16:04:57 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0661F8B7E8;
        Tue, 14 Jan 2020 16:04:57 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A51D9637D5; Tue, 14 Jan 2020 15:04:56 +0000 (UTC)
Message-Id: <9e6aebaaf0702c3cbc199278d920f368c95af18e.1579014273.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: reorder Linux PTE bits to better match Hash PTE
 bits.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Jan 2020 15:04:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder Linux PTE bits to (almost) match Hash PTE bits.

RW Kernel : PP = 00
RO Kernel : PP = 00
RW User   : PP = 01
RO User   : PP = 11

So naturally, we should have
_PAGE_USER = 0x001
_PAGE_RW   = 0x002

Today 0x001 and 0x002 and _PAGE_PRESENT and _PAGE_HASHPTE which
both are software only bits.

Switch _PAGE_USER and _PAGE_PRESET
Switch _PAGE_RW and _PAGE_HASHPTE

This allows to remove a few insns.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/hash.h |  8 ++++----
 arch/powerpc/kernel/head_32.S             |  9 +++------
 arch/powerpc/mm/book3s32/hash_low.S       | 14 ++++++--------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/hash.h b/arch/powerpc/include/asm/book3s/32/hash.h
index 2a0a467d2985..34a7215ae81e 100644
--- a/arch/powerpc/include/asm/book3s/32/hash.h
+++ b/arch/powerpc/include/asm/book3s/32/hash.h
@@ -17,9 +17,9 @@
  * updating the accessed and modified bits in the page table tree.
  */
 
-#define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
-#define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
-#define _PAGE_USER	0x004	/* usermode access allowed */
+#define _PAGE_USER	0x001	/* usermode access allowed */
+#define _PAGE_RW	0x002	/* software: user write access allowed */
+#define _PAGE_PRESENT	0x004	/* software: pte contains a translation */
 #define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
 #define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
@@ -27,7 +27,7 @@
 #define _PAGE_DIRTY	0x080	/* C: page changed */
 #define _PAGE_ACCESSED	0x100	/* R: page referenced */
 #define _PAGE_EXEC	0x200	/* software: exec allowed */
-#define _PAGE_RW	0x400	/* software: user write access allowed */
+#define _PAGE_HASHPTE	0x400	/* hash_page has made an HPTE for this pte */
 #define _PAGE_SPECIAL	0x800	/* software: Special page */
 
 #ifdef CONFIG_PTE_64BIT
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 4a24f8f026c7..df31998abc2a 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -306,7 +306,7 @@ DataAccess:
 #endif
 	bne	1f			/* if not, try to put a PTE */
 	mfspr	r4,SPRN_DAR		/* into the hash table */
-	rlwinm	r3,r10,32-15,21,21	/* DSISR_STORE -> _PAGE_RW */
+	rlwinm	r3,r10,32-24,30,30	/* DSISR_STORE -> _PAGE_RW */
 BEGIN_MMU_FTR_SECTION
 	bl	hash_page
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
@@ -437,7 +437,6 @@ InstructionTLBMiss:
 	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	InstructionAddressInvalid /* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r0,r0,32-2,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1, r1, 0xe06		/* clear out reserved bits */
 	andc	r1, r0, r1		/* PP = user? 1 : 0 */
 BEGIN_FTR_SECTION
@@ -505,9 +504,8 @@ DataLoadTLBMiss:
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwinm	r1,r0,32-9,30,30	/* _PAGE_RW -> PP msb */
-	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
-	rlwimi	r0,r0,32-1,31,31	/* _PAGE_USER -> PP lsb */
+	rlwinm	r1,r0,0,30,30		/* _PAGE_RW -> PP msb */
+	rlwimi	r0,r0,1,30,30		/* _PAGE_USER -> PP msb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
 	andc	r1,r0,r1		/* PP = user? rw? 1: 3: 0 */
 BEGIN_FTR_SECTION
@@ -585,7 +583,6 @@ DataStoreTLBMiss:
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r0,r0,32-2,31,31	/* _PAGE_USER -> PP lsb */
 	li	r1,0xe06		/* clear out reserved bits & PP msb */
 	andc	r1,r0,r1		/* PP = user? 1: 0 */
 BEGIN_FTR_SECTION
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 8bbbd9775c8a..b83ad67c218f 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -35,7 +35,7 @@ mmu_hash_lock:
 /*
  * Load a PTE into the hash table, if possible.
  * The address is in r4, and r3 contains an access flag:
- * _PAGE_RW (0x400) if a write.
+ * _PAGE_RW (0x002) if a write.
  * r9 contains the SRR1 value, from which we use the MSR_PR bit.
  * SPRG_THREAD contains the physical address of the current task's thread.
  *
@@ -69,7 +69,7 @@ _GLOBAL(hash_page)
 	blt+	112f			/* assume user more likely */
 	lis	r5, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r5 ,r5 ,(swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
-	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
+	rlwimi	r3,r9,32-14,31,31	/* MSR_PR -> _PAGE_USER */
 112:
 #ifndef CONFIG_PTE_64BIT
 	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
@@ -94,7 +94,7 @@ _GLOBAL(hash_page)
 #else
 	rlwimi	r8,r4,23,20,28		/* compute pte address */
 #endif
-	rlwinm	r0,r3,32-3,24,24	/* _PAGE_RW access -> _PAGE_DIRTY */
+	rlwinm	r0,r3,6,24,24		/* _PAGE_RW access -> _PAGE_DIRTY */
 	ori	r0,r0,_PAGE_ACCESSED|_PAGE_HASHPTE
 
 	/*
@@ -304,11 +304,9 @@ Hash_msk = (((1 << Hash_bits) - 1) * 64)
 
 _GLOBAL(create_hpte)
 	/* Convert linux-style PTE (r5) to low word of PPC-style PTE (r8) */
-	rlwinm	r8,r5,32-9,30,30	/* _PAGE_RW -> PP msb */
 	rlwinm	r0,r5,32-6,30,30	/* _PAGE_DIRTY -> PP msb */
-	and	r8,r8,r0		/* writable if _RW & _DIRTY */
-	rlwimi	r5,r5,32-1,30,30	/* _PAGE_USER -> PP msb */
-	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
+	and	r8,r5,r0		/* writable if _RW & _DIRTY */
+	rlwimi	r5,r5,1,30,30		/* _PAGE_USER -> PP msb */
 	ori	r8,r8,0xe04		/* clear out reserved bits */
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 1: 3): 0 */
 BEGIN_FTR_SECTION
@@ -560,7 +558,7 @@ _GLOBAL(flush_hash_pages)
 33:	lwarx	r8,0,r5			/* fetch the pte flags word */
 	andi.	r0,r8,_PAGE_HASHPTE
 	beq	8f			/* done if HASHPTE is already clear */
-	rlwinm	r8,r8,0,31,29		/* clear HASHPTE bit */
+	rlwinm	r8,r8,0,~_PAGE_HASHPTE	/* clear HASHPTE bit */
 	stwcx.	r8,0,r5			/* update the pte */
 	bne-	33b
 
-- 
2.13.3

