Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D470DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFBC20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jygygaAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbgCPU62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:58:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49318 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732597AbgCPU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:58:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GKqxCq126138;
        Mon, 16 Mar 2020 20:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=TvtD3TOkvgzzTEPSWQHzGsFNrRLPncyfa1YXwDtt5d0=;
 b=jygygaAQL8vhvLpZLxPWmTgmD3LJ027rIceyhVSffT/CU36Gl/D14V6Eji6bYjmOALNk
 G29PZDzRqoeIN8tqd29nMvAUb6/kzbtkzJt5Tx7l5bVAIOsivRY8Ipza42WKlTrAobCg
 ZpJYmpeeLkKGCWKXooDJHcNEVn6TioBbQA81xOZ3HCjmTRSsJmA0l1j2/obTq+EE2XEv
 ISUsASFE/Skk+br97+iBUuhUpfcrKHOtKikI6objoyjg7i/7UChdWYfuhe4RI3v9n/Pg
 SI6Qb1pMQ8JFoBN4u9fIQagk1br0Z8jRyokWuMpaBJKlQVrB3C1nnRPUUfEXdFrkjY9/ ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yrppr1bfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 20:58:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GKqmHU005686;
        Mon, 16 Mar 2020 20:58:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ys8tqe3m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 20:58:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02GKw7Uf031277;
        Mon, 16 Mar 2020 20:58:07 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Mar 2020 13:58:06 -0700
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
Subject: [PATCH v2 1/2] hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
Date:   Mon, 16 Mar 2020 13:57:55 -0700
Message-Id: <20200316205756.146666-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316205756.146666-1-mike.kravetz@oracle.com>
References: <20200316205756.146666-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=883 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003160087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=944 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003160087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at BUGs associated with invalid huge page map counts,
it was discovered and observed that a huge pte pointer could become
'invalid' and point to another task's page table.  Consider the
following:

A task takes a page fault on a shared hugetlbfs file and calls
huge_pte_alloc to get a ptep.  Suppose the returned ptep points to a
shared pmd.

Now, another task truncates the hugetlbfs file.  As part of truncation,
it unmaps everyone who has the file mapped.  If the range being
truncated is covered by a shared pmd, huge_pmd_unshare will be called.
For all but the last user of the shared pmd, huge_pmd_unshare will
clear the pud pointing to the pmd.  If the task in the middle of the
page fault is not the last user, the ptep returned by huge_pte_alloc
now points to another task's page table or worse.  This leads to bad
things such as incorrect page map/reference counts or invalid memory
references.

To fix, expand the use of i_mmap_rwsem as follows:
- i_mmap_rwsem is held in read mode whenever huge_pmd_share is called.
  huge_pmd_share is only called via huge_pte_alloc, so callers of
  huge_pte_alloc take i_mmap_rwsem before calling.  In addition, callers
  of huge_pte_alloc continue to hold the semaphore until finished with
  the ptep.
- i_mmap_rwsem is held in write mode whenever huge_pmd_unshare is called.

One problem with this scheme is that it requires taking i_mmap_rwsem
before taking the page lock during page faults.  This is not the order
specified in the rest of mm code.  Handling of hugetlbfs pages is mostly
isolated today.  Therefore, we use this alternative locking order for
PageHuge() pages.
         mapping->i_mmap_rwsem
           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
             page->flags PG_locked (lock_page)

To help with lock ordering issues, hugetlb_page_mapping_lock_write()
is introduced to write lock the i_mmap_rwsem associated with a page.

In most cases it is easy to get address_space via vma->vm_file->f_mapping.
However, in the case of migration or memory errors for anon pages we do
not have an associated vma.  A new routine _get_hugetlb_page_mapping()
will use anon_vma to get address_space in these cases.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2 - Fixed a hang that could be reproduced via a ltp move_pages12 caused
     by a bad return path in unmap_and_move_huge_page.

 fs/hugetlbfs/inode.c    |   2 +
 include/linux/fs.h      |   5 ++
 include/linux/hugetlb.h |   8 +++
 mm/hugetlb.c            | 156 +++++++++++++++++++++++++++++++++++++---
 mm/memory-failure.c     |  29 +++++++-
 mm/migrate.c            |  25 ++++++-
 mm/rmap.c               |  17 ++++-
 mm/userfaultfd.c        |  11 ++-
 8 files changed, 234 insertions(+), 19 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index aff8642f0c2e..ce9d354ea5c2 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -450,7 +450,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(page_mapped(page))) {
 				BUG_ON(truncate_op);
 
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
+				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8c14396bf7a6..6070616f1351 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -526,6 +526,11 @@ static inline void i_mmap_lock_write(struct address_space *mapping)
 	down_write(&mapping->i_mmap_rwsem);
 }
 
