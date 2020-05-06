Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60170C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375DA20A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgEFQuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:50:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2642 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbgEFQsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMwh3SYrz9v4kD;
        Wed,  6 May 2020 18:48:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 298RJ25tnwrx; Wed,  6 May 2020 18:48:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMwh2Fd7z9v4kF;
        Wed,  6 May 2020 18:48:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 275638B7C5;
        Wed,  6 May 2020 18:48:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Wdcjihdw97il; Wed,  6 May 2020 18:48:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A185E8B7C3;
        Wed,  6 May 2020 18:48:21 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 70E9665911; Wed,  6 May 2020 16:48:21 +0000 (UTC)
Message-Id: <3c4fdf4049ccad8f714866324ca0a39f6fefd9d7.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 16/45] powerpc/mm: Fix conditions to perform MMU specific
 management by blocks on PPC32.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting init mem to NX shall depend on sinittext being mapped by
block, not on stext being mapped by block.

Setting text and rodata to RO shall depend on stext being mapped by
block, not on sinittext being mapped by block.

Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/pgtable_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 9934659cb871..bd0cb6e3573e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -185,7 +185,7 @@ void mark_initmem_nx(void)
 	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
 				 PFN_DOWN((unsigned long)_sinittext);
 
-	if (v_block_mapped((unsigned long)_stext + 1))
+	if (v_block_mapped((unsigned long)_sinittext))
 		mmu_mark_initmem_nx();
 	else
 		change_page_attr(page, numpages, PAGE_KERNEL);
@@ -197,7 +197,7 @@ void mark_rodata_ro(void)
 	struct page *page;
 	unsigned long numpages;
 
-	if (v_block_mapped((unsigned long)_sinittext)) {
+	if (v_block_mapped((unsigned long)_stext + 1)) {
 		mmu_mark_rodata_ro();
 		ptdump_check_wx();
 		return;
-- 
2.25.0

