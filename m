Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09063C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05C6208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgEFQts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:49:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22955 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbgEFQsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMx80Bk2z9v4kG;
        Wed,  6 May 2020 18:48:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b9ALZa32zAYE; Wed,  6 May 2020 18:48:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMx76WdVz9v4kH;
        Wed,  6 May 2020 18:48:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BAF318B7C5;
        Wed,  6 May 2020 18:48:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vORc0usDt-Y3; Wed,  6 May 2020 18:48:45 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 74BB88B777;
        Wed,  6 May 2020 18:48:45 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 4092765911; Wed,  6 May 2020 16:48:45 +0000 (UTC)
Message-Id: <fc290394393bbac8810bee23befc88f76538f0a1.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 39/45] powerpc/8xx: Map IMMR with a huge page
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:45 +0000 (UTC)
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