+static inline int i_mmap_trylock_write(struct address_space *mapping)
+{
+	return down_write_trylock(&mapping->i_mmap_rwsem);
+}
+
 static inline void i_mmap_unlock_write(struct address_space *mapping)
 {
 	up_write(&mapping->i_mmap_rwsem);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b831e9fa1a26..ad96515f2a88 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -154,6 +154,8 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
 
+struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
+
 extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages;
 
@@ -196,6 +198,12 @@ static inline unsigned long hugetlb_total_pages(void)
 	return 0;
 }
 
+static inline struct address_space *hugetlb_page_mapping_lock_write(
+							struct page *hpage)
+{
+	return NULL;
+}
+
 static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr,
 					pte_t *ptep)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d8ebd876871d..1709fbfd6b4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1558,6 +1558,106 @@ int PageHeadHuge(struct page *page_head)
 	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
 }
 
+/*
+ * Find address_space associated with hugetlbfs page.
+ * Upon entry page is locked and page 'was' mapped although mapped state
+ * could change.  If necessary, use anon_vma to find vma and associated
+ * address space.  The returned mapping may be stale, but it can not be
+ * invalid as page lock (which is held) is required to destroy mapping.
+ */
+static struct address_space *_get_hugetlb_page_mapping(struct page *hpage)
+{
+	struct anon_vma *anon_vma;
+	pgoff_t pgoff_start, pgoff_end;
+	struct anon_vma_chain *avc;
+	struct address_space *mapping = page_mapping(hpage);
+
+	/* Simple file based mapping */
+	if (mapping)
+		return mapping;
+
+	/*
+	 * Even anonymous hugetlbfs mappings are associated with an
+	 * underlying hugetlbfs file (see hugetlb_file_setup in mmap
+	 * code).  Find a vma associated with the anonymous vma, and
+	 * use the file pointer to get address_space.
+	 */
+	anon_vma = page_lock_anon_vma_read(hpage);
+	if (!anon_vma)
+		return mapping;  /* NULL */
+
+	/* Use first found vma */
+	pgoff_start = page_to_pgoff(hpage);
+	pgoff_end = pgoff_start + hpage_nr_pages(hpage) - 1;
+	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
+					pgoff_start, pgoff_end) {
+		struct vm_area_struct *vma = avc->vma;
+
+		mapping = vma->vm_file->f_mapping;
+		break;
+	}
+
+	anon_vma_unlock_read(anon_vma);
+	return mapping;
+}
+
+/*
+ * Find and lock address space (mapping) in write mode.
+ *
+ * Upon entry, the page is locked which allows us to find the mapping
+ * even in the case of an anon page.  However, locking order dictates
+ * the i_mmap_rwsem be acquired BEFORE the page lock.  This is hugetlbfs
+ * specific.  So, we first try to lock the sema while still holding the
+ * page lock.  If this works, great!  If not, then we need to drop the
+ * page lock and then acquire i_mmap_rwsem and reacquire page lock.  Of
+ * course, need to revalidate state along the way.
+ */
+struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
+{
+	struct address_space *mapping, *mapping2;
+
+	mapping = _get_hugetlb_page_mapping(hpage);
+retry:
+	if (!mapping)
+		return mapping;
+
+	/*
+	 * If no contention, take lock and return
+	 */
+	if (i_mmap_trylock_write(mapping))
+		return mapping;
+
+	/*
+	 * Must drop page lock and wait on mapping sema.
+	 * Note:  Once page lock is dropped, mapping could become invalid.
+	 * As a hack, increase map count until we lock page again.
+	 */
+	atomic_inc(&hpage->_mapcount);
+	unlock_page(hpage);
+	i_mmap_lock_write(mapping);
+	lock_page(hpage);
+	atomic_add_negative(-1, &hpage->_mapcount);
+
+	/* verify page is still mapped */
+	if (!page_mapped(hpage)) {
+		i_mmap_unlock_write(mapping);
+		return NULL;
+	}
+
+	/*
+	 * Get address space again and verify it is the same one
+	 * we locked.  If not, drop lock and retry.
+	 */
+	mapping2 = _get_hugetlb_page_mapping(hpage);
+	if (mapping2 != mapping) {
+		i_mmap_unlock_write(mapping);
+		mapping = mapping2;
+		goto retry;
+	}
+
+	return mapping;
+}
+
 pgoff_t __basepage_index(struct page *page)
 {
 	struct page *page_head = compound_head(page);
@@ -3586,6 +3686,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	int cow;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
+	struct address_space *mapping = vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
@@ -3596,6 +3697,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					vma->vm_start,
 					vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
+	} else {
+		/*
+		 * For shared mappings i_mmap_rwsem must be held to call
+		 * huge_pte_alloc, otherwise the returned ptep could go
+		 * away if part of a shared pmd and another thread calls
+		 * huge_pmd_unshare.
+		 */
+		i_mmap_lock_read(mapping);
 	}
 
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
@@ -3673,6 +3782,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 	if (cow)
 		mmu_notifier_invalidate_range_end(&range);
