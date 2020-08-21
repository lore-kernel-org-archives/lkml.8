Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2027FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045D220658
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHUHP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:15:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9122 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgHUHP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:15:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BXt8F5Xvcz9tym5;
        Fri, 21 Aug 2020 09:15:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id O0PyNLgBqKj0; Fri, 21 Aug 2020 09:15:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BXt8F4c1Vz9tym4;
        Fri, 21 Aug 2020 09:15:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A286A8B8AD;
        Fri, 21 Aug 2020 09:15:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xvEEdfAwWWmE; Fri, 21 Aug 2020 09:15:26 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C6518B8A2;
        Fri, 21 Aug 2020 09:15:26 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0403765CFE; Fri, 21 Aug 2020 07:15:25 +0000 (UTC)
Message-Id: <09fc73fe9c7423c6b4cf93f93df9bb0ed8eefab5.1597994047.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Fix module loading failure when VMALLOC_END is
 over 0xf0000000
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, schwab@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 21 Aug 2020 07:15:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In is_module_segment(), when VMALLOC_END is over 0xf0000000,
ALIGN(VMALLOC_END, SZ_256M) has value 0.

In that case, addr >= ALIGN(VMALLOC_END, SZ_256M) is always
true then is_module_segment() always returns false.

Use (ALIGN(VMALLOC_END, SZ_256M) - 1) which will have
value 0xffffffff and will be suitable for the comparison.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: c49643319715 ("powerpc/32s: Only leave NX unset on segments used for modules")
---
 arch/powerpc/mm/book3s32/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 82ae9e06a773..d426eaf76bb0 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -194,12 +194,12 @@ static bool is_module_segment(unsigned long addr)
 #ifdef MODULES_VADDR
 	if (addr < ALIGN_DOWN(MODULES_VADDR, SZ_256M))
 		return false;
-	if (addr >= ALIGN(MODULES_END, SZ_256M))
+	if (addr > ALIGN(MODULES_END, SZ_256M) - 1)
 		return false;
 #else
 	if (addr < ALIGN_DOWN(VMALLOC_START, SZ_256M))
 		return false;
-	if (addr >= ALIGN(VMALLOC_END, SZ_256M))
+	if (addr > ALIGN(VMALLOC_END, SZ_256M) - 1)
 		return false;
 #endif
 	return true;
-- 
2.25.0

