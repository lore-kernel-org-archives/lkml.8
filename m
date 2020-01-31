Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABCDC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF89520707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="amAps2lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAaPhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:37:37 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39133 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgAaPhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:37:37 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 488LvK75YVz9vBLm;
        Fri, 31 Jan 2020 16:37:33 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=amAps2lu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1Zr0D3p_eBNz; Fri, 31 Jan 2020 16:37:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 488LvK6366z9vBL4;
        Fri, 31 Jan 2020 16:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580485053; bh=rwibZjUuY57oEQV4vttL8T5XPDBQagD/WKxnULqhffM=;
        h=From:Subject:To:Cc:Date:From;
        b=amAps2luD9CY/AyDhuukwxNmDJo9InG+AgrqpVbn+FSyUyZ/Aq0Lmk2GEz5Ocb+8s
         kgkdhI2FExbkFe22ScmUkb4z2arjQ4AvOhv+wG5phhY/FYyxIGhHmGTN5eUlTAojaJ
         4s4qiroibsIysfGSqfHMGQBgEwYmjmprkXALr77k=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 601B68B8B6;
        Fri, 31 Jan 2020 16:37:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R76Xz6559bST; Fri, 31 Jan 2020 16:37:35 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29FC38B8B4;
        Fri, 31 Jan 2020 16:37:35 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2DF716528B; Fri, 31 Jan 2020 15:37:35 +0000 (UTC)
Message-Id: <8cc8c64755ae63a6ef2b9808c1874664cdff8869.1580485010.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/nohash: Don't flush all TLBs when flushing one page
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 31 Jan 2020 15:37:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flushing a range, the flushing function flushes all TLBs.

When the range is a single page, do a page flush instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/nohash/tlb.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 696f568253a0..3d05d70c54dc 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -362,13 +362,32 @@ void __init early_init_mmu_47x(void)
  */
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
+	int tsize = mmu_get_tsize(mmu_virtual_psize);
+
 #ifdef CONFIG_SMP
 	preempt_disable();
-	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
-	_tlbil_pid(0);
+#endif
+	start = ALIGN_DOWN(start, PAGE_SIZE);
+	end = ALIGN(end, PAGE_SIZE);
+	if (end - start == PAGE_SIZE) {
+#ifdef CONFIG_SMP
+		struct tlb_flush_param p = {
+			.pid = 0,
+			.addr = start,
+			.tsize = tsize,
+			.ind = 0,
+		};
+		smp_call_function(do_flush_tlb_page_ipi, &p, 1);
+#endif
+		_tlbil_va(start, 0, tsize, 0);
+	} else {
+#ifdef CONFIG_SMP
+		smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
+#endif
+		_tlbil_pid(0);
+	}
+#ifdef CONFIG_SMP
 	preempt_enable();
-#else
-	_tlbil_pid(0);
 #endif
 }
 EXPORT_SYMBOL(flush_tlb_kernel_range);
-- 
2.25.0

