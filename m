Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6930421883
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgG3KI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:08:28 -0400
Received: from mail1.windriver.com ([147.11.146.13]:38298 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgG3KI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:08:27 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 06UA89XB019930
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 30 Jul 2020 03:08:09 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Jul 2020 03:07:48 -0700
From:   <qiang.zhang@windriver.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] mm/slab.c: add node spinlock protect in __cache_free_alien
Date:   Thu, 30 Jul 2020 18:19:34 +0800
Message-ID: <20200730101934.38343-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

for example:
			        node0
	cpu0				                cpu1
slab_dead_cpu
   >mutex_lock(&slab_mutex)
     >cpuup_canceled                            slab_dead_cpu
       >mask = cpumask_of_node(node)               >mutex_lock(&slab_mutex)
       >n = get_node(cachep0, node0)
       >spin_lock_irq(n&->list_lock)
       >if (!cpumask_empty(mask)) == true
       	>spin_unlock_irq(&n->list_lock)
	>goto free_slab
       ....
   >mutex_unlock(&slab_mutex)

....						   >cpuup_canceled
						     >mask = cpumask_of_node(node)
kmem_cache_free(cachep0 )			     >n = get_node(cachep0, node0)
 >__cache_free_alien(cachep0 )			     >spin_lock_irq(n&->list_lock)
   >n = get_node(cachep0, node0)		     >if (!cpumask_empty(mask)) == false
   >if (n->alien && n->alien[page_node])	     >alien = n->alien
     >alien = n->alien[page_node]	             >n->alien = NULL
     >....					     >spin_unlock_irq(&n->list_lock)
						     >....

Due to multiple cpu offline, The same cache in a node may be operated in
parallel,the "n->alien" should be protect.

Fixes: 6731d4f12315 ("slab: Convert to hotplug state machine")
Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 v1->v2->v3:
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

