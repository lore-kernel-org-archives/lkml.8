Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00190C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0DA20775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgGAIin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:38:43 -0400
Received: from 8bytes.org ([81.169.241.247]:50922 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgGAIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:38:42 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 07570217; Wed,  1 Jul 2020 10:38:41 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 1/3] x86/mm/64: Pre-allocate p4d/pud pages for vmalloc area
Date:   Wed,  1 Jul 2020 10:38:36 +0200
Message-Id: <20200701083839.19193-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701083839.19193-1-joro@8bytes.org>
References: <20200701083839.19193-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Pre-allocate the page-table pages for the vmalloc area at the level
which needs synchronization on x86. This is P4D for 5-level and PUD
for 4-level paging.

Doing this at boot makes sure all page-tables in the system have these
pages already and do not need to be synchronized at runtime. The
runtime synchronizatin takes the pgd_lock and iterates over all
page-tables in the system, so it can take quite long and is better
avoided.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/init_64.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dbae185511cd..e76bdb001460 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1238,6 +1238,56 @@ static void __init register_page_bootmem_info(void)
 #endif
 }
 
+/*
+ * Pre-allocates page-table pages for the vmalloc area in the kernel page-table.
+ * Only the level which needs to be synchronized between all page-tables is
+ * allocated because the synchronization can be expensive.
+ */
+static void __init preallocate_vmalloc_pages(void)
+{
+	unsigned long addr;
+	const char *lvl;
+
+	for (addr = VMALLOC_START; addr <= VMALLOC_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
+		pgd_t *pgd = pgd_offset_k(addr);
+		p4d_t *p4d;
+		pud_t *pud;
+
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_none(*p4d)) {
+			/* Can only happen with 5-level paging */
+			p4d = p4d_alloc(&init_mm, pgd, addr);
+			if (!p4d) {
+				lvl = "p4d";
+				goto failed;
+			}
+		}
+
+		if (pgtable_l5_enabled())
+			continue;
+
+		pud = pud_offset(p4d, addr);
+		if (pud_none(*pud)) {
+			/* Ends up here only with 4-level paging */
+			pud = pud_alloc(&init_mm, p4d, addr);
+			if (!pud) {
+				lvl = "pud";
+				goto failed;
+			}
+		}
+	}
+
+	return;
+
+failed:
+
+	/*
+	 * The pages have to be there now or they will be missing in
+	 * process page-tables later.
+	 */
+	panic("Failed to pre-allocate %s pages for vmalloc area\n", lvl);
+}
+
 void __init mem_init(void)
 {
 	pci_iommu_alloc();
@@ -1261,6 +1311,8 @@ void __init mem_init(void)
 	if (get_gate_vma(&init_mm))
 		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
+	preallocate_vmalloc_pages();
+
 	mem_init_print_info(NULL);
 }
 
-- 
2.17.1

