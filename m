Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A946C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7179320658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgGOMfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:35:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:62591 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgGOMfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:35:31 -0400
IronPort-SDR: +SEn2+9Cb6d3w4Vj9YylY/R2YfUJgU2u+idsTD2WOyrubosPlSWBXqigVnIoi+KkvpmgVBLmns
 91ln9iiYL9yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="149130062"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="149130062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 05:35:17 -0700
IronPort-SDR: GFVku8FxPuBhbJwckGG+97wqo1oklR5rxjArhU0zj/kScG7/CZXpWNSSdIK5U+PaP39ZUjSj5Y
 qUMlHCtEVM+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="268943784"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2020 05:35:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D95A2190; Wed, 15 Jul 2020 15:35:14 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH] mm: Fix warning in move_normal_pmd()
Date:   Wed, 15 Jul 2020 15:35:13 +0300
Message-Id: <20200715123513.42240-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mremap(2) does not allow source and destination regions to overlap, but
shift_arg_pages() calls move_page_tables() directly and in this case the
source and destination overlap often. It confuses move_normal_pmd():

  WARNING: CPU: 3 PID: 27091 at mm/mremap.c:211 move_page_tables+0x6ef/0x720

move_normal_pmd() expects the destination PMD to be empty, but when
ranges overlap nobody removes PTE page tables on source side.
move_ptes() only removes PTE entries, leaving tables behind.
When the source PMD becomes destination and alignment/size is right we
step onto the warning.

The warning is harmless: kernel correctly fallbacks to handle entries on
per-entry basis.

The fix is to avoid move_normal_pmd() if we see that source and
destination ranges overlap.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-and-tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 2c91bd4a4e2e ("mm: speed up mremap by 20x on large regions")
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: William Kucharski <william.kucharski@oracle.com>
---
 mm/mremap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5dd572d57ca9..e33fcee541fe 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -245,6 +245,18 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	unsigned long extent, next, old_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
+	bool overlaps;
+
+	/*
+	 * shift_arg_pages() can call move_page_tables() on overlapping ranges.
+	 * In this case we cannot use move_normal_pmd() because destination pmd
+	 * might be established page table: move_ptes() doesn't free page
+	 * table.
+	 */
+	if (old_addr > new_addr)
+		overlaps = old_addr - new_addr < len;
+	else
+		overlaps = new_addr - old_addr < len;
 
 	old_end = old_addr + len;
 	flush_cache_range(vma, old_addr, old_end);
@@ -282,7 +294,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
-		} else if (extent == PMD_SIZE) {
+		} else if (!overlaps && extent == PMD_SIZE) {
 #ifdef CONFIG_HAVE_MOVE_PMD
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
-- 
2.26.2

