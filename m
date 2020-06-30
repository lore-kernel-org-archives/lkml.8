Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2908E2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgF3VZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:43377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgF3VZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:23 -0400
IronPort-SDR: uehVox3YyWQEVPpZFOJpg9JX/4qfra9tPpx2wNDqo9QXG198LsJu/v+F9bYoKtDL8e1rhnE0Nt
 wHHs70GIRvOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676810"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:22 -0700
IronPort-SDR: Ov0YaenJERyHlKrRWV9cIrfOzL1LUSY/DeDfkMZ/AHGcvyfsEPHB1EGkCWR3iFPNnFpnA+J2DR
 T/N2chdpCZWg==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336251"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:21 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 01/12] mm/mempolicy: Add comment for missing LOCAL
Date:   Tue, 30 Jun 2020 14:25:06 -0700
Message-Id: <20200630212517.308045-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPOL_LOCAL is a bit weird because it is simply a different name for an
existing behavior (preferred policy with no node mask). It has been this
way since it was added here:
commit 479e2802d09f ("mm: mempolicy: Make MPOL_LOCAL a real policy")

It is so similar to MPOL_PREFERRED in fact that when the policy is
created in mpol_new, the mode is set as PREFERRED, and an internal state
representing LOCAL doesn't exist.

To prevent future explorers from scratching their head as to why
MPOL_LOCAL isn't defined in the mpol_ops table, add a small comment
explaining the situations.

v2:
Change comment to refer to mpol_new (Michal)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 381320671677..bde193278301 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -427,6 +427,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_bind,
 		.rebind = mpol_rebind_nodemask,
 	},
+	/* [MPOL_LOCAL] - see mpol_new() */
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
-- 
2.27.0

