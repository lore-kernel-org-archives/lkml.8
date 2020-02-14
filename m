Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAABAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7A2217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jaqqs9jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBNIjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:39:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47779 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgBNIjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:39:52 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Jmys4ssFz9txhq;
        Fri, 14 Feb 2020 09:39:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jaqqs9jF; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 50U80ObWLknG; Fri, 14 Feb 2020 09:39:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Jmys3n50z9txhn;
        Fri, 14 Feb 2020 09:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581669589; bh=6gQazCc4WD16N17R9Ucj88w7ApMUGuUdxrC5CbZ6kUo=;
        h=From:Subject:To:Cc:Date:From;
        b=jaqqs9jFSGENAD7NHdG9Xqc4Alx7dezcbLukx1hq0a2cdwzs1UKZqfIXBohObK5sE
         qkpMRBWZ/o3bWdsPEyg/lcu5J8gCJJBVGkPxF5CjZJR2ycwaWshXiraNeWvbAGloIC
         1iQ2NVm5vPb5706Mxep/Xw0YYo7ny8x7CNRbrQNY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D97C8B87B;
        Fri, 14 Feb 2020 09:39:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wS7cpYO9s94s; Fri, 14 Feb 2020 09:39:50 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D74B8B874;
        Fri, 14 Feb 2020 09:39:50 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 466D565320; Fri, 14 Feb 2020 08:39:50 +0000 (UTC)
Message-Id: <d2330584f8c42d3039896e2b56f5d39676dc919c.1581669558.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RESEND with Fixes: tag] powerpc/chrp: Fix enter_rtas() with CONFIG_VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Feb 2020 08:39:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_VMAP_STACK, data MMU has to be enabled
to read data on the stack.

Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
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

