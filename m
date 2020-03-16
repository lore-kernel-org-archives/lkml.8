Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E0C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AAC205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JwfJyVcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgCPMgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:36:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731203AbgCPMg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwlR4xFwz9v02l;
        Mon, 16 Mar 2020 13:36:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JwfJyVcZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DxA4GsYKtVKH; Mon, 16 Mar 2020 13:36:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwlR3sBWz9v02f;
        Mon, 16 Mar 2020 13:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362179; bh=CdZwfArEauz62WETmDYTfQuV7IO+vN/4hsOwJJkocPg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=JwfJyVcZPjsrUY59A7jAQfPiEJoLBMDpREVF34qc3Cl4n/JaJYEjMAbRii6h2+NMV
         aOdgGVQ9534Ze10EkgAbRrL3WQuY+344DaOzhSI7Li4AoH3GrKDWXHh0BJP+Zp3vEy
         NeNwWxI8mOGUut+6MzIvnJv0ftu9Pw/amiyahHgQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 692348B7D0;
        Mon, 16 Mar 2020 13:36:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ISyzpdGQwtCf; Mon, 16 Mar 2020 13:36:24 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B17F8B7CB;
        Mon, 16 Mar 2020 13:36:24 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3EE1E65595; Mon, 16 Mar 2020 12:36:24 +0000 (UTC)
Message-Id: <86e2192ff3d21fa6c8bdeb934cbd836f7e4f5ce4.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 38/46] powerpc/8xx: Refactor kernel address boundary
 comparison
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:24 +0000 (UTC)
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

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index d12f5846d527..410cb48ab36f 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -31,10 +31,15 @@
 
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
@@ -208,20 +213,11 @@ InstructionTLBMiss:
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
@@ -287,9 +283,7 @@ DataStoreTLBMiss:
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

