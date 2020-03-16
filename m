Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67460C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EBF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Us9I/hEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgCPMgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:36:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6249 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbgCPMgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwl06kRlz9v02l;
        Mon, 16 Mar 2020 13:35:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Us9I/hEi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WY7DCd4dv6qS; Mon, 16 Mar 2020 13:35:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwl05hSRz9v02g;
        Mon, 16 Mar 2020 13:35:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362156; bh=tsG5tjCntKOJbZ6UipwLnv4ptK9ICt4FKsJU4O5EBMY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Us9I/hEiZT4/EmSmoA49PBTKUAJYKnyVUceiIpOE92w82jyz8DarsR923MndB4Rin
         3DZHTuzFyQb7GAqNQPlY+nhCRX4bbfoxfHf/5ZsqhZ9Yg+csCYRVYftlf5gAnW69Yo
         QQXt1+bi1io2S5PsG0N40B5cegBf2K9dv5Ubkj/0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE06B8B7CB;
        Mon, 16 Mar 2020 13:36:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QO-e-1su5sdr; Mon, 16 Mar 2020 13:36:01 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F0AB8B7D0;
        Mon, 16 Mar 2020 13:36:01 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7408065595; Mon, 16 Mar 2020 12:36:01 +0000 (UTC)
Message-Id: <d4bd46fe0103f8a8cb7e5affb2a7fcc3185be24e.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 16/46] powerpc/mm: Allocate static page tables for fixmap
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate static page tables for the fixmap area. This allows
setting mappings through page tables before memblock is ready.
That's needed to use early_ioremap() early and to use standard
page mappings with fixmap.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/fixmap.h |  4 ++++
 arch/powerpc/kernel/setup_32.c    |  2 +-
 arch/powerpc/mm/pgtable_32.c      | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 2ef155a3c821..ccbe2e83c950 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -86,6 +86,10 @@ enum fixed_addresses {
 #define __FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
 
+#define FIXMAP_ALIGNED_SIZE	(ALIGN(FIXADDR_TOP, PGDIR_SIZE) - \
+				 ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE))
+#define FIXMAP_PTE_SIZE	(FIXMAP_ALIGNED_SIZE / PGDIR_SIZE * PTE_TABLE_SIZE)
+
 #define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NCG
 #define FIXMAP_PAGE_IO	PAGE_KERNEL_NCG
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 5b49b26eb154..3f1e1c0b328a 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -81,7 +81,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Configure static keys first, now that we're relocated. */
 	setup_feature_keys();
 
-	early_ioremap_setup();
+	early_ioremap_init();
 
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index f62de06e3d07..9934659cb871 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -29,11 +29,27 @@
 #include <asm/fixmap.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
+#include <asm/early_ioremap.h>
 
 #include <mm/mmu_decl.h>
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
+static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
+
+notrace void __init early_ioremap_init(void)
+{
+	unsigned long addr = ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE);
+	pte_t *ptep = (pte_t *)early_fixmap_pagetable;
+	pmd_t *pmdp = pmd_ptr_k(addr);
+
+	for (; (s32)(FIXADDR_TOP - addr) > 0;
+	     addr += PGDIR_SIZE, ptep += PTRS_PER_PTE, pmdp++)
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+
+	early_ioremap_setup();
+}
+
 static void __init *early_alloc_pgtable(unsigned long size)
 {
 	void *ptr = memblock_alloc(size, size);
-- 
2.25.0

