Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7B5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBDE20BED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCHQ/GCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGFU0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:26:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGFU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:26:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KMV1L067944;
        Mon, 6 Jul 2020 20:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=7JsQApN0BMGpz+aVHeK67BKjZn8HFGP3784iAYJAa+s=;
 b=CCHQ/GCk3RbyK+kRfSJez25eXRWAixwDsWqZPd7anwhLc9S4NhWtAV2DWOHVrq/DKEJi
 yjtJJwTeQt0dVPvSDXtzw4aci1eVKg1f9P2Z1X/nx8ttJZwD6blBkspDsbyn2WZmDVWI
 LCNG6ByKRAhhKIu1er3int3mXm/YdbSXsGK55w9wiEK/A4NBnILg9yEIf/O7kCcPx8g/
 w7DX5k6oXxRtG2M2pnbKMr5fjMfLWCyLrCCefHRrUQNJ5/MFx7uRU+lw84ZUNG9Ezwao
 O3j3DzgmFk8coN8NTPJFnKK8gbjMFD2HeKypjVIyYeXWG5u9l1sxQ2mFTCUDdEyNu3pj lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 322kv68gvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 20:26:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KN5TV108646;
        Mon, 6 Jul 2020 20:26:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3233p0sw4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 20:26:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 066KQLgj013157;
        Mon, 6 Jul 2020 20:26:21 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jul 2020 13:26:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [RFC PATCH 1/3] Revert: "hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race"
Date:   Mon,  6 Jul 2020 13:26:13 -0700
Message-Id: <20200706202615.32111-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706202615.32111-1-mike.kravetz@oracle.com>
References: <20200622005551.GK5535@shao2-debian>
 <20200706202615.32111-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts 87bf91d39bb52b688fb411d668fbe7df278b29ae

Commit 87bf91d39bb5 depends on i_mmap_rwsem being taken during hugetlb
fault processing.  Commit c0d0381ade79 added code to take i_mmap_rwsem
in read mode during fault processing.  However, this was observed to
increase fault processing time by aprox 33%.  To address this, i_mmap_rwsem
will only be taken during fault processing when necessary.  As a result,
i_mmap_rwsem can not be used to synchronize fault and truncate.  In a
subsequent commit, code will be added to detect the race and back out
operations.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 28 ++++++++--------------------
 mm/hugetlb.c         | 23 ++++++++++++-----------
 2 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ef5313f9c78f..b4bb82815dd4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -444,9 +444,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserv
  *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
- *	page faults in the truncated range by checking i_size.  i_size is
- *	modified while holding i_mmap_rwsem.
+ *	in this routine.  hugetlb_no_page() prevents page faults in the
+ *	truncated range.  It checks i_size before allocation, and again after
+ *	with the page table lock for the page held.  The same lock must be
+ *	acquired to unmap a page.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserv map
@@ -486,15 +487,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			index = page->index;
 			hash = hugetlb_fault_mutex_hash(mapping, index);
-			if (!truncate_op) {
-				/*
-				 * Only need to hold the fault mutex in the
-				 * hole punch case.  This prevents races with
-				 * page faults.  Races are not possible in the
-				 * case of truncation.
-				 */
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
-			}
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 			/*
 			 * If page is mapped, it was faulted in after being
@@ -537,8 +530,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			if (!truncate_op)
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -576,8 +568,8 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
+	i_mmap_lock_write(mapping);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
@@ -699,11 +691,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/*
-		 * fault mutex taken here, protects against fault path
-		 * and hole punch.  inode_lock previously taken protects
-		 * against truncation.
-		 */
+		/* mutex taken here, fault path and hole punch */
 		hash = hugetlb_fault_mutex_hash(mapping, index);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..5349beda3658 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4322,17 +4322,16 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	/*
-	 * We can not race with truncation due to holding i_mmap_rwsem.
-	 * i_size is modified when holding i_mmap_rwsem, so check here
-	 * once for faults beyond end of file.
+	 * Use page lock to guard against racing truncation
+	 * before we get page_table_lock.
 	 */
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto out;
-
 retry:
 	page = find_lock_page(mapping, idx);
 	if (!page) {
+		size = i_size_read(mapping->host) >> huge_page_shift(h);
+		if (idx >= size)
+			goto out;
+
 		/*
 		 * Check for page in userfault range
 		 */
@@ -4438,6 +4437,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto backout;
+
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
 		goto backout;
@@ -4541,10 +4544,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This serves two purposes:
-	 * 1) It prevents huge_pmd_unshare from being called elsewhere
-	 *    and making the ptep no longer valid.
-	 * 2) It synchronizes us with i_size modifications during truncation.
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
 	 *
 	 * ptep could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
-- 
2.25.4

