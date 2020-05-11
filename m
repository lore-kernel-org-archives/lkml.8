Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C173C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BAF20722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgEKLZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:25:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20998 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgEKLZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJWx6jKWz9ty3l;
        Mon, 11 May 2020 13:25:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8RSGgLJ2_fvF; Mon, 11 May 2020 13:25:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJWx6099z9ty3g;
        Mon, 11 May 2020 13:25:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CCF18B7AE;
        Mon, 11 May 2020 13:25:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kUe8LzdcB0qu; Mon, 11 May 2020 13:25:40 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 431CE8B7AD;
        Mon, 11 May 2020 13:25:40 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2A0CC65A09; Mon, 11 May 2020 11:25:40 +0000 (UTC)
Message-Id: <abc6d67079a28db9713440718450ea969bcfbd7b.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 14/45] powerpc/32s: Don't warn when mapping RO data ROX.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:25:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping RO data as ROX is not an issue since that data
cannot be modified to introduce an exploit.

PPC64 accepts to have RO data mapped ROX, as a trade off
between kernel size and strictness of protection.

On PPC32, kernel size is even more critical as amount of
memory is usually small.

Depending on the number of available IBATs, the last IBATs
might overflow the end of text. Only warn if it crosses
the end of RO data.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 39ba53ca5bb5..a9b2cbc74797 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -187,6 +187,7 @@ void mmu_mark_initmem_nx(void)
 	int i;
 	unsigned long base = (unsigned long)_stext - PAGE_OFFSET;
 	unsigned long top = (unsigned long)_etext - PAGE_OFFSET;
+	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
 	unsigned long size;
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S_601))
@@ -201,9 +202,10 @@ void mmu_mark_initmem_nx(void)
 		size = block_size(base, top);
 		size = max(size, 128UL << 10);
 		if ((top - base) > size) {
-			if (strict_kernel_rwx_enabled())
-				pr_warn("Kernel _etext not properly aligned\n");
 			size <<= 1;
+			if (strict_kernel_rwx_enabled() && base + size > border)
+				pr_warn("Some RW data is getting mapped X. "
+					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
 		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
 		base += size;
-- 
2.25.0

