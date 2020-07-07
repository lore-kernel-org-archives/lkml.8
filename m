Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5AFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194132075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGMdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:33:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49449 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGMdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:33:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4B1ML61wP0z9tySt;
        Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bhDiDSnff4fv; Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4B1ML60m90z9tySr;
        Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA3858B7E1;
        Tue,  7 Jul 2020 14:33:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JtV9cE63Lvdx; Tue,  7 Jul 2020 14:33:35 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [10.25.210.22])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CCE28B7D7;
        Tue,  7 Jul 2020 14:33:35 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 77128658EB; Tue,  7 Jul 2020 12:33:35 +0000 (UTC)
Message-Id: <173de3b659fa3a5f126a0eb170522cccd909950f.1594125164.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/signal_32: Remove !FULL_REGS() special handling
 in PPC64 save_general_regs()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  7 Jul 2020 12:33:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ("1bd79336a426 powerpc: Fix various
syscall/signal/swapcontext bugs"), getting save_general_regs() called
without FULL_REGS() is very unlikely and generates a warning.

The 32-bit version of save_general_regs() doesn't take care of it
at all and copies all registers anyway since that commit.

Moreover, commit 965dd3ad3076 ("powerpc/64/syscall: Remove
non-volatile GPR save optimisation") is another reason why it would
never happen.

So the same with 64-bit, don't worry about FULL_REGS() and copy
all registers all the time.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 1415c16ab628..0fd59fbc6d49 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -109,8 +109,6 @@ static inline int save_general_regs(struct pt_regs *regs,
 	WARN_ON(!FULL_REGS(regs));
 
 	for (i = 0; i <= PT_RESULT; i ++) {
-		if (i == 14 && !FULL_REGS(regs))
-			i = 32;
 		if ( i == PT_SOFTE) {
 			if(__put_user((unsigned int)softe, &frame->mc_gregs[i]))
 				return -EFAULT;
-- 
2.25.0

