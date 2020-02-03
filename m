Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF55C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29CA2051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UjiGo/TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgBCQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:47:46 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3752 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729958AbgBCQrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:47:42 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48BDJm0L6Zz9vBnS;
        Mon,  3 Feb 2020 17:47:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UjiGo/TP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DOO-4TdMqxFC; Mon,  3 Feb 2020 17:47:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48BDJl6Rqrz9vBnH;
        Mon,  3 Feb 2020 17:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580748455; bh=vvTMn3v7C5AvjARDFgAcHr2XgNLNjS1AjFV1Ob4WJ98=;
        h=From:Subject:To:Cc:Date:From;
        b=UjiGo/TPZTh8ApBh3br6yA3ywoAEdftFa0DhDduKyAwKYh/1mB/zzThLvJ/WPSooX
         H8itmeaoa4MIoxtcmx0Lhracs3VK1psJXfFrNb/JM21QjL/KRPH3B2zQeOTX8pXzBW
         aZLCp3R1hO/O28fcWTPluFXbyHI5dKo9jLvVIff8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 657798B7B5;
        Mon,  3 Feb 2020 17:47:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2YQbN13zgr-R; Mon,  3 Feb 2020 17:47:40 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61D658B7AC;
        Mon,  3 Feb 2020 17:47:38 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E721665299; Mon,  3 Feb 2020 16:47:37 +0000 (UTC)
Message-Id: <12f4f4f0ff89aeab3b937fc96c84fb35e1b2517e.1580748445.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: Slenderize _tlbia() for powerpc 603/603e
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  3 Feb 2020 16:47:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_tlbia() is a function used only on 603/603e core, ie on CPUs which
don't have a hash table.

_tlbia() uses the tlbia macro which implements a loop of 1024 tlbie.

On the 603/603e core, flushing the entire TLB requires no more than
32 tlbie.

Replace tlbia by a loop of 32 tlbie.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/book3s32/hash_low.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index c11b0a005196..a5039ad10429 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -696,18 +696,21 @@ _GLOBAL(_tlbia)
 	bne-	10b
 	stwcx.	r8,0,r9
 	bne-	10b
+#endif /* CONFIG_SMP */
+	li	r5, 32
+	lis	r4, KERNELBASE@h
+	mtctr	r5
 	sync
-	tlbia
+0:	tlbie	r4
+	addi	r4, r4, 0x1000
+	bdnz	0b
 	sync
+#ifdef CONFIG_SMP
 	TLBSYNC
 	li	r0,0
 	stw	r0,0(r9)		/* clear mmu_hash_lock */
 	mtmsr	r10
 	SYNC_601
 	isync
-#else /* CONFIG_SMP */
-	sync
-	tlbia
-	sync
 #endif /* CONFIG_SMP */
 	blr
-- 
2.25.0

