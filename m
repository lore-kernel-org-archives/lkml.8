Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777BEC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8AB206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JD9x2z+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgC2JlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:41:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6110 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgC2JlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:41:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qrF70qgKz9tyY0;
        Sun, 29 Mar 2020 11:40:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JD9x2z+x; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W2DKOqpYvs0k; Sun, 29 Mar 2020 11:40:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qrF66qzKz9tyXy;
        Sun, 29 Mar 2020 11:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585474859; bh=9Ex3O+iluoexmpGb+PEB5x2/IMSdkbD5UGZNuiYc8UI=;
        h=From:Subject:To:Cc:Date:From;
        b=JD9x2z+x1Fdqj6pXC/MT1KrW50s81K/1H4B1yO35cf1HCqE/W8y37LwrmymhK/FBj
         d6fIe0YvTLR9yqVq6YzTVbhqrF64ud8ChFXgtcezg/iNRAucb5lnhZH72cCdFmedYj
         1iO0c+HhCMYbjNBMFkbrhbbFciPfgQZ8Be2iXr4k=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC5188B770;
        Sun, 29 Mar 2020 11:41:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id STH3M_JcQ2vg; Sun, 29 Mar 2020 11:41:01 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 954998B752;
        Sun, 29 Mar 2020 11:41:01 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4CDA965653; Sun, 29 Mar 2020 09:41:01 +0000 (UTC)
Message-Id: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 01/12] powerpc/52xx: Blacklist functions running with MMU
 disabled for kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 29 Mar 2020 09:41:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/52xx/lite5200_sleep.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/lite5200_sleep.S b/arch/powerpc/platforms/52xx/lite5200_sleep.S
index 3a9969c429b3..70083649c9ea 100644
--- a/arch/powerpc/platforms/52xx/lite5200_sleep.S
+++ b/arch/powerpc/platforms/52xx/lite5200_sleep.S
@@ -248,6 +248,7 @@ mmu_on:
 
 
 	blr
+_ASM_NOKPROBE_SYMBOL(lite5200_wakeup)
 
 
 /* ---------------------------------------------------------------------- */
@@ -391,6 +392,7 @@ restore_regs:
 	LOAD_SPRN(TBWU,  0x5b);
 
 	blr
+_ASM_NOKPROBE_SYMBOL(restore_regs)
 
 
 
-- 
2.25.0

