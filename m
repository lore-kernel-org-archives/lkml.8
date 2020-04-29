Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64CCC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A082087E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgD2N0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:26:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbgD2N0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:26:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 57ED0A9850F2DA043BC5;
        Wed, 29 Apr 2020 21:26:35 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 21:26:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ubraun@linux.ibm.com>, <kgraul@linux.ibm.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/smc: remove unused inline function smc_curs_read
Date:   Wed, 29 Apr 2020 21:26:23 +0800
Message-ID: <20200429132623.48608-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bac6de7b6370 ("net/smc: eliminate cursor read and write calls")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/smc/smc_cdc.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 861dc24c588c..5a19e5e2280e 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -97,23 +97,6 @@ static inline void smc_curs_add(int size, union smc_host_cursor *curs,
 	}
 }
 
-/* SMC cursors are 8 bytes long and require atomic reading and writing */
-static inline u64 smc_curs_read(union smc_host_cursor *curs,
-				struct smc_connection *conn)
-{
-#ifndef KERNEL_HAS_ATOMIC64
-	unsigned long flags;
-	u64 ret;
-
-	spin_lock_irqsave(&conn->acurs_lock, flags);
-	ret = curs->acurs;
-	spin_unlock_irqrestore(&conn->acurs_lock, flags);
-	return ret;
-#else
-	return atomic64_read(&curs->acurs);
-#endif
-}
-
 /* Copy cursor src into tgt */
 static inline void smc_curs_copy(union smc_host_cursor *tgt,
 				 union smc_host_cursor *src,
-- 
2.17.1


