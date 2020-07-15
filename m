Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DEAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B66D20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGOCw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:52:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7853 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbgGOCw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:52:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 19767E055D47C59AA819;
        Wed, 15 Jul 2020 10:52:22 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 10:52:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <edumazet@google.com>, <davem@davemloft.net>,
        <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] netpoll: Remove unused inline function netpoll_netdev_init()
Date:   Wed, 15 Jul 2020 10:52:03 +0800
Message-ID: <20200715025203.10260-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d565b0a1a9b6 ("net: Add Generic Receive Offload infrastructure")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/netpoll.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f47af135bd56..e6a2d72e0dc7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -102,9 +102,6 @@ static inline void *netpoll_poll_lock(struct napi_struct *napi)
 static inline void netpoll_poll_unlock(void *have)
 {
 }
-static inline void netpoll_netdev_init(struct net_device *dev)
-{
-}
 static inline bool netpoll_tx_running(struct net_device *dev)
 {
 	return false;
-- 
2.17.1


