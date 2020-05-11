Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE66C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93F720722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgEKL0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:26:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43614 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbgEKL0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:26:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJXX0TWbz9ty3k;
        Mon, 11 May 2020 13:26:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 06hRKL3H4ikb; Mon, 11 May 2020 13:26:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXW6sFgz9ty3g;
        Mon, 11 May 2020 13:26:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A2DB78B7AE;
        Mon, 11 May 2020 13:26:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cMnp7aswnbEZ; Mon, 11 May 2020 13:26:10 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AEB58B7AD;
        Mon, 11 May 2020 13:26:10 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4BF3865A09; Mon, 11 May 2020 11:26:10 +0000 (UTC)
Message-Id: <4dda77ed725d679510c337ab936121ba2614d838.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 43/45] powerpc/8xx: Implement dedicated kasan_init_region()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:26:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a kasan_init_region() dedicated to 8xx that
allocates KASAN regions using huge pages.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/kasan/8xx.c    | 74 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/kasan/Makefile |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 arch/powerpc/mm/kasan/8xx.c

diff --git a/arch/powerpc/mm/kasan/8xx.c b/arch/powerpc/mm/kasan/8xx.c
new file mode 100644
index 000000000000..db4ef44af22f
--- /dev/null
+++ b/arch/powerpc/mm/kasan/8xx.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/kasan.h>
+#include <linux/memblock.h>
+#include <linux/hugetlb.h>
+#include <asm/pgalloc.h>
+
+static int __init
+kasan_init_shadow_8M(unsigned long k_start, unsigned long k_end, void *block)
+{
+	pmd_t *pmd = pmd_ptr_k(k_start);
+	unsigned long k_cur, k_next;
+
+	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd += 2, block += SZ_8M) {
+		pte_basic_t *new;
+
+		k_next = pgd_addr_end(k_cur, k_end);
+		k_next = pgd_addr_end(k_next, k_end);
+		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
+			continue;
+
+		new = memblock_alloc(sizeof(pte_basic_t), SZ_4K);
+		if (!new)
+			return -ENOMEM;
+
+		*new = pte_val(pte_mkhuge(pfn_pte(PHYS_PFN(__pa(block)), PAGE_KERNEL)));
+
+		hugepd_populate_kernel((hugepd_t *)pmd, (pte_t *)new, PAGE_SHIFT_8M);
+		hugepd_populate_kernel((hugepd_t *)pmd + 1, (pte_t *)new, PAGE_SHIFT_8M);
+	}
+	return 0;
+}
+
+int __init kasan_init_region(void *start, size_t size)
+{
+	unsigned long k_start = (unsigned long)kasan_mem_to_shadow(start);
+	unsigned long k_end = (unsigned long)kasan_mem_to_shadow(start + size);
+	unsigned long k_cur;
+	int ret;
+	void *block;
+
+	block = memblock_alloc(k_end - k_start, SZ_8M);
+	if (!block)
+		return -ENOMEM;
+
+	if (IS_ALIGNED(k_start, SZ_8M)) {
+		kasan_init_shadow_8M(k_start, ALIGN_DOWN(k_end, SZ_8M), block);
+		k_cur = ALIGN_DOWN(k_end, SZ_8M);
+		if (k_cur == k_end)
+			goto finish;
+	} else {
+		k_cur = k_start;
+	}
+
+	ret = kasan_init_shadow_page_tables(k_start, k_end);
+	if (ret)
+		return ret;
+
+	for (; k_cur < k_end; k_cur += PAGE_SIZE) {
+		pmd_t *pmd = pmd_ptr_k(k_cur);
+		void *va = block + k_cur - k_start;
+		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
+
+		if (k_cur < ALIGN_DOWN(k_end, SZ_512K))
+			pte = pte_mkhuge(pte);
+
+		__set_pte_at(&init_mm, k_cur, pte_offset_kernel(pmd, k_cur), pte, 0);
+	}
+finish:
+	flush_tlb_kernel_range(k_start, k_end);
+	return 0;
+}
diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..440038ea79f1 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -3,3 +3,4 @@
 KASAN_SANITIZE := n
 
 obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC_8xx)		+= 8xx.o
-- 
2.25.0

