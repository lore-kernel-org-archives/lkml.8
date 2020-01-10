Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB61C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B772080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgAJD01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:26:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:7944 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbgAJD00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:26:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 19:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,415,1571727600"; 
   d="scan'208";a="216520441"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2020 19:26:24 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/2] mm/huge_memory.c: use head to emphasize the purpose of page
Date:   Fri, 10 Jan 2020 11:26:10 +0800
Message-Id: <20200110032610.26499-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110032610.26499-1-richardw.yang@linux.intel.com>
References: <20200110032610.26499-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During split huge page, it checks the property of the page. Currently we
do the check on page and head without emphasizing the check is on the
compound page. In case the page passed to split_huge_page_to_list is a
tail page, audience would take some time to think about whether the
check is on compound page or tail page itself.

To make it explicit, use head instead of page for those checks. After
this, audience would be more clear about the checks are on compound page
and the page is used to do the split and dump error message if failed.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/huge_memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 90165f68cf13..69e623216211 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2688,7 +2688,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
 	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
@@ -2697,10 +2697,10 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(!PageCompound(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(head), head);
+	VM_BUG_ON_PAGE(!PageCompound(head), head);
 
-	if (PageWriteback(page))
+	if (PageWriteback(head))
 		return -EBUSY;
 
 	if (PageAnon(head)) {
@@ -2751,7 +2751,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		goto out_unlock;
 	}
 
-	mlocked = PageMlocked(page);
+	mlocked = PageMlocked(head);
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
@@ -2785,10 +2785,10 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
-			if (PageSwapBacked(page))
-				__dec_node_page_state(page, NR_SHMEM_THPS);
+			if (PageSwapBacked(head))
+				__dec_node_page_state(head, NR_SHMEM_THPS);
 			else
-				__dec_node_page_state(page, NR_FILE_THPS);
+				__dec_node_page_state(head, NR_FILE_THPS);
 		}
 
 		__split_huge_page(page, list, end, flags);
-- 
2.17.1

