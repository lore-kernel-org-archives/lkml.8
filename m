Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B2EC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16B221473
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Np+ER3Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCZDYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36055 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgCZDY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id d11so5114820qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gPIr3sMHKm0Eg/X2MJ83Q4o7q/Yh6VlfcqjWss6+Y4o=;
        b=Np+ER3XpXP3xatSew72fqYIgywSlmUJyfUzsR7RuwvTnKQrjpyERrNj+EvfXrJyWW9
         W+sxelJuhu1ZSGw+1n9sRGoH4Nu4KbAtfrqTCoUWKeqGQ2bicHmBN1jJWZqMxTNmxRnF
         plOne/JIMjbqnR6Cv0oF8IIkx/ey2DSlmgA0ifhIEVBxx+KhxneyfC8D1ikFhE8Z8Zx3
         I4nzMR2Re4f41bAosqjpj5BpevCMGoQKcH23PFSImbgHc94xQtAEg70FWoX9XFL2tjH9
         0ZDNtowg0Y+IPP+hUNhz2LdLMllsx4K4YruLTGFWoi9ENKz3fnxKMYegeeFuD0vQM7vV
         arLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gPIr3sMHKm0Eg/X2MJ83Q4o7q/Yh6VlfcqjWss6+Y4o=;
        b=NVJc3IC0MLXRPbtW+hEmN694/zZyxIvaj0C+F2Bmd98Dvh5xEG+Z/A3EgvYqi3Wogq
         U2+3OholE1lTmQhHvh4vVsN8xXwD+OpnDtCKwN0avWtot33+bYiFxaANmVZsLtfY5MdN
         C1f6DvX5hQKRk9b+qN9lLU43d9ag87+VWp2jRUkc4cbE7lJ2G033gou09TEegDe8uN64
         ZFK2KaOM7YARkO+8cDibZin8+0Xk1C+ORYtL7phm4OacgKulazM/lQYsCgKpRrzUQ+/c
         SUnCCnzOrh99oz/gEx7mgeTbKeAJAtHO8b+QsBa2ZaUkMiL7Xu4W6pqDBXAN635qsLVg
         s61Q==
X-Gm-Message-State: ANhLgQ2bLPU6rCjW5iEUwit1uSeoPqBHLDHmbN7IUO1MZ8wfhQDF7463
        d5E2HE2paIP3gV/I/lFczNSRJA==
X-Google-Smtp-Source: ADFU+vu2LuSP2xM/wRHh5Sup1U57yJstHfVsFcFOMuWM8U2UTB5lN9kl0Z/AesTxoJRpDvCFmCt3Ng==
X-Received: by 2002:a37:9e88:: with SMTP id h130mr6125408qke.145.1585193067625;
        Wed, 25 Mar 2020 20:24:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:27 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 03/18] arm64: trans_pgd: make trans_pgd_map_page generic
Date:   Wed, 25 Mar 2020 23:24:05 -0400
Message-Id: <20200326032420.27220-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec is going to use a different allocator, so make
trans_pgd_map_page to accept allocator as an argument, and also
kexec is going to use a different map protection, so also pass
it via argument.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/include/asm/trans_pgd.h | 18 ++++++++++++++++--
 arch/arm64/kernel/hibernate.c      | 12 +++++++++++-
 arch/arm64/mm/trans_pgd.c          | 27 +++++++++++++++++++++------
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 23153c13d1ce..ad5194ad178d 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -12,10 +12,24 @@
 #include <linux/types.h>
 #include <asm/pgtable-types.h>
 
+/*
+ * trans_alloc_page
+ *	- Allocator that should return exactly one zeroed page, if this
+ *	 allocator fails, trans_pgd returns -ENOMEM error.
+ *
+ * trans_alloc_arg
+ *	- Passed to trans_alloc_page as an argument
+ */
+
+struct trans_pgd_info {
+	void * (*trans_alloc_page)(void *arg);
+	void *trans_alloc_arg;
+};
+
 int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			  unsigned long end);
 
-int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
-		       pgprot_t pgprot);
+int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
+		       void *page, unsigned long dst_addr, pgprot_t pgprot);
 
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 3d6f0fd73591..607bb1fbc349 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -179,6 +179,11 @@ int arch_hibernation_header_restore(void *addr)
 }
 EXPORT_SYMBOL(arch_hibernation_header_restore);
 
+static void *hibernate_page_alloc(void *arg)
+{
+	return (void *)get_safe_page((gfp_t)(unsigned long)arg);
+}
+
 /*
  * Copies length bytes, starting at src_start into an new page,
  * perform cache maintenance, then maps it at the specified address low
@@ -195,6 +200,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+	};
+
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
 	pgd_t *trans_pgd;
 	int rc;
@@ -209,7 +219,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	if (!trans_pgd)
 		return -ENOMEM;
 
-	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
+	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
 				PAGE_KERNEL_EXEC);
 	if (rc)
 		return rc;
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index d20e48520cef..275a79935d7e 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -25,6 +25,11 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 
+static void *trans_alloc(struct trans_pgd_info *info)
+{
+	return info->trans_alloc_page(info->trans_alloc_arg);
+}
+
 static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 {
 	pte_t pte = READ_ONCE(*src_ptep);
@@ -180,8 +185,18 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 	return rc;
 }
 
-int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
-		       pgprot_t pgprot)
+/*
+ * Add map entry to trans_pgd for a base-size page at PTE level.
+ * info:	contains allocator and its argument
+ * trans_pgd:	page table in which new map is added.
+ * page:	page to be mapped.
+ * dst_addr:	new VA address for the pages
+ * pgprot:	protection for the page.
+ *
+ * Returns 0 on success, and -ENOMEM on failure.
+ */
+int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
+		       void *page, unsigned long dst_addr, pgprot_t pgprot)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -190,7 +205,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
 
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = (void *)get_safe_page(GFP_ATOMIC);
+		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
 		pgd_populate(&init_mm, pgdp, pudp);
@@ -198,7 +213,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = (void *)get_safe_page(GFP_ATOMIC);
+		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
 		pud_populate(&init_mm, pudp, pmdp);
@@ -206,14 +221,14 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = (void *)get_safe_page(GFP_ATOMIC);
+		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
+	set_pte(ptep, pfn_pte(virt_to_pfn(page), pgprot));
 
 	return 0;
 }
-- 
2.17.1

