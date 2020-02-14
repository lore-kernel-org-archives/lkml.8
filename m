Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B09C3B191
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B03024654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBNAaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:30:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:25633 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgBNAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:30:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 16:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="227246069"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2020 16:30:16 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com, david@redhat.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v5 2/4] mm/migrate.c: wrap do_move_pages_to_node() and store_status()
Date:   Fri, 14 Feb 2020 08:30:15 +0800
Message-Id: <20200214003017.25558-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214003017.25558-1-richardw.yang@linux.intel.com>
References: <20200214003017.25558-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, do_move_pages_to_node() and store_status() are used in
combination. We have three similar call sites.

Let's provide a wrapper for both function calls -
move_pages_and_store_status - to make the calling code easier to
maintain and fix (as noted by Yang Shi, the return value handling of
do_move_pages_to_node() has a flaw).

[david@redhat.com rephrase changelog]

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 61 +++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6d466de4d1d0..c9e18012d113 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1583,6 +1583,29 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 	return err;
 }
 
+static int move_pages_and_store_status(struct mm_struct *mm, int node,
+		struct list_head *pagelist, int __user *status,
+		int start, int i, unsigned long nr_pages)
+{
+	int err;
+
+	err = do_move_pages_to_node(mm, pagelist, node);
+	if (err) {
+		/*
+		 * Positive err means the number of failed
+		 * pages to migrate.  Since we are going to
+		 * abort and return the number of non-migrated
+		 * pages, so need to incude the rest of the
+		 * nr_pages that have not been attempted as
+		 * well.
+		 */
+		if (err > 0)
+			err += nr_pages - i - 1;
+		return err;
+	}
+	return store_status(status, start, node, i - start);
+}
+
 /*
  * Migrate an array of page address onto an array of nodes and fill
  * the corresponding array of status.
@@ -1626,21 +1649,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			current_node = node;
 			start = i;
 		} else if (node != current_node) {
-			err = do_move_pages_to_node(mm, &pagelist, current_node);
-			if (err) {
-				/*
-				 * Positive err means the number of failed
-				 * pages to migrate.  Since we are going to
-				 * abort and return the number of non-migrated
-				 * pages, so need to incude the rest of the
-				 * nr_pages that have not been attempted as
-				 * well.
-				 */
-				if (err > 0)
-					err += nr_pages - i - 1;
-				goto out;
-			}
-			err = store_status(status, start, current_node, i - start);
+			err = move_pages_and_store_status(mm, current_node,
+					&pagelist, status, start, i, nr_pages);
 			if (err)
 				goto out;
 			start = i;
@@ -1669,13 +1679,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (err)
 			goto out_flush;
 
-		err = do_move_pages_to_node(mm, &pagelist, current_node);
-		if (err) {
-			if (err > 0)
-				err += nr_pages - i - 1;
-			goto out;
-		}
-		err = store_status(status, start, current_node, i - start);
+		err = move_pages_and_store_status(mm, current_node, &pagelist,
+				status, start, i, nr_pages);
 		if (err)
 			goto out;
 		current_node = NUMA_NO_NODE;
@@ -1685,16 +1690,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		return err;
 
 	/* Make sure we do not overwrite the existing error */
-	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
-	/*
-	 * Don't have to report non-attempted pages here since:
-	 *     - If the above loop is done gracefully all pages have been
-	 *       attempted.
-	 *     - If the above loop is aborted it means a fatal error
-	 *       happened, should return ret.
-	 */
-	if (!err1)
-		err1 = store_status(status, start, current_node, i - start);
+	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
+				status, start, i, nr_pages);
 	if (err >= 0)
 		err = err1;
 out:
-- 
2.17.1

