Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD01C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB09217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgEIJmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:42:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11599 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgEIJmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:42:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49K2Kl03dpz9twwr;
        Sat,  9 May 2020 11:42:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id k7gWcFdnhRdJ; Sat,  9 May 2020 11:42:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49K2Kk6DRQz9tww3;
        Sat,  9 May 2020 11:42:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DA7A8B771;
        Sat,  9 May 2020 11:42:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T85gcY7K1Kn2; Sat,  9 May 2020 11:42:15 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BE408B75F;
        Sat,  9 May 2020 11:42:15 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id ACCC76590E; Sat,  9 May 2020 09:42:14 +0000 (UTC)
Message-Id: <7316a9e2c0c2517923eb4b0411c4a08d15e675a4.1589017281.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH fixes] powerpc/vdso32: Fallback on getres syscall when clock is
 unknown
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat,  9 May 2020 09:42:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are other clocks than the standard ones, for instance
per process clocks. Therefore, being above the last standard clock
doesn't mean it is a bad clock. So, fallback to syscall instead
of returning -EINVAL inconditionaly.

Fixes: e33ffc956b08 ("powerpc/vdso32: implement clock_getres entirely")
Cc: stable@vger.kernel.org
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index a3951567118a..e7f8f9f1b3f4 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -218,11 +218,11 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	blr
 
 	/*
-	 * invalid clock
+	 * syscall fallback
 	 */
 99:
-	li	r3, EINVAL
-	crset	so
+	li	r0,__NR_clock_getres
+	sc
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_clock_getres)
-- 
2.25.0