+	else
+		i_mmap_unlock_read(mapping);
 
 	return ret;
 }
@@ -4121,13 +4232,15 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			};
 
 			/*
-			 * hugetlb_fault_mutex must be dropped before
-			 * handling userfault.  Reacquire after handling
-			 * fault to make calling code simpler.
+			 * hugetlb_fault_mutex and i_mmap_rwsem must be
+			 * dropped before handling userfault.  Reacquire
+			 * after handling fault to make calling code simpler.
 			 */
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			i_mmap_unlock_read(mapping);
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
+			i_mmap_lock_read(mapping);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
@@ -4292,6 +4405,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
+		/*
+		 * Since we hold no locks, ptep could be stale.  That is
+		 * OK as we are only making decisions based on content and
+		 * not actually modifying content here.
+		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
@@ -4305,14 +4423,29 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			return VM_FAULT_OOM;
 	}
 
+	/*
+	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
+	 *
+	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * is OK, as huge_pte_alloc will return the same value unless
+	 * something has changed.
+	 */
 	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
+	i_mmap_lock_read(mapping);
+	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
+	if (!ptep) {
+		i_mmap_unlock_read(mapping);
+		return VM_FAULT_OOM;
+	}
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
+	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -4400,6 +4533,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -5080,10 +5214,12 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
- * code much cleaner. pmd allocation is essential for the shared case because
- * pud has to be populated inside the same i_mmap_rwsem section - otherwise
- * racing tasks could either miss the sharing (see huge_pte_offset) or select a
- * bad pmd for sharing.
+ * code much cleaner.
+ *
+ * This routine must be called with i_mmap_rwsem held in at least read mode.
+ * For hugetlbfs, this prevents removal of any page table entries associated
+ * with the address space.  This is important as we are setting up sharing
+ * based on existing page table entries (mappings).
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
@@ -5100,7 +5236,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
 
-	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -5130,7 +5265,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
-	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -5141,7 +5275,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * called with page table lock held.
+ * Called with page table lock held and i_mmap_rwsem held in write mode.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 41c634f45d45..1c961cd26c0b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -954,7 +954,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
-	bool unmap_success;
+	bool unmap_success = true;
 	int kill = 1, forcekill;
 	struct page *hpage = *hpagep;
 	bool mlocked = PageMlocked(hpage);
@@ -1016,7 +1016,32 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	if (kill)
 		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = try_to_unmap(hpage, ttu);
+	if (!PageHuge(hpage)) {
+		unmap_success = try_to_unmap(hpage, ttu);
+	} else {
+		/*
+		 * For hugetlb pages, try_to_unmap could potentially call
+		 * huge_pmd_unshare.  Because of this, take semaphore in
+		 * write mode here and set TTU_RMAP_LOCKED to indicate we
+		 * have taken the lock at this higer level.
+		 *
+		 * Note that the call to hugetlb_page_mapping_lock_write
+		 * is necessary even if mapping is already set.  It handles
+		 * ugliness of potentially having to drop page lock to obtain
+		 * i_mmap_rwsem.
+		 */
+		mapping = hugetlb_page_mapping_lock_write(hpage);
+
+		if (mapping) {
+			unmap_success = try_to_unmap(hpage,
+						     ttu|TTU_RMAP_LOCKED);
+			i_mmap_unlock_write(mapping);
+		} else {
+			pr_info("Memory failure: %#lx: could not find mapping for mapped huge page\n",
+				pfn);
+			unmap_success = false;
+		}
+	}
 	if (!unmap_success)
 		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
 		       pfn, page_mapcount(hpage));
