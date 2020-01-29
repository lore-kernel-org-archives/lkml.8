Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BDAC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD27207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgA2WQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:16:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:4886 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2WQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:16:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 14:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="261959958"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2020 14:16:35 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com, david@redhat.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v4 4/4] mm/migrate.c: unify "not queued for migration" handling in do_pages_move()
Date:   Thu, 30 Jan 2020 06:16:16 +0800
Message-Id: <20200129221616.25432-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129221616.25432-1-richardw.yang@linux.intel.com>
References: <20200129221616.25432-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can currently happen that we store the status of a page twice:
* Once we detect that it is already on the target node
* Once we moved a bunch of pages, and a page that's already on the
  target node is contained in the current interval.

Let's simplify the code and always call do_move_pages_to_node() in
case we did not queue a page for migration. Note that pages that are
already on the target node are not added to the pagelist and are,
therefore, ignored by do_move_pages_to_node() - there is no functional
change.

The status of such a page is now only stored once.

[david@redhat.com rephrase changelog]

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 981916007b4f..7c850fe5a1a8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1653,18 +1653,16 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = add_page_for_migration(mm, addr, current_node,
 				&pagelist, flags & MPOL_MF_MOVE_ALL);
 
-		if (!err) {
-			/* The page is already on the target node */
-			err = store_status(status, i, current_node, 1);
-			if (err)
-				goto out_flush;
-			continue;
-		} else if (err > 0) {
+		if (err > 0) {
 			/* The page is successfully queued for migration */
 			continue;
 		}
 
-		err = store_status(status, i, err, 1);
+		/*
+		 * If the page is already on the target node (!err), store the
+		 * node, otherwise, store the err.
+		 */
+		err = store_status(status, i, err ? : current_node, 1);
 		if (err)
 			goto out_flush;
 
-- 
2.17.1

