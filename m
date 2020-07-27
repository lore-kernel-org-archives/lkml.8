Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFCDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FB720714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LTGHdzxL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtNjSuNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgG0Mqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:46:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgG0MqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:46:25 -0400
Date:   Mon, 27 Jul 2020 12:46:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595853981;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qk9rcqcVnAajuP5XyiCDtBaj/43af4bgVnKd+Dq+9Q=;
        b=LTGHdzxLIPZSqwU49kvPG+eoOGumsu2vkjOHPr8RArPaPPqzIsplTWwsahBvywkDQaMBD/
        uT20E7oSNd3zB6e05uitLIyfUTJts5zCpR8NcmnKNGXTaUbcBwois5awly+mH/ptR34DGg
        RVVm37rhHUCn2Rm4Tqabc0tDY5RM2deOHXK1n02nTNo5sfaxaCZFKfPJqAuf3tuSvnnFCg
        Kqn8An1DN1B+a8AlOLDNklDnTyHC9Amh69GqyTDyjuVCThcYUNwLEWwLUvf4vlkQYPsHHE
        Xdf8cFoflsiXGmSs8UYjASehfWNrnTZtT9Kwdx1eHwMVpXrXcbfIBz2pY7y6Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595853981;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qk9rcqcVnAajuP5XyiCDtBaj/43af4bgVnKd+Dq+9Q=;
        b=OtNjSuNu8rOp/HiNOvPg/isb14Uoha5R90dySmrPcyUfm6BAyVIz+P0YFltTxV7cdJdlpU
        9PXwXWhXlg0rGMAA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Pre-allocate P4D/PUD pages for vmalloc area
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200721095953.6218-2-joro@8bytes.org>
References: <20200721095953.6218-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159585398074.4006.9712719046633654602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6eb82f9940267d3af260989d077a2833f588beae
Gitweb:        https://git.kernel.org/tip/6eb82f9940267d3af260989d077a2833f588beae
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 21 Jul 2020 11:59:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 12:32:29 +02:00

x86/mm: Pre-allocate P4D/PUD pages for vmalloc area

Pre-allocate the page-table pages for the vmalloc area at the level
which needs synchronization on x86-64, which is P4D for 5-level and
PUD for 4-level paging.

Doing this at boot makes sure no synchronization of that area is
necessary at runtime. The synchronization takes the pgd_lock and
iterates over all page-tables in the system, so it can take quite long
and is better avoided.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lore.kernel.org/r/20200721095953.6218-2-joro@8bytes.org
---
 arch/x86/mm/init_64.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dbae185..e76bdb0 100644
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
 
