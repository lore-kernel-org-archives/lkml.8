Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12715C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FF520716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597685717;
	bh=+RjtoMXfi5nM0xHjJHVcjEt1tdqpHEiBMxfBhtLK/uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pvbCCrC7sJRths0cGq8M7jq5bq3vrFK414+VjuteG+L14RyJD7NN7FciBLqGn+2jf
	 /umiyqIR9mkvTEuTlFhDUh6K+IiVxv8YOqorqQuicIFjaPC9qDH53phQcWzIa73F/I
	 KY24OjQkABP/ixIjOE5kHdaSn14K/aLMMmu8Yln0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgHQRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbgHQQRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:17:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FFEC22BEA;
        Mon, 17 Aug 2020 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597681063;
        bh=+RjtoMXfi5nM0xHjJHVcjEt1tdqpHEiBMxfBhtLK/uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M53BPLl2wZH+nSBU9WzvJyJR4gc6XHG1emi+IDGBY4+Z9akXq6X5d8UPnSFFuNyzH
         sOJLMvBVcsP+dov2DvlecDgqE5u82LxsRkotIUh9197QwWDzzwoyzzywem8x1N32Ne
         w+908E902LSCk7DJ1pn+ZcoZYrPk3z1s4bBHpX5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Tim Froidcoeur <tim.froidcoeur@tessares.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 136/168] net: refactor bind_bucket fastreuse into helper
Date:   Mon, 17 Aug 2020 17:17:47 +0200
Message-Id: <20200817143740.496196974@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Froidcoeur <tim.froidcoeur@tessares.net>

[ Upstream commit 62ffc589abb176821662efc4525ee4ac0b9c3894 ]

Refactor the fastreuse update code in inet_csk_get_port into a small
helper function that can be called from other places.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_connection_sock.h |    4 +
 net/ipv4/inet_connection_sock.c    |   93 ++++++++++++++++++++-----------------
 2 files changed, 55 insertions(+), 42 deletions(-)

--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -313,5 +313,9 @@ int inet_csk_compat_getsockopt(struct so
 int inet_csk_compat_setsockopt(struct sock *sk, int level, int optname,
 			       char __user *optval, unsigned int optlen);
 
+/* update the fast reuse flag when adding a socket */
+void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
+			       struct sock *sk);
+
 struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
 #endif /* _INET_CONNECTION_SOCK_H */
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -285,51 +285,12 @@ static inline int sk_reuseport_match(str
 				    ipv6_only_sock(sk), true, false);
 }
 
-/* Obtain a reference to a local port for the given sock,
- * if snum is zero it means select any available local port.
- * We try to allocate an odd port (and leave even ports for connect())
- */
-int inet_csk_get_port(struct sock *sk, unsigned short snum)
+void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
+			       struct sock *sk)
 {
-	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
-	struct inet_hashinfo *hinfo = sk->sk_prot->h.hashinfo;
-	int ret = 1, port = snum;
-	struct inet_bind_hashbucket *head;
-	struct net *net = sock_net(sk);
-	struct inet_bind_bucket *tb = NULL;
 	kuid_t uid = sock_i_uid(sk);
+	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 
-	if (!port) {
-		head = inet_csk_find_open_port(sk, &tb, &port);
-		if (!head)
-			return ret;
-		if (!tb)
-			goto tb_not_found;
-		goto success;
-	}
-	head = &hinfo->bhash[inet_bhashfn(net, port,
-					  hinfo->bhash_size)];
-	spin_lock_bh(&head->lock);
-	inet_bind_bucket_for_each(tb, &head->chain)
-		if (net_eq(ib_net(tb), net) && tb->port == port)
-			goto tb_found;
-tb_not_found:
-	tb = inet_bind_bucket_create(hinfo->bind_bucket_cachep,
-				     net, head, port);
-	if (!tb)
-		goto fail_unlock;
-tb_found:
-	if (!hlist_empty(&tb->owners)) {
-		if (sk->sk_reuse == SK_FORCE_REUSE)
-			goto success;
-
-		if ((tb->fastreuse > 0 && reuse) ||
-		    sk_reuseport_match(tb, sk))
-			goto success;
-		if (inet_csk_bind_conflict(sk, tb, true, true))
-			goto fail_unlock;
-	}
-success:
 	if (hlist_empty(&tb->owners)) {
 		tb->fastreuse = reuse;
 		if (sk->sk_reuseport) {
@@ -373,6 +334,54 @@ success:
 			tb->fastreuseport = 0;
 		}
 	}
+}
+
+/* Obtain a reference to a local port for the given sock,
+ * if snum is zero it means select any available local port.
+ * We try to allocate an odd port (and leave even ports for connect())
+ */
+int inet_csk_get_port(struct sock *sk, unsigned short snum)
+{
+	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
+	struct inet_hashinfo *hinfo = sk->sk_prot->h.hashinfo;
+	int ret = 1, port = snum;
+	struct inet_bind_hashbucket *head;
+	struct net *net = sock_net(sk);
+	struct inet_bind_bucket *tb = NULL;
+
+	if (!port) {
+		head = inet_csk_find_open_port(sk, &tb, &port);
+		if (!head)
+			return ret;
+		if (!tb)
+			goto tb_not_found;
+		goto success;
+	}
+	head = &hinfo->bhash[inet_bhashfn(net, port,
+					  hinfo->bhash_size)];
+	spin_lock_bh(&head->lock);
+	inet_bind_bucket_for_each(tb, &head->chain)
+		if (net_eq(ib_net(tb), net) && tb->port == port)
+			goto tb_found;
+tb_not_found:
+	tb = inet_bind_bucket_create(hinfo->bind_bucket_cachep,
+				     net, head, port);
+	if (!tb)
+		goto fail_unlock;
+tb_found:
+	if (!hlist_empty(&tb->owners)) {
+		if (sk->sk_reuse == SK_FORCE_REUSE)
+			goto success;
+
+		if ((tb->fastreuse > 0 && reuse) ||
+		    sk_reuseport_match(tb, sk))
+			goto success;
+		if (inet_csk_bind_conflict(sk, tb, true, true))
+			goto fail_unlock;
+	}
+success:
+	inet_csk_update_fastreuse(tb, sk);
+
 	if (!inet_csk(sk)->icsk_bind_hash)
 		inet_bind_hash(sk, tb, port);
 	WARN_ON(inet_csk(sk)->icsk_bind_hash != tb);


