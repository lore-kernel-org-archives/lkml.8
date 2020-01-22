Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F34C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C84E24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699311;
	bh=JjPHG6GkHbdguECzk6PpSjxJAxH4nEN4EflwHtweL7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FKZdcE6eLQLrMDUMIUA7tKNxFxnoncq5zDC5Y/jDXCOkW8mHeyK2bW17mf4Giv4lH
	 SIA/k1CAUNjkbHlpaEINKHJVmeKe9WUpV9iuWAciivxTlo/ML6OFTvPSYXkztmpsbH
	 c2Y6KG1AgmlTtgXbRdzqTCJwUs2Y7i0asZsiN1+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgAVNVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgAVNVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:48 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5965205F4;
        Wed, 22 Jan 2020 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699307;
        bh=JjPHG6GkHbdguECzk6PpSjxJAxH4nEN4EflwHtweL7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJXVhUArGRNf8Qyze12vBEfGncQ2Z5YaOsAjKO7sVfOlRhJtAx8yD8FVyXYawweyz
         YzT9P32/da24jCpqYfAjauBt0tPCk4oyjNe/ItvoaoQw3Q3UrGPalYnguLEZBRi/zU
         og1oJe69iX00T6uZQ+IeMKMgE/NM2iKgDwfLZb3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Tuong Lien <tuong.t.lien@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 103/222] tipc: fix retrans failure due to wrong destination
Date:   Wed, 22 Jan 2020 10:28:09 +0100
Message-Id: <20200122092841.116433294@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuong Lien <tuong.t.lien@dektech.com.au>

commit abc9b4e0549b93fdaff56e9532bc49a2d7b04955 upstream.

When a user message is sent, TIPC will check if the socket has faced a
congestion at link layer. If that happens, it will make a sleep to wait
for the congestion to disappear. This leaves a gap for other users to
take over the socket (e.g. multi threads) since the socket is released
as well. Also, in case of connectionless (e.g. SOCK_RDM), user is free
to send messages to various destinations (e.g. via 'sendto()'), then
the socket's preformatted header has to be updated correspondingly
prior to the actual payload message building.

Unfortunately, the latter action is done before the first action which
causes a condition issue that the destination of a certain message can
be modified incorrectly in the middle, leading to wrong destination
when that message is built. Consequently, when the message is sent to
the link layer, it gets stuck there forever because the peer node will
simply reject it. After a number of retransmission attempts, the link
is eventually taken down and the retransmission failure is reported.

This commit fixes the problem by rearranging the order of actions to
prevent the race condition from occurring, so the message building is
'atomic' and its header will not be modified by anyone.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tuong Lien <tuong.t.lien@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/socket.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1306,8 +1306,8 @@ static int __tipc_sendmsg(struct socket
 	struct tipc_msg *hdr = &tsk->phdr;
 	struct tipc_name_seq *seq;
 	struct sk_buff_head pkts;
-	u32 dport, dnode = 0;
-	u32 type, inst;
+	u32 dport = 0, dnode = 0;
+	u32 type = 0, inst = 0;
 	int mtu, rc;
 
 	if (unlikely(dlen > TIPC_MAX_USER_MSG_SIZE))
@@ -1360,23 +1360,11 @@ static int __tipc_sendmsg(struct socket
 		type = dest->addr.name.name.type;
 		inst = dest->addr.name.name.instance;
 		dnode = dest->addr.name.domain;
-		msg_set_type(hdr, TIPC_NAMED_MSG);
-		msg_set_hdr_sz(hdr, NAMED_H_SIZE);
-		msg_set_nametype(hdr, type);
-		msg_set_nameinst(hdr, inst);
-		msg_set_lookup_scope(hdr, tipc_node2scope(dnode));
 		dport = tipc_nametbl_translate(net, type, inst, &dnode);
-		msg_set_destnode(hdr, dnode);
-		msg_set_destport(hdr, dport);
 		if (unlikely(!dport && !dnode))
 			return -EHOSTUNREACH;
 	} else if (dest->addrtype == TIPC_ADDR_ID) {
 		dnode = dest->addr.id.node;
-		msg_set_type(hdr, TIPC_DIRECT_MSG);
-		msg_set_lookup_scope(hdr, 0);
-		msg_set_destnode(hdr, dnode);
-		msg_set_destport(hdr, dest->addr.id.ref);
-		msg_set_hdr_sz(hdr, BASIC_H_SIZE);
 	} else {
 		return -EINVAL;
 	}
@@ -1387,6 +1375,22 @@ static int __tipc_sendmsg(struct socket
 	if (unlikely(rc))
 		return rc;
 
+	if (dest->addrtype == TIPC_ADDR_NAME) {
+		msg_set_type(hdr, TIPC_NAMED_MSG);
+		msg_set_hdr_sz(hdr, NAMED_H_SIZE);
+		msg_set_nametype(hdr, type);
+		msg_set_nameinst(hdr, inst);
+		msg_set_lookup_scope(hdr, tipc_node2scope(dnode));
+		msg_set_destnode(hdr, dnode);
+		msg_set_destport(hdr, dport);
+	} else { /* TIPC_ADDR_ID */
+		msg_set_type(hdr, TIPC_DIRECT_MSG);
+		msg_set_lookup_scope(hdr, 0);
+		msg_set_destnode(hdr, dnode);
+		msg_set_destport(hdr, dest->addr.id.ref);
+		msg_set_hdr_sz(hdr, BASIC_H_SIZE);
+	}
+
 	__skb_queue_head_init(&pkts);
 	mtu = tipc_node_get_mtu(net, dnode, tsk->portid);
 	rc = tipc_msg_build(hdr, m, 0, dlen, mtu, &pkts);


