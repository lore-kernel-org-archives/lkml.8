Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91F020675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgHMQgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:36:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52769 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgHMQgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:36:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BSBzT533Hz9vCyM;
        Thu, 13 Aug 2020 18:36:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XNL6jZHtvOut; Thu, 13 Aug 2020 18:36:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BSBzT47LTz9vCyK;
        Thu, 13 Aug 2020 18:36:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3354E8B7A8;
        Thu, 13 Aug 2020 18:36:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id a-VgD8RZ1QwY; Thu, 13 Aug 2020 18:36:39 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E6D608B7A7;
        Thu, 13 Aug 2020 18:36:38 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C5B5D65C8E; Thu, 13 Aug 2020 16:36:38 +0000 (UTC)
Message-Id: <03c497a8e048ec030a8044c6bbcb6f2146e4c891.1597336549.git.christophe.leroy@csgroup.eu>
In-Reply-To: <11a330af231af22874c006302a945388846f8112.1597336548.git.christophe.leroy@csgroup.eu>
References: <11a330af231af22874c006302a945388846f8112.1597336548.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 7/9] powerpc: Tidy up a bit after removal of PowerPC 601.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Aug 2020 16:36:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of the 601 left some standalone blocks from
former if/else. Drop the { } and re-indent.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/btext.c    | 11 +++------
 arch/powerpc/mm/book3s32/mmu.c | 45 +++++++++++++++-------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index b609fb39dba8..c22a8e0dbc93 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -95,13 +95,10 @@ void __init btext_prepare_BAT(void)
 		boot_text_mapped = 0;
 		return;
 	}
-	{
-		/* 603, 604, G3, G4, ... */
-		lowbits = addr & ~0xFF000000UL;
-		addr &= 0xFF000000UL;
-		disp_BAT[0] = vaddr | (BL_16M<<2) | 2;
-		disp_BAT[1] = addr | (_PAGE_NO_CACHE | _PAGE_GUARDED | BPP_RW);	
-	}
+	lowbits = addr & ~0xFF000000UL;
+	addr &= 0xFF000000UL;
+	disp_BAT[0] = vaddr | (BL_16M<<2) | 2;
+	disp_BAT[1] = addr | (_PAGE_NO_CACHE | _PAGE_GUARDED | BPP_RW);
 	logicalDisplayBase = (void *) (vaddr + lowbits);
 }
 #endif
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index f42b718ea971..16546ca4074e 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -73,16 +73,13 @@ unsigned long p_block_mapped(phys_addr_t pa)
 static int find_free_bat(void)
 {
 	int b;
+	int n = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
 
-	{
-		int n = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
+	for (b = 0; b < n; b++) {
+		struct ppc_bat *bat = BATS[b];
 
-		for (b = 0; b < n; b++) {
-			struct ppc_bat *bat = BATS[b];
-
-			if (!(bat[1].batu & 3))
-				return b;
-		}
+		if (!(bat[1].batu & 3))
+			return b;
 	}
 	return -1;
 }
@@ -273,24 +270,22 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		flags &= ~_PAGE_COHERENT;
 
 	bl = (size >> 17) - 1;
-	{
-		/* Do DBAT first */
-		wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
-				   | _PAGE_COHERENT | _PAGE_GUARDED);
-		wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
-		bat[1].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
-		bat[1].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
-		if (flags & _PAGE_USER)
-			bat[1].batu |= 1; 	/* Vp = 1 */
-		if (flags & _PAGE_GUARDED) {
-			/* G bit must be zero in IBATs */
-			flags &= ~_PAGE_EXEC;
-		}
-		if (flags & _PAGE_EXEC)
-			bat[0] = bat[1];
-		else
-			bat[0].batu = bat[0].batl = 0;
+	/* Do DBAT first */
+	wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
+			   | _PAGE_COHERENT | _PAGE_GUARDED);
+	wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
+	bat[1].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
+	bat[1].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
+	if (flags & _PAGE_USER)
+		bat[1].batu |= 1; 	/* Vp = 1 */
+	if (flags & _PAGE_GUARDED) {
+		/* G bit must be zero in IBATs */
+		flags &= ~_PAGE_EXEC;
 	}
+	if (flags & _PAGE_EXEC)
+		bat[0] = bat[1];
+	else
+		bat[0].batu = bat[0].batl = 0;
 
 	bat_addrs[index].start = virt;
 	bat_addrs[index].limit = virt + ((bl + 1) << 17) - 1;
-- 
2.25.0

