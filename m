Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7883EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6325E2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHQFqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:46:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42591 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgHQFqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:46:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVNMh4r8Xz9tytq;
        Mon, 17 Aug 2020 07:46:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id q-szUbL8Q2Ir; Mon, 17 Aug 2020 07:46:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNMh3vBwz9tytn;
        Mon, 17 Aug 2020 07:46:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6282A8B772;
        Mon, 17 Aug 2020 07:46:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8mJDGUloHsjn; Mon, 17 Aug 2020 07:46:45 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39CC28B75B;
        Mon, 17 Aug 2020 07:46:45 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 37CC065CDD; Mon, 17 Aug 2020 05:46:45 +0000 (UTC)
Message-Id: <3612a8f8aaca16de3fc414a7e66293319d6e213c.1597643147.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1] powerpc/process: Tag an #endif to help locate the matching
 #ifdef.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Aug 2020 05:46:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That #endif is more than 100 lines after the matching #ifdef,
and there are several #ifdef/#else/#endif inbetween.

Tag it as /* CONFIG_PPC_BOOK3S_64 */ to help locate the
matching #ifdef.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 016bd831908e..ffbe79960c73 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -575,7 +575,7 @@ void notrace restore_math(struct pt_regs *regs)
 		regs->msr |= new_msr;
 	}
 }
-#endif
+#endif /* CONFIG_PPC_BOOK3S_64 */
 
 static void save_all(struct task_struct *tsk)
 {
-- 
2.25.0

