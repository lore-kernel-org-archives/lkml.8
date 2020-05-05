Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C82C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE0C20658
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgEEIdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:33:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3411 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgEEIdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:33:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F17FEFE53B4BF7EC7C92;
        Tue,  5 May 2020 16:33:21 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 16:33:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sun: cassini: Remove unused inline functions
Date:   Tue, 5 May 2020 16:33:12 +0800
Message-ID: <20200505083312.52312-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/sun/cassini.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 3ee6ab104cb9..e6e25960da4f 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -237,12 +237,6 @@ static inline void cas_lock_tx(struct cas *cp)
 		spin_lock_nested(&cp->tx_lock[i], i);
 }
 
-static inline void cas_lock_all(struct cas *cp)
-{
-	spin_lock_irq(&cp->lock);
-	cas_lock_tx(cp);
-}
-
 /* WTZ: QA was finding deadlock problems with the previous
  * versions after long test runs with multiple cards per machine.
  * See if replacing cas_lock_all with safer versions helps. The
@@ -266,12 +260,6 @@ static inline void cas_unlock_tx(struct cas *cp)
 		spin_unlock(&cp->tx_lock[i - 1]);
 }
 
-static inline void cas_unlock_all(struct cas *cp)
-{
-	cas_unlock_tx(cp);
-	spin_unlock_irq(&cp->lock);
-}
-
 #define cas_unlock_all_restore(cp, flags) \
 do { \
 	struct cas *xxxcp = (cp); \
-- 
2.17.1


