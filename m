Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8968C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC0F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgDUIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:09:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727889AbgDUIJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:09:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4E462C5A192B1903B93A;
        Tue, 21 Apr 2020 16:09:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 16:09:27 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <gregkh@linuxfoundation.org>, <info@metux.net>,
        <allison@lohutok.net>, <james.morse@arm.com>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] arm32: fix flushcache syscall with device address
Date:   Tue, 21 Apr 2020 16:08:34 +0800
Message-ID: <1587456514-61156-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue has been observed on our Kungpeng916 systems when using a PCI
express GPU. This occurs when a 32 bit application running on a 64 bit
kernel issues a cache flush operation to a memory address that is in
a PCI BAR of the GPU.The results in an illegal operation and
subsequent crash.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Lixin Chen <chenlixin1@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 arch/arm64/kernel/sys_compat.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 3c18c24..6c07944 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -15,12 +15,74 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/hugetlb.h>
 
 #include <asm/cacheflush.h>
 #include <asm/system_misc.h>
 #include <asm/tlbflush.h>
 #include <asm/unistd.h>
 
+static long __check_pt_cacheable(unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pudval_t pudval;
+	pmd_t *pmd;
+	pmdval_t pmdval;
+	pte_t *pte;
+	pteval_t pteval;
+	pgprot_t pgprot;
+
+	spin_lock(&mm->page_table_lock);
+	pgd = pgd_offset(mm, vaddr);
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		goto no_page;
+
+	p4d = p4d_offset(pgd, vaddr);
+	if (p4d_none(*p4d) || unlikely(p4d_bad(*p4d)))
+		goto no_page;
+
+	pud = pud_offset(p4d, vaddr);
+	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+		goto no_page;
+	if (pud_huge(*pud)) {
+		pudval = pud_val(*pud);
+		pgprot = __pgprot(pudval);
+		goto out;
+	}
+
+	pmd = pmd_offset(pud, vaddr);
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		goto no_page;
+	if (pmd_huge(*pmd)) {
+		pmdval = pmd_val(*pmd);
+		pgprot = __pgprot(pmdval);
+		goto out;
+	}
+
+	pte = pte_offset_map(pmd, vaddr);
+	if (!pte_present(*pte) || pte_none(*pte))
+		goto no_page;
+	pteval = pte_val(*pte);
+	pgprot = __pgprot(pteval);
+
+out:
+	pgprot.pgprot &= PTE_ATTRINDX_MASK;
+	if (pgprot.pgprot != PTE_ATTRINDX(MT_NORMAL)) {
+		pr_debug("non-cache page pgprot value=0x%llx.\n",
+			pgprot.pgprot);
+		goto no_page;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return 1;
+
+no_page:
+	spin_unlock(&mm->page_table_lock);
+	return 0;
+}
+
 static long
 __do_compat_cache_op(unsigned long start, unsigned long end)
 {
@@ -32,6 +94,13 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
 		if (fatal_signal_pending(current))
 			return 0;
 
+		 /* do not flush page table is non-cacheable */
+		if (!__check_pt_cacheable(start)) {
+			cond_resched();
+			start += chunk;
+			continue;
+		}
+
 		if (cpus_have_const_cap(ARM64_WORKAROUND_1542419)) {
 			/*
 			 * The workaround requires an inner-shareable tlbi.
-- 
2.7.4

