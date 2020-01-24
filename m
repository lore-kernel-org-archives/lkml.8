Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0137EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72E420718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859769;
	bh=gHH+EGP3Q2crbuz4UDGnrMfx3iIAgUGN75u1sKhpUAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zarWrJ/K02eHiXhehG3Mx/bVElhp6ypGQWsDT1zUA4s3hyB98e86FUHPJVFK1kbdc
	 YJGJmHSjvKi58SxlnLsKMzmvsmJdBS7EWcXHTpUWcMeP+OfqYLk9q8GpcSXmmcXbpu
	 PIrjXiLvjP2hq5uJx/fM+Zb1+wMUB1B69IyDHg9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbgAXJ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbgAXJ4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:56:07 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2F120709;
        Fri, 24 Jan 2020 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859767;
        bh=gHH+EGP3Q2crbuz4UDGnrMfx3iIAgUGN75u1sKhpUAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+N0FrCf2tGlMWGyTmDK2l6ZW881V9dX0xKE+8exQ+vs6KyPkETTu9c2pu1o0H0sl
         csx4edU3nAnCkFexsTmeuJaXrd8wXWHwX54P3tLCrO5lAtfe9uLKW7of+CM47GXxsK
         ziVbsG1ebXW19SEuIGKAaC4ZfDdWAKF+VVWY4Q5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Laight <David.Laight@aculab.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 182/343] packet: in recvmsg msg_name return at least sizeof sockaddr_ll
Date:   Fri, 24 Jan 2020 10:30:00 +0100
Message-Id: <20200124092943.967185392@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit b2cf86e1563e33a14a1c69b3e508d15dc12f804c ]

Packet send checks that msg_name is at least sizeof sockaddr_ll.
Packet recv must return at least this length, so that its output
can be passed unmodified to packet send.

This ceased to be true since adding support for lladdr longer than
sll_addr. Since, the return value uses true address length.

Always return at least sizeof sockaddr_ll, even if address length
is shorter. Zero the padding bytes.

Change v1->v2: do not overwrite zeroed padding again. use copy_len.

Fixes: 0fb375fb9b93 ("[AF_PACKET]: Allow for > 8 byte hardware addresses.")
Suggested-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4e1058159b082..e788f9c7c3984 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3407,20 +3407,29 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	sock_recv_ts_and_drops(msg, sk, skb);
 
 	if (msg->msg_name) {
+		int copy_len;
+
 		/* If the address length field is there to be filled
 		 * in, we fill it in now.
 		 */
 		if (sock->type == SOCK_PACKET) {
 			__sockaddr_check_size(sizeof(struct sockaddr_pkt));
 			msg->msg_namelen = sizeof(struct sockaddr_pkt);
+			copy_len = msg->msg_namelen;
 		} else {
 			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
 
 			msg->msg_namelen = sll->sll_halen +
 				offsetof(struct sockaddr_ll, sll_addr);
+			copy_len = msg->msg_namelen;
+			if (msg->msg_namelen < sizeof(struct sockaddr_ll)) {
+				memset(msg->msg_name +
+				       offsetof(struct sockaddr_ll, sll_addr),
+				       0, sizeof(sll->sll_addr));
+				msg->msg_namelen = sizeof(struct sockaddr_ll);
+			}
 		}
-		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa,
-		       msg->msg_namelen);
+		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
 	}
 
 	if (pkt_sk(sk)->auxdata) {
-- 
2.20.1



