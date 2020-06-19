Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EF0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7C421532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbgFSQJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:09:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22758 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391526AbgFSPHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:07:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49pMbP6PQgz9v09v;
        Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VrREeVhTjvlf; Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49pMbP5cRmz9v09s;
        Fri, 19 Jun 2020 17:06:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DAD338B87B;
        Fri, 19 Jun 2020 17:06:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id j7mciZV-qZtK; Fri, 19 Jun 2020 17:06:59 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69DCD8B87D;
        Fri, 19 Jun 2020 17:06:59 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5685B65B16; Fri, 19 Jun 2020 15:06:59 +0000 (UTC)
Message-Id: <ee7a475b12be04568e2433738a15c0c7dde01c45.1592578278.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1592578278.git.christophe.leroy@csgroup.eu>
References: <cover.1592578278.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 8/8] powerpc/32s: Use dedicated segment for modules with
 STRICT_KERNEL_RWX
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Jun 2020 15:06:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When STRICT_KERNEL_RWX is set, we want to set NX bit on vmalloc
segments. But modules require exec.

Use a dedicated segment for modules. There is not much space
above kernel, and we don't waste vmalloc space to do alignment.
Therefore, we take the segment before PAGE_OFFSET for modules.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h | 15 +++++----------
 arch/powerpc/mm/ptdump/ptdump.c              |  8 ++++++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9fa23eb320ff..2ba6ac9da46f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1198,6 +1198,7 @@ config TASK_SIZE_BOOL
 config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
 	default "0x80000000" if PPC_8xx
+	default "0xb0000000" if PPC_BOOK3S_32 && STRICT_KERNEL_RWX
 	default "0xc0000000"
 endmenu
 
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 224912432821..36443cda8dcf 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -184,17 +184,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
 
-/*
- * With CONFIG_STRICT_KERNEL_RWX, kernel segments are set NX. But when modules
- * are used, NX cannot be set on VMALLOC space. So vmalloc VM space and linear
- * memory shall not share segments.
- */
-#if defined(CONFIG_STRICT_KERNEL_RWX) && defined(CONFIG_MODULES)
-#define VMALLOC_START ((ALIGN((long)high_memory, 256L << 20) + VMALLOC_OFFSET) & \
-		       ~(VMALLOC_OFFSET - 1))
-#else
 #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
-#endif
 
 #ifdef CONFIG_KASAN_VMALLOC
 #define VMALLOC_END	ALIGN_DOWN(ioremap_bot, PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
@@ -202,6 +192,11 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
 #define VMALLOC_END	ioremap_bot
 #endif
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+#define MODULES_END	ALIGN_DOWN(PAGE_OFFSET, SZ_256M)
+#define MODULES_VADDR	(MODULES_END - SZ_256M)
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
 #include <linux/threads.h>
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index e995f2e9e9f7..51aab1b7be31 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -74,6 +74,10 @@ struct addr_marker {
 
 static struct addr_marker address_markers[] = {
 	{ 0,	"Start of kernel VM" },
+#ifdef MODULES_VADDR
+	{ 0,	"modules start" },
+	{ 0,	"modules end" },
+#endif
 	{ 0,	"vmalloc() Area" },
 	{ 0,	"vmalloc() End" },
 #ifdef CONFIG_PPC64
@@ -352,6 +356,10 @@ static void populate_markers(void)
 	int i = 0;
 
 	address_markers[i++].start_address = TASK_SIZE;
+#ifdef MODULES_VADDR
+	address_markers[i++].start_address = MODULES_VADDR;
+	address_markers[i++].start_address = MODULES_END;
+#endif
 	address_markers[i++].start_address = VMALLOC_START;
 	address_markers[i++].start_address = VMALLOC_END;
 #ifdef CONFIG_PPC64
-- 
2.25.0

