Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FDAC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D762078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgIDNBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:01:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56920 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730311AbgIDNBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:01:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 61244116E2FDBEFA3C65;
        Fri,  4 Sep 2020 21:01:36 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 21:01:30 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] caif: Remove duplicate macro SRVL_CTRL_PKT_SIZE
Date:   Fri, 4 Sep 2020 20:58:58 +0800
Message-ID: <20200904125858.16204-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SRVL_CTRL_PKT_SIZE which is defined more than once.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/caif/cfsrvl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/caif/cfsrvl.c b/net/caif/cfsrvl.c
index d0a4d0ac7045..9cef9496a707 100644
--- a/net/caif/cfsrvl.c
+++ b/net/caif/cfsrvl.c
@@ -21,7 +21,6 @@
 #define SRVL_FLOW_OFF 0x81
 #define SRVL_FLOW_ON  0x80
 #define SRVL_SET_PIN  0x82
-#define SRVL_CTRL_PKT_SIZE 1
 
 #define container_obj(layr) container_of(layr, struct cfsrvl, layer)
 
-- 
2.17.1

