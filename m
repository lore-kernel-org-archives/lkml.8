Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7419C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F492065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgF3VZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:43377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgF3VZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:25 -0400
IronPort-SDR: ITq4zyEAGNua+gUTrrKHgOzpdwX7k4XvG1fodZQlrq5CM/gaojUeJrduyX0PIe9+4ydAYuOkZH
 fOiPnDoZIa4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676815"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:23 -0700
IronPort-SDR: cA821hHlmTE2NiSTAOgHl5UlpxdCUWDkRaE6ceH/S074++WSfveBc1T2NQ4PPRjFo/FRFCZHo0
 t1fnhyXlrwPQ==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336263"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:23 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 04/12] mm/mempolicy: allow preferred code to take a nodemask
Date:   Tue, 30 Jun 2020 14:25:09 -0700
Message-Id: <20200630212517.308045-5-ben.widawsky@intel.com>
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

Create a helper function (mpol_new_preferred_many()) which is usable
both by the old, single-node MPOL_PREFERRED and the new
MPOL_PREFERRED_MANY.

Enforce the old single-node MPOL_PREFERRED behavior in the "new"
version of mpol_new_preferred() which calls mpol_new_preferred_many().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 33bf29ddfab2..1ad6e446d8f6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -203,17 +203,30 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
-static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
+static int mpol_new_preferred_many(struct mempolicy *pol,
+				   const nodemask_t *nodes)
 {
 	if (!nodes)
 		pol->flags |= MPOL_F_LOCAL;	/* local allocation */
 	else if (nodes_empty(*nodes))
 		return -EINVAL;			/*  no allowed nodes */
 	else
-		pol->v.preferred_nodes = nodemask_of_node(first_node(*nodes));
+		pol->v.preferred_nodes = *nodes;
 	return 0;
 }
 
+static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
+{
+	if (nodes) {
+		/* MPOL_PREFERRED can only take a single node: */
+		nodemask_t tmp = nodemask_of_node(first_node(*nodes));
+
+		return mpol_new_preferred_many(pol, &tmp);
+	}
+
+	return mpol_new_preferred_many(pol, NULL);
+}
+
 static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
-- 
2.27.0

