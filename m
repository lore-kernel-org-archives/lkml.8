Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C263BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97540205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="a5K8dZM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbgCPMiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:38:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58171 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731055AbgCPMfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:35:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwkn2WC4z9tygR;
        Mon, 16 Mar 2020 13:35:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=a5K8dZM0; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b-sdWkBrRdNk; Mon, 16 Mar 2020 13:35:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwkn1TCfz9tyg5;
        Mon, 16 Mar 2020 13:35:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362145; bh=zz3LY4LnIULNvU2REeo9vroSmYzMKaaLGdN2qxLIwuw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=a5K8dZM0rtPQrBXIENhJKCrGi9u581IUm5g2QO1QBHYk8nD3uEBcPHfiZy2ohQ8ho
         gI48qROSO33VlFay08xja22eTWgUzjFkhsK2mk603o9Wzm2TFwo/GLR+61BuJaqhFo
         fKc4fEIGdwFJav/ulZig4Rl/2idpNJ3FmdxRfTlw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 303AA8B7D0;
        Mon, 16 Mar 2020 13:35:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8eLsKBpz6-mm; Mon, 16 Mar 2020 13:35:50 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1796B8B7CB;
        Mon, 16 Mar 2020 13:35:50 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 108EA65595; Mon, 16 Mar 2020 12:35:50 +0000 (UTC)
Message-Id: <28206484284c1bc83b661de438eba04c6e75a1bc.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 05/46] powerpc/kasan: Remove unnecessary page table locking
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:35:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 45ff3c559585 ("powerpc/kasan: Fix parallel loading of
modules.") added spinlocks to manage parallele module loading.

Since then commit 47febbeeec44 ("powerpc/32: Force KASAN_VMALLOC for
modules") converted the module loading to KASAN_VMALLOC.

The spinlocking has then become unneeded and can be removed to
simplify kasan_init_shadow_page_tables()

Also remove inclusion of linux/moduleloader.h and linux/vmalloc.h
which are not needed anymore since the removal of modules management.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index c41e700153da..c9d053078c37 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -5,9 +5,7 @@
 #include <linux/kasan.h>
 #include <linux/printk.h>
 #include <linux/memblock.h>
-#include <linux/moduleloader.h>
 #include <linux/sched/task.h>
-#include <linux/vmalloc.h>
 #include <asm/pgalloc.h>
 #include <asm/code-patching.h>
 #include <mm/mmu_decl.h>
@@ -34,31 +32,22 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
 {
 	pmd_t *pmd;
 	unsigned long k_cur, k_next;
-	pte_t *new = NULL;
 
 	pmd = pmd_ptr_k(k_start);
 
 	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
+		pte_t *new;
+
 		k_next = pgd_addr_end(k_cur, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
-		if (!new)
-			new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
+		new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
 
 		if (!new)
 			return -ENOMEM;
 		kasan_populate_pte(new, PAGE_KERNEL);
-
-		smp_wmb(); /* See comment in __pte_alloc */
-
-		spin_lock(&init_mm.page_table_lock);
-			/* Has another populated it ? */
-		if (likely((void *)pmd_page_vaddr(*pmd) == kasan_early_shadow_pte)) {
-			pmd_populate_kernel(&init_mm, pmd, new);
-			new = NULL;
-		}
-		spin_unlock(&init_mm.page_table_lock);
+		pmd_populate_kernel(&init_mm, pmd, new);
 	}
 	return 0;
 }
-- 
2.25.0

