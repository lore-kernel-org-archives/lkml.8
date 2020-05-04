Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2175BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDE4206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aiDhQg48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgEDPC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:02:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53264 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgEDPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:02:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbML116466;
        Mon, 4 May 2020 15:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=mpXXd7uEdJ6fmVl0iUxBjNXdKzD8MJRJwDBOk9pZnT0=;
 b=aiDhQg48J1nTnS19xiB7JOTozw6IIJ6RDVQKmmdGkIqRuLpW8s76/frddUZtuAuBUjPy
 ElA+W64NLBZsxkRyNsTHCo/mD+yeVv56uxVANbu6S2URk2CukVo65oH/WwumHiwC9XLc
 QLGhAmMgjaDqXIMK2tNJ7Vprz/i/aInfcGOScTAJSLJvVJE6wJFVgf9hUJd/N0KarHKf
 iKzeHffR/dJ89EaaBaWr3bOJ5r6XSVp4fiR+K8C2nCHgNcngD6TILIBhQQQ8MlZsG6z+
 pXc71NSWiGFr7xuMH6ygsa1m/aagaunI0X0rkwg6+vL6vOEyqgIYgPdHioAuVPhoN8i8 aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09qyg76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:01:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbCv053434;
        Mon, 4 May 2020 14:59:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30t1r2esd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:42 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044ExeBx022128;
        Mon, 4 May 2020 14:59:40 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:59:40 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 02/13] mm/dpt: Track buffers allocated for a decorated page-table
Date:   Mon,  4 May 2020 16:57:59 +0200
Message-Id: <20200504145810.11882-3-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions to track buffers allocated for a decorated page-table.
A page-table can have direct references to the kernel page table, at
different levels (PGD, P4D, PUD, PMD). When freeing a page-table, we
should make sure that we free parts actually allocated for the decorated
page-table, and not parts of the kernel page table referenced from the
page-table. To do so, we will keep track of buffers when building the
page-table.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h | 21 ++++++++++
 arch/x86/mm/dpt.c          | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index 1da4d43d5e94..b9cba051ebf2 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -3,9 +3,18 @@
 #define ARCH_X86_MM_DPT_H
 
 #include <linux/spinlock.h>
+#include <linux/xarray.h>
 
 #include <asm/pgtable.h>
 
+enum page_table_level {
+	PGT_LEVEL_PTE,
+	PGT_LEVEL_PMD,
+	PGT_LEVEL_PUD,
+	PGT_LEVEL_P4D,
+	PGT_LEVEL_PGD
+};
+
 /*
  * A decorated page-table (dpt) encapsulates a native page-table (e.g.
  * a PGD) and maintain additional attributes related to this page-table.
@@ -15,6 +24,18 @@ struct dpt {
 	pgd_t			*pagetable;	/* the actual page-table */
 	unsigned int		alignment;	/* page-table alignment */
 
+	/*
+	 * A page-table can have direct references to another page-table,
+	 * at different levels (PGD, P4D, PUD, PMD). When freeing or
+	 * modifying a page-table, we should make sure that we free/modify
+	 * parts effectively allocated to the actual page-table, and not
+	 * parts of another page-table referenced from this page-table.
+	 *
+	 * To do so, the backend_pages XArray is used to keep track of pages
+	 * used for this page-table.
+	 */
+	struct xarray		backend_pages;		/* page-table pages */
+	unsigned long		backend_pages_count;	/* pages count */
 };
 
 extern struct dpt *dpt_create(unsigned int pgt_alignment);
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index 333e259c5b7f..6df2d4fde8ec 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -8,6 +8,80 @@
 
 #include <asm/dpt.h>
 
+/*
+ * Get the pointer to the beginning of a page table directory from a page
+ * table directory entry.
+ */
+#define DPT_BACKEND_PAGE_ALIGN(entry)	\
+	((typeof(entry))(((unsigned long)(entry)) & PAGE_MASK))
+
+/*
+ * Pages used to build a page-table are stored in the backend_pages XArray.
+ * Each entry in the array is a logical OR of the page address and the page
+ * table level (PTE, PMD, PUD, P4D) this page is used for in the page-table.
+ *
+ * As a page address is aligned with PAGE_SIZE, we have plenty of space
+ * for storing the page table level (which is a value between 0 and 4) in
+ * the low bits of the page address.
+ *
+ */
+
+#define DPT_BACKEND_PAGE_ENTRY(addr, level)	\
+	((typeof(addr))(((unsigned long)(addr)) | ((unsigned long)(level))))
+#define DPT_BACKEND_PAGE_ADDR(entry)		\
+	((void *)(((unsigned long)(entry)) & PAGE_MASK))
+#define DPT_BACKEND_PAGE_LEVEL(entry)		\
+	((enum page_table_level)(((unsigned long)(entry)) & ~PAGE_MASK))
+
+static int dpt_add_backend_page(struct dpt *dpt, void *addr,
+				enum page_table_level level)
+{
+	unsigned long index;
+	void *old_entry;
+
+	if ((!addr) || ((unsigned long)addr) & ~PAGE_MASK)
+		return -EINVAL;
+
+	lockdep_assert_held(&dpt->lock);
+	index = dpt->backend_pages_count;
+
+	old_entry = xa_store(&dpt->backend_pages, index,
+			     DPT_BACKEND_PAGE_ENTRY(addr, level),
+			     GFP_KERNEL);
+	if (xa_is_err(old_entry))
+		return xa_err(old_entry);
+	if (old_entry)
+		return -EBUSY;
+
+	dpt->backend_pages_count++;
+
+	return 0;
+}
+
+/*
+ * Check if an offset in the page-table is valid, i.e. check that the
+ * offset is on a page effectively belonging to the page-table.
+ */
+static bool dpt_valid_offset(struct dpt *dpt, void *offset)
+{
+	unsigned long index;
+	void *addr, *entry;
+	bool valid;
+
+	addr = DPT_BACKEND_PAGE_ALIGN(offset);
+	valid = false;
+
+	lockdep_assert_held(&dpt->lock);
+	xa_for_each(&dpt->backend_pages, index, entry) {
+		if (DPT_BACKEND_PAGE_ADDR(entry) == addr) {
+			valid = true;
+			break;
+		}
+	}
+
+	return valid;
+}
+
 /*
  * dpt_create - allocate a page-table and create a corresponding
  * decorated page-table. The page-table is allocated and aligned
@@ -41,6 +115,7 @@ struct dpt *dpt_create(unsigned int pgt_alignment)
 	dpt->alignment = pgt_alignment;
 
 	spin_lock_init(&dpt->lock);
+	xa_init(&dpt->backend_pages);
 
 	return dpt;
 }
@@ -50,10 +125,17 @@ void dpt_destroy(struct dpt *dpt)
 {
 	unsigned int pgt_alignment;
 	unsigned int alloc_order;
+	unsigned long index;
+	void *entry;
 
 	if (!dpt)
 		return;
 
+	if (dpt->backend_pages_count) {
+		xa_for_each(&dpt->backend_pages, index, entry)
+			free_page((unsigned long)DPT_BACKEND_PAGE_ADDR(entry));
+	}
+
 	if (dpt->pagetable) {
 		pgt_alignment = dpt->alignment;
 		alloc_order = round_up(PAGE_SIZE + pgt_alignment,
-- 
2.18.2

