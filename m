Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A04DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E014020772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHQFqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:46:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50735 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHQFqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:46:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVNMf4NxZz9tytl;
        Mon, 17 Aug 2020 07:46:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZrDGUPrwf_gL; Mon, 17 Aug 2020 07:46:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNMf3Z9Vz9tydp;
        Mon, 17 Aug 2020 07:46:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 425108B772;
        Mon, 17 Aug 2020 07:46:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QqRp2YYzzIB9; Mon, 17 Aug 2020 07:46:43 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 240E88B75B;
        Mon, 17 Aug 2020 07:46:43 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 220F665CDD; Mon, 17 Aug 2020 05:46:43 +0000 (UTC)
Message-Id: <a1b6ef3d657c8f249193442f56868fc358ea5b6c.1597643160.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1] powerpc/process: Replace an #if defined(CONFIG_4xx) ||
 defined(CONFIG_BOOKE) by IS_ENABLED()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Aug 2020 05:46:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE) encloses some
printk which can be compiled in all cases.

Replace by IS_ENABLED().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index fd3e11663613..087711aa0126 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1446,12 +1446,13 @@ void show_regs(struct pt_regs * regs)
 	trap = TRAP(regs);
 	if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
 		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
-	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-		pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
-#else
-		pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
-#endif
+	if (trap == 0x200 || trap == 0x300 || trap == 0x600) {
+		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
+			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
+		else
+			pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
+	}
+
 #ifdef CONFIG_PPC64
 	pr_cont("IRQMASK: %lx ", regs->softe);
 #endif
-- 
2.25.0

