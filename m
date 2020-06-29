Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59415204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgF2SvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:51:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51094 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbgF2Suz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49wPzR6BNdz9tyrJ;
        Mon, 29 Jun 2020 13:15:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SSMGtPgzPSPM; Mon, 29 Jun 2020 13:15:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49wPzR5HWWz9tyqw;
        Mon, 29 Jun 2020 13:15:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 539078B79E;
        Mon, 29 Jun 2020 13:15:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YWm1IOLnrLpw; Mon, 29 Jun 2020 13:15:22 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DFDEB8B799;
        Mon, 29 Jun 2020 13:15:21 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DE2C765B29; Mon, 29 Jun 2020 11:15:21 +0000 (UTC)
Message-Id: <7ecf5fff1eef67d450e73fc412b6ec3818483d75.1593428200.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1593428200.git.christophe.leroy@csgroup.eu>
References: <cover.1593428200.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/6] powerpc: Use MODULES_VADDR if defined
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 29 Jun 2020 11:15:21 +0000 (UTC)
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

