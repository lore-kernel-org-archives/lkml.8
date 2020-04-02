Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E047C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2421920675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbgDBCAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:00:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:65293 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732498AbgDBCAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:00:45 -0400
IronPort-SDR: mN1y/PilKLl/Lwf10aYELEpvCpGDV/YHVlK6/rz0wwJUsvB5+9WK+E3nJO344tSYdEQV/0Wq+2
 kf76qLyE1yuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 19:00:45 -0700
IronPort-SDR: VtO7W3BqsOK5s4SUFIxlwyf+pUZfzge24frnaaFGaEjCrFIv3Tvvh4qvC1WKhAJZBsok67jmof
 MBrpBAmPnF2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="240690407"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by fmsmga007.fm.intel.com with ESMTP; 01 Apr 2020 19:00:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
Date:   Thu,  2 Apr 2020 10:00:31 +0800
Message-Id: <20200402020031.1611223-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
is added.

Before the patch, for a fully populated 400 MB anonymous VMA, sometimes some THP
pages under migration may be lost as follows.

7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
Size:             409600 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              407552 kB
Pss:              407552 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    407552 kB
Referenced:       301056 kB
Anonymous:        407552 kB
LazyFree:              0 kB
AnonHugePages:    405504 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		1
VmFlags: rd wr mr mw me ac

After the patch, it will be always,

7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
Size:             409600 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:              409600 kB
Pss:              409600 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:    409600 kB
Referenced:       294912 kB
Anonymous:        409600 kB
LazyFree:              0 kB
AnonHugePages:    407552 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:        0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:		1
VmFlags: rd wr mr mw me ac

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
---

v2:

- Use thp_migration_supported() in condition to reduce code size if THP
  migration isn't enabled.

- Replace VM_BUG_ON() with VM_WARN_ON_ONCE(), it's not necessary to nuking
  kernel for this.

---
 fs/proc/task_mmu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8d382d4ec067..9c72f9ce2dd8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -546,10 +546,19 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
-	struct page *page;
+	struct page *page = NULL;
 
-	/* FOLL_DUMP will return -EFAULT on huge zero page */
-	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+	if (pmd_present(*pmd)) {
+		/* FOLL_DUMP will return -EFAULT on huge zero page */
+		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
+		swp_entry_t entry = pmd_to_swp_entry(*pmd);
+
+		if (is_migration_entry(entry))
+			page = migration_entry_to_page(entry);
+		else
+			VM_WARN_ON_ONCE(1);
+	}
 	if (IS_ERR_OR_NULL(page))
 		return;
 	if (PageAnon(page))
@@ -578,8 +587,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
-		if (pmd_present(*pmd))
-			smaps_pmd_entry(pmd, addr, walk);
+		smaps_pmd_entry(pmd, addr, walk);
 		spin_unlock(ptl);
 		goto out;
 	}
-- 
2.25.0

