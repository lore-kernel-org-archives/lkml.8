Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A376C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F07D206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LlwksrUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgEDPEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:04:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEDPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:04:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EliEO024627;
        Mon, 4 May 2020 15:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=chwC6Qoj6vU2BtpkAhEtUbdF5FP79ZRqRWpFJfRAy6o=;
 b=LlwksrUjmqVcn1DFyrllRb6xoNpjN33QJHik5LcDtjxf0E/guw3MrcmImj7l4qRhGxaw
 xvTUH17OCFjpRI9t+m3PSuUbha++t6V6NcgrvCTDdE59OxGtJkRy2FxBBAalPM9uCzPm
 KBO3QcRo1GryhcX094C4/nyows7PelusYzeNgUTj2DL53S4l1SG8OigpdNCmRmQnRAYi
 SfXfQhmqKd8oe4tcbPD4l8RK07MRO5R0LBnDuxAnqd976MHFZD9E1/kU/sNA5SbIaX5/
 ATCiadnJQSYJCOAXVm8p/UC4qAJrHfjt/tjUACg7qz/TK/4K0VfYPXE1eOmzV+XrNr4S 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gmy945-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:02:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVhV105651;
        Mon, 4 May 2020 15:00:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjw0jje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F0NuL027832;
        Mon, 4 May 2020 15:00:23 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:00:22 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 12/13] mm/dpt: Handle decorated page-table mapped range leaks and overlaps
Date:   Mon,  4 May 2020 16:58:09 +0200
Message-Id: <20200504145810.11882-13-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mapping a buffer in a decorated page-table, data around the buffer can
also be mapped if the entire buffer is not aligned with the page directory
size used for the mapping. So, data can potentially leak into the decorated
page-table. In such a case, print a warning that data are leaking.

