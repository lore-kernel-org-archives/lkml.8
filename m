Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33841C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0021720BED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IOYsjUoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGFU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:28:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:28:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KMXNT068015;
        Mon, 6 Jul 2020 20:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Ek3cu3980FjfdjMBjhaJjsW0/MXLN4KL95B9Eh15jvo=;
 b=IOYsjUoT9/A91GCjKBYdBXFtaYuNs46cpDoPvxw3Bg/Rs7rpiLxXRMRsJiYrSa81nVZv
 L89joWucqI8ZkVfdS3EW5+jCNBeW6irqgw/EncJVaI3Ae/2Sil3hltpaJCM4F/yN/iZY
 CirF7iof7sVhPwxySWQgPReojxRIlCJBOBETNcsnuHRrJgdfGLuYiJjPscRdc5Fhol/1
 yUR9HIbksHSh8G/uM9Rae/hgogJsKwM4Dd9cGI4mbR++nZ+zYqW/S69rDfPeKS627g7u
 3EKyic6DmsbhuOOUrtFAHD6k+xBrCl35yBIx9a+sWLEZk5HLzuRvvQ2rjhygUpI5+Qno Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 322kv68h5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 20:28:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KMvx7054548;
        Mon, 6 Jul 2020 20:26:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3243pddfxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 20:26:26 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 066KQPLJ008675;
        Mon, 6 Jul 2020 20:26:25 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jul 2020 13:26:25 -0700
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
Subject: [RFC PATCH 3/3] huegtlbfs: handle page fault/truncate races
Date:   Mon,  6 Jul 2020 13:26:15 -0700
Message-Id: <20200706202615.32111-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706202615.32111-1-mike.kravetz@oracle.com>
References: <20200622005551.GK5535@shao2-debian>
 <20200706202615.32111-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A huegtlb page fault can race with page truncation.  Make the code
identifying and handling these races more robust.

Page fault handling needs to back out pages added to page cache beyond
file size (i_size).  When backing out the page, take care to restore
reserve map  entries and counts as necessary.

File truncation (remove_inode_hugepages) needs to handle page mapping
changes before locking the page.  This could happen if page was added
to page cache and later backed out in fault processing.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 41 ++++++++++++++++++++++-------------------
 mm/hugetlb.c         | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b4bb82815dd4..eeddd43b8809 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -494,13 +494,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			 * unmapped in caller.  Unmap (again) now after taking
 			 * the fault mutex.  The mutex will prevent faults
 			 * until we finish removing the page.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
 			 */
 			if (unlikely(page_mapped(page))) {
-				BUG_ON(truncate_op);
-
 				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
 				mutex_lock(&hugetlb_fault_mutex_table[hash]);
@@ -512,23 +507,31 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			lock_page(page);
 			/*
-			 * We must free the huge page and remove from page
-			 * cache (remove_huge_page) BEFORE removing the
-			 * region/reserve map (hugetlb_unreserve_pages).  In
-			 * rare out of memory conditions, removal of the
-			 * region/reserve map could fail. Correspondingly,
-			 * the subpool and global reserve usage count can need
-			 * to be adjusted.
+			 * After locking page, make sure mapping is the same.
+			 * We could have raced with page fault populate and
+			 * backout code.
 			 */
-			VM_BUG_ON(PagePrivate(page));
-			remove_huge_page(page);
-			freed++;
-			if (!truncate_op) {
-				if (unlikely(hugetlb_unreserve_pages(inode,
+			if (page_mapping(page) == mapping) {
+				/*
+				 * We must free the huge page and remove from
+				 * page cache (remove_huge_page) BEFORE
+				 * removing the region/reserve map.  In rare
+				 * out of memory conditions, removal of the
+				 * region/reserve map could fail.
+				 * Correspondingly, the subpool and global
+				 * reserve usage count can need to be adjusted.
+				 */
+				VM_BUG_ON(PagePrivate(page));
+				remove_huge_page(page);
+				freed++;
+				if (!truncate_op) {
+					if (unlikely(
+					    hugetlb_unreserve_pages(inode,
 							index, index + 1, 1)))
-					hugetlb_fix_reserve_counts(inode);
+						hugetlb_fix_reserve_counts(
+							inode);
+				}
 			}
-
 			unlock_page(page);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6e9085464e78..68785cc80523 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4339,6 +4339,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page = false;
+	bool page_cache = false;
+	bool reserve_alloc = false;
+	bool beyond_i_size = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -4423,6 +4426,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (PagePrivate(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
@@ -4432,6 +4437,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 					goto retry;
 				goto out;
 			}
+			page_cache = true;
 		} else {
 			lock_page(page);
 			if (unlikely(anon_vma_prepare(vma))) {
@@ -4470,8 +4476,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
+	if (idx >= size) {
+		beyond_i_size = true;
 		goto backout;
+	}
 
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
@@ -4509,8 +4517,33 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
+	if (new_page) {
+		/*
+		 * Back out pages added to page cache beyond i_size.  Otherwise,
+		 * they will 'sit' there until the file is removed.
+		 */
+		if (page_cache && beyond_i_size) {
+			/* FIXME - following lines are remove_huge_page() */
+			ClearPageDirty(page);
+			ClearPageUptodate(page);
+			delete_from_page_cache(page);
+		}
+
+		/*
+		 * If reserve was consumed, set PagePrivate so that it will
+		 * be restored in free_huge_page().
+		 */
+		if (reserve_alloc)
+			SetPagePrivate(page);
+
+		/*
+		 * Do not restore reserve map entries beyond i_size.  Otherwise,
+		 * there will be leaks when the file is removed.
+		 */
+		if (!beyond_i_size)
+			restore_reserve_on_error(h, vma, haddr, page);
+	}
 	unlock_page(page);
-	restore_reserve_on_error(h, vma, haddr, page);
 	put_page(page);
 	goto out;
 }
-- 
2.25.4

