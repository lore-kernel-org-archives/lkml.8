Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439B5207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgE1Oiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:38:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgE1Oim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:38:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 236C15584F194234AC35;
        Thu, 28 May 2020 22:38:35 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 28 May 2020
 22:38:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jmaloy@redhat.com>, <ying.xue@windriver.com>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <tuong.t.lien@dektech.com.au>
CC:     <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] tipc: Fix NULL pointer dereference in __tipc_sendstream()
Date:   Thu, 28 May 2020 22:34:07 +0800
Message-ID: <20200528143407.56196-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tipc_sendstream() may send zero length packet, then tipc_msg_append()
do not alloc skb, skb_peek_tail() will get NULL, msg_set_ack_required
will trigger NULL pointer dereference.

Reported-by: syzbot+8eac6d030e7807c21d32@syzkaller.appspotmail.com
Fixes: 0a3e060f340d ("tipc: add test for Nagle algorithm effectiveness")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/tipc/socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d6b67d07d22e..2943561399f1 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1588,8 +1588,12 @@ static int __tipc_sendstream(struct socket *sock, struct msghdr *m, size_t dlen)
 				tsk->pkt_cnt += skb_queue_len(txq);
 			} else {
 				skb = skb_peek_tail(txq);
-				msg_set_ack_required(buf_msg(skb));
-				tsk->expect_ack = true;
+				if (skb) {
+					msg_set_ack_required(buf_msg(skb));
+					tsk->expect_ack = true;
+				} else {
+					tsk->expect_ack = false;
+				}
 				tsk->msg_acc = 0;
 				tsk->pkt_cnt = 0;
 			}
-- 
2.17.1


