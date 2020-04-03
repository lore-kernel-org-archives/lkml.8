Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CEDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649912077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbgDCMby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:31:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:45126 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgDCMby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:31:54 -0400
IronPort-SDR: 1ZiUU/T8QvcGMAzWD/6Af5WpOiQ1rqsgCFAQjgjwM75ghBeqrXFms+lN/5YX12kWSgp2gKzbRT
 gkmVxH+P+BIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 05:31:53 -0700
IronPort-SDR: nI2olLeXrFo1lRBhvElCdhDMR3vtppxqaBq/NacGGUrVv6B7DI8vpIsFPJ7Rq3yQb2ITRGkori
 D5E/TseIovkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; 
   d="scan'208";a="273934294"
Received: from unknown (HELO yhuang-dev.sh.intel.com) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2020 05:31:50 -0700
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
Subject: [PATCH -V3] /proc/PID/smaps: Add PMD migration entry parsing
Date:   Fri,  3 Apr 2020 20:30:59 +0800
Message-Id: <20200403123059.1846960-1-ying.huang@intel.com>
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

To test the patch, we run pmbench to eat 400 MB memory in background, then run
/usr/bin/migratepages and `cat /proc/PID/smaps` every second.  The issue as
follows can be reproduced within 60 seconds.

Before the patch, for the fully populated 400 MB anonymous VMA, some THP pages
under migration may be lost as below.

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

v3:

- Revised patch description and remove VM_WARN_ON_ONCE() per Michal's comments

v2:

- Use thp_migration_supported() in condition to reduce code size if THP
  migration isn't enabled.

- Replace VM_BUG_ON() with VM_WARN_ON_ONCE(), it's not necessary to nuking
  kernel for this.

---
 fs/proc/task_mmu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8d382d4ec067..36dc7417c0df 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -546,10 +546,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
-	struct page *page;
+	struct page *page = NULL;
+
+	if (pmd_present(*pmd)) {
+		/* FOLL_DUMP will return -EFAULT on huge zero page */
+		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
+		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
-	/* FOLL_DUMP will return -EFAULT on huge zero page */
-	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+		if (is_migration_entry(entry))
+			page = migration_entry_to_page(entry);
+	}
 	if (IS_ERR_OR_NULL(page))
 		return;
 	if (PageAnon(page))
@@ -578,8 +585,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 
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

