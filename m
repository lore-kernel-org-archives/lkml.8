Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFEEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEC720873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Ae6H25Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgBNIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:33:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7650 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgBNIdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:33:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48JmqJ5B7vz9txhn;
        Fri, 14 Feb 2020 09:33:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Ae6H25Sk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dVdXZgnzcuRk; Fri, 14 Feb 2020 09:33:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48JmqJ41PGz9txhm;
        Fri, 14 Feb 2020 09:33:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581669196; bh=rfu9QfcHTR7SY43rhOXPY1brk16w1ODvFQIZbggd35g=;
        h=From:Subject:To:Cc:Date:From;
        b=Ae6H25SkRuCmgIV1MWiGxiyUpkFpaPxsD/hc4nExSBHb1pGT88UfkkrCFq4V1lqVO
         5wSuioE+fZpTb3aAJd3e9RCF6xgJwt6ELmR2ivPb6bf2Bs6NPw/U7CjddE7sQ4iRnQ
         JRdojKrggmIjcWqjpIVbgharhtupCjxqUmJnC2X4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 87AC88B87B;
        Fri, 14 Feb 2020 09:33:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZanIXXYaCly0; Fri, 14 Feb 2020 09:33:17 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D94B8B874;
        Fri, 14 Feb 2020 09:33:17 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 01C8565320; Fri, 14 Feb 2020 08:33:16 +0000 (UTC)
Message-Id: <159ecb0ab021c07fd2f383d4a083a43d16d67b92.1581669187.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/chrp: Fix enter_rtas() with CONFIG_VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Feb 2020 08:33:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_VMAP_STACK, data MMU has to be enabled
to read data on the stack.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0713daa651d9..bc056d906b51 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1354,12 +1354,17 @@ _GLOBAL(enter_rtas)
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
 	RFI
-1:	tophys(r9,r1)
+1:	tophys_novmstack r9, r1
+#ifdef CONFIG_VMAP_STACK
+	li	r0, MSR_KERNEL & ~MSR_IR	/* can take DTLB miss */
+	mtmsr	r0
+	isync
+#endif
 	lwz	r8,INT_FRAME_SIZE+4(r9)	/* get return address */
 	lwz	r9,8(r9)	/* original msr value */
 	addi	r1,r1,INT_FRAME_SIZE
 	li	r0,0
-	tophys(r7, r2)
+	tophys_novmstack r7, r2
 	stw	r0, THREAD + RTAS_SP(r7)
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
-- 
2.25.0

