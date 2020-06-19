Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9842158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394284AbgFSQJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:09:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51985 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391511AbgFSPG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:06:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49pMbM4Jstz9v09q;
        Fri, 19 Jun 2020 17:06:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Z9Ecxi_udfqH; Fri, 19 Jun 2020 17:06:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49pMbM3bC8z9v09j;
        Fri, 19 Jun 2020 17:06:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BA408B879;
        Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 64TxG8F7f-0Q; Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CEE08B868;
        Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 48FBF65B16; Fri, 19 Jun 2020 15:06:57 +0000 (UTC)
Message-Id: <c81ed22c5716008463ee14869c25f49c3ae53e25.1592578278.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1592578278.git.christophe.leroy@csgroup.eu>
References: <cover.1592578278.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 6/8] powerpc/32s: Only leave NX unset on segments used for
 modules
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Jun 2020 15:06:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of leaving NX unset on all segments above the start
of vmalloc space, only leave NX unset on segments used for
modules.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 03b6ba54460e..c0162911f6cb 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -187,6 +187,17 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	return __mmu_mapin_ram(border, top);
 }
 
+static bool is_module_segment(unsigned long addr)
+{
+	if (!IS_ENABLED(CONFIG_MODULES))
+		return false;
+	if (addr < ALIGN_DOWN(VMALLOC_START, SZ_256M))
+		return false;
+	if (addr >= ALIGN(VMALLOC_END, SZ_256M))
+		return false;
+	return true;
+}
+
 void mmu_mark_initmem_nx(void)
 {
 	int nb = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
@@ -223,9 +234,9 @@ void mmu_mark_initmem_nx(void)
 
 	for (i = TASK_SIZE >> 28; i < 16; i++) {
 		/* Do not set NX on VM space for modules */
-		if (IS_ENABLED(CONFIG_MODULES) &&
-		    (VMALLOC_START & 0xf0000000) == i << 28)
-			break;
+		if (is_module_segment(i << 28))
+			continue;
+
 		mtsrin(mfsrin(i << 28) | 0x10000000, i << 28);
 	}
 }
-- 
2.25.0

