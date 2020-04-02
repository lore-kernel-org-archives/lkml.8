Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45382C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FEB20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585848784;
	bh=xVubXSQwXk7yBqdt3AgqFuiQCQHJa0pYhL2JWHLyChs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tsg3I5AdG79VH7rC/BTht78QEWCf17CEw3Wp5qlqjCmEuSbPw8OHaDLO36eoh/2vu
	 aVAcoGWcVqBKR5FOAmWI4lOlSUHLkR73aFEgl4TzTyqnAnDs+PQbQbjH5Lh6ranFuj
	 ZQ2EO/IVF0esSOf3KNqO2nB++P+wHqNH4axedAeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbgDBRdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389964AbgDBRdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:33:01 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827D120737;
        Thu,  2 Apr 2020 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585848780;
        bh=xVubXSQwXk7yBqdt3AgqFuiQCQHJa0pYhL2JWHLyChs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZY38EB/KYmIY92JRPQYceCjrw+1CP8az5Lj2VjOxcdRjOGGJ+ZxVSWubPn7wc/U+s
         LeK1/UUmxZt5rPSFBDjVH2htLBfVfDiJyM05kSTzd3q2jAbY+qfWgvGRwcvWgXST0V
         YIDxoxjFJJFpa27kOU/8OoN12Tkz+HeJ1dOqTJYU=
From:   Will Deacon <will@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, g.nault@alphalink.fr,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 2/8] net: l2tp: Make l2tp_ip6 namespace aware
Date:   Thu,  2 Apr 2020 18:32:44 +0100
Message-Id: <20200402173250.7858-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402173250.7858-1-will@kernel.org>
References: <20200402173250.7858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shmulik Ladkani <shmulik.ladkani@gmail.com>

commit 0e6b5259824e97a0f7e7b450421ff12865d3b0e2 upstream.

l2tp_ip6 tunnel and session lookups were still using init_net, although
the l2tp core infrastructure already supports lookups keyed by 'net'.

As a result, l2tp_ip6_recv discarded packets for tunnels/sessions
created in namespaces other than the init_net.

Fix, by using dev_net(skb->dev) or sock_net(sk) where appropriate.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/l2tp/l2tp_ip6.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index a88649c5d26c..391dd9d8144f 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -127,6 +127,7 @@ static inline struct sock *l2tp_ip6_bind_lookup(struct net *net,
  */
 static int l2tp_ip6_recv(struct sk_buff *skb)
 {
+	struct net *net = dev_net(skb->dev);
 	struct sock *sk;
 	u32 session_id;
 	u32 tunnel_id;
@@ -153,7 +154,7 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 	}
 
 	/* Ok, this is a data packet. Lookup the session. */
-	session = l2tp_session_find(&init_net, NULL, session_id);
+	session = l2tp_session_find(net, NULL, session_id);
 	if (session == NULL)
 		goto discard;
 
@@ -190,7 +191,7 @@ pass_up:
 		goto discard;
 
 	tunnel_id = ntohl(*(__be32 *) &skb->data[4]);
-	tunnel = l2tp_tunnel_find(&init_net, tunnel_id);
+	tunnel = l2tp_tunnel_find(net, tunnel_id);
 	if (tunnel) {
 		sk = tunnel->sock;
 		sock_hold(sk);
@@ -198,7 +199,7 @@ pass_up:
 		struct ipv6hdr *iph = ipv6_hdr(skb);
 
 		read_lock_bh(&l2tp_ip6_lock);
-		sk = __l2tp_ip6_bind_lookup(&init_net, &iph->daddr,
+		sk = __l2tp_ip6_bind_lookup(net, &iph->daddr,
 					    0, tunnel_id);
 		if (!sk) {
 			read_unlock_bh(&l2tp_ip6_lock);
@@ -267,6 +268,7 @@ static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct sockaddr_l2tpip6 *addr = (struct sockaddr_l2tpip6 *) uaddr;
+	struct net *net = sock_net(sk);
 	__be32 v4addr = 0;
 	int addr_type;
 	int err;
@@ -288,7 +290,7 @@ static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	err = -EADDRINUSE;
 	read_lock_bh(&l2tp_ip6_lock);
-	if (__l2tp_ip6_bind_lookup(&init_net, &addr->l2tp_addr,
+	if (__l2tp_ip6_bind_lookup(net, &addr->l2tp_addr,
 				   sk->sk_bound_dev_if, addr->l2tp_conn_id))
 		goto out_in_use;
 	read_unlock_bh(&l2tp_ip6_lock);
@@ -461,7 +463,7 @@ static int l2tp_ip6_backlog_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 drop:
-	IP_INC_STATS(&init_net, IPSTATS_MIB_INDISCARDS);
+	IP_INC_STATS(sock_net(sk), IPSTATS_MIB_INDISCARDS);
 	kfree_skb(skb);
 	return -1;
 }
-- 
2.26.0.rc2.310.g2932bb562d-goog