Also data effectively mapped can overlap with an already mapped buffer.
This is not an issue when mapping data but, when unmapping, make sure
data from another buffer don't get unmapped as a side effect.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h |   1 +
 arch/x86/mm/dpt.c          | 197 +++++++++++++++++++++++++++++++------
 2 files changed, 168 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index 3234ba968d80..e0adbf69dadf 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -25,6 +25,7 @@ struct dpt_range_mapping {
 	void *ptr;			/* range start address */
 	size_t size;			/* range size */
 	enum page_table_level level;	/* mapping level */
+	int refcnt;			/* reference count (for overlap) */
 };
 
 /*
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index 9517e3081716..d3d3c3de2943 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -9,6 +9,22 @@
 
 #include <asm/dpt.h>
 
+
+static unsigned long page_directory_size[] = {
+	[PGT_LEVEL_PTE] = PAGE_SIZE,
+	[PGT_LEVEL_PMD] = PMD_SIZE,
+	[PGT_LEVEL_PUD] = PUD_SIZE,
+	[PGT_LEVEL_P4D] = P4D_SIZE,
+	[PGT_LEVEL_PGD] = PGDIR_SIZE,
+};
+
+#define DPT_RANGE_MAP_ADDR(r)	\
+	round_down((unsigned long)((r)->ptr), page_directory_size[(r)->level])
+
+#define DPT_RANGE_MAP_END(r)	\
+	round_up((unsigned long)((r)->ptr + (r)->size), \
+		 page_directory_size[(r)->level])
+
 /*
  * Get the pointer to the beginning of a page table directory from a page
  * table directory entry.
@@ -572,6 +588,70 @@ static int dpt_copy_pgd_range(struct dpt *dpt,
 	return 0;
 }
 
+/*
+ * Map a VA range, taking into account any overlap with already mapped
+ * VA ranges. On error, return < 0. Otherwise return the number of
+ * ranges the specified range is overlapping with.
+ */
+static int dpt_map_overlap(struct dpt *dpt, void *ptr, size_t size,
+			   enum page_table_level level)
+{
+	unsigned long map_addr, map_end;
+	unsigned long addr, end;
+	struct dpt_range_mapping *range;
+	bool need_mapping;
+	int err, overlap;
+
+	addr = (unsigned long)ptr;
+	end = addr + (unsigned long)size;
+	need_mapping = true;
+	overlap = 0;
+
+	lockdep_assert_held(&dpt->lock);
+	list_for_each_entry(range, &dpt->mapping_list, list) {
+
+		if (range->ptr == ptr && range->size == size) {
+			/* we are mapping the same range again */
+			pr_debug("DPT %p: MAP %px/%lx/%d already mapped\n",
+				 dpt, ptr, size, level);
+			return -EBUSY;
+		}
+
+		/* check overlap with mapped range */
+		map_addr = DPT_RANGE_MAP_ADDR(range);
+		map_end = DPT_RANGE_MAP_END(range);
+		if (end <= map_addr || addr >= map_end) {
+			/* no overlap, continue */
+			continue;
+		}
+
+		pr_debug("DPT %p: MAP %px/%lx/%d overlaps with %px/%lx/%d\n",
+			 dpt, ptr, size, level,
+			 range->ptr, range->size, range->level);
+		range->refcnt++;
+		overlap++;
+
+		/*
+		 * Check if new range is included into an existing range.
+		 * If so then the new range is already entirely mapped.
+		 */
+		if (addr >= map_addr && end <= map_end) {
+			pr_debug("DPT %p: MAP %px/%lx/%d implicitly mapped\n",
+				 dpt, ptr, size, level);
+			need_mapping = false;
+		}
+	}
+
+	if (need_mapping) {
+		err = dpt_copy_pgd_range(dpt, dpt->pagetable, current->mm->pgd,
+					 addr, end, level);
+		if (err)
+			return err;
+	}
+
+	return overlap;
+}
+
 /*
  * Copy page table entries from the current page table (i.e. from the
  * kernel page table) to the specified decorated page-table. The level
@@ -582,47 +662,48 @@ int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
 		  enum page_table_level level)
 {
 	struct dpt_range_mapping *range_mapping;
+	unsigned long page_dir_size = page_directory_size[level];
 	unsigned long addr = (unsigned long)ptr;
 	unsigned long end = addr + ((unsigned long)size);
+	unsigned long map_addr, map_end;
 	unsigned long flags;
-	int err;
+	int overlap;
 
-	pr_debug("DPT %p: MAP %px/%lx/%d\n", dpt, ptr, size, level);
+	map_addr = round_down(addr, page_dir_size);
+	map_end = round_up(end, page_dir_size);
 
-	spin_lock_irqsave(&dpt->lock, flags);
-
-	/* check if the range is already mapped */
-	range_mapping = dpt_get_range_mapping(dpt, ptr);
-	if (range_mapping) {
-		pr_debug("DPT %p: MAP %px/%lx/%d already mapped\n",
-			 dpt, ptr, size, level);
-		err = -EBUSY;
-		goto done;
-	}
+	pr_debug("DPT %p: MAP %px/%lx/%d -> %lx-%lx\n", dpt, ptr, size, level,
+		 map_addr, map_end);
+	if (map_addr < addr)
+		pr_debug("DPT %p: MAP LEAK %lx-%lx\n", dpt, map_addr, addr);
+	if (map_end > end)
+		pr_debug("DPT %p: MAP LEAK %lx-%lx\n", dpt, end, map_end);
 
-	/* map new range */
+	/* add new range */
 	range_mapping = kmalloc(sizeof(*range_mapping), GFP_KERNEL);
-	if (!range_mapping) {
-		err = -ENOMEM;
-		goto done;
-	}
+	if (!range_mapping)
+		return -ENOMEM;
 
