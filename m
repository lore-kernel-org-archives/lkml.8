Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A141EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B91D207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgESFtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:49:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51466 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgESFtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:49:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4hS58Rrz9txm4;
        Tue, 19 May 2020 07:49:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Lyrsl5okq7J7; Tue, 19 May 2020 07:49:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4hS4R27z9txlx;
        Tue, 19 May 2020 07:49:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B94658B7A7;
        Tue, 19 May 2020 07:49:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YpGHmKomxx0b; Tue, 19 May 2020 07:49:29 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7991C8B767;
        Tue, 19 May 2020 07:49:29 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5558F65A4A; Tue, 19 May 2020 05:49:29 +0000 (UTC)
Message-Id: <709e821602b48a1d7c211a9b156da26db98c3e9d.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 45/45] powerpc/32s: Implement dedicated kasan_init_region()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:49:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a kasan_init_region() dedicated to book3s/32 that
allocates KASAN regions using BATs.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kasan.h      |  1 +
 arch/powerpc/mm/kasan/Makefile        |  1 +
 arch/powerpc/mm/kasan/book3s_32.c     | 57 +++++++++++++++++++++++++++
 arch/powerpc/mm/kasan/kasan_init_32.c |  2 +-
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/mm/kasan/book3s_32.c

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 107a24c3f7b3..be85c7005fb1 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -34,6 +34,7 @@ static inline void kasan_init(void) { }
 static inline void kasan_late_init(void) { }
 #endif
 
+void kasan_update_early_region(unsigned long k_start, unsigned long k_end, pte_t pte);
 int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end);
 int kasan_init_region(void *start, size_t size);
 
diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 440038ea79f1..bb1a5408b86b 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -4,3 +4,4 @@ KASAN_SANITIZE := n
 
 obj-$(CONFIG_PPC32)           += kasan_init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s_32.o
diff --git a/arch/powerpc/mm/kasan/book3s_32.c b/arch/powerpc/mm/kasan/book3s_32.c
new file mode 100644
index 000000000000..4bc491a4a1fd
--- /dev/null
+++ b/arch/powerpc/mm/kasan/book3s_32.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/kasan.h>
+#include <linux/memblock.h>
+#include <asm/pgalloc.h>
+#include <mm/mmu_decl.h>
+
+int __init kasan_init_region(void *start, size_t size)
+{
+	unsigned long k_start = (unsigned long)kasan_mem_to_shadow(start);
+	unsigned long k_end = (unsigned long)kasan_mem_to_shadow(start + size);
+	unsigned long k_cur = k_start;
+	int k_size = k_end - k_start;
+	int k_size_base = 1 << (ffs(k_size) - 1);
+	int ret;
+	void *block;
+
+	block = memblock_alloc(k_size, k_size_base);
+
+	if (block && k_size_base >= SZ_128K && k_start == ALIGN(k_start, k_size_base)) {
+		int k_size_more = 1 << (ffs(k_size - k_size_base) - 1);
+
+		setbat(-1, k_start, __pa(block), k_size_base, PAGE_KERNEL);
+		if (k_size_more >= SZ_128K)
+			setbat(-1, k_start + k_size_base, __pa(block) + k_size_base,
+			       k_size_more, PAGE_KERNEL);
+		if (v_block_mapped(k_start))
+			k_cur = k_start + k_size_base;
+		if (v_block_mapped(k_start + k_size_base))
+			k_cur = k_start + k_size_base + k_size_more;
+
+		update_bats();
+	}
+
+	if (!block)
+		block = memblock_alloc(k_size, PAGE_SIZE);
+	if (!block)
+		return -ENOMEM;
+
+	ret = kasan_init_shadow_page_tables(k_start, k_end);
+	if (ret)
+		return ret;
+
+	kasan_update_early_region(k_start, k_cur, __pte(0));
+
+	for (; k_cur < k_end; k_cur += PAGE_SIZE) {
+		pmd_t *pmd = pmd_ptr_k(k_cur);
+		void *va = block + k_cur - k_start;
+		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
+
+		__set_pte_at(&init_mm, k_cur, pte_offset_kernel(pmd, k_cur), pte, 0);
+	}
+	flush_tlb_kernel_range(k_start, k_end);
+	return 0;
+}
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 76d418af4ce8..c42085801c04 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -79,7 +79,7 @@ int __init __weak kasan_init_region(void *start, size_t size)
 	return 0;
 }
 
-static void __init
+void __init
 kasan_update_early_region(unsigned long k_start, unsigned long k_end, pte_t pte)
 {
 	unsigned long k_cur;
-- 
2.25.0

