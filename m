Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57B3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A902C206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgHQJDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:03:50 -0400
Received: from mail5.windriver.com ([192.103.53.11]:58166 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgHQJDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:03:46 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 07H92DgH005054
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 17 Aug 2020 02:02:55 -0700
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 02:02:47 -0700
From:   <yanfei.xu@windriver.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>
Subject: [PATCH] mm/mempolicy: Remove the useless newline in policy_node()
Date:   Mon, 17 Aug 2020 17:02:45 +0800
Message-ID: <20200817090245.28750-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

Remove the useless newline among policy_node parameters, that makes
code neater.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/mempolicy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index afaa09ff9f6c..a345ad50b86f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1885,8 +1885,7 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 }
 
 /* Return the node id preferred by the given mempolicy, or the given id */
-static int policy_node(gfp_t gfp, struct mempolicy *policy,
-								int nd)
+static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 {
 	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL))
 		nd = policy->v.preferred_node;
-- 
2.18.2

