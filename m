Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB871C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D4C2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgIDNA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:00:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730281AbgIDM7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:59:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 722D292D5CE18AD8CE44;
        Fri,  4 Sep 2020 20:59:32 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 20:59:29 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>,
        <roopa@nvidia.com>, <nikolay@nvidia.com>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <bridge@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] netfilter: ebt_stp: Remove unused macro BPDU_TYPE_TCN
Date:   Fri, 4 Sep 2020 20:56:53 +0800
Message-ID: <20200904125653.15170-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPDU_TYPE_TCN is never used after it was introduced.
So better to remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/bridge/netfilter/ebt_stp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bridge/netfilter/ebt_stp.c b/net/bridge/netfilter/ebt_stp.c
index 0d6d20c9105e..8f68afda5f81 100644
--- a/net/bridge/netfilter/ebt_stp.c
+++ b/net/bridge/netfilter/ebt_stp.c
@@ -15,7 +15,6 @@
 #include <linux/netfilter_bridge/ebt_stp.h>
 
 #define BPDU_TYPE_CONFIG 0
-#define BPDU_TYPE_TCN 0x80
 
 struct stp_header {
 	u8 dsap;
-- 
2.17.1

