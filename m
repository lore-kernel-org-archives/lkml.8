Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95164C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECB320663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGOCbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:31:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbgGOCbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:31:36 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 663955E75DFDB15AD290;
        Wed, 15 Jul 2020 10:31:33 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 10:31:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <yuehaibing@huawei.com>,
        <fw@strlen.de>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: flow: Remove unused inline function
Date:   Wed, 15 Jul 2020 10:31:19 +0800
Message-ID: <20200715023119.22108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used since commit 09c7570480f7 ("xfrm: remove flow cache")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/net/flow.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/net/flow.h b/include/net/flow.h
index a50fb77a0b27..929d3ca614d0 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -204,24 +204,6 @@ static inline struct flowi *flowidn_to_flowi(struct flowidn *fldn)
 	return container_of(fldn, struct flowi, u.dn);
 }
 
-typedef unsigned long flow_compare_t;
-
-static inline unsigned int flow_key_size(u16 family)
-{
-	switch (family) {
-	case AF_INET:
-		BUILD_BUG_ON(sizeof(struct flowi4) % sizeof(flow_compare_t));
-		return sizeof(struct flowi4) / sizeof(flow_compare_t);
-	case AF_INET6:
-		BUILD_BUG_ON(sizeof(struct flowi6) % sizeof(flow_compare_t));
-		return sizeof(struct flowi6) / sizeof(flow_compare_t);
-	case AF_DECnet:
-		BUILD_BUG_ON(sizeof(struct flowidn) % sizeof(flow_compare_t));
-		return sizeof(struct flowidn) / sizeof(flow_compare_t);
-	}
-	return 0;
-}
-
 __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys);
 
 #endif
-- 
2.17.1


