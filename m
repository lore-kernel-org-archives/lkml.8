Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C00C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0E121532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394294AbgFSQJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:09:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40200 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391500AbgFSPG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:06:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49pMbJ5SR2z9v09n;
        Fri, 19 Jun 2020 17:06:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HWsNtuMNdH_C; Fri, 19 Jun 2020 17:06:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49pMbJ4gGDz9v09j;
        Fri, 19 Jun 2020 17:06:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1ECC8B87B;
        Fri, 19 Jun 2020 17:06:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9KI_eDtvs7VY; Fri, 19 Jun 2020 17:06:54 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E0178B879;
        Fri, 19 Jun 2020 17:06:54 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2FD8265AF4; Fri, 19 Jun 2020 15:06:54 +0000 (UTC)
Message-Id: <c634cadd3ef2c9667838c4fe2bd425a72c8fcbd5.1592578278.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1592578278.git.christophe.leroy@csgroup.eu>
References: <cover.1592578278.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/8] powerpc: Set user/kernel boundary at TASK_SIZE instead
 of PAGE_OFFSET
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Jun 2020 15:06:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space stops at TASK_SIZE. At the moment, kernel space starts
at PAGE_OFFSET.

In order to use space between TASK_SIZE and PAGE_OFFSET for modules,
make TASK_SIZE the limit between user and kernel space.

Note that fault.c already considers TASK_SIZE as the boundary between
user and kernel space.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/page.h | 2 +-
 arch/powerpc/mm/ptdump/ptdump.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index a63fe6f3a0ff..352a2b80d505 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -256,7 +256,7 @@ static inline bool pfn_valid(unsigned long pfn)
 #ifdef CONFIG_PPC_BOOK3E_64
 #define is_kernel_addr(x)	((x) >= 0x8000000000000000ul)
 #else
-#define is_kernel_addr(x)	((x) >= PAGE_OFFSET)
+#define is_kernel_addr(x)	((x) >= TASK_SIZE)
 #endif
 
 #ifndef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index b71cc628facd..e995f2e9e9f7 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -351,7 +351,7 @@ static void populate_markers(void)
 {
 	int i = 0;
 
-	address_markers[i++].start_address = PAGE_OFFSET;
+	address_markers[i++].start_address = TASK_SIZE;
 	address_markers[i++].start_address = VMALLOC_START;
 	address_markers[i++].start_address = VMALLOC_END;
 #ifdef CONFIG_PPC64
@@ -388,7 +388,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	struct pg_state st = {
 		.seq = m,
 		.marker = address_markers,
-		.start_address = PAGE_OFFSET,
+		.start_address = TASK_SIZE,
 	};
 
 #ifdef CONFIG_PPC64
@@ -432,7 +432,7 @@ void ptdump_check_wx(void)
 		.seq = NULL,
 		.marker = address_markers,
 		.check_wx = true,
-		.start_address = PAGE_OFFSET,
+		.start_address = TASK_SIZE,
 	};
 
 #ifdef CONFIG_PPC64
-- 
2.25.0

