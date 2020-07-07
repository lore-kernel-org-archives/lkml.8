Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FBCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355CC20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGGMdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:33:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7186 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgGGMdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:33:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4B1ML66Yk1z9tySw;
        Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FNhIg905TvsU; Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4B1ML65mTqz9tySr;
        Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E68E8B7E1;
        Tue,  7 Jul 2020 14:33:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Hn2tdZquK4Ew; Tue,  7 Jul 2020 14:33:36 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [10.25.210.22])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C8D08B7D7;
        Tue,  7 Jul 2020 14:33:36 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 73948658EB; Tue,  7 Jul 2020 12:33:36 +0000 (UTC)
Message-Id: <47a38df46cae5a5a88a558a64d71f75e9c4d9950.1594125164.git.christophe.leroy@csgroup.eu>
In-Reply-To: <173de3b659fa3a5f126a0eb170522cccd909950f.1594125164.git.christophe.leroy@csgroup.eu>
References: <173de3b659fa3a5f126a0eb170522cccd909950f.1594125164.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc/signal_32: Simplify loop in PPC64
 save_general_regs()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  7 Jul 2020 12:33:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_general_regs() which does special handling when i == PT_SOFTE.

Rewrite it to minimise the specific part, especially the __put_user()
and associated error handling is the same so make it common.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0fd59fbc6d49..aae31fa5e411 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -103,19 +103,14 @@ static inline int save_general_regs(struct pt_regs *regs,
 {
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
-	/* Force usr to alway see softe as 1 (interrupts enabled) */
-	elf_greg_t64 softe = 0x1;
 
 	WARN_ON(!FULL_REGS(regs));
 
 	for (i = 0; i <= PT_RESULT; i ++) {
-		if ( i == PT_SOFTE) {
-			if(__put_user((unsigned int)softe, &frame->mc_gregs[i]))
-				return -EFAULT;
-			else
-				continue;
-		}
-		if (__put_user((unsigned int)gregs[i], &frame->mc_gregs[i]))
+		/* Force usr to alway see softe as 1 (interrupts enabled) */
+		int val = (i == PT_SOFTE) ? 1 : gregs[i];
+
+		if (__put_user(val, &frame->mc_gregs[i]))
 			return -EFAULT;
 	}
 	return 0;
-- 
2.25.0

