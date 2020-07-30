Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D61C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA95322B48
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgG3ClA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:41:00 -0400
Received: from mail.windriver.com ([147.11.1.11]:61721 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgG3ClA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:41:00 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 06U2efi2012132
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 29 Jul 2020 19:40:41 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Jul 2020 19:40:40 -0700
From:   <qiang.zhang@windriver.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm/slab.c: add node spinlock protect in __cache_free_alien
Date:   Thu, 30 Jul 2020 10:52:26 +0800
Message-ID: <20200730025226.10350-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Due to cpu hotplug, the "cpuup_canceled" func be called, it's currently
manipulating the alien cache for the canceled cpu's node and this node
may be the same as the node which node's alien cache being operated in
the "__cache_free_alien" func, so we should add a protect for node's alien
cache in "__cache_free_alien" func.

Fixes: 6731d4f12315 ("slab: Convert to hotplug state machine")
Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 v1->v2:
 change submission information and fixes tags.

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

