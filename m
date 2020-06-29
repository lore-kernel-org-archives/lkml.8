Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEBFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F93A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgF2SvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:51:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1073 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgF2Su4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49wPzT6MWWz9tyrL;
        Mon, 29 Jun 2020 13:15:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MTFRV6BJdewt; Mon, 29 Jun 2020 13:15:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49wPzT5F5Yz9tyqw;
        Mon, 29 Jun 2020 13:15:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1785E8B79E;
        Mon, 29 Jun 2020 13:15:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KIh9pwSoMCUv; Mon, 29 Jun 2020 13:15:24 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ECE6B8B799;
        Mon, 29 Jun 2020 13:15:23 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EC4CE65B29; Mon, 29 Jun 2020 11:15:23 +0000 (UTC)
Message-Id: <b38b52cd8dabbb56fbd6f9219d6f3cdccbb43b44.1593428200.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1593428200.git.christophe.leroy@csgroup.eu>
References: <cover.1593428200.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 4/6] powerpc/32: Set user/kernel boundary at TASK_SIZE
 instead of PAGE_OFFSET
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 29 Jun 2020 11:15:23 +0000 (UTC)
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
 arch/powerpc/include/asm/page.h | 4 +++-
 arch/powerpc/mm/ptdump/ptdump.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index a63fe6f3a0ff..254687258f42 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -255,8 +255,10 @@ static inline bool pfn_valid(unsigned long pfn)
  */
 #ifdef CONFIG_PPC_BOOK3E_64
 #define is_kernel_addr(x)	((x) >= 0x8000000000000000ul)
-#else
+#elif defined(CONFIG_PPC_BOOK3S_64)
 #define is_kernel_addr(x)	((x) >= PAGE_OFFSET)
+#else
+#define is_kernel_addr(x)	((x) >= TASK_SIZE)
 #endif
 
 #ifndef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index de6e05ef871c..9d942136c7be 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -348,7 +348,11 @@ static void populate_markers(void)
 {
 	int i = 0;
 
+#ifdef CONFIG_PPC64
 	address_markers[i++].start_address = PAGE_OFFSET;
+#else
+	address_markers[i++].start_address = TASK_SIZE;
+#endif
 	address_markers[i++].start_address = VMALLOC_START;
 	address_markers[i++].start_address = VMALLOC_END;
 #ifdef CONFIG_PPC64
@@ -385,7 +389,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	struct pg_state st = {
 		.seq = m,
 		.marker = address_markers,
-		.start_address = PAGE_OFFSET,
+		.start_address = IS_ENABLED(CONFIG_PPC64) ? PAGE_OFFSET : TASK_SIZE,
 	};
 
 #ifdef CONFIG_PPC64
@@ -429,7 +433,7 @@ void ptdump_check_wx(void)
 		.seq = NULL,
 		.marker = address_markers,
 		.check_wx = true,
-		.start_address = PAGE_OFFSET,
+		.start_address = IS_ENABLED(CONFIG_PPC64) ? PAGE_OFFSET : TASK_SIZE,
 	};
 
 #ifdef CONFIG_PPC64
-- 
2.25.0

