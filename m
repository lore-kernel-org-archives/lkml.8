Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E0C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B901206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qc3jDiKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgEDPA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50586 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgEDPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elblu116453;
        Mon, 4 May 2020 14:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=OTEdK+JfE5NUVbySnV/SKcjHMMG3B870KclVub1fY4A=;
 b=Qc3jDiKW5iRpfH4T4cg4am63x66ajlrkrmv2BFaRP08O1ep940mwx/tYWRutDrS60i53
 cQJLoLkzQnh6ewWeKHs2OO+9+2FJuC/VUFdFv1j/Rhlb201fHpvknSbo7Cr13/4l9Pvu
 z1kvUoKtAyBqHQLBrtjFzr8gCme0OsHDV+PhWXEJFPRWSiQZzpGcDBiB9EsCL+7a/6Zq
 t4s6YNtc4ZSuLkUfkOzL64yqQ7Gzyl8NTHZ9mFDY/ddc6jRwqHqo+PpUgPrMePm4IHP+
 NwjBcTljbBPwzLJ7g1KRwFo2jygkIVLBcc5A9XzlPFFRFUwp1AckrrOZPmthVN9eTIYs Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09qyfs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVFx105642;
        Mon, 4 May 2020 14:59:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30sjjw0gea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:58 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044ExvW4001276;
        Mon, 4 May 2020 14:59:57 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:59:56 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 06/13] mm/dpt: Functions to populate a decorated page-table from a VA range
Date:   Mon,  4 May 2020 16:58:03 +0200
Message-Id: <20200504145810.11882-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide functions to copy page-table entries from the kernel page-table
to a decorated page-table for a specified VA range. These functions are
based on the copy_pxx_range() functions defined in mm/memory.c. A first
difference is that a level parameter can be specified to indicate the
page-table level (PGD, P4D, PUD PMD, PTE) at which the copy should be
done. Also functions don't rely on mm or vma, and they don't alter the
source page-table even if an entry is bad. Finally, the VA range start
and size don't need to be page-aligned.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h |   3 +
 arch/x86/mm/dpt.c          | 205 +++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index b9cba051ebf2..85d2c5051acb 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -40,5 +40,8 @@ struct dpt {
 
 extern struct dpt *dpt_create(unsigned int pgt_alignment);
 extern void dpt_destroy(struct dpt *dpt);
+extern int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
+			 enum page_table_level level);
+extern int dpt_map(struct dpt *dpt, void *ptr, unsigned long size);
 
 #endif
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index 7a1b4cd53b03..0e725344b921 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -384,6 +384,211 @@ static int dpt_set_pgd(struct dpt *dpt, pgd_t *pgd, pgd_t pgd_value)
 	return 0;
 }
 