diff --git a/mm/migrate.c b/mm/migrate.c
index 1fb90c0ef9c3..c0ec383b3c03 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1294,6 +1294,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	int page_was_mapped = 0;
 	struct page *new_hpage;
 	struct anon_vma *anon_vma = NULL;
+	struct address_space *mapping = NULL;
 
 	/*
 	 * Migratability of hugepages depends on architectures and their size.
@@ -1341,18 +1342,36 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
+		/*
+		 * try_to_unmap could potentially call huge_pmd_unshare.
+		 * Because of this, take semaphore in write mode here and
+		 * set TTU_RMAP_LOCKED to let lower levels know we have
+		 * taken the lock.
+		 */
+		mapping = hugetlb_page_mapping_lock_write(hpage);
+		if (unlikely(!mapping))
+			goto unlock_put_anon;
+
 		try_to_unmap(hpage,
-			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
+			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS|
+			TTU_RMAP_LOCKED);
 		page_was_mapped = 1;
+		/*
+		 * Leave mapping locked until after subsequent call to
+		 * remove_migration_ptes()
+		 */
 	}
 
 	if (!page_mapped(hpage))
 		rc = move_to_new_page(new_hpage, hpage, mode);
 
-	if (page_was_mapped)
+	if (page_was_mapped) {
 		remove_migration_ptes(hpage,
-			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
+			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, true);
+		i_mmap_unlock_write(mapping);
+	}
 
+unlock_put_anon:
 	unlock_page(new_hpage);
 
 put_anon:
diff --git a/mm/rmap.c b/mm/rmap.c
index 633101a57ad9..b83864763f78 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -22,9 +22,10 @@
  *
  * inode->i_mutex	(while writing or truncating, not reading or faulting)
  *   mm->mmap_sem
- *     page->flags PG_locked (lock_page)
+ *     page->flags PG_locked (lock_page)   * (see huegtlbfs below)
  *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *         mapping->i_mmap_rwsem
+ *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *           anon_vma->rwsem
  *             mm->page_table_lock or pte_lock
  *               pgdat->lru_lock (in mark_page_accessed, isolate_lru_page)
@@ -43,6 +44,11 @@
  * anon_vma->rwsem,mapping->i_mutex      (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
+ *
+ * * hugetlbfs PageHuge() pages take locks in this order:
+ *         mapping->i_mmap_rwsem
+ *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
+ *             page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
@@ -1396,6 +1402,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		/*
 		 * If sharing is possible, start and end will be adjusted
 		 * accordingly.
+		 *
+		 * If called for a huge page, caller must hold i_mmap_rwsem
+		 * in write mode as it is possible to call huge_pmd_unshare.
 		 */
 		adjust_range_if_pmd_sharing_possible(vma, &range.start,
 						     &range.end);
@@ -1443,6 +1452,12 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		address = pvmw.address;
 
 		if (PageHuge(page)) {
+			/*
+			 * To call huge_pmd_unshare, i_mmap_rwsem must be
+			 * held in write mode.  Caller needs to explicitly
+			 * do this outside rmap routines.
+			 */
+			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
 			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
 				/*
 				 * huge_pmd_unshare unmapped an entire PMD
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cf1217e6f956..512576e171ce 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -281,10 +281,14 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via hugetlb_fault_mutex
+		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
+		 * i_mmap_rwsem ensures the dst_pte remains valid even
+		 * in the case of shared pmds.  fault mutex prevents
+		 * races with other faulting threads.
 		 */
-		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
+		i_mmap_lock_read(mapping);
+		idx = linear_page_index(dst_vma, dst_addr);
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -292,6 +296,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -299,6 +304,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pteval = huge_ptep_get(dst_pte);
 		if (!huge_pte_none(dst_pteval)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -306,6 +312,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 						dst_addr, src_addr, &page);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		i_mmap_unlock_read(mapping);
 		vm_alloc_shared = vm_shared;
 
 		cond_resched();
-- 
2.24.1

