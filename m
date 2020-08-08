Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8742072D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHHIUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 04:20:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgHHIUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 04:20:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4685C6D5A0FFC2F1E59F;
        Sat,  8 Aug 2020 16:20:50 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 8 Aug 2020
 16:20:41 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] net: Convert to use the fallthrough macro
Date:   Sat, 8 Aug 2020 16:23:10 +0800
Message-ID: <1596874990-22437-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index c61f036d24f5..f4d5998bdcba 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1325,7 +1325,7 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
 	case SOCK_WAKE_SPACE:
 		if (!test_and_clear_bit(SOCKWQ_ASYNC_NOSPACE, &wq->flags))
 			break;
-		/* fall through */
+		fallthrough;
 	case SOCK_WAKE_IO:
 call_kill:
 		kill_fasync(&wq->fasync_list, SIGIO, band);
@@ -3158,13 +3158,13 @@ static int ethtool_ioctl(struct net *net, struct compat_ifreq __user *ifr32)
 		if (rule_cnt > KMALLOC_MAX_SIZE / sizeof(u32))
 			return -ENOMEM;
 		buf_size += rule_cnt * sizeof(u32);
-		/* fall through */
+		fallthrough;
 	case ETHTOOL_GRXRINGS:
 	case ETHTOOL_GRXCLSRLCNT:
 	case ETHTOOL_GRXCLSRULE:
 	case ETHTOOL_SRXCLSRLINS:
 		convert_out = true;
-		/* fall through */
+		fallthrough;
 	case ETHTOOL_SRXCLSRLDEL:
 		buf_size += sizeof(struct ethtool_rxnfc);
 		convert_in = true;
-- 
2.19.1

