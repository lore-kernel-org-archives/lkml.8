Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAA9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF51720757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDICzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:55:07 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:33214 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgDICzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 22:55:06 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 3953B4E18B4;
        Thu,  9 Apr 2020 10:54:59 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wen Gong <wgong@codeaurora.org>,
        Allison Randal <allison@lohutok.net>,
        Willem de Bruijn <willemb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Carl Huang <cjhuang@codeaurora.org>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH v3] net: qrtr: send msgs from local of same id as broadcast
Date:   Wed,  8 Apr 2020 19:53:53 -0700
Message-Id: <20200409025414.19376-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPTklLS0tKT0pKT0hDWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6Pgw*MTg0EhcPCg01VkkZ
        LDkKCTNVSlVKTkNNT0tLQktKQ0xDVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUhKSUo3Bg++
X-HM-Tid: 0a715cdcb2a59376kuws3953b4e18b4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the local node id(qrtr_local_nid) is not modified after its
initialization, it equals to the broadcast node id(QRTR_NODE_BCAST).
So the messages from local node should not be taken as broadcast
and keep the process going to send them out anyway.

The definitions are as follow:
static unsigned int qrtr_local_nid = NUMA_NO_NODE;
#define QRTR_NODE_BCAST	0xffffffffu

Fixes: commit fdf5fd397566 ("net: qrtr: Broadcast messages only from control port")
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changlog:
 - v3 Use whitespace rather than tabs to make the line up correct.
 - v2 For coding style, line up the newline of the if conditional judgement
      with the one exists before.
---
 net/qrtr/qrtr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 5a8e42ad1504..b7b854621c26 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -907,20 +907,21 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 	node = NULL;
 	if (addr->sq_node == QRTR_NODE_BCAST) {
-		enqueue_fn = qrtr_bcast_enqueue;
-		if (addr->sq_port != QRTR_PORT_CTRL) {
+		if (addr->sq_port != QRTR_PORT_CTRL &&
+		    qrtr_local_nid != QRTR_NODE_BCAST) {
 			release_sock(sk);
 			return -ENOTCONN;
 		}
+		enqueue_fn = qrtr_bcast_enqueue;
 	} else if (addr->sq_node == ipc->us.sq_node) {
 		enqueue_fn = qrtr_local_enqueue;
 	} else {
-		enqueue_fn = qrtr_node_enqueue;
 		node = qrtr_node_lookup(addr->sq_node);
 		if (!node) {
 			release_sock(sk);
 			return -ECONNRESET;
 		}
+		enqueue_fn = qrtr_node_enqueue;
 	}
 
 	plen = (len + 3) & ~3;
-- 
2.17.1

