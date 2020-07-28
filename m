Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D43CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37EF620775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgG1Jq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:46:26 -0400
Received: from mail5.windriver.com ([192.103.53.11]:58298 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgG1JqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:46:25 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 06S9iHF0005340
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 28 Jul 2020 02:44:28 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 02:44:07 -0700
From:   <qiang.zhang@windriver.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slab.c: add node spinlock protect in __cache_free_alien
Date:   Tue, 28 Jul 2020 17:55:51 +0800
Message-ID: <20200728095551.30634-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

We should add node spinlock protect "n->alien" which may be
assigned to NULL in cpuup_canceled func. cause address access
exception.

Fixes: 18bf854117c6 ("slab: use get_node() and kmem_cache_node() functions")
Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 mm/slab.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index a89633603b2d..290523c90b4e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -759,8 +759,10 @@ static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
 
 	n = get_node(cachep, node);
 	STATS_INC_NODEFREES(cachep);
+	spin_lock(&n->list_lock);
 	if (n->alien && n->alien[page_node]) {
 		alien = n->alien[page_node];
+		spin_unlock(&n->list_lock);
 		ac = &alien->ac;
 		spin_lock(&alien->lock);
 		if (unlikely(ac->avail == ac->limit)) {
@@ -769,14 +771,15 @@ static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
 		}
 		ac->entry[ac->avail++] = objp;
 		spin_unlock(&alien->lock);
-		slabs_destroy(cachep, &list);
 	} else {
+		spin_unlock(&n->list_lock);
 		n = get_node(cachep, page_node);
 		spin_lock(&n->list_lock);
 		free_block(cachep, &objp, 1, page_node, &list);
 		spin_unlock(&n->list_lock);
-		slabs_destroy(cachep, &list);
 	}
+
+	slabs_destroy(cachep, &list);
 	return 1;
 }
 
-- 
2.26.2

