Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9CBC33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06C4246B1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgASDHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:07:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:14153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgASDHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:07:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 19:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="258308794"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2020 19:07:29 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 7/8] mm/migrate.c: move page on next iteration
Date:   Sun, 19 Jan 2020 11:06:35 +0800
Message-Id: <20200119030636.11899-8-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119030636.11899-1-richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page is not successfully queued for migration, we would move pages
on pagelist immediately. Actually, this could be done in the next
iteration by telling it we need some help.

This patch adds a new variable need_move to be an indication. After
this, we only need to call move_pages_and_store_status() twice.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index aee5aeb082c4..2a857fec65b6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1610,6 +1610,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	LIST_HEAD(pagelist);
 	int start, i;
 	int err = 0, err1;
+	int need_move = 0;
 
 	migrate_prep();
 
@@ -1641,13 +1642,15 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (current_node == NUMA_NO_NODE) {
 			current_node = node;
 			start = i;
-		} else if (node != current_node) {
+		} else if (node != current_node || need_move) {
 			err = move_pages_and_store_status(mm, current_node,
-					&pagelist, status, start, i - start);
+					&pagelist, status, start,
+					i - start - need_move);
 			if (err)
 				goto out;
 			start = i;
 			current_node = node;
+			need_move = 0;
 		}
 
 		/*
@@ -1662,6 +1665,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			continue;
 		}
 
+		/* Ask next iteration to move us */
+		need_move = 1;
+
 		/*
 		 * Two possible cases for err here:
 		 * == 0: page is already on the target node, then store
@@ -1671,17 +1677,11 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = store_status(status, i, err ? : current_node, 1);
 		if (err)
 			goto out_flush;
-
-		err = move_pages_and_store_status(mm, current_node, &pagelist,
-				status, start, i - start);
-		if (err)
-			goto out;
-		current_node = NUMA_NO_NODE;
 	}
 out_flush:
 	/* Make sure we do not overwrite the existing error */
 	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
-				status, start, i - start);
+				status, start, i - start - need_move);
 	if (err >= 0)
 		err = err1;
 out:
-- 
2.17.1

