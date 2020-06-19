Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D28DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4541821974
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbgFSPHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:07:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62953 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391525AbgFSPHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:07:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49pMbP6FZrz9v09t;
        Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r47RiLH63nh6; Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49pMbP5XS2z9v09j;
        Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA2588B868;
        Fri, 19 Jun 2020 17:06:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KAW_dSQhF3_R; Fri, 19 Jun 2020 17:06:59 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 645308B879;
        Fri, 19 Jun 2020 17:06:59 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3E4C365AF4; Fri, 19 Jun 2020 15:06:56 +0000 (UTC)
Message-Id: <de47e3d8dd3ef4c5f0a93c5ff19b5af52390cb9c.1592578278.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1592578278.git.christophe.leroy@csgroup.eu>
References: <cover.1592578278.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 5/8] powerpc: Use MODULES_VADDR if defined
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Jun 2020 15:06:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow allocation of modules outside of vmalloc space,
use MODULES_VADDR and MODULES_END when MODULES_VADDR is defined.

Redefine module_alloc() when MODULES_VADDR defined.
Unmap corresponding KASAN shadow memory.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/module.c          | 11 +++++++++++
 arch/powerpc/mm/kasan/kasan_init_32.c |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index df649acb5631..a211b0253cdb 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -86,3 +86,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 	return 0;
 }
+
+#ifdef MODULES_VADDR
+void *module_alloc(unsigned long size)
+{
+	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
+
+	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP_KERNEL,
+				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+#endif
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 0760e1e754e4..f1bc267d42af 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -115,6 +115,12 @@ static void __init kasan_unmap_early_shadow_vmalloc(void)
 	unsigned long k_end = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END);
 
 	kasan_update_early_region(k_start, k_end, __pte(0));
+
+#ifdef MODULES_VADDR
+	k_start = (unsigned long)kasan_mem_to_shadow((void *)MODULES_VADDR);
+	k_end = (unsigned long)kasan_mem_to_shadow((void *)MODULES_END);
+	kasan_update_early_region(k_start, k_end, __pte(0));
+#endif
 }
 
 static void __init kasan_mmu_init(void)
-- 
2.25.0

