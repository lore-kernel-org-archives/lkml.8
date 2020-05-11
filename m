Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED602C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DF420736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgEKL0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:26:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54291 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgEKL0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJXP6cn7z9ty3j;
        Mon, 11 May 2020 13:25:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ChN5xmvL_AYX; Mon, 11 May 2020 13:25:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXP5mjlz9ty3g;
        Mon, 11 May 2020 13:25:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AE4E8B7AE;
        Mon, 11 May 2020 13:26:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ry3s_qjLDGHS; Mon, 11 May 2020 13:26:04 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F3D78B7B1;
        Mon, 11 May 2020 13:26:04 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1C6D565A09; Mon, 11 May 2020 11:26:04 +0000 (UTC)
Message-Id: <e72b392b0626c66585ce82521e5e43e82f9c3fc9.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 37/45] powerpc/8xx: Refactor kernel address boundary
 comparison
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:26:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that linear and IMMR dedicated TLB handling is gone, kernel
boundary address comparison is similar in ITLB miss handler and
in DTLB miss handler.

Create a macro named compare_to_kernel_boundary.

When TASK_SIZE is strictly below 0x80000000 and PAGE_OFFSET is
above 0x80000000, it is enough to compare to 0x8000000, and this
can be done with a single instruction.

Using not. instruction, we get to use 'blt' conditional branch as
when doing a regular comparison:

0x00000000 <= addr <= 0x7fffffff ==>
0xffffffff >= NOT(addr) >= 0x80000000
The above test corresponds to a 'blt'

Otherwise, do a regular comparison using two instructions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 9f3f7f3d03a7..9a117b9f0998 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -32,10 +32,15 @@
 
 #include "head_32.h"
 
+.macro compare_to_kernel_boundary scratch, addr
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
 /* By simply checking Address >= 0x80000000, we know if its a kernel address */
-#define SIMPLE_KERNEL_ADDRESS		1
+	not.	\scratch, \addr
+#else
+	rlwinm	\scratch, \addr, 16, 0xfff8
+	cmpli	cr0, \scratch, PAGE_OFFSET@h
 #endif
+.endm
 
 /*
  * We need an ITLB miss handler for kernel addresses if:
@@ -209,20 +214,11 @@ InstructionTLBMiss:
 	mtspr	SPRN_MD_EPN, r10
 #ifdef ITLB_MISS_KERNEL
 	mfcr	r11
-#if defined(SIMPLE_KERNEL_ADDRESS)
-	cmpi	cr0, r10, 0	/* Address >= 0x80000000 */
-#else
-	rlwinm	r10, r10, 16, 0xfff8
-	cmpli	cr0, r10, PAGE_OFFSET@h
-#endif
+	compare_to_kernel_boundary r10, r10
 #endif
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
 #ifdef ITLB_MISS_KERNEL
-#if defined(SIMPLE_KERNEL_ADDRESS)
-	bge+	3f
-#else
 	blt+	3f
-#endif
 	rlwinm	r10, r10, 0, 20, 31
 	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
 3:
@@ -288,9 +284,7 @@ DataStoreTLBMiss:
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_MD_EPN
-	rlwinm	r10, r10, 16, 0xfff8
-	cmpli	cr0, r10, PAGE_OFFSET@h
-
+	compare_to_kernel_boundary r10, r10
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
 	blt+	3f
 	rlwinm	r10, r10, 0, 20, 31
-- 
2.25.0

