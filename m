Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5734FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2911620675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgEEIwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:52:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbgEEIwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:52:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A335BE89CA7B20D56C8C;
        Tue,  5 May 2020 16:52:25 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 16:52:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <tglx@linutronix.de>
CC:     <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sierra_net: Remove unused inline function
Date:   Tue, 5 May 2020 16:51:24 +0800
Message-ID: <20200505085124.53000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/usb/sierra_net.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 389d19dd7909..0abd257b634c 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -354,11 +354,6 @@ static void sierra_net_set_ctx_index(struct sierra_net_data *priv, u8 ctx_ix)
 		cpu_to_be16(SIERRA_NET_HIP_EXT_IP_OUT_ID);
 }
 
-static inline int sierra_net_is_valid_addrlen(u8 len)
-{
-	return len == sizeof(struct in_addr);
-}
-
 static int sierra_net_parse_lsi(struct usbnet *dev, char *data, int datalen)
 {
 	struct lsi_umts *lsi = (struct lsi_umts *)data;
-- 
2.17.1


