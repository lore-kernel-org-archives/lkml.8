Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2802720770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgIDLEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:04:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37024 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbgIDLBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:01:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BjZVh3vs1z9twhK;
        Fri,  4 Sep 2020 13:01:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZNCm8itgyiEL; Fri,  4 Sep 2020 13:01:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BjZVh363vzB09bP;
        Fri,  4 Sep 2020 13:01:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BE43E8B81C;
        Fri,  4 Sep 2020 13:01:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WmnyPshTE7Fn; Fri,  4 Sep 2020 13:01:33 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [10.25.210.31])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 74BC18B81B;
        Fri,  4 Sep 2020 13:01:33 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 030F8653FF; Fri,  4 Sep 2020 11:01:32 +0000 (UTC)
Message-Id: <d66c4a372738d2fbd81f433ca86e4295871ace6a.1599216721.git.christophe.leroy@csgroup.eu>
In-Reply-To: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy@csgroup.eu>
References: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/3] powerpc/uaccess: Remove __put_user_asm() and
 __put_user_asm2()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Sep 2020 11:01:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__put_user_asm() and __put_user_asm2() are not used anymore.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 41 ++++--------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 96d1c144f92b..26781b044932 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -151,42 +151,6 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 
 extern long __put_user_bad(void);
 
-/*
- * We don't tell gcc that we are accessing memory, but this is OK
- * because we do not write to any memory gcc knows about, so there
- * are no aliasing issues.
- */
-#define __put_user_asm(x, addr, err, op)			\
-	__asm__ __volatile__(					\
-		"1:	" op "%U2%X2 %1,%2	# put_user\n"	\
-		"2:\n"						\
-		".section .fixup,\"ax\"\n"			\
-		"3:	li %0,%3\n"				\
-		"	b 2b\n"					\
-		".previous\n"					\
-		EX_TABLE(1b, 3b)				\
-		: "=r" (err)					\
-		: "r" (x), "m<>" (*addr), "i" (-EFAULT), "0" (err))
-
-#ifdef __powerpc64__
-#define __put_user_asm2(x, ptr, retval)				\
-	  __put_user_asm(x, ptr, retval, "std")
-#else /* __powerpc64__ */
-#define __put_user_asm2(x, addr, err)				\
-	__asm__ __volatile__(					\
-		"1:	stw%X2 %1,%2\n"			\
-		"2:	stw%X2 %L1,%L2\n"			\
-		"3:\n"						\
-		".section .fixup,\"ax\"\n"			\
-		"4:	li %0,%3\n"				\
-		"	b 3b\n"					\
-		".previous\n"					\
-		EX_TABLE(1b, 4b)				\
-		EX_TABLE(2b, 4b)				\
-		: "=r" (err)					\
-		: "r" (x), "m" (*addr), "i" (-EFAULT), "0" (err))
-#endif /* __powerpc64__ */
-
 #define __put_user_size_allowed(x, ptr, size, retval)		\
 do {								\
 	__label__ __pu_failed;					\
@@ -249,6 +213,11 @@ do {								\
 })
 
 
+/*
+ * We don't tell gcc that we are accessing memory, but this is OK
+ * because we do not write to any memory gcc knows about, so there
+ * are no aliasing issues.
+ */
 #define __put_user_asm_goto(x, addr, label, op)			\
 	asm volatile goto(					\
 		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
-- 
2.25.0

