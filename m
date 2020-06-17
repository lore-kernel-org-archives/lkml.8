Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBA9206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgFQHNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:13:25 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:34294 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQHNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:13:24 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 86EBB8D48A63CAD36D11;
        Wed, 17 Jun 2020 15:13:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 05H7DK4g028206;
        Wed, 17 Jun 2020 15:13:20 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020061715134070-3975772 ;
          Wed, 17 Jun 2020 15:13:40 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] mm, slab: Use kmem_cache_zalloc() instead of kmem_cache_alloc() with flag GFP_ZERO.
Date:   Wed, 17 Jun 2020 15:15:56 +0800
Message-Id: <1592378156-7748-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-06-17 15:13:41,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-06-17 15:13:23,
        Serialize complete at 2020-06-17 15:13:23
X-MAIL: mse-fl2.zte.com.cn 05H7DK4g028206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Use kmem_cache_zalloc instead of manually calling kmem_cache_alloc
with flag GFP_ZERO.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6d45488..1fa62d9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -656,7 +656,7 @@ extern void *__kmalloc_node_track_caller(size_t, gfp_t, int, unsigned long);
  */
 static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
 {
-	return kmem_cache_alloc(k, flags | __GFP_ZERO);
+	return kmem_cache_zalloc(k, flags);
 }
 
 /**
-- 
2.9.5

