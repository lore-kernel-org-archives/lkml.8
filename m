Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F60C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118D622B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgHEUPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:15:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31507 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgHEQVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:21:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMFqM2bGYz9vD3q;
        Wed,  5 Aug 2020 17:27:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L2uasisRzKAF; Wed,  5 Aug 2020 17:27:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMFqM116rz9vD3n;
        Wed,  5 Aug 2020 17:27:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 44D088B7ED;
        Wed,  5 Aug 2020 17:27:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aH2Oy26jO9oh; Wed,  5 Aug 2020 17:27:29 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FBF08B7EC;
        Wed,  5 Aug 2020 17:27:29 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B76FC65BC2; Wed,  5 Aug 2020 15:27:28 +0000 (UTC)
Message-Id: <07884ed033c31e074747b7eb8eaa329d15db07ec.1596641219.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Fix is_module_segment() when MODULES_VADDR is
 defined
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Aug 2020 15:27:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MODULES_VADDR is defined, is_module_segment() shall check the
address against it instead of checking agains VMALLOC_START.

Fixes: 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules with STRICT_KERNEL_RWX")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index c0162911f6cb..82ae9e06a773 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -191,10 +191,17 @@ static bool is_module_segment(unsigned long addr)
 {
 	if (!IS_ENABLED(CONFIG_MODULES))
 		return false;
+#ifdef MODULES_VADDR
+	if (addr < ALIGN_DOWN(MODULES_VADDR, SZ_256M))
+		return false;
+	if (addr >= ALIGN(MODULES_END, SZ_256M))
+		return false;
+#else
 	if (addr < ALIGN_DOWN(VMALLOC_START, SZ_256M))
 		return false;
 	if (addr >= ALIGN(VMALLOC_END, SZ_256M))
 		return false;
+#endif
 	return true;
 }
 
-- 
2.25.0

