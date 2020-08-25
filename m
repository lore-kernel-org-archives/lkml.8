Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D41C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0D120786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHYNym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:54:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37114 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHYNyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:54:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BbVpR386fz9txln;
        Tue, 25 Aug 2020 15:54:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wYJEZo8a1ZRO; Tue, 25 Aug 2020 15:54:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BbVpR1f5cz9txlj;
        Tue, 25 Aug 2020 15:54:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF6D38B825;
        Tue, 25 Aug 2020 15:54:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 10ZooPWDYufu; Tue, 25 Aug 2020 15:54:08 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 342A58B823;
        Tue, 25 Aug 2020 15:54:07 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7257965D42; Tue, 25 Aug 2020 13:54:07 +0000 (UTC)
Message-Id: <30d2ed97e1494f6ffbd4493e06cb58d9f402bb17.1598363608.git.christophe.leroy@csgroup.eu>
In-Reply-To: <df48ed76cf8a756a7f97ed42a1a39d0a404014bc.1598363608.git.christophe.leroy@csgroup.eu>
References: <df48ed76cf8a756a7f97ed42a1a39d0a404014bc.1598363608.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 9/9] powerpc/vdso: Remove unused \tmp param in
 __get_datapage()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Aug 2020 13:54:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The \tmp param is not used anymore, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 4 ++--
 arch/powerpc/include/asm/vdso_datapage.h     | 2 +-
 arch/powerpc/kernel/vdso32/cacheflush.S      | 2 +-
 arch/powerpc/kernel/vdso32/datapage.S        | 4 ++--
 arch/powerpc/kernel/vdso64/cacheflush.S      | 2 +-
 arch/powerpc/kernel/vdso64/datapage.S        | 4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 59a609a48b63..8602f1243e8d 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -22,7 +22,7 @@
 #ifdef CONFIG_PPC64
 	PPC_STL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
 #endif
-	get_datapage	r5, r0
+	get_datapage	r5
 	addi		r5, r5, VDSO_DATA_OFFSET
 	bl		\funct
 	PPC_LL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
@@ -51,7 +51,7 @@
 #ifdef CONFIG_PPC64
 	PPC_STL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
 #endif
-	get_datapage	r4, r0
+	get_datapage	r4
 	addi		r4, r4, VDSO_DATA_OFFSET
 	bl		\funct
 	PPC_LL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 2bc415f7714c..71f44598f392 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -102,7 +102,7 @@ extern struct vdso_arch_data *vdso_data;
 
 #else /* __ASSEMBLY__ */
 
-.macro get_datapage ptr, tmp
+.macro get_datapage ptr
 	bcl	20, 31, .+4
 999:
 	mflr	\ptr
diff --git a/arch/powerpc/kernel/vdso32/cacheflush.S b/arch/powerpc/kernel/vdso32/cacheflush.S
index 3440ddf21c8b..017843bf5382 100644
--- a/arch/powerpc/kernel/vdso32/cacheflush.S
+++ b/arch/powerpc/kernel/vdso32/cacheflush.S
@@ -27,7 +27,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10, r0
+	get_datapage	r10
 	mtlr	r12
 #endif
 
diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index 5513a4f8253e..0513a2eabec8 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3, r0
+	get_datapage	r3
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP32
 	beqlr
@@ -49,7 +49,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3, r0
+	get_datapage	r3
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 	lwz	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
diff --git a/arch/powerpc/kernel/vdso64/cacheflush.S b/arch/powerpc/kernel/vdso64/cacheflush.S
index cab14324242b..61985de5758f 100644
--- a/arch/powerpc/kernel/vdso64/cacheflush.S
+++ b/arch/powerpc/kernel/vdso64/cacheflush.S
@@ -25,7 +25,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10, r0
+	get_datapage	r10
 	mtlr	r12
 
 	lwz	r7,CFG_DCACHE_BLOCKSZ(r10)
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 03bb72c440dc..00760dc69d68 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr	r4,r3
-	get_datapage	r3, r0
+	get_datapage	r3
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
 	cmpldi	cr0,r4,0
@@ -50,7 +50,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3, r0
+	get_datapage	r3
 	ld	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
 	crclr	cr0*4+so
-- 
2.25.0

