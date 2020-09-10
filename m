Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD60C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D8C2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgIJIpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:45:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729455AbgIJInX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:43:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A6A026E2D7F30463F3E5;
        Thu, 10 Sep 2020 16:43:17 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 16:43:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <steffen.klassert@secunet.com>,
        <willemb@google.com>, <mstarovoitov@marvell.com>,
        <kuba@kernel.org>, <mchehab+huawei@kernel.org>,
        <antoine.tenart@bootlin.com>, <edumazet@google.com>,
        <Jason@zx2c4.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] net: Correct the comment of dst_dev_put()
Date:   Thu, 10 Sep 2020 04:41:53 -0400
Message-ID: <20200910084153.52078-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to
invalidate dst entries"), we use blackhole_netdev to invalidate dst entries
instead of loopback device anymore.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index d6b6ced0d451..0c01bd8d9d81 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -144,7 +144,7 @@ static void dst_destroy_rcu(struct rcu_head *head)
 
 /* Operations to mark dst as DEAD and clean up the net device referenced
  * by dst:
- * 1. put the dst under loopback interface and discard all tx/rx packets
+ * 1. put the dst under blackhole interface and discard all tx/rx packets
  *    on this route.
  * 2. release the net_device
  * This function should be called when removing routes from the fib tree
-- 
2.19.1

