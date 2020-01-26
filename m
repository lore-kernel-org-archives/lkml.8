Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CBEC35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FAE20842
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgAZK1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 05:27:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:33300 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgAZK1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 05:27:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 02:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,365,1574150400"; 
   d="scan'208";a="223002736"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2020 02:27:18 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, yang.shi@linux.alibaba.com, rientjes@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v3 1/4] mm/migrate.c: not necessary to check start and i
Date:   Sun, 26 Jan 2020 18:26:20 +0800
Message-Id: <20200126102623.9616-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200126102623.9616-1-richardw.yang@linux.intel.com>
References: <20200126102623.9616-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Till here, i must no less than start. And if i equals to start,
store_status() would always return 0.

Remove some unnecessary check to make it easy to read and prepare for
further cleanup.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/migrate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6a6c8f247bce..ae3db45c6a42 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1674,11 +1674,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 				err += nr_pages - i - 1;
 			goto out;
 		}
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

