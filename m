Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236D620658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgCPIki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:40:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730126AbgCPIkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:40:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 84C48E8881D087B6834A;
        Mon, 16 Mar 2020 16:40:34 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 16:40:23 +0800
From:   Luo bin <luobin9@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <aviad.krawczyk@huawei.com>, <luoxianjun@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <yin.yinshi@huawei.com>
Subject: [PATCH net 6/6] hinic: fix wrong value of MIN_SKB_LEN
Date:   Mon, 16 Mar 2020 00:56:30 +0000
Message-ID: <20200316005630.9817-7-luobin9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316005630.9817-1-luobin9@huawei.com>
References: <20200316005630.9817-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the minimum value of skb len that hw supports is 32 rather than 17

Signed-off-by: Luo bin <luobin9@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index cabcc9019ee4..8993f5b07059 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -45,7 +45,7 @@
 
 #define HW_CONS_IDX(sq)                 be16_to_cpu(*(u16 *)((sq)->hw_ci_addr))
 
-#define MIN_SKB_LEN			17
+#define MIN_SKB_LEN			32
 #define HINIC_GSO_MAX_SIZE		65536
 
 #define	MAX_PAYLOAD_OFFSET		221
-- 
2.17.1

