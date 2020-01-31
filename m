Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98313C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8ED20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WJ8FUohC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAaPhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:37:36 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51817 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbgAaPhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:37:36 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 488LvK0tBHz9vBLW;
        Fri, 31 Jan 2020 16:37:33 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WJ8FUohC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bKZuUQUrbMCp; Fri, 31 Jan 2020 16:37:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 488LvJ6rtfz9vBL4;
        Fri, 31 Jan 2020 16:37:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580485053; bh=qxGZgbj/FD/IJ6W0teXBPBNvikZf0YYVM3GmTICCJWI=;
        h=From:Subject:To:Cc:Date:From;
        b=WJ8FUohCIAn8QkB0O5Nba7L22e6x0wh0WuFfgdqqAT3nsvcii2hshCYtTvtw9DoDR
         9fkkGoQXHbG12WwztLB9AGEWMmbkXfObzbDL/FWK21v5E1k8pTlUyfHTXxhtV6MpsA
         5GTz7HJd0KT0vOYWW8foc9GkvtIgZf7Ej6Vxrxkw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 743C08B8B6;
        Fri, 31 Jan 2020 16:37:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N9uyqklYTQCc; Fri, 31 Jan 2020 16:37:34 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D2188B8B4;
        Fri, 31 Jan 2020 16:37:34 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 227966528B; Fri, 31 Jan 2020 15:37:34 +0000 (UTC)
Message-Id: <e31c57eb5308a5a73a5c8232454c0dd9f65f6175.1580485014.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: Don't flush all TLBs when flushing one page
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 31 Jan 2020 15:37:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flushing a range, the flushing function flushes all TLBs.

When the range is a single page, do a page flush instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/book3s32/tlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 2fcd321040ff..8e0089065a7e 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -79,14 +79,17 @@ static void flush_range(struct mm_struct *mm, unsigned long start,
 	int count;
 	unsigned int ctx = mm->context.id;
 
+	start &= PAGE_MASK;
+	end = (end - 1) | ~PAGE_MASK;
 	if (!Hash) {
-		_tlbia();
+		if (end - start == PAGE_SIZE)
+			_tlbie(start);
+		else
+			_tlbia();
 		return;
 	}
-	start &= PAGE_MASK;
 	if (start >= end)
 		return;
-	end = (end - 1) | ~PAGE_MASK;
 	pmd = pmd_offset(pud_offset(pgd_offset(mm, start), start), start);
 	for (;;) {
 		pmd_end = ((start + PGDIR_SIZE) & PGDIR_MASK) - 1;
-- 
2.25.0

