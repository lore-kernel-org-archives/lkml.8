Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2C2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7364321582
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k3nxkLIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgEDPAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50830 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEDPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbNQ116459;
        Mon, 4 May 2020 15:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=K4WuIRzv6NwwGlBbEMaCvqf1ii2XJ+sibBt35OcpXCQ=;
 b=k3nxkLIW+pEF/Y1ilQRHwL3pob0Wn2rsWjG7ffWhhxZMxX3ArXWlk53vjW8dlpCraVDy
 imbEqF68auq3T0FZwjgk1kOkrKy/xfFtKr8jSV6L5g6z3OAzfru1i2z0TUkJfh+CpwQT
 NyFQkYbHWh8Ywk5aRwA/AEWEijwE2FmJCgklc2rjAOQ8pS7HE3+3PhS6s4xKa++fb5Wo
 oKeG1oYIf/DWcAAq7TKZoX3+2CdjEab8V32ZbOM9qAcB/X4opRlwbftrikc5VTofvRq0
 LA+86v60a5hycNhDTXyeOZ6fHqTWUW3ZTqYMQmC294WtBK+U6JXpvL08u/sDuSUbsIiY Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09qyftp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElLhg033730;
        Mon, 4 May 2020 15:00:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnaw2ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:07 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F06lt001343;
        Mon, 4 May 2020 15:00:06 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:00:05 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 08/13] mm/dpt: Keep track of VA ranges mapped in a decorated page-table
Date:   Mon,  4 May 2020 16:58:05 +0200
Message-Id: <20200504145810.11882-9-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
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

Add functions to keep track of VA ranges mapped in a decorated page-table.
This will be used when unmapping to ensure the same range is unmapped,
at the same page-table level. This will also be used to handle mapping
and unmapping of overlapping VA ranges.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h | 12 ++++++++
 arch/x86/mm/dpt.c          | 60 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index 5a38d97a70a8..0d74afb10141 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -16,6 +16,17 @@ enum page_table_level {
 	PGT_LEVEL_PGD
 };
 
+/*
+ * Structure to keep track of address ranges mapped into a decorated
+ * page-table.
+ */
+struct dpt_range_mapping {
+	struct list_head list;
+	void *ptr;			/* range start address */
+	size_t size;			/* range size */
+	enum page_table_level level;	/* mapping level */
+};
+
 /*
  * A decorated page-table (dpt) encapsulates a native page-table (e.g.
  * a PGD) and maintain additional attributes related to this page-table.
@@ -24,6 +35,7 @@ struct dpt {
 	spinlock_t		lock;		/* protect all attributes */
 	pgd_t			*pagetable;	/* the actual page-table */
 	unsigned int		alignment;	/* page-table alignment */
+	struct list_head	mapping_list;	/* list of VA range mapping */
 
 	/*
 	 * A page-table can have direct references to another page-table,
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index 0e725344b921..12eb0d794d84 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -59,6 +59,24 @@ static int dpt_add_backend_page(struct dpt *dpt, void *addr,
 	return 0;
 }
 
+/*
+ * Return the range mapping starting at the specified address, or NULL if
+ * no such range is found.
+ */
+static struct dpt_range_mapping *dpt_get_range_mapping(struct dpt *dpt,
+						       void *ptr)
+{
+	struct dpt_range_mapping *range;
+
+	lockdep_assert_held(&dpt->lock);
+	list_for_each_entry(range, &dpt->mapping_list, list) {
+		if (range->ptr == ptr)
+			return range;
+	}
+
+	return NULL;
+}
+
 /*
  * Check if an offset in the page-table is valid, i.e. check that the
  * offset is on a page effectively belonging to the page-table.
@@ -563,6 +581,7 @@ static int dpt_copy_pgd_range(struct dpt *dpt,
 int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
 		  enum page_table_level level)
 {
+	struct dpt_range_mapping *range_mapping;
 	unsigned long addr = (unsigned long)ptr;
 	unsigned long end = addr + ((unsigned long)size);
 	unsigned long flags;
@@ -571,8 +590,36 @@ int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
 	pr_debug("DPT %p: MAP %px/%lx/%d\n", dpt, ptr, size, level);
 
 	spin_lock_irqsave(&dpt->lock, flags);
+
+	/* check if the range is already mapped */
+	range_mapping = dpt_get_range_mapping(dpt, ptr);
+	if (range_mapping) {
+		pr_debug("DPT %p: MAP %px/%lx/%d already mapped\n",
+			 dpt, ptr, size, level);
+		err = -EBUSY;
+		goto done;
+	}
+
+	/* map new range */
+	range_mapping = kmalloc(sizeof(*range_mapping), GFP_KERNEL);
+	if (!range_mapping) {
+		err = -ENOMEM;
+		goto done;
+	}
+
 	err = dpt_copy_pgd_range(dpt, dpt->pagetable, current->mm->pgd,
 				 addr, end, level);
+	if (err) {
+		kfree(range_mapping);
+		goto done;
+	}
+
+	INIT_LIST_HEAD(&range_mapping->list);
+	range_mapping->ptr = ptr;
+	range_mapping->size = size;
+	range_mapping->level = level;
+	list_add(&range_mapping->list, &dpt->mapping_list);
+done:
 	spin_unlock_irqrestore(&dpt->lock, flags);
 
 	return err;
@@ -611,6 +658,8 @@ struct dpt *dpt_create(unsigned int pgt_alignment)
 	if (!dpt)
 		return NULL;
 
+	INIT_LIST_HEAD(&dpt->mapping_list);
+
 	pagetable = (unsigned long)__get_free_pages(GFP_KERNEL_ACCOUNT |
 						    __GFP_ZERO,
 						    alloc_order);
@@ -632,6 +681,7 @@ void dpt_destroy(struct dpt *dpt)
 {
 	unsigned int pgt_alignment;
 	unsigned int alloc_order;
+	struct dpt_range_mapping *range, *range_next;
 	unsigned long index;
 	void *entry;
 
@@ -643,6 +693,16 @@ void dpt_destroy(struct dpt *dpt)
 			free_page((unsigned long)DPT_BACKEND_PAGE_ADDR(entry));
 	}
 
+	list_for_each_entry_safe(range, range_next, &dpt->mapping_list, list) {
+		list_del(&range->list);
+		kfree(range);
+	}
+
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

