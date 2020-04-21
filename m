Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE6AC54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC021D94
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgDUDKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:10:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgDUDKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:10:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CFB5FF6C1523A0C6D6D6;
        Tue, 21 Apr 2020 11:10:27 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:10:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <kuba@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] ila: remove unused macro 'ILA_HASH_TABLE_SIZE'
Date:   Tue, 21 Apr 2020 11:09:12 +0800
Message-ID: <20200421030912.37200-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv6/ila/ila_xlat.c:604:0: warning: macro "ILA_HASH_TABLE_SIZE" is not used [-Wunused-macros]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/ipv6/ila/ila_xlat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 5fc1f4e0c0cf..a1ac0e3d8c60 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -601,8 +601,6 @@ int ila_xlat_nl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	return ret;
 }
 
-#define ILA_HASH_TABLE_SIZE 1024
-
 int ila_xlat_init_net(struct net *net)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
-- 
2.17.1