+static int dpt_copy_pte_range(struct dpt *dpt, pmd_t *dst_pmd, pmd_t *src_pmd,
+			      unsigned long addr, unsigned long end)
+{
+	pte_t *src_pte, *dst_pte;
+
+	dst_pte = dpt_pte_alloc(dpt, dst_pmd, addr);
+	if (IS_ERR(dst_pte))
+		return PTR_ERR(dst_pte);
+
+	addr &= PAGE_MASK;
+	src_pte = pte_offset_map(src_pmd, addr);
+
+	do {
+		dpt_set_pte(dpt, dst_pte, *src_pte);
+
+	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr < end);
+
+	return 0;
+}
+
+static int dpt_copy_pmd_range(struct dpt *dpt, pud_t *dst_pud, pud_t *src_pud,
+			      unsigned long addr, unsigned long end,
+			      enum page_table_level level)
+{
+	pmd_t *src_pmd, *dst_pmd;
+	unsigned long next;
+	int err;
+
+	dst_pmd = dpt_pmd_alloc(dpt, dst_pud, addr);
+	if (IS_ERR(dst_pmd))
+		return PTR_ERR(dst_pmd);
+
+	src_pmd = pmd_offset(src_pud, addr);
+
+	do {
+		next = pmd_addr_end(addr, end);
+		if (level == PGT_LEVEL_PMD || pmd_none(*src_pmd) ||
+		    pmd_trans_huge(*src_pmd) || pmd_devmap(*src_pmd)) {
+			err = dpt_set_pmd(dpt, dst_pmd, *src_pmd);
+			if (err)
+				return err;
+			continue;
+		}
+
+		if (!pmd_present(*src_pmd)) {
+			pr_warn("DPT %p: PMD not present for [%lx,%lx]\n",
+				dpt, addr, next - 1);
+			pmd_clear(dst_pmd);
+			continue;
+		}
+
+		err = dpt_copy_pte_range(dpt, dst_pmd, src_pmd, addr, next);
+		if (err) {
+			pr_err("DPT %p: PMD error copying PTE addr=%lx next=%lx\n",
+			       dpt, addr, next);
+			return err;
+		}
+
+	} while (dst_pmd++, src_pmd++, addr = next, addr < end);
+
+	return 0;
+}
+
+static int dpt_copy_pud_range(struct dpt *dpt, p4d_t *dst_p4d, p4d_t *src_p4d,
+			      unsigned long addr, unsigned long end,
+			      enum page_table_level level)
+{
+	pud_t *src_pud, *dst_pud;
+	unsigned long next;
+	int err;
+
+	dst_pud = dpt_pud_alloc(dpt, dst_p4d, addr);
+	if (IS_ERR(dst_pud))
+		return PTR_ERR(dst_pud);
+
+	src_pud = pud_offset(src_p4d, addr);
+
+	do {
+		next = pud_addr_end(addr, end);
+		if (level == PGT_LEVEL_PUD || pud_none(*src_pud) ||
+		    pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+			err = dpt_set_pud(dpt, dst_pud, *src_pud);
+			if (err)
+				return err;
+			continue;
+		}
+
+		err = dpt_copy_pmd_range(dpt, dst_pud, src_pud, addr, next,
+					 level);
+		if (err) {
+			pr_err("DPT %p: PUD error copying PMD addr=%lx next=%lx\n",
+			       dpt, addr, next);
+			return err;
+		}
+
+	} while (dst_pud++, src_pud++, addr = next, addr < end);
+
+	return 0;
+}
+
+static int dpt_copy_p4d_range(struct dpt *dpt, pgd_t *dst_pgd, pgd_t *src_pgd,
+			      unsigned long addr, unsigned long end,
+			      enum page_table_level level)
+{
+	p4d_t *src_p4d, *dst_p4d;
+	unsigned long next;
+	int err;
+
+	dst_p4d = dpt_p4d_alloc(dpt, dst_pgd, addr);
+	if (IS_ERR(dst_p4d))
+		return PTR_ERR(dst_p4d);
+
+	src_p4d = p4d_offset(src_pgd, addr);
+
+	do {
+		next = p4d_addr_end(addr, end);
+		if (level == PGT_LEVEL_P4D || p4d_none(*src_p4d)) {
+			err = dpt_set_p4d(dpt, dst_p4d, *src_p4d);
+			if (err)
+				return err;
+			continue;
+		}
+
+		err = dpt_copy_pud_range(dpt, dst_p4d, src_p4d, addr, next,
+					 level);
+		if (err) {
+			pr_err("DPT %p: P4D error copying PUD addr=%lx next=%lx\n",
+			       dpt, addr, next);
+			return err;
+		}
+
+	} while (dst_p4d++, src_p4d++, addr = next, addr < end);
+
+	return 0;
+}
+
+static int dpt_copy_pgd_range(struct dpt *dpt,
+			      pgd_t *dst_pagetable, pgd_t *src_pagetable,
+			      unsigned long addr, unsigned long end,
+			      enum page_table_level level)
+{
+	pgd_t *src_pgd, *dst_pgd;
+	unsigned long next;
+	int err;
+
+	dst_pgd = pgd_offset_pgd(dst_pagetable, addr);
+	src_pgd = pgd_offset_pgd(src_pagetable, addr);
+
+	do {
+		next = pgd_addr_end(addr, end);
+		if (level == PGT_LEVEL_PGD || pgd_none(*src_pgd)) {
+			err = dpt_set_pgd(dpt, dst_pgd, *src_pgd);
+			if (err)
+				return err;
+			continue;
+		}
+
+		err = dpt_copy_p4d_range(dpt, dst_pgd, src_pgd, addr, next,
+					 level);
+		if (err) {
+			pr_err("DPT %p: PGD error copying P4D addr=%lx next=%lx\n",
+			       dpt, addr, next);
+			return err;
+		}
+
+	} while (dst_pgd++, src_pgd++, addr = next, addr < end);
+
+	return 0;
+}
+
+/*
+ * Copy page table entries from the current page table (i.e. from the
+ * kernel page table) to the specified decorated page-table. The level
+ * parameter specifies the page-table level (PGD, P4D, PUD PMD, PTE)
+ * at which the copy should be done.
+ */
+int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
+		  enum page_table_level level)
+{
+	unsigned long addr = (unsigned long)ptr;
+	unsigned long end = addr + ((unsigned long)size);
+	unsigned long flags;
+	int err;
+
+	pr_debug("DPT %p: MAP %px/%lx/%d\n", dpt, ptr, size, level);
+
+	spin_lock_irqsave(&dpt->lock, flags);
+	err = dpt_copy_pgd_range(dpt, dpt->pagetable, current->mm->pgd,
+				 addr, end, level);
+	spin_unlock_irqrestore(&dpt->lock, flags);
+
+	return err;
+}
+EXPORT_SYMBOL(dpt_map_range);
+
+/*
+ * Copy page-table PTE entries from the current page-table to the
+ * specified decorated page-table.
+ */
+int dpt_map(struct dpt *dpt, void *ptr, unsigned long size)
+{
+	return dpt_map_range(dpt, ptr, size, PGT_LEVEL_PTE);
+}
+EXPORT_SYMBOL(dpt_map);
+
 /*
  * dpt_create - allocate a page-table and create a corresponding
  * decorated page-table. The page-table is allocated and aligned
-- 
2.18.2

