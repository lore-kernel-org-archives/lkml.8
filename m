Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCE5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A80206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759011;
	bh=KcQDRppZ2VF40zfirse00hJ9t9a1++npF9ADLet5GIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3sN0Tnh9f9x8fjb+6d9ooujzJsjukZftI6dTxTqInBPg19ax4SiYHl93QeZYNgmo
	 NbY7T0hA8lgiBId9I/Yi2nebezF98P/7TgHP6qRo8NRmVee61SOZxo8sjslU8WdMGw
	 2q1Aylv8XH55EnSRVq0+v9KvkOKypcnygGpf6cNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbgDAQgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388506AbgDAQgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:36:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54AAA20BED;
        Wed,  1 Apr 2020 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759006;
        bh=KcQDRppZ2VF40zfirse00hJ9t9a1++npF9ADLet5GIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2mPX3djNeMG2jqJw5DvBVFrB6KP9B0fq3wOlTTCfLeofK1kPlXeZZ1GH9YT0nAr2
         SNXQqvlD0n3La8ycVRtQEOVBqbPUZuh/B8NsT20gmr75GxxR2fOVxme2lHoeqLt2Z8
         j5Qc7QbxBPSOKLwZM5jzjXw/Mb0bMeiymk4TnJLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 047/102] hsr: use rcu_read_lock() in hsr_get_node_{list/status}()
Date:   Wed,  1 Apr 2020 18:17:50 +0200
Message-Id: <20200401161541.683370714@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 173756b86803655d70af7732079b3aa935e6ab68 ]

hsr_get_node_{list/status}() are not under rtnl_lock() because
they are callback functions of generic netlink.
But they use __dev_get_by_index() without rtnl_lock().
So, it would use unsafe data.
In order to fix it, rcu_read_lock() and dev_get_by_index_rcu()
are used instead of __dev_get_by_index().

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/hsr/hsr_framereg.c |   10 ++--------
 net/hsr/hsr_netlink.c  |   43 +++++++++++++++++++++----------------------
 2 files changed, 23 insertions(+), 30 deletions(-)

--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -468,13 +468,9 @@ int hsr_get_node_data(struct hsr_priv *h
 	struct hsr_port *port;
 	unsigned long tdiff;
 
-
-	rcu_read_lock();
 	node = find_node_by_AddrA(&hsr->node_db, addr);
-	if (!node) {
-		rcu_read_unlock();
-		return -ENOENT;	/* No such entry */
-	}
+	if (!node)
+		return -ENOENT;
 
 	ether_addr_copy(addr_b, node->MacAddressB);
 
@@ -509,7 +505,5 @@ int hsr_get_node_data(struct hsr_priv *h
 		*addr_b_ifindex = -1;
 	}
 
-	rcu_read_unlock();
-
 	return 0;
 }
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -264,17 +264,16 @@ static int hsr_get_node_status(struct sk
 	if (!na)
 		goto invalid;
 
-	hsr_dev = __dev_get_by_index(genl_info_net(info),
-					nla_get_u32(info->attrs[HSR_A_IFINDEX]));
+	rcu_read_lock();
+	hsr_dev = dev_get_by_index_rcu(genl_info_net(info),
+				       nla_get_u32(info->attrs[HSR_A_IFINDEX]));
 	if (!hsr_dev)
-		goto invalid;
+		goto rcu_unlock;
 	if (!is_hsr_master(hsr_dev))
-		goto invalid;
-
+		goto rcu_unlock;
 
 	/* Send reply */
-
-	skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
 	if (!skb_out) {
 		res = -ENOMEM;
 		goto fail;
@@ -326,12 +325,10 @@ static int hsr_get_node_status(struct sk
 	res = nla_put_u16(skb_out, HSR_A_IF1_SEQ, hsr_node_if1_seq);
 	if (res < 0)
 		goto nla_put_failure;
-	rcu_read_lock();
 	port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_A);
 	if (port)
 		res = nla_put_u32(skb_out, HSR_A_IF1_IFINDEX,
 				  port->dev->ifindex);
-	rcu_read_unlock();
 	if (res < 0)
 		goto nla_put_failure;
 
@@ -341,20 +338,22 @@ static int hsr_get_node_status(struct sk
 	res = nla_put_u16(skb_out, HSR_A_IF2_SEQ, hsr_node_if2_seq);
 	if (res < 0)
 		goto nla_put_failure;
-	rcu_read_lock();
 	port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
 	if (port)
 		res = nla_put_u32(skb_out, HSR_A_IF2_IFINDEX,
 				  port->dev->ifindex);
-	rcu_read_unlock();
 	if (res < 0)
 		goto nla_put_failure;
 
+	rcu_read_unlock();
+
 	genlmsg_end(skb_out, msg_head);
 	genlmsg_unicast(genl_info_net(info), skb_out, info->snd_portid);
 
 	return 0;
 
+rcu_unlock:
+	rcu_read_unlock();
 invalid:
 	netlink_ack(skb_in, nlmsg_hdr(skb_in), -EINVAL);
 	return 0;
@@ -364,6 +363,7 @@ nla_put_failure:
 	/* Fall through */
 
 fail:
+	rcu_read_unlock();
 	return res;
 }
 
@@ -390,17 +390,16 @@ static int hsr_get_node_list(struct sk_b
 	if (!na)
 		goto invalid;
 
-	hsr_dev = __dev_get_by_index(genl_info_net(info),
-				     nla_get_u32(info->attrs[HSR_A_IFINDEX]));
+	rcu_read_lock();
+	hsr_dev = dev_get_by_index_rcu(genl_info_net(info),
+				       nla_get_u32(info->attrs[HSR_A_IFINDEX]));
 	if (!hsr_dev)
-		goto invalid;
+		goto rcu_unlock;
 	if (!is_hsr_master(hsr_dev))
-		goto invalid;
-
+		goto rcu_unlock;
 
 	/* Send reply */
-
-	skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
 	if (!skb_out) {
 		res = -ENOMEM;
 		goto fail;
@@ -420,14 +419,11 @@ static int hsr_get_node_list(struct sk_b
 
 	hsr = netdev_priv(hsr_dev);
 
-	rcu_read_lock();
 	pos = hsr_get_next_node(hsr, NULL, addr);
 	while (pos) {
 		res = nla_put(skb_out, HSR_A_NODE_ADDR, ETH_ALEN, addr);
-		if (res < 0) {
-			rcu_read_unlock();
+		if (res < 0)
 			goto nla_put_failure;
-		}
 		pos = hsr_get_next_node(hsr, pos, addr);
 	}
 	rcu_read_unlock();
@@ -437,6 +433,8 @@ static int hsr_get_node_list(struct sk_b
 
 	return 0;
 
+rcu_unlock:
+	rcu_read_unlock();
 invalid:
 	netlink_ack(skb_in, nlmsg_hdr(skb_in), -EINVAL);
 	return 0;
@@ -446,6 +444,7 @@ nla_put_failure:
 	/* Fall through */
 
 fail:
+	rcu_read_unlock();
 	return res;
 }
 


