Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7373C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C749120729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGUKAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:00:08 -0400
Received: from 8bytes.org ([81.169.241.247]:58336 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgGUKAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:00:08 -0400
Received: from cap.home.8bytes.org (p5b006776.dip0.t-ipconnect.de [91.0.103.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id CEA732C8;
        Tue, 21 Jul 2020 12:00:06 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] x86/mm: Pre-allocate p4d/pud pages for vmalloc area
Date:   Tue, 21 Jul 2020 11:59:51 +0200
Message-Id: <20200721095953.6218-2-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721095953.6218-1-joro@8bytes.org>
References: <20200721095953.6218-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Pre-allocate the page-table pages for the vmalloc area at the level
which needs synchronization on x86-64, which is P4D for 5-level and
PUD for 4-level paging.

Doing this at boot makes sure all no synchronization of that area is
necessary at runtime. The synchronization takes the pgd_lock and
iterates over all page-tables in the system, so it can take quite long
and is better avoided.

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
2.27.0

