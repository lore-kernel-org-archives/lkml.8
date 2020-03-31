Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C004C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E0B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgCaI4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:56:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:36209 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:56:32 -0400
IronPort-SDR: mK8ECY0m5cs7ahrKu5XgV9tcD46HGCq/RJ42PUfw3ECl9OvO/Qfzce63cR18iy6v1gZ/Rx83Ea
 PAXeaDxpNI7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 01:56:31 -0700
IronPort-SDR: rY2Lz/HrtN4L05LwqCHEIGPro6fjbVG88EiP8Yy2Btzm2jo0QEIOOymxovM50kXXzqYHbexX0Z
 aYptoeE+mgFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="450093037"
Received: from yhuang-dev.sh.intel.com ([10.239.159.23])
  by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2020 01:56:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
Date:   Tue, 31 Mar 2020 16:56:04 +0800
Message-Id: <20200331085604.1260162-1-ying.huang@intel.com>
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

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
---
 fs/proc/task_mmu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8d382d4ec067..b5b3aef8cb3b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page;
 
-	/* FOLL_DUMP will return -EFAULT on huge zero page */
-	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+	if (pmd_present(*pmd)) {
+		/* FOLL_DUMP will return -EFAULT on huge zero page */
+		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+	} else if (unlikely(is_swap_pmd(*pmd))) {
+		swp_entry_t entry = pmd_to_swp_entry(*pmd);
+
+		VM_BUG_ON(!is_migration_entry(entry));
+		page = migration_entry_to_page(entry);
+	} else {
+		return;
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

