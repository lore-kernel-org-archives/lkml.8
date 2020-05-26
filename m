Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AA9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189E220E65
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519382;
	bh=o/jdbYgqxoIqWH8TuofPAQE8atoxvsnCieF1qOSh428=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGYhMUj8OVT2ll7LH9zReB5s7CeaEnu1mWIU/3bSB5sfW8xnMxpGYCLnErd0/xgU7
	 9A6tpI19xzUhrUukKNepFU+7BLHdK6Vt5B3XzfFpRBchknwt8o33qoa516Dac/bS+7
	 Stb2UKuizjUaHuo84/3NcYUmyjBIhwtn1j5GLtC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbgEZS4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389769AbgEZS4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:56:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E738A2086A;
        Tue, 26 May 2020 18:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519375;
        bh=o/jdbYgqxoIqWH8TuofPAQE8atoxvsnCieF1qOSh428=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuLCg0uqhDyY1bqyKxznjRjFET7urNcMwjAvewhq9C8WowgP7jyfbUaim9uJw4B7X
         ZF7r2YF4xcpNN5a5P68QZUVvy5o4+G/0tuOGErpGdweGBXqezZ9gMBVSg8i2/RC/RL
         NTtZOd/C96Y0jJxwtW8QOjIcLCVK0TxHeRWbbVlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "R. Parameswaran" <rparames@brocade.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.4 42/65] New kernel function to get IP overhead on a socket.
Date:   Tue, 26 May 2020 20:53:01 +0200
Message-Id: <20200526183920.541009923@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "R. Parameswaran" <parameswaran.r7@gmail.com>

commit 113c3075931a334f899008f6c753abe70a3a9323 upstream.

A new function, kernel_sock_ip_overhead(), is provided
to calculate the cumulative overhead imposed by the IP
Header and IP options, if any, on a socket's payload.
The new function returns an overhead of zero for sockets
that do not belong to the IPv4 or IPv6 address families.
This is used in the L2TP code path to compute the
total outer IP overhead on the L2TP tunnel socket when
calculating the default MTU for Ethernet pseudowires.

Signed-off-by: R. Parameswaran <rparames@brocade.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/net.h |    3 +++
 net/socket.c        |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -291,6 +291,9 @@ int kernel_sendpage(struct socket *sock,
 int kernel_sock_ioctl(struct socket *sock, int cmd, unsigned long arg);
 int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how);
 
+/* Following routine returns the IP overhead imposed by a socket.  */
+u32 kernel_sock_ip_overhead(struct sock *sk);
+
 #define MODULE_ALIAS_NETPROTO(proto) \
 	MODULE_ALIAS("net-pf-" __stringify(proto))
 
--- a/net/socket.c
+++ b/net/socket.c
@@ -3304,3 +3304,49 @@ int kernel_sock_shutdown(struct socket *
 	return sock->ops->shutdown(sock, how);
 }
 EXPORT_SYMBOL(kernel_sock_shutdown);
+
+/* This routine returns the IP overhead imposed by a socket i.e.
+ * the length of the underlying IP header, depending on whether
+ * this is an IPv4 or IPv6 socket and the length from IP options turned
+ * on at the socket.
+ */
+u32 kernel_sock_ip_overhead(struct sock *sk)
+{
+	struct inet_sock *inet;
+	struct ip_options_rcu *opt;
+	u32 overhead = 0;
+	bool owned_by_user;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct ipv6_pinfo *np;
+	struct ipv6_txoptions *optv6 = NULL;
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+
+	if (!sk)
+		return overhead;
+
+	owned_by_user = sock_owned_by_user(sk);
+	switch (sk->sk_family) {
+	case AF_INET:
+		inet = inet_sk(sk);
+		overhead += sizeof(struct iphdr);
+		opt = rcu_dereference_protected(inet->inet_opt,
+						owned_by_user);
+		if (opt)
+			overhead += opt->opt.optlen;
+		return overhead;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		np = inet6_sk(sk);
+		overhead += sizeof(struct ipv6hdr);
+		if (np)
+			optv6 = rcu_dereference_protected(np->opt,
+							  owned_by_user);
+		if (optv6)
+			overhead += (optv6->opt_flen + optv6->opt_nflen);
+		return overhead;
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+	default: /* Returns 0 overhead if the socket is not ipv4 or ipv6 */
+		return overhead;
+	}
+}
+EXPORT_SYMBOL(kernel_sock_ip_overhead);


