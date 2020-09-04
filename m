Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A08C28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B57C2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgIDNEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:04:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729297AbgIDNEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:04:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5661F5AA6CE11C5F8329;
        Fri,  4 Sep 2020 21:04:34 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 21:04:30 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <gustavo@embeddedor.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] NFC: digital: Remove two unused macroes
Date:   Fri, 4 Sep 2020 21:01:57 +0800
Message-ID: <20200904130157.17812-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIGITAL_NFC_DEP_REQ_RES_TAILROOM is never used after it was introduced.
DIGITAL_NFC_DEP_REQ_RES_HEADROOM is no more used after below
commit e8e7f4217564 ("NFC: digital: Remove useless call to skb_reserve()")
Remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/nfc/digital_dep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 304b1a9bb18a..5971fb6f51cc 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -38,9 +38,6 @@
 
 #define DIGITAL_GB_BIT	0x02
 
-#define DIGITAL_NFC_DEP_REQ_RES_HEADROOM	2 /* SoD: [SB (NFC-A)] + LEN */
-#define DIGITAL_NFC_DEP_REQ_RES_TAILROOM	2 /* EoD: 2-byte CRC */
-
 #define DIGITAL_NFC_DEP_PFB_TYPE(pfb) ((pfb) & 0xE0)
 
 #define DIGITAL_NFC_DEP_PFB_TIMEOUT_BIT 0x10
-- 
2.17.1

