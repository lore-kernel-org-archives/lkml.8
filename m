Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908412077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197172;
	bh=q3G5YY3fMhDkuXe1bh7UJCOxHJAMsJjBSjbcp3rQKfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UK4JwZS9NsaD7H56Tct4ZlsX+H2BTQT6pWGtCInQeiqaWIddyIhrfK0FU4vqzXPy7
	 FyXhOtJFWE05HIlPwebnKbhQJNDM9Rgv5YRCm32nFtEq4/F1GTxROf83Q6mQTjloty
	 dM5+PY7W8veEC/G3Pye3dWNIe7EN+JVI5cedBtig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406124AbgAPRpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405948AbgAPRop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF7124748;
        Thu, 16 Jan 2020 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196685;
        bh=q3G5YY3fMhDkuXe1bh7UJCOxHJAMsJjBSjbcp3rQKfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPrDQ4z22kg1A57bC8JiAUQBNk5lAJfmVF25QotewojDDUQhaey4JglNZ8PGVsxSq
         OGlSqr86JWSjYP/QeJ9d8f2ZDT4gwzlvcH2JBkyVINUAS2PuC41RICIjFTpZe0kUxK
         ++M9IbEJ6AlGdrodr9z6jemJqwLdLiHxZIlwJIQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Willem de Bruijn <willemb@google.com>,
        David Laight <David.Laight@aculab.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 082/174] packet: in recvmsg msg_name return at least sizeof sockaddr_ll
Date:   Thu, 16 Jan 2020 12:41:19 -0500
Message-Id: <20200116174251.24326-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8b277658905f..9de7e3e6edd3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3309,20 +3309,29 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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

