Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D372C11D02
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E65124656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBTHwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:52:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:57481 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgBTHwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:52:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 23:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,463,1574150400"; 
   d="scan'208";a="349123453"
Received: from yhuang-dev.sh.intel.com ([10.239.159.41])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2020 23:52:33 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm: Fix possible PMD dirty bit lost in set_pmd_migration_entry()
Date:   Thu, 20 Feb 2020 15:52:20 +0800
Message-Id: <20200220075220.2327056-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In set_pmd_migration_entry(), pmdp_invalidate() is used to change PMD
atomically.  But the PMD is read before that with an ordinary memory
reading.  If the THP (transparent huge page) is written between the
PMD reading and pmdp_invalidate(), the PMD dirty bit may be lost, and
cause data corruption.  The race window is quite small, but still
possible in theory, so need to be fixed.

The race is fixed via using the return value of pmdp_invalidate() to
get the original content of PMD, which is a read/modify/write atomic
operation.  So no THP writing can occur in between.

The race has been introduced when the THP migration support is added
in the commit 616b8371539a ("mm: thp: enable thp migration in generic
path").  But this fix depends on the commit d52605d7cb30 ("mm: do not
lose dirty and accessed bits in pmdp_invalidate()").  So it's easy to
be backported after v4.16.  But the race window is really small, so it
may be fine not to backport the fix at all.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/huge_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 580098e115bd..b1e069e68189 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3060,8 +3060,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		return;
 
 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
-	pmdval = *pvmw->pmd;
-	pmdp_invalidate(vma, address, pvmw->pmd);
+	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
 	if (pmd_dirty(pmdval))
 		set_page_dirty(page);
 	entry = make_migration_entry(page, pmd_write(pmdval));
-- 
2.25.0

