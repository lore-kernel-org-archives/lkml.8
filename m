Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D347C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725D12158C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PKolNnM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGFU0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:26:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56840 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGFU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:26:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KN0kf068162;
        Mon, 6 Jul 2020 20:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=b4THuCn4C9a7B6Y9bQgWFqgNH1327HQkfLZ8OO2NUd0=;
 b=PKolNnM9dnKExK2G++WTmtfCqcsQv02F10MGuzrbJfUAj72FCVZUNh7lMPyVHLw8rN7N
 A1SE4Y4iG2nQ2dob9AdeyH7a8yukEBnvZ5R9YSez6/suweKdsgadUx46RVdZnKJxxDTZ
 QVX3tlRj/hI09+Rd9ohHB62si3tTbvGp3PTt10FPFaTWBp8ukSou101/dOoQYI1JU94i
 iaPn1cDLP7HRxGgm9028pjbaTeyGr6iAYerLonIDZ0J3aZZcsdB32teQpodFQGjQ455M
 JpjT0O4XeqU4HZbrQVoNVzvnyOCEuaBv6b1E8JMWoN/uRPLR/HnCTEmb/mKVeoVaL6ew 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 322kv68gw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 20:26:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KMv7n054443;
        Mon, 6 Jul 2020 20:26:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3243pddfwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 20:26:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 066KQNTd025732;
        Mon, 6 Jul 2020 20:26:23 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jul 2020 13:26:23 -0700
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
Subject: [RFC PATCH 2/3] hugetlbfs: Only take i_mmap_rwsem when sharing is possible
Date:   Mon,  6 Jul 2020 13:26:14 -0700
Message-Id: <20200706202615.32111-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706202615.32111-1-mike.kravetz@oracle.com>
References: <20200622005551.GK5535@shao2-debian>
 <20200706202615.32111-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060138
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

Commit c0d0381ade79 added code to take i_mmap_rwsem in read mode during
fault processing.  However, this was observed to increase fault processing
time by aprox 33%.  Technically, i_mmap_rwsem only needs to be held when
pmd sharing is possible.  pmd sharing depends on mapping flags, alignment
and size.  The routine vma_shareable() already checks these conditions.
Therefore, use vma_shareable to determine if sharing is possible and if
taking i_mmap_rwsem is necessary.  This is done during fault processing
and vma copying.  Code in memory-failure, page migration and userfaultfd
continue to always take i_mmap_rwsem.  These are not as performance
sensitive.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 96 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5349beda3658..6e9085464e78 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3656,6 +3656,21 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+	unsigned long base = addr & PUD_MASK;
+	unsigned long end = base + PUD_SIZE;
+
+	/*
+	 * check on proper vm_flags and page table alignment
+	 */
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
+		return true;
+	return false;
+}
+#endif
+
 static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 {
 	struct resv_map *resv = vma_resv_map(vma);
@@ -3807,6 +3822,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long sz = huge_page_size(h);
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
+	bool i_mmap_rwsem_held = false;
 	int ret = 0;
 
 	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
@@ -3816,14 +3832,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					vma->vm_start,
 					vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
-	} else {
-		/*
-		 * For shared mappings i_mmap_rwsem must be held to call
-		 * huge_pte_alloc, otherwise the returned ptep could go
-		 * away if part of a shared pmd and another thread calls
-		 * huge_pmd_unshare.
-		 */
-		i_mmap_lock_read(mapping);
 	}
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
@@ -3831,6 +3839,28 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte)
 			continue;
+
+		/*
+		 * For shared mappings(non-cow) i_mmap_rwsem must be held to
+		 * call huge_pte_alloc, otherwise the returned ptep could go
+		 * away if part of a shared pmd and another thread calls
+		 * huge_pmd_unshare.  This is only necessary if the specific
+		 * pmd can be shared.  Acquire/drop semaphore as necessary.
+		 */
+		if (!cow) {
+			if (!i_mmap_rwsem_held) {
+				if (vma_shareable(vma, addr)) {
+					i_mmap_lock_read(mapping);
+					i_mmap_rwsem_held = true;
+				}
+			} else {
+				if (!vma_shareable(vma, addr)) {
+					i_mmap_unlock_read(mapping);
+					i_mmap_rwsem_held = false;
+				}
+			}
+		}
+
 		dst_pte = huge_pte_alloc(dst, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
@@ -3901,7 +3931,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 	if (cow)
 		mmu_notifier_invalidate_range_end(&range);
-	else
+	if (i_mmap_rwsem_held)
 		i_mmap_unlock_read(mapping);
 
 	return ret;
@@ -4357,9 +4387,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 */
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
+			if (vma_shareable(vma, haddr))
+				i_mmap_unlock_read(mapping);
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
-			i_mmap_lock_read(mapping);
+			if (vma_shareable(vma, haddr))
+				i_mmap_lock_read(mapping);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
@@ -4543,19 +4575,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	/*
-	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * If PMD sharing is possible, acquire i_mmap_rwsem before calling
+	 * huge_pte_alloc and hold until finished with ptep.  This prevents
+	 * huge_pmd_unshare from being called elsewhere and making the ptep
+	 * no longer valid.
 	 *
 	 * ptep could have already be assigned via huge_pte_offset.  That
 	 * is OK, as huge_pte_alloc will return the same value unless
 	 * something has changed.
 	 */
 	mapping = vma->vm_file->f_mapping;
-	i_mmap_lock_read(mapping);
+	if (vma_shareable(vma, haddr))
+		i_mmap_lock_read(mapping);
 	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
 	if (!ptep) {
-		i_mmap_unlock_read(mapping);
+		if (vma_shareable(vma, haddr))
+			i_mmap_unlock_read(mapping);
 		return VM_FAULT_OOM;
 	}
 
@@ -4652,7 +4687,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
+	if (vma_shareable(vma, haddr))
+		i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -5287,19 +5323,6 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
-{
-	unsigned long base = addr & PUD_MASK;
-	unsigned long end = base + PUD_SIZE;
-
-	/*
-	 * check on proper vm_flags and page table alignment
-	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
-		return true;
-	return false;
-}
-
 /*
  * Determine if start,end range within vma could be mapped by shared pmd.
  * If yes, adjust start and end to cover range associated with possible
@@ -5335,9 +5358,12 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * !shared pmd case because we can allocate the pmd later as well, it makes the
  * code much cleaner.
  *
- * This routine must be called with i_mmap_rwsem held in at least read mode.
- * For hugetlbfs, this prevents removal of any page table entries associated
- * with the address space.  This is important as we are setting up sharing
+ * FIXME - If sharing is possible, this routine must be called with
+ * i_mmap_rwsem held in at least read mode.  Leaving it up to the caller
+ * to determine if sharing is possible is asking for trouble.  Right now, all
+ * calling code is correct.  But, this needs to be cleaner.  Holding
+ * i_mmap_rwsem prevents removal of any page table entries associated with
+ * the address space.  This is important as we are setting up sharing
  * based on existing page table entries (mappings).
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
@@ -5355,6 +5381,10 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
 
+	/*
+	 * If we get here, caller should have acquired i_mmap_rwsem in
+	 * at least read mode.
+	 */
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
-- 
2.25.4

