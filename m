Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A308C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F410120B80
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645447;
	bh=Oz0qI06ehZL1R8FnE8z2ekkD37JMOBJNah1EdjcNgbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUUq3UABBNPFm6+Dr3CS1gBRpfNRzKnZixrUviUvplKUmoTt4tSQy/ifByg4Abk5G
	 0zS/RoDx4L6O25Xhft5gS5kCHLDokKA6WNwaOrQ6kzUs2m8hll/py5Xw81dq9CV6wH
	 S1d1nuPdCziUMevJZfTgINsy6PtehN2PjNLsGFLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgCaJEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730691AbgCaJEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:04:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D93F20848;
        Tue, 31 Mar 2020 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645441;
        bh=Oz0qI06ehZL1R8FnE8z2ekkD37JMOBJNah1EdjcNgbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgEJA1+n/Tg5P0P4yiTOCw/TEl7iaktdGZ/1YL/5U1cWF+S0I5ILmghP86VcNDpcn
         lwMXBY5sgzeqrrWf/aosnL85CpZdZdzdyg2qH8Tnb78YrxJv02EkyVFPkZ6sO9fpY1
         FPQn+AoUBfYa+T51EhYP2opn+YtSJSQzSvN9oP3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 054/170] hsr: add restart routine into hsr_get_node_list()
Date:   Tue, 31 Mar 2020 10:57:48 +0200
Message-Id: <20200331085430.189432340@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit ca19c70f5225771c05bcdcb832b4eb84d7271c5e ]

The hsr_get_node_list() is to send node addresses to the userspace.
If there are so many nodes, it could fail because of buffer size.
In order to avoid this failure, the restart routine is added.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/hsr/hsr_netlink.c |   38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -360,16 +360,14 @@ fail:
  */
 static int hsr_get_node_list(struct sk_buff *skb_in, struct genl_info *info)
 {
-	/* For receiving */
-	struct nlattr *na;
+	unsigned char addr[ETH_ALEN];
 	struct net_device *hsr_dev;
-
-	/* For sending */
 	struct sk_buff *skb_out;
-	void *msg_head;
 	struct hsr_priv *hsr;
-	void *pos;
-	unsigned char addr[ETH_ALEN];
+	bool restart = false;
+	struct nlattr *na;
+	void *pos = NULL;
+	void *msg_head;
 	int res;
 
 	if (!info)
@@ -387,8 +385,9 @@ static int hsr_get_node_list(struct sk_b
 	if (!is_hsr_master(hsr_dev))
 		goto rcu_unlock;
 
+restart:
 	/* Send reply */
-	skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
+	skb_out = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (!skb_out) {
 		res = -ENOMEM;
 		goto fail;
@@ -402,17 +401,28 @@ static int hsr_get_node_list(struct sk_b
 		goto nla_put_failure;
 	}
 
-	res = nla_put_u32(skb_out, HSR_A_IFINDEX, hsr_dev->ifindex);
-	if (res < 0)
-		goto nla_put_failure;
+	if (!restart) {
+		res = nla_put_u32(skb_out, HSR_A_IFINDEX, hsr_dev->ifindex);
+		if (res < 0)
+			goto nla_put_failure;
+	}
 
 	hsr = netdev_priv(hsr_dev);
 
-	pos = hsr_get_next_node(hsr, NULL, addr);
+	if (!pos)
+		pos = hsr_get_next_node(hsr, NULL, addr);
 	while (pos) {
 		res = nla_put(skb_out, HSR_A_NODE_ADDR, ETH_ALEN, addr);
-		if (res < 0)
+		if (res < 0) {
+			if (res == -EMSGSIZE) {
+				genlmsg_end(skb_out, msg_head);
+				genlmsg_unicast(genl_info_net(info), skb_out,
+						info->snd_portid);
+				restart = true;
+				goto restart;
+			}
 			goto nla_put_failure;
+		}
 		pos = hsr_get_next_node(hsr, pos, addr);
 	}
 	rcu_read_unlock();
@@ -429,7 +439,7 @@ invalid:
 	return 0;
 
 nla_put_failure:
-	kfree_skb(skb_out);
+	nlmsg_free(skb_out);
 	/* Fall through */
 
 fail:


