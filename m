Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC9C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8864F2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XKE79qjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDTFho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:37:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26686 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgDTFho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:37:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 495FpB1WFWz9tyFs;
        Mon, 20 Apr 2020 07:37:38 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XKE79qjG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6HpAP5DcRqMR; Mon, 20 Apr 2020 07:37:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 495FpB0VL5z9tyFq;
        Mon, 20 Apr 2020 07:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587361058; bh=8/duh4NEuRU6gaNn7hJT4yxLtzxr8IS/3hNU9Njuf8A=;
        h=From:Subject:To:Cc:Date:From;
        b=XKE79qjG68jzpytpQhRa0zkpWtrGLnHTWohb1ySycjQZ1r131eOlVKZzyIEz6qjAb
         H3LJiSSdpZh6WBkm6de8ZDBT2IFujtEftJwLuGh5mBf0geqc4fn4bTsw8x/v+Wq3WD
         TTrt5dHWmlTQ0CtxirR8sMh/oW3uSyleNKwILIog=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E991A8B776;
        Mon, 20 Apr 2020 07:37:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iQXkDGhso4sW; Mon, 20 Apr 2020 07:37:42 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB84E8B752;
        Mon, 20 Apr 2020 07:37:42 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 3548A657AE; Mon, 20 Apr 2020 05:37:42 +0000 (UTC)
Message-Id: <485caac75f195f18c11eb077b0031fdd2bb7fb9e.1587361039.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/8xx: Fix STRICT_KERNEL_RWX startup test failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 20 Apr 2020 05:37:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WRITE_RO lkdtm test works.

But when selecting CONFIG_DEBUG_RODATA_TEST, the kernel reports
	rodata_test: test data was not read only

This is because when rodata test runs, there are still old entries
in TLB.

Flush TLB after setting kernel pages RO or NX.

Fixes: d5f17ee96447 ("powerpc/8xx: don't disable large TLBs with CONFIG_STRICT_KERNEL_RWX")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/nohash/8xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 3189308dece4..d83a12c5bc7f 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -185,6 +185,7 @@ void mmu_mark_initmem_nx(void)
 			mmu_mapin_ram_chunk(etext8, einittext8, PAGE_KERNEL);
 		}
 	}
+	_tlbil_all();
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
@@ -199,6 +200,8 @@ void mmu_mark_rodata_ro(void)
 				      ~(LARGE_PAGE_SIZE_8M - 1)));
 	mmu_patch_addis(&patch__dtlbmiss_romem_top, -__pa(_sinittext));
 
+	_tlbil_all();
+
 	/* Update page tables for PTDUMP and BDI */
 	mmu_mapin_ram_chunk(0, sinittext, __pgprot(0));
 	mmu_mapin_ram_chunk(0, etext, PAGE_KERNEL_ROX);
-- 
2.25.0

