Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF0C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810822073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xPvV2kRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgEDPBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:01:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47896 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEDPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:01:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9bZ024708;
        Mon, 4 May 2020 15:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=GsovF01BLBXADs9ogvbBPifuM8m9iNcoQzHGafVfZWQ=;
 b=xPvV2kRQBk3Nlt40ptkPC9KCMt9BYKDiPFbPmxAgFBng46AyCQUZGwjiTU6qKYSbb2/2
 l97gXnRDxXCYqavU1u3WK4VV/AZNHg+kfGxqv+J/UnfAaUwh8rNebHujYO2WRXls2iYl
 114hPLOOs7H28p6lsLWjbBNwf/V4UByCs1gZIi34GD0rfCtk65MN8dfHZ9GgAIxOrOQH
 YbevGLfZNHXwh7G256hpoyMmLjxRzr5zQFbAA9OavbQroFIMR8Pkr058C9HRLlW6NzjQ
 /nFSkSW+J/amLXkw+oMe6Yg6XDfeUU1zumGj32R0BB4W1kdlAqeDwSPsfKYeVBCwIPO+ Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30s0tm7dn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVae105750;
        Mon, 4 May 2020 15:00:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjw0hkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F0AuU027632;
        Mon, 4 May 2020 15:00:10 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:00:09 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 09/13] mm/dpt: Functions to clear decorated page-table entries for a VA range
Date:   Mon,  4 May 2020 16:58:06 +0200
Message-Id: <20200504145810.11882-10-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide functions to clear page-table entries in a decorated page-table
for a specified VA range. Functions also check that the clearing
effectively happens in the decorated page-table and there is no crossing
of the decorated page-table boundary (through references to another page
table), so that another page table is not modified by mistake.

As information (address, size, page-table level) about VA ranges mapped
to the decorated page-table is tracked, clearing is done with just
specifying the start address of the range.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h |   1 +
 arch/x86/mm/dpt.c          | 135 +++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index 0d74afb10141..01727ef0577e 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -56,6 +56,7 @@ extern void dpt_destroy(struct dpt *dpt);
 extern int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
 			 enum page_table_level level);
 extern int dpt_map(struct dpt *dpt, void *ptr, unsigned long size);
+extern void dpt_unmap(struct dpt *dpt, void *ptr);
 
 static inline int dpt_map_module(struct dpt *dpt, char *module_name)
 {
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index 12eb0d794d84..c495c9b59b3e 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -636,6 +636,141 @@ int dpt_map(struct dpt *dpt, void *ptr, unsigned long size)
 }
 EXPORT_SYMBOL(dpt_map);
 
+static void dpt_clear_pte_range(struct dpt *dpt, pmd_t *pmd,
+				unsigned long addr, unsigned long end)
+{
+	pte_t *pte;
+
+	pte = dpt_pte_offset(dpt, pmd, addr);
+	if (IS_ERR(pte))
+		return;
+
+	do {
+		pte_clear(NULL, addr, pte);
+	} while (pte++, addr += PAGE_SIZE, addr < end);
+}
+
+static void dpt_clear_pmd_range(struct dpt *dpt, pud_t *pud,
+				unsigned long addr, unsigned long end,
+				enum page_table_level level)
+{
+	unsigned long next;
+	pmd_t *pmd;
+
+	pmd = dpt_pmd_offset(dpt, pud, addr);
+	if (IS_ERR(pmd))
+		return;
+
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (level == PGT_LEVEL_PMD || pmd_trans_huge(*pmd) ||
+		    pmd_devmap(*pmd) || !pmd_present(*pmd)) {
+			pmd_clear(pmd);
+			continue;
+		}
+		dpt_clear_pte_range(dpt, pmd, addr, next);
+	} while (pmd++, addr = next, addr < end);
+}
+
+static void dpt_clear_pud_range(struct dpt *dpt, p4d_t *p4d,
+				unsigned long addr, unsigned long end,
+				enum page_table_level level)
+{
+	unsigned long next;
+	pud_t *pud;
+
+	pud = dpt_pud_offset(dpt, p4d, addr);
+	if (IS_ERR(pud))
+		return;
+
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none(*pud))
+			continue;
+		if (level == PGT_LEVEL_PUD || pud_trans_huge(*pud) ||
+		    pud_devmap(*pud)) {
+			pud_clear(pud);
+			continue;
+		}
+		dpt_clear_pmd_range(dpt, pud, addr, next, level);
+	} while (pud++, addr = next, addr < end);
+}
+
+static void dpt_clear_p4d_range(struct dpt *dpt, pgd_t *pgd,
+				unsigned long addr, unsigned long end,
+				enum page_table_level level)
+{
+	unsigned long next;
+	p4d_t *p4d;
+
+	p4d = dpt_p4d_offset(dpt, pgd, addr);
+	if (IS_ERR(p4d))
+		return;
+
+	do {
+		next = p4d_addr_end(addr, end);
+		if (p4d_none(*p4d))
+			continue;
+		if (level == PGT_LEVEL_P4D) {
+			p4d_clear(p4d);
+			continue;
+		}
+		dpt_clear_pud_range(dpt, p4d, addr, next, level);
+	} while (p4d++, addr = next, addr < end);
+}
+
+static void dpt_clear_pgd_range(struct dpt *dpt, pgd_t *pagetable,
+				unsigned long addr, unsigned long end,
+				enum page_table_level level)
+{
+	unsigned long next;
+	pgd_t *pgd;
+
+	pgd = pgd_offset_pgd(pagetable, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		if (level == PGT_LEVEL_PGD) {
+			pgd_clear(pgd);
+			continue;
+		}
+		dpt_clear_p4d_range(dpt, pgd, addr, next, level);
+	} while (pgd++, addr = next, addr < end);
+}
+
+/*
+ * Clear page table entries in the specified decorated page-table.
+ */
+void dpt_unmap(struct dpt *dpt, void *ptr)
+{
+	struct dpt_range_mapping *range_mapping;
+	unsigned long addr, end;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dpt->lock, flags);
+
+	range_mapping = dpt_get_range_mapping(dpt, ptr);
+	if (!range_mapping) {
+		pr_debug("DPT %p: UNMAP %px - not mapped\n", dpt, ptr);
+		goto done;
+	}
+
+	addr = (unsigned long)range_mapping->ptr;
+	end = addr + range_mapping->size;
+	pr_debug("DPT %p: UNMAP %px/%lx/%d\n", dpt, ptr,
+		 range_mapping->size, range_mapping->level);
+	dpt_clear_pgd_range(dpt, dpt->pagetable, addr, end,
+			    range_mapping->level);
+	list_del(&range_mapping->list);
+	kfree(range_mapping);
+done:
+	spin_unlock_irqrestore(&dpt->lock, flags);
+}
+EXPORT_SYMBOL(dpt_unmap);
+
 /*
  * dpt_create - allocate a page-table and create a corresponding
  * decorated page-table. The page-table is allocated and aligned
-- 
2.18.2

