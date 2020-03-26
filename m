Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3422074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VAs1MfJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgCZDZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:25:16 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38592 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgCZDYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:34 -0400
Received: by mail-qv1-f66.google.com with SMTP id p60so2273380qva.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=79vWRy0i2YzlhYfgfL3OtU1rYDrCPAZhCt4GY/kzDbU=;
        b=VAs1MfJjSDIrtNcFz+9Q8ZT25hpAwOX3ydp9C6411J1KeAiqQSaBJET61DnDYN3t65
         OYNb9gVZ28UO29s5RYt0qHgipHiOb3Q9omuV0F5AN7DLqWtLjlwf35lvcvQatExrmN3B
         ECWzq1uNVYMAPFYt/TdrccT/38W9l+FiHi9uhtiGQWz4gQWgRq/vCZV2OY2q/w4yxq++
         Htuzp2xVaiP3nnw5QfI2ieMT/G0YOppL9HfjhJgqkXGCyRXF913QC/od/grwE2IsXK8p
         dDwF1EwTWXoUCBsMKoSg+Sh2/EVFGkS5wI5qzfCpo3EK3pHi9rRNy09j9FGaLH3SIyq7
         +XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=79vWRy0i2YzlhYfgfL3OtU1rYDrCPAZhCt4GY/kzDbU=;
        b=eOhRuBBzH1dTrspLlDfHn2XRSDPFMgw9ljRtjizPYKbOLFJoVNCLgJx2QSDDxKLZpx
         VQaADR9/8W72TueVY5KSrFKMJJJruuVQAASp63D2Tk3Uzcxs3nP165olqfvh0qoZf82F
         3MsqP1HqH9lOBMrWeDMn3AkdFMysWFyPQFie/nmHbTZn1alwjaWFFyyNmPHfwwxR8HcN
         EqtBJTZy0HWV/f2R0bDPtJIrx2D5s4mofoFr6f5lSvd4pjYGxHXfMJLUO3HHwIDZbqTO
         JAWUrxVRIhp0YjFTHvNFb+qO5XWl0c5Wcu1Hp+5czl2m4GPvvkvWp5lovbhIuxbNyaOO
         0yDQ==
X-Gm-Message-State: ANhLgQ231rdjtw3DzBBlLWG8o5FMrewTKpGv3XOyCFNXhSq7Bo3p80mc
        q5dwCdT52t312giC0DF6s1Zamw==
X-Google-Smtp-Source: ADFU+vs04jZQgyyzWnthBR9uVyhpJZVnOP1cEoH7ghqntqa9P123xXiIbPAEb81z75icBIeZHSMlHA==
X-Received: by 2002:ad4:4862:: with SMTP id u2mr6360876qvy.67.1585193073744;
        Wed, 25 Mar 2020 20:24:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:33 -0700 (PDT)
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
Subject: [PATCH v9 07/18] arm64: trans_pgd: hibernate: idmap the single page that holds the copy page routines
Date:   Wed, 25 Mar 2020 23:24:09 -0400
Message-Id: <20200326032420.27220-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

To resume from hibernate, the contents of memory are restored from
the swap image. This may overwrite any page, including the running
kernel and its page tables.

Hibernate copies the code it uses to do the restore into a single
page that it knows won't be overwritten, and maps it with page tables
built from pages that won't be overwritten.

Today the address it uses for this mapping is arbitrary, but to allow
kexec to reuse this code, it needs to be idmapped. To idmap the page
we must avoid the kernel helpers that have VA_BITS baked in.

Convert create_single_mapping() to take a single PA, and idmap it.
The page tables are built in the reverse order to normal using
pfn_pte() to stir in any bits between 52:48. T0SZ is always increased
to cover 48bits, or 52 if the copy code has bits 52:48 in its PA.

Pasha: The original patch from James
inux-arm-kernel/20200115143322.214247-4-james.morse@arm.com
Adopted it to trans_pgd, so it can be commonly used by both Kexec
and Hibernate. Some minor clean-ups.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  3 ++
 arch/arm64/kernel/hibernate.c      | 32 +++++++------------
 arch/arm64/mm/trans_pgd.c          | 49 ++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 97a7ea73b289..4912d3caf0ca 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -32,4 +32,7 @@ int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
 int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		       void *page, unsigned long dst_addr, pgprot_t pgprot);
 
