Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF3C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD14620722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgEKL0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:26:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39938 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbgEKL0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJXR6Knmz9ty3l;
        Mon, 11 May 2020 13:25:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id s7j_99tBxDhg; Mon, 11 May 2020 13:25:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXR5bptz9ty3g;
        Mon, 11 May 2020 13:25:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 780D78B7AE;
        Mon, 11 May 2020 13:26:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XM4qTcqbNDGm; Mon, 11 May 2020 13:26:06 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4959E8B7AD;
        Mon, 11 May 2020 13:26:06 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2B7EF65A09; Mon, 11 May 2020 11:26:06 +0000 (UTC)
Message-Id: <5b965960e22434ae2f72418d87a924dcdea26b39.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 39/45] powerpc/8xx: Map IMMR with a huge page
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:26:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map the IMMR area with a single 512k huge page.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/8xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 570ab2114a73..fb31a0c1c2a4 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -117,17 +117,13 @@ static bool immr_is_mapped __initdata;
 
 void __init mmu_mapin_immr(void)
 {
-	unsigned long p = PHYS_IMMR_BASE;
-	unsigned long v = VIRT_IMMR_BASE;
-	int offset;
-
 	if (immr_is_mapped)
 		return;
 
 	immr_is_mapped = true;
 
-	for (offset = 0; offset < IMMR_SIZE; offset += PAGE_SIZE)
-		map_kernel_page(v + offset, p + offset, PAGE_KERNEL_NCG);
+	__early_map_kernel_hugepage(VIRT_IMMR_BASE, PHYS_IMMR_BASE,
+				    PAGE_KERNEL_NCG, MMU_PAGE_512K, true);
 }
 
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
-- 
2.25.0