-	err = dpt_copy_pgd_range(dpt, dpt->pagetable, current->mm->pgd,
-				 addr, end, level);
-	if (err) {
-		kfree(range_mapping);
-		goto done;
+	spin_lock_irqsave(&dpt->lock, flags);
+
+	/*
+	 * Map the new range with taking overlap with already mapped ranges
+	 * into account.
+	 */
+	overlap = dpt_map_overlap(dpt, ptr, size, level);
+	if (overlap < 0) {
+		spin_unlock_irqrestore(&dpt->lock, flags);
+		return overlap;
 	}
 
 	INIT_LIST_HEAD(&range_mapping->list);
 	range_mapping->ptr = ptr;
 	range_mapping->size = size;
 	range_mapping->level = level;
+	range_mapping->refcnt = overlap + 1;
 	list_add(&range_mapping->list, &dpt->mapping_list);
-done:
 	spin_unlock_irqrestore(&dpt->lock, flags);
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(dpt_map_range);
 
@@ -741,13 +822,72 @@ static void dpt_clear_pgd_range(struct dpt *dpt, pgd_t *pagetable,
 	} while (pgd++, addr = next, addr < end);
 }
 
+
+/*
+ * Unmap a VA range, taking into account any overlap with other mapped
+ * VA ranges.
+ */
+static void dpt_unmap_overlap(struct dpt *dpt, struct dpt_range_mapping *range)
+{
+	unsigned long pgdir_size = page_directory_size[range->level];
+	unsigned long chunk_addr, chunk_end;
+	unsigned long map_addr, map_end;
+	struct dpt_range_mapping *r;
+	unsigned long addr, end;
+	bool overlap;
+
+	addr = DPT_RANGE_MAP_ADDR(range);
+	end = DPT_RANGE_MAP_END(range);
+
+	lockdep_assert_held(&dpt->lock);
+
+	/*
+	 * Unmap the VA range by chunk to handle mapping overlap
+	 * with any another range.
+	 * XXX can be improved with a sorted range list
+	 */
+	chunk_addr = addr;
+	while (chunk_addr < end) {
+		overlap = false;
+		list_for_each_entry(r, &dpt->mapping_list, list) {
+			map_addr = DPT_RANGE_MAP_ADDR(r);
+			map_end = DPT_RANGE_MAP_END(r);
+			/*
+			 * Check if there's an overlap and how far it goes.
+			 */
+			chunk_end = chunk_addr;
+			while (chunk_end >= map_addr && chunk_end < map_end) {
+				overlap = true;
+				chunk_end += pgdir_size;
+				if (chunk_end >= end)
+					break;
+			}
+			if (overlap) {
+				pr_debug("DPT %p: UNMAP %px/%lx/%d overlaps with %px/%lx/%d\n",
+					 dpt, range->ptr, range->size,
+					 range->level,
+					 r->ptr, r->size, r->level);
+				break;
+			}
+		}
+
+		if (!overlap) {
+			pr_debug("DPT %p: UNMAP CHUNK %lx/%lx/%d\n", dpt,
+				 chunk_addr, pgdir_size, range->level);
+			chunk_end = chunk_addr + pgdir_size;
+			dpt_clear_pgd_range(dpt, dpt->pagetable, chunk_addr,
+					    chunk_end, range->level);
+		}
+		chunk_addr = chunk_end;
+	}
+}
+
 /*
  * Clear page table entries in the specified decorated page-table.
  */
 void dpt_unmap(struct dpt *dpt, void *ptr)
 {
 	struct dpt_range_mapping *range_mapping;
-	unsigned long addr, end;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dpt->lock, flags);
@@ -758,13 +898,10 @@ void dpt_unmap(struct dpt *dpt, void *ptr)
 		goto done;
 	}
 
-	addr = (unsigned long)range_mapping->ptr;
-	end = addr + range_mapping->size;
 	pr_debug("DPT %p: UNMAP %px/%lx/%d\n", dpt, ptr,
 		 range_mapping->size, range_mapping->level);
-	dpt_clear_pgd_range(dpt, dpt->pagetable, addr, end,
-			    range_mapping->level);
 	list_del(&range_mapping->list);
+	dpt_unmap_overlap(dpt, range_mapping);
 	kfree(range_mapping);
 done:
 	spin_unlock_irqrestore(&dpt->lock, flags);
-- 
2.18.2

