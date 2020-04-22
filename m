Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236AC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835CA20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553302;
	bh=G4im9AdlOXfDKoQn1m8PR/bnrn+ah8nqq88MXdYNarU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PgWVo2BDG7uNW3U/ayQ/S5PG7yFP5q4XnAr/5rYCFsRwGkCDjGOdWwmfgs3aerEAY
	 wwHaX5zyE4Rp3PnAFvYjyEaaVpKI6oEz8B0/BDOzsgueM4u7c/QLXU8GE4o+Uy9ksB
	 KN+unpejo6Ll7je3WVaeclkArqBTjyG/+P9kMOMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgDVLBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgDVKBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:01:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D73020776;
        Wed, 22 Apr 2020 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549669;
        bh=G4im9AdlOXfDKoQn1m8PR/bnrn+ah8nqq88MXdYNarU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bf8DHVrr718GP4sYb3VhAFk/fAKBoa6KQRWew2dJPiStFkhuc/y4RqzD31ManH4kF
         MO/GjBq23CI0aEATmiHde7+2Rqqg5WZJZiilblMChrxlE6fuwo+gJXM50SxlGeNNhu
         6pgA6hfBDAUK4NiETsMATquIFdR+RZ/CFtSbQDzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taras Chornyi <taras.chornyi@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 056/100] net: ipv4: devinet: Fix crash when add/del multicast IP with autojoin
Date:   Wed, 22 Apr 2020 11:56:26 +0200
Message-Id: <20200422095033.205387451@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taras Chornyi <taras.chornyi@plvision.eu>

[ Upstream commit 690cc86321eb9bcee371710252742fb16fe96824 ]

When CONFIG_IP_MULTICAST is not set and multicast ip is added to the device
with autojoin flag or when multicast ip is deleted kernel will crash.

steps to reproduce:

ip addr add 224.0.0.0/32 dev eth0
ip addr del 224.0.0.0/32 dev eth0

or

ip addr add 224.0.0.0/32 dev eth0 autojoin

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000088
 pc : _raw_write_lock_irqsave+0x1e0/0x2ac
 lr : lock_sock_nested+0x1c/0x60
 Call trace:
  _raw_write_lock_irqsave+0x1e0/0x2ac
  lock_sock_nested+0x1c/0x60
  ip_mc_config.isra.28+0x50/0xe0
  inet_rtm_deladdr+0x1a8/0x1f0
  rtnetlink_rcv_msg+0x120/0x350
  netlink_rcv_skb+0x58/0x120
  rtnetlink_rcv+0x14/0x20
  netlink_unicast+0x1b8/0x270
  netlink_sendmsg+0x1a0/0x3b0
  ____sys_sendmsg+0x248/0x290
  ___sys_sendmsg+0x80/0xc0
  __sys_sendmsg+0x68/0xc0
  __arm64_sys_sendmsg+0x20/0x30
  el0_svc_common.constprop.2+0x88/0x150
  do_el0_svc+0x20/0x80
 el0_sync_handler+0x118/0x190
  el0_sync+0x140/0x180

Fixes: 93a714d6b53d ("multicast: Extend ip address command to enable multicast group join/leave on")
Signed-off-by: Taras Chornyi <taras.chornyi@plvision.eu>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/devinet.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -560,12 +560,15 @@ struct in_ifaddr *inet_ifa_byprefix(stru
 	return NULL;
 }
 
-static int ip_mc_config(struct sock *sk, bool join, const struct in_ifaddr *ifa)
+static int ip_mc_autojoin_config(struct net *net, bool join,
+				 const struct in_ifaddr *ifa)
 {
+#if defined(CONFIG_IP_MULTICAST)
 	struct ip_mreqn mreq = {
 		.imr_multiaddr.s_addr = ifa->ifa_address,
 		.imr_ifindex = ifa->ifa_dev->dev->ifindex,
 	};
+	struct sock *sk = net->ipv4.mc_autojoin_sk;
 	int ret;
 
 	ASSERT_RTNL();
@@ -578,6 +581,9 @@ static int ip_mc_config(struct sock *sk,
 	release_sock(sk);
 
 	return ret;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh)
@@ -617,7 +623,7 @@ static int inet_rtm_deladdr(struct sk_bu
 			continue;
 
 		if (ipv4_is_multicast(ifa->ifa_address))
-			ip_mc_config(net->ipv4.mc_autojoin_sk, false, ifa);
+			ip_mc_autojoin_config(net, false, ifa);
 		__inet_del_ifa(in_dev, ifap, 1, nlh, NETLINK_CB(skb).portid);
 		return 0;
 	}
@@ -873,8 +879,7 @@ static int inet_rtm_newaddr(struct sk_bu
 		 */
 		set_ifa_lifetime(ifa, valid_lft, prefered_lft);
 		if (ifa->ifa_flags & IFA_F_MCAUTOJOIN) {
-			int ret = ip_mc_config(net->ipv4.mc_autojoin_sk,
-					       true, ifa);
+			int ret = ip_mc_autojoin_config(net, true, ifa);
 
 			if (ret < 0) {
 				inet_free_ifa(ifa);


