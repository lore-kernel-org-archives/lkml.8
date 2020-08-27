Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69B7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA232087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgH0Pt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:49:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34419 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgH0Pt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:49:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BcnGX4JyBz9v2L8;
        Thu, 27 Aug 2020 17:49:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XUXG79OLzFOR; Thu, 27 Aug 2020 17:49:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BcnGX33Kkz9v2Kg;
        Thu, 27 Aug 2020 17:49:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 805898B884;
        Thu, 27 Aug 2020 17:49:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5gXfghUxCvqE; Thu, 27 Aug 2020 17:49:25 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CAB6E8B880;
        Thu, 27 Aug 2020 17:49:24 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 76ACF65D45; Thu, 27 Aug 2020 15:49:24 +0000 (UTC)
Message-Id: <e8d735102627299303acd8fbec8c7a706b1e7882.1598543237.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/6] powerpc/vdso: Remove DBG()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Aug 2020 15:49:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DBG() is defined as void when DEBUG is not defined,
and DEBUG is explicitly undefined.

It means there is no other way than modifying source code
to get the messages printed.

It was most likely useful in the first days of VDSO, but
today the only 3 DBG() calls don't deserve a special
handling.

Just remove them. If one day someone need such messages back,
use a standard pr_debug() or equivalent.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index e8aaeeae9e9f..a44e8e6a4692 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -31,14 +31,6 @@
 #include <asm/vdso_datapage.h>
 #include <asm/setup.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* Max supported size for symbol names */
 #define MAX_SYMNAME	64
 
@@ -567,9 +559,6 @@ static __init int vdso_fixup_alt_funcs(struct lib32_elfinfo *v32,
 		if (!match)
 			continue;
 
-		DBG("replacing %s with %s...\n", patch->gen_name,
-		    patch->fix_name ? "NONE" : patch->fix_name);
-
 		/*
 		 * Patch the 32 bits and 64 bits symbols. Note that we do not
 		 * patch the "." symbol on 64 bits.
@@ -704,7 +693,6 @@ static int __init vdso_init(void)
 	 * Calculate the size of the 64 bits vDSO
 	 */
 	vdso64_pages = (&vdso64_end - &vdso64_start) >> PAGE_SHIFT;
-	DBG("vdso64_kbase: %p, 0x%x pages\n", vdso64_kbase, vdso64_pages);
 
 	vdso32_kbase = &vdso32_start;
 
@@ -713,7 +701,6 @@ static int __init vdso_init(void)
 	 * Calculate the size of the 32 bits vDSO
 	 */
 	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
-	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
 #endif
 
 	/*
-- 
2.25.0

