Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0DEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114E924688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699309;
	bh=qGeoai9UnnZ3Cp9T1ScTRcn83Sx5k4kgEfiDhgQv7kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qRoHsY7DB4CbK7kl4ez71E2LM2+YzFRtnd5MZK8AuF78LSjZWbi+QjVoAKRMyo/Gd
	 7KugGfgXpcs3K6dIRxGpUprfkxKHWpc3sTEtB/UzZT7ZRQ/V5e2tsM7Wgx2CEcDilE
	 9hzFvkj9CI3TC6oWHwwojvTw4RROz5Asr3pEurVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgAVNVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbgAVNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:45 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7639D2467C;
        Wed, 22 Jan 2020 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699304;
        bh=qGeoai9UnnZ3Cp9T1ScTRcn83Sx5k4kgEfiDhgQv7kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j68xtD08w0PmIvXYE66TkbnuIagOggDfGhSfiJYIuD38VrgNBs3A33ibwYjK0nYgu
         6N8PJmlEQbYMPplqnkHrZbw7S5SQjkDwrSzl7FYUpnuUc60n9BdoBfhIzGdveLhwcT
         x0HGF/hfNNwi1aY75hXBZWKxknDze97C2Iu+ZCMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Tuong Lien <tuong.t.lien@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 102/222] tipc: fix potential hanging after b/rcast changing
Date:   Wed, 22 Jan 2020 10:28:08 +0100
Message-Id: <20200122092841.046200497@linuxfoundation.org>
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

commit dca4a17d24ee9d878836ce5eb8dc25be1ffa5729 upstream.

In commit c55c8edafa91 ("tipc: smooth change between replicast and
broadcast"), we allow instant switching between replicast and broadcast
by sending a dummy 'SYN' packet on the last used link to synchronize
packets on the links. The 'SYN' message is an object of link congestion
also, so if that happens, a 'SOCK_WAKEUP' will be scheduled to be sent
back to the socket...
However, in that commit, we simply use the same socket 'cong_link_cnt'
counter for both the 'SYN' & normal payload message sending. Therefore,
if both the replicast & broadcast links are congested, the counter will
be not updated correctly but overwritten by the latter congestion.
Later on, when the 'SOCK_WAKEUP' messages are processed, the counter is
reduced one by one and eventually overflowed. Consequently, further
activities on the socket will only wait for the false congestion signal
to disappear but never been met.

Because sending the 'SYN' message is vital for the mechanism, it should
be done anyway. This commit fixes the issue by marking the message with
an error code e.g. 'TIPC_ERR_NO_PORT', so its sending should not face a
link congestion, there is no need to touch the socket 'cong_link_cnt'
either. In addition, in the event of any error (e.g. -ENOBUFS), we will
purge the entire payload message queue and make a return immediately.

Fixes: c55c8edafa91 ("tipc: smooth change between replicast and broadcast")
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tuong Lien <tuong.t.lien@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/bcast.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -305,17 +305,17 @@ static int tipc_rcast_xmit(struct net *n
  * @skb: socket buffer to copy
  * @method: send method to be used
  * @dests: destination nodes for message.
- * @cong_link_cnt: returns number of encountered congested destination links
  * Returns 0 if success, otherwise errno
  */
 static int tipc_mcast_send_sync(struct net *net, struct sk_buff *skb,
 				struct tipc_mc_method *method,
-				struct tipc_nlist *dests,
-				u16 *cong_link_cnt)
+				struct tipc_nlist *dests)
 {
 	struct tipc_msg *hdr, *_hdr;
 	struct sk_buff_head tmpq;
 	struct sk_buff *_skb;
+	u16 cong_link_cnt;
+	int rc = 0;
 
 	/* Is a cluster supporting with new capabilities ? */
 	if (!(tipc_net(net)->capabilities & TIPC_MCAST_RBCTL))
@@ -343,18 +343,19 @@ static int tipc_mcast_send_sync(struct n
 	_hdr = buf_msg(_skb);
 	msg_set_size(_hdr, MCAST_H_SIZE);
 	msg_set_is_rcast(_hdr, !msg_is_rcast(hdr));
+	msg_set_errcode(_hdr, TIPC_ERR_NO_PORT);
 
 	__skb_queue_head_init(&tmpq);
 	__skb_queue_tail(&tmpq, _skb);
 	if (method->rcast)
-		tipc_bcast_xmit(net, &tmpq, cong_link_cnt);
+		rc = tipc_bcast_xmit(net, &tmpq, &cong_link_cnt);
 	else
-		tipc_rcast_xmit(net, &tmpq, dests, cong_link_cnt);
+		rc = tipc_rcast_xmit(net, &tmpq, dests, &cong_link_cnt);
 
 	/* This queue should normally be empty by now */
 	__skb_queue_purge(&tmpq);
 
-	return 0;
+	return rc;
 }
 
 /* tipc_mcast_xmit - deliver message to indicated destination nodes
@@ -396,9 +397,14 @@ int tipc_mcast_xmit(struct net *net, str
 		msg_set_is_rcast(hdr, method->rcast);
 
 		/* Switch method ? */
-		if (rcast != method->rcast)
-			tipc_mcast_send_sync(net, skb, method,
-					     dests, cong_link_cnt);
+		if (rcast != method->rcast) {
+			rc = tipc_mcast_send_sync(net, skb, method, dests);
+			if (unlikely(rc)) {
+				pr_err("Unable to send SYN: method %d, rc %d\n",
+				       rcast, rc);
+				goto exit;
+			}
+		}
 
 		if (method->rcast)
 			rc = tipc_rcast_xmit(net, pkts, dests, cong_link_cnt);


