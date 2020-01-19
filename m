Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DEEC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA11F2469C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgASDHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:07:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:14153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgASDHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:07:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 19:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="258308795"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2020 19:07:31 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 8/8] mm/migrate.c: use break instead of goto out_flush
Date:   Sun, 19 Jan 2020 11:06:36 +0800
Message-Id: <20200119030636.11899-9-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119030636.11899-1-richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Label out_flush is just outside the loop, so break the loop is enough.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2a857fec65b6..59bfae11b9d6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1621,22 +1621,22 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 
 		err = -EFAULT;
 		if (get_user(p, pages + i))
-			goto out_flush;
+			break;
 		if (get_user(node, nodes + i))
-			goto out_flush;
+			break;
 		addr = (unsigned long)untagged_addr(p);
 
 		/* Check node if it is not checked. */
 		if (current_node == NUMA_NO_NODE || node != current_node) {
 			err = -ENODEV;
 			if (node < 0 || node >= MAX_NUMNODES)
-				goto out_flush;
+				break;
 			if (!node_state(node, N_MEMORY))
-				goto out_flush;
+				break;
 
 			err = -EACCES;
 			if (!node_isset(node, task_nodes))
-				goto out_flush;
+				break;
 		}
 
 		if (current_node == NUMA_NO_NODE) {
@@ -1676,9 +1676,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		 */
 		err = store_status(status, i, err ? : current_node, 1);
 		if (err)
-			goto out_flush;
+			break;
 	}
-out_flush:
+
 	/* Make sure we do not overwrite the existing error */
 	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
 				status, start, i - start - need_move);
-- 
2.17.1