+int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
+			 unsigned long *t0sz, void *page);
+
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 95e00536aa67..784aa01bb4bd 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -197,7 +197,6 @@ static void *hibernate_page_alloc(void *arg)
  * page system.
  */
 static int create_safe_exec_page(void *src_start, size_t length,
-				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
 	struct trans_pgd_info trans_info = {
@@ -206,7 +205,8 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	};
 
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
-	pgd_t *trans_pgd;
+	phys_addr_t trans_ttbr0;
+	unsigned long t0sz;
 	int rc;
 
 	if (!page)
@@ -214,13 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
-
-	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_pgd)
-		return -ENOMEM;
-
-	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
-				PAGE_KERNEL_EXEC);
+	rc = trans_pgd_idmap_page(&trans_info, &trans_ttbr0, &t0sz, page);
 	if (rc)
 		return rc;
 
@@ -233,12 +227,15 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI
 	 * runtime services), while for a userspace-driven test_resume cycle it
 	 * points to userspace page tables (and we must point it at a zero page
-	 * ourselves). Elsewhere we only (un)install the idmap with preemption
-	 * disabled, so T0SZ should be as required regardless.
+	 * ourselves).
+	 *
+	 * We change T0SZ as part of installing the idmap. This is undone by
+	 * cpu_uninstall_idmap() in __cpu_suspend_exit().
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
+	__cpu_set_tcr_t0sz(t0sz);
+	write_sysreg(trans_ttbr0, ttbr0_el1);
 	isb();
 
 	*phys_dst_addr = virt_to_phys(page);
@@ -319,7 +316,6 @@ int swsusp_arch_resume(void)
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
-	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
 	struct trans_pgd_info trans_info = {
@@ -347,19 +343,13 @@ int swsusp_arch_resume(void)
 		return -ENOMEM;
 	}
 
-	/*
-	 * Locate the exit code in the bottom-but-one page, so that *NULL
-	 * still has disastrous affects.
-	 */
-	hibernate_exit = (void *)PAGE_SIZE;
 	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
 	/*
 	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
 	 * a new set of ttbr0 page tables and load them.
 	 */
 	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
-				   (unsigned long)hibernate_exit,
-				   &phys_hibernate_exit);
+				   (phys_addr_t *)&hibernate_exit);
 	if (rc) {
 		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
 		return rc;
@@ -378,7 +368,7 @@ int swsusp_arch_resume(void)
 	 * We can skip this step if we booted at EL1, or are running with VHE.
 	 */
 	if (el2_reset_needed()) {
-		phys_addr_t el2_vectors = phys_hibernate_exit;  /* base */
+		phys_addr_t el2_vectors = (phys_addr_t)hibernate_exit;
 		el2_vectors += hibernate_el2_vectors -
 			       __hibernate_exit_text_start;     /* offset */
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 37d7d1c60f65..c2517d1af2af 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -242,3 +242,52 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 
 	return 0;
 }
+
+/*
+ * The page we want to idmap may be outside the range covered by VA_BITS that
+ * can be built using the kernel's p?d_populate() helpers. As a one off, for a
+ * single page, we build these page tables bottom up and just assume that will
+ * need the maximum T0SZ.
+ *
+ * Returns 0 on success, and -ENOMEM on failure.
+ * On success trans_ttbr0 contains page table with idmapped page, t0sz is set to
+ * maxumum T0SZ for this page.
+ */
+int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
+			 unsigned long *t0sz, void *page)
+{
+	phys_addr_t dst_addr = virt_to_phys(page);
+	unsigned long pfn = __phys_to_pfn(dst_addr);
+	int max_msb = (dst_addr & GENMASK(52, 48)) ? 51 : 47;
+	int bits_mapped = PAGE_SHIFT - 4;
+	unsigned long level_mask, prev_level_entry, *levels[4];
+	int this_level, index, level_lsb, level_msb;
+
+	dst_addr &= PAGE_MASK;
+	prev_level_entry = pte_val(pfn_pte(pfn, PAGE_KERNEL_EXEC));
+
+	for (this_level = 3; this_level >= 0; this_level--) {
+		levels[this_level] = trans_alloc(info);
+		if (!levels[this_level])
+			return -ENOMEM;
+
+		level_lsb = ARM64_HW_PGTABLE_LEVEL_SHIFT(this_level);
+		level_msb = min(level_lsb + bits_mapped, max_msb);
+		level_mask = GENMASK_ULL(level_msb, level_lsb);
+
+		index = (dst_addr & level_mask) >> level_lsb;
+		*(levels[this_level] + index) = prev_level_entry;
+
+		pfn = virt_to_pfn(levels[this_level]);
+		prev_level_entry = pte_val(pfn_pte(pfn,
+						   __pgprot(PMD_TYPE_TABLE)));
+
+		if (level_msb == max_msb)
+			break;
+	}
+
+	*trans_ttbr0 = phys_to_ttbr(__pfn_to_phys(pfn));
+	*t0sz = TCR_T0SZ(max_msb + 1);
+
+	return 0;
+}
-- 
2.17.1

