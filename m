Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B52C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE6520679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cusif3Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgCPU61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:58:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49320 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732601AbgCPU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:58:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GKqxgr126209;
        Mon, 16 Mar 2020 20:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=NtRhG2aMedRsirVNJ3WGkvDdMSsjRU1kN0E8Hrk6XSM=;
 b=Cusif3Lh3InmjFd/Ias/jitOWJzqQXxCljoCQziA6JmZ37+tRJ/5jeKa38JPDpKGdVuR
 FuQpFarsOpSspXymvMtrfRfeVgVZQc/h/L3B7l9VPKWEUki1QkwoM8WrfkW38vP0VKYw
 3hP9ipo4rr/Ix4HLAkZrdDUmpnKXPFc7U0wrfzU/u4RON5WRALYHDna3tpcVimDeuWQm
 Sx2X5y8CpXMPDrOPE+K/qS0BnW3CTw4rMQzX0sC35eGMyvldFuuaIwfhwABxM845fbre
 MSjUBwCjca5yWYUr7Elw4cgbbBiURarXJ7y2D76BnNQQcug1gNz0pP9+ZwkZF/D7Y45/ RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yrppr1bfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 20:58:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GKqkKa005273;
        Mon, 16 Mar 2020 20:58:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ys8tqe3n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 20:58:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02GKw9j0031299;
        Mon, 16 Mar 2020 20:58:09 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Mar 2020 13:58:09 -0700
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 2/2] hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race
Date:   Mon, 16 Mar 2020 13:57:56 -0700
Message-Id: <20200316205756.146666-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316205756.146666-1-mike.kravetz@oracle.com>
References: <20200316205756.146666-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003160087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003160087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlbfs page faults can race with truncate and hole punch operations.
Current code in the page fault path attempts to handle this by 'backing
out' operations if we encounter the race.  One obvious omission in the
current code is removing a page newly added to the page cache.  This is
pretty straight forward to address, but there is a more subtle and
difficult issue of backing out hugetlb reservations.  To handle this
correctly, the 'reservation state' before page allocation needs to be
noted so that it can be properly backed out.  There are four distinct
possibilities for reservation state: shared/reserved, shared/no-resv,
private/reserved and private/no-resv.  Backing out a reservation may
require memory allocation which could fail so that needs to be taken
into account as well.

Instead of writing the required complicated code for this rare
occurrence, just eliminate the race.  i_mmap_rwsem is now held in read
mode for the duration of page fault processing.  Hold i_mmap_rwsem in
write mode when modifying i_size.  In this way, truncation can not
proceed when page faults are being processed.  In addition, i_size
will not change during fault processing so a single check can be made
to ensure faults are not beyond (proposed) end of file.  Faults can
still race with hole punch, but that race is handled by existing code
and the use of hugetlb_fault_mutex.

With this modification, checks for races with truncation in the page
fault path can be simplified and removed.  remove_inode_hugepages no
longer needs to take hugetlb_fault_mutex in the case of truncation.
Comments are expanded to explain reasoning behind locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2 - Fixed compiler warnings in remove_inode_hugepages

 fs/hugetlbfs/inode.c | 28 ++++++++++++++++++++--------
 mm/hugetlb.c         | 23 +++++++++++------------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ce9d354ea5c2..991c60c7ffe0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -393,10 +393,9 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
  *	In this case, we first scan the range and release found pages.
  *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserv
  *	maps and global counts.  Page faults can not race with truncation
- *	in this routine.  hugetlb_no_page() prevents page faults in the
- *	truncated range.  It checks i_size before allocation, and again after
- *	with the page table lock for the page held.  The same lock must be
- *	acquired to unmap a page.
+ *	in this routine.  hugetlb_no_page() holds i_mmap_rwsem and prevents
+ *	page faults in the truncated range by checking i_size.  i_size is
+ *	modified while holding i_mmap_rwsem.
  * hole punch is indicated if end is not LLONG_MAX
  *	In the hole punch case we scan the range and release found pages.
  *	Only when releasing a page is the associated region/reserv map
@@ -436,7 +435,15 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			index = page->index;
 			hash = hugetlb_fault_mutex_hash(mapping, index);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			if (!truncate_op) {
+				/*
+				 * Only need to hold the fault mutex in the
+				 * hole punch case.  This prevents races with
+				 * page faults.  Races are not possible in the
+				 * case of truncation.
+				 */
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			}
 
 			/*
 			 * If page is mapped, it was faulted in after being
@@ -479,7 +486,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			}
 
 			unlock_page(page);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			if (!truncate_op)
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		huge_pagevec_release(&pvec);
 		cond_resched();
@@ -517,8 +525,8 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	BUG_ON(offset & ~huge_page_mask(h));
 	pgoff = offset >> PAGE_SHIFT;
 
-	i_size_write(inode, offset);
 	i_mmap_lock_write(mapping);
+	i_size_write(inode, offset);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
 	i_mmap_unlock_write(mapping);
@@ -640,7 +648,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		/* addr is the offset within the file (zero based) */
 		addr = index * hpage_size;
 
-		/* mutex taken here, fault path and hole punch */
+		/*
+		 * fault mutex taken here, protects against fault path
+		 * and hole punch.  inode_lock previously taken protects
+		 * against truncation.
+		 */
 		hash = hugetlb_fault_mutex_hash(mapping, index);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1709fbfd6b4e..d43e20652616 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4203,16 +4203,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	/*
-	 * Use page lock to guard against racing truncation
-	 * before we get page_table_lock.
+	 * We can not race with truncation due to holding i_mmap_rwsem.
+	 * i_size is modified when holding i_mmap_rwsem, so check here
+	 * once for faults beyond end of file.
 	 */
+	size = i_size_read(mapping->host) >> huge_page_shift(h);
+	if (idx >= size)
+		goto out;
+
 retry:
 	page = find_lock_page(mapping, idx);
 	if (!page) {
-		size = i_size_read(mapping->host) >> huge_page_shift(h);
-		if (idx >= size)
-			goto out;
-
 		/*
 		 * Check for page in userfault range
 		 */
@@ -4318,10 +4319,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
-		goto backout;
-
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
 		goto backout;
@@ -4425,8 +4422,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * until finished with ptep.  This serves two purposes:
+	 * 1) It prevents huge_pmd_unshare from being called elsewhere
+	 *    and making the ptep no longer valid.
+	 * 2) It synchronizes us with i_size modifications during truncation.
 	 *
 	 * ptep could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
-- 
2.24.1

