Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575FCC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406532054F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgHQFqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:46:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10454 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgHQFqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:46:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVNMg4Yg9z9tytp;
        Mon, 17 Aug 2020 07:46:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vtjVRr15GY8P; Mon, 17 Aug 2020 07:46:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNMg3d2Zz9tytn;
        Mon, 17 Aug 2020 07:46:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 477298B772;
        Mon, 17 Aug 2020 07:46:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pLXIvOJRt5b4; Mon, 17 Aug 2020 07:46:44 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 298EB8B75B;
        Mon, 17 Aug 2020 07:46:44 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 26C8565CDD; Mon, 17 Aug 2020 05:46:44 +0000 (UTC)
Message-Id: <2d89732a9062b2cf2651728804e4b8f6c9b9358e.1597643164.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1] powerpc/process: Replace #ifdef CONFIG_KALLSYMS by
 IS_ENABLED()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Aug 2020 05:46:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #ifdef CONFIG_KALLSYMS encloses some printk which can
compile in all cases.

Replace by IS_ENABLED().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 087711aa0126..987bc8e73d5e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1469,14 +1469,14 @@ void show_regs(struct pt_regs * regs)
 			break;
 	}
 	pr_cont("\n");
-#ifdef CONFIG_KALLSYMS
 	/*
 	 * Lookup NIP late so we have the best change of getting the
 	 * above info out without failing
 	 */
-	printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
-	printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
-#endif
+	if (IS_ENABLED(CONFIG_KALLSYMS)) {
+		printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
+		printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
+	}
 	show_stack(current, (unsigned long *) regs->gpr[1], KERN_DEFAULT);
 	if (!user_mode(regs))
 		show_instructions(regs);
-- 
2.25.0

