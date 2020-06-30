Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E3AC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF03207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgF3VZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:43377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgF3VZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:29 -0400
IronPort-SDR: 6RMSDgOwgHPJiCdn5vFlsO3zNTH80XOyrOdu4dsjymWQdAZbw/mAivGygmutIuppekJAuHhOXk
 kUDIg06PV6cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676820"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676820"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:26 -0700
IronPort-SDR: YOtfhjFDe7/DRkbzG2XfTI/q1VqpxcJUI87TCypy0Kj2J8ISrWTHDu+KPWiDjWGa4u2zFYbYTS
 VUkQfmK3ZZPA==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336285"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:25 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 09/12] mm/mempolicy: Thread allocation for many preferred
Date:   Tue, 30 Jun 2020 14:25:14 -0700
Message-Id: <20200630212517.308045-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support MPOL_PREFERRED_MANY as the mode used by
set_mempolicy(2), alloc_pages_current() needs to support it. This patch
does that by using the new helper function to allocate properly based on
policy.

All the actual machinery to make this work was part of
("mm/mempolicy: Create a page allocator for policy")

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1009cf90ad37..5fb70e6599a6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2365,7 +2365,7 @@ EXPORT_SYMBOL(alloc_pages_vma);
 struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 {
 	struct mempolicy *pol = &default_policy;
-	struct page *page;
+	int nid = NUMA_NO_NODE;
 
 	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
 		pol = get_task_policy(current);
@@ -2375,13 +2375,10 @@ struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 	 * nor system default_policy
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
-		page = alloc_pages_policy(pol, gfp, order, interleave_nodes(pol));
-	else
-		page = __alloc_pages_nodemask(gfp, order,
-				policy_node(gfp, pol, numa_node_id()),
-				policy_nodemask(gfp, pol));
+		nid = interleave_nodes(pol);
+
+	return alloc_pages_policy(pol, gfp, order, nid);
 
-	return page;
 }
 EXPORT_SYMBOL(alloc_pages_current);
 
-- 
2.27.0

