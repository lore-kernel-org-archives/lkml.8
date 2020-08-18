Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96B0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09BD204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHRMIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:08:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbgHRMIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:08:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 472B2D419263F9D20B84;
        Tue, 18 Aug 2020 20:08:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 20:08:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <jmaloy@redhat.com>, <ying.xue@windriver.com>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] net: tipc: Convert to use the preferred fallthrough macro
Date:   Tue, 18 Aug 2020 08:07:13 -0400
Message-ID: <20200818120713.25381-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/tipc/bearer.c | 2 +-
 net/tipc/link.c   | 2 +-
 net/tipc/socket.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 808b147df7d5..650414110452 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -652,7 +652,7 @@ static int tipc_l2_device_event(struct notifier_block *nb, unsigned long evt,
 			test_and_set_bit_lock(0, &b->up);
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	case NETDEV_GOING_DOWN:
 		clear_bit_unlock(0, &b->up);
 		tipc_reset_bearer(net, b);
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 107578122973..b7362556da95 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1239,7 +1239,7 @@ static bool tipc_data_input(struct tipc_link *l, struct sk_buff *skb,
 			skb_queue_tail(mc_inputq, skb);
 			return true;
 		}
-		/* fall through */
+		fallthrough;
 	case CONN_MANAGER:
 		skb_queue_tail(inputq, skb);
 		return true;
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 07419f36116a..2679e97e0389 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -783,7 +783,7 @@ static __poll_t tipc_poll(struct file *file, struct socket *sock,
 	case TIPC_ESTABLISHED:
 		if (!tsk->cong_link_cnt && !tsk_conn_cong(tsk))
 			revents |= EPOLLOUT;
-		/* fall through */
+		fallthrough;
 	case TIPC_LISTEN:
 	case TIPC_CONNECTING:
 		if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
@@ -2597,7 +2597,7 @@ static int tipc_connect(struct socket *sock, struct sockaddr *dest,
 		 * case is EINPROGRESS, rather than EALREADY.
 		 */
 		res = -EINPROGRESS;
-		/* fall through */
+		fallthrough;
 	case TIPC_CONNECTING:
 		if (!timeout) {
 			if (previous == TIPC_CONNECTING)
-- 
2.19.1

