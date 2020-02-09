Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFEAC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 18:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CE420715
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bUG4IZTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBISOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 13:14:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18870 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgBISOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 13:14:45 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48FxyS2YJfz9v3Sk;
        Sun,  9 Feb 2020 19:14:40 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bUG4IZTS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6Xv58HyFhFy5; Sun,  9 Feb 2020 19:14:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48FxyS1L1Xz9v3Sj;
        Sun,  9 Feb 2020 19:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581272080; bh=/x/ryEnrK5GCFnH7Q+2EYronwEPznvfsw50OG2P+qvY=;
        h=From:Subject:To:Cc:Date:From;
        b=bUG4IZTShRCXxb4P59NMcSU7KCwkQDCE42iPZsXVgBKqA5FB4/aAyR2yfXX6Jxy4w
         E32aK/D51/ZcQFKDtI99nN6B6wOCBwLTNMZnAuxqP8qpzLF34Jn0Lku8L3HTpw2EsQ
         xwibyKG8AAKwVo+Bma4vwci+ecaUPT1NhWEweUak=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BDDC38B773;
        Sun,  9 Feb 2020 19:14:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9ykToH1Zr2rT; Sun,  9 Feb 2020 19:14:43 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A4878B755;
        Sun,  9 Feb 2020 19:14:43 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 0B7B0652AE; Sun,  9 Feb 2020 18:14:42 +0000 (UTC)
Message-Id: <4f70c2778163affce8508a210f65d140e84524b4.1581272050.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: Fix clearing of bits 20-23 in ITLB miss
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  9 Feb 2020 18:14:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ITLB miss handled the line supposed to clear bits 20-23 on the
L2 ITLB entry is buggy and does indeed nothing, leading to undefined
value which could allow execution when it shouldn't.

Properly do the clearing with the relevant instruction.

Fixes: 74fabcadfd43 ("powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 9922306ae512..073a651787df 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -256,7 +256,7 @@ InstructionTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-	rlwimi	r10, r10, 0, 0x0f00	/* Clear bits 20-23 */
+	rlwinm	r10, r10, 0, ~0x0f00	/* Clear bits 20-23 */
 	rlwimi	r10, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
 	ori	r10, r10, RPN_PATTERN | 0x200 /* Set 22 and 24-27 */
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
-- 
2.25.0

