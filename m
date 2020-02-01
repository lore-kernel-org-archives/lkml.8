Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C8C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC8E20679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Kdi/bVSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgBAIEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:04:43 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7797 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgBAIEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:04:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 488mpK0GJcz9txXb;
        Sat,  1 Feb 2020 09:04:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Kdi/bVSI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7gid33ueGGIG; Sat,  1 Feb 2020 09:04:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 488mpJ5mDTz9txXZ;
        Sat,  1 Feb 2020 09:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580544280; bh=pF6qOsoa+B6c+k7OrSh1l90UqfLv4FfQzTjeEPDmFbU=;
        h=From:Subject:To:Cc:Date:From;
        b=Kdi/bVSIkI/YciLcIslviNphJQReBFpq493fmrSQ9yEl3rHlug890zMlL8S3CdLAK
         PvRv0+RzQVclxi5MA5OfaNSDTJ/HBUStyx+Tt1agsjIc1qB5NDir8cjFcZAY5st9Jy
         ckDGEM1/aETvxZJ2KWSjdpbe9jH339QMv0ZS39Ao=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A0FA18B785;
        Sat,  1 Feb 2020 09:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GAtog0G4TJHt; Sat,  1 Feb 2020 09:04:36 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 039D58B752;
        Sat,  1 Feb 2020 09:04:33 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E8ADC65290; Sat,  1 Feb 2020 08:04:31 +0000 (UTC)
Message-Id: <b30b2eae6960502eaf0d9e36c60820b839693c33.1580542939.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/32s: Don't flush all TLBs when flushing one page
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat,  1 Feb 2020 08:04:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flushing any memory range, the flushing function
flushes all TLBs.

When (start) and (end - 1) are in the same memory page,
flush that page instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: Reworked the test as the previous one was always false (end - start was PAGE_SIZE - 1 for a single page)
---
 arch/powerpc/mm/book3s32/tlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 2fcd321040ff..724c0490fb17 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -79,11 +79,14 @@ static void flush_range(struct mm_struct *mm, unsigned long start,
 	int count;
 	unsigned int ctx = mm->context.id;
 
+	start &= PAGE_MASK;
 	if (!Hash) {
-		_tlbia();
+		if (end - start <= PAGE_SIZE)
+			_tlbie(start);
+		else
+			_tlbia();
 		return;
 	}
-	start &= PAGE_MASK;
 	if (start >= end)
 		return;
 	end = (end - 1) | ~PAGE_MASK;
-- 
2.25.0

