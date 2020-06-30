Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B977C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE3B20809
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgF3VZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:43380 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbgF3VZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:25 -0400
IronPort-SDR: uxtDMiKFK3m9CM4WmfDYf+fQidR0iK50QxC911HrBFiMhVbtt5RsrpPTQdhfRcjTorgdsUPpf0
 ogI/wklghc8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676816"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676816"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:24 -0700
IronPort-SDR: 8tf47HXTmflERPAz04KulZYeKlsYIfrtqxfeH/oK2tBgZDLjipaFmRLB7TDBLXheYyn3sHaWSP
 bgzUhgbo8Snw==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336270"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:23 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 05/12] mm/mempolicy: refactor rebind code for PREFERRED_MANY
Date:   Tue, 30 Jun 2020 14:25:10 -0700
Message-Id: <20200630212517.308045-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Again, this extracts the "only one node must be set" behavior of
MPOL_PREFERRED.  It retains virtually all of the existing code so it can
be used by MPOL_PREFERRED_MANY as well.

v2:
Fixed typos in commit message. (Ben)
Merged bits from other patches. (Ben)
annotate mpol_rebind_preferred_many as unused (Ben)

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1ad6e446d8f6..d320a02fd35b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -359,14 +359,11 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	pol->v.nodes = tmp;
 }
 
-static void mpol_rebind_preferred(struct mempolicy *pol,
-						const nodemask_t *nodes)
+static void mpol_rebind_preferred_common(struct mempolicy *pol,
+					 const nodemask_t *preferred_nodes,
+					 const nodemask_t *nodes)
 {
 	nodemask_t tmp;
-	nodemask_t preferred_node;
-
-	/* MPOL_PREFERRED uses only the first node in the mask */
-	preferred_node = nodemask_of_node(first_node(*nodes));
 
 	if (pol->flags & MPOL_F_STATIC_NODES) {
 		int node = first_node(pol->w.user_nodemask);
@@ -381,12 +378,30 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 		pol->v.preferred_nodes = tmp;
 	} else if (!(pol->flags & MPOL_F_LOCAL)) {
 		nodes_remap(tmp, pol->v.preferred_nodes,
-			    pol->w.cpuset_mems_allowed, preferred_node);
+			    pol->w.cpuset_mems_allowed, *preferred_nodes);
 		pol->v.preferred_nodes = tmp;
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
 }
 
+/* MPOL_PREFERRED_MANY allows multiple nodes to be set in 'nodes' */
+static void __maybe_unused mpol_rebind_preferred_many(struct mempolicy *pol,
+						      const nodemask_t *nodes)
+{
+	mpol_rebind_preferred_common(pol, nodes, nodes);
+}
+
+static void mpol_rebind_preferred(struct mempolicy *pol,
+				  const nodemask_t *nodes)
+{
+	nodemask_t preferred_node;
+
+	/* MPOL_PREFERRED uses only the first node in 'nodes' */
+	preferred_node = nodemask_of_node(first_node(*nodes));
+
+	mpol_rebind_preferred_common(pol, &preferred_node, nodes);
+}
+
 /*
  * mpol_rebind_policy - Migrate a policy to a different set of nodes
  *
-- 
2.27.0

