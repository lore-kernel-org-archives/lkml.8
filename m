Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3248C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F84212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgFZJe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:34:58 -0400
Received: from 8bytes.org ([81.169.241.247]:50210 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgFZJe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:34:58 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 72182391; Fri, 26 Jun 2020 11:34:57 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/mm: Pre-allocate p4d/pud pages for vmalloc area
Date:   Fri, 26 Jun 2020 11:34:50 +0200
Message-Id: <20200626093450.27741-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
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
 arch/x86/mm/init_64.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dbae185511cd..475a4008445b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1238,6 +1238,59 @@ static void __init register_page_bootmem_info(void)
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
+	int count = 0;
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
+			count += 1;
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
+			count += 1;
+		}
+	}
+
+	return;
+
+failed:
+
+	/*
+	 * A failure here is not fatal - If the pages can be allocated later it
+	 * will be synchronized to other page-tables.
+	 */
+	pr_err("Failed to pre-allocate %s pages for vmalloc area\n", lvl);
+}
+
 void __init mem_init(void)
 {
 	pci_iommu_alloc();
@@ -1261,6 +1314,8 @@ void __init mem_init(void)
 	if (get_gate_vma(&init_mm))
 		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
+	preallocate_vmalloc_pages();
+
 	mem_init_print_info(NULL);
 }
 
-- 
2.27.0

