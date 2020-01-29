Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D3DC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF9B207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgA2WQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:16:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:4886 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2WQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:16:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 14:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="261959914"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2020 14:16:28 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com, david@redhat.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v4 1/4] mm/migrate.c: no need to check for i > start in do_pages_move()
Date:   Thu, 30 Jan 2020 06:16:13 +0800
Message-Id: <20200129221616.25432-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129221616.25432-1-richardw.yang@linux.intel.com>
References: <20200129221616.25432-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, we always have i >= start. If i == start, store_status()
will return 0. So we can drop the check for i > start.

[david@redhat.com rephrase changelog]

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 430fdccc733e..4c2a21856717 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1661,11 +1661,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = do_move_pages_to_node(mm, &pagelist, current_node);
 		if (err)
 			goto out;
-		if (i > start) {
-			err = store_status(status, start, current_node, i - start);
-			if (err)
-				goto out;
-		}
+		err = store_status(status, start, current_node, i - start);
+		if (err)
+			goto out;
 		current_node = NUMA_NO_NODE;
 	}
 out_flush:
-- 
2.17.1

