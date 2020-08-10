Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99EF2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHJIIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:08:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbgHJIIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:08:37 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1001481EC8B43A87BDCD;
        Mon, 10 Aug 2020 16:08:36 +0800 (CST)
Received: from DESKTOP-A9S207P.china.huawei.com (10.174.179.61) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 16:08:29 +0800
From:   <wuyun.wu@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <liu.xiang6@zte.com.cn>, Abel Wu <wuyun.wu@huawei.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slub: remove useless kmem_cache_debug
Date:   Mon, 10 Aug 2020 16:07:55 +0800
Message-ID: <20200810080758.940-1-wuyun.wu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Wu <wuyun.wu@huawei.com>

The commit below is incomplete, as it didn't handle the add_full() part.
commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")

Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index fe81773..0b021b7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2182,7 +2182,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		}
 	} else {
 		m = M_FULL;
-		if (kmem_cache_debug(s) && !lock) {
+#ifdef CONFIG_SLUB_DEBUG
+		if (!lock) {
 			lock = 1;
 			/*
 			 * This also ensures that the scanning of full
@@ -2191,6 +2192,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 */
 			spin_lock(&n->list_lock);
 		}
+#endif
 	}

 	if (l != m) {
--
1.8.3.1

