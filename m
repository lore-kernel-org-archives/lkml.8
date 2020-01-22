Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6DA24673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAVBRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:17:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:24737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgAVBRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:17:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 17:17:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="244885521"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2020 17:17:12 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 3/4] mm/migrate.c: check pagelist in move_pages_and_store_status()
Date:   Wed, 22 Jan 2020 09:16:46 +0800
Message-Id: <20200122011647.13636-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122011647.13636-1-richardw.yang@linux.intel.com>
References: <20200122011647.13636-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pagelist is empty, it is not necessary to do the move and store.
Also it consolidate the empty list check in one place.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/migrate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a4d3bd6475e1..80d2bba57265 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1499,9 +1499,6 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 {
 	int err;
 
-	if (list_empty(pagelist))
-		return 0;
-
 	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
 			MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
@@ -1589,6 +1586,9 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
 {
 	int err;
 
+	if (list_empty(pagelist))
+		return 0;
+
 	err = do_move_pages_to_node(mm, pagelist, node);
 	if (err)
 		return err;
@@ -1676,9 +1676,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		current_node = NUMA_NO_NODE;
 	}
 out_flush:
-	if (list_empty(&pagelist))
-		return err;
-
 	/* Make sure we do not overwrite the existing error */
 	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
 				status, start, i - start);
-- 
2.17.1

