Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A49C3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F70C208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258876;
	bh=RBkE2p+p1wkYJ94iTvM47rJcXwsX+MC8/AcJdXC+qCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=edyXB19LeBq6Nm3dWmHDNQLQa5XrDP4ZomoozyRz5Tv2jtd4Z56BSqJHSkKcb2xg2
	 q/LhoWRxhLHxJnNlcF4M1/q/Fx5sWgIdRdsIaYDl4wTmHTij8X3D9MkDxdLrKzAQ4u
	 aurqYIp+YrXuQBbr7Q7KTnKy45SScWq2eNujzMW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbgCCRyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732478AbgCCRyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:54:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2A62146E;
        Tue,  3 Mar 2020 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258046;
        bh=RBkE2p+p1wkYJ94iTvM47rJcXwsX+MC8/AcJdXC+qCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvfc2I6yxx6pAKIXUzAanC4HzDGz+Wqm8cAJlwlzFB5M0/nQ7KN/WX8haHPzHZoue
         omTmJg0zBCsL4jJzNqyMBL7tNWapsBvLfiRsy8UexfKPqVmjCiyQmpmYX6J6KS4SMc
         0m8TNsrBkmqH8/kN6GNcZ0fqD9gdAlP34pYGzmjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Roskin <plroskin@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 013/152] udp: rehash on disconnect
Date:   Tue,  3 Mar 2020 18:41:51 +0100
Message-Id: <20200303174304.011342222@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 303d0403b8c25e994e4a6e45389e173cf8706fb5 ]

As of the below commit, udp sockets bound to a specific address can
coexist with one bound to the any addr for the same port.

The commit also phased out the use of socket hashing based only on
port (hslot), in favor of always hashing on {addr, port} (hslot2).

The change broke the following behavior with disconnect (AF_UNSPEC):

    server binds to 0.0.0.0:1337
    server connects to 127.0.0.1:80
    server disconnects
    client connects to 127.0.0.1:1337
    client sends "hello"
    server reads "hello"	// times out, packet did not find sk

On connect the server acquires a specific source addr suitable for
routing to its destination. On disconnect it reverts to the any addr.

The connect call triggers a rehash to a different hslot2. On
disconnect, add the same to return to the original hslot2.

Skip this step if the socket is going to be unhashed completely.

Fixes: 4cdeeee9252a ("net: udp: prefer listeners bound to an address")
Reported-by: Pavel Roskin <plroskin@gmail.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1856,8 +1856,12 @@ int __udp_disconnect(struct sock *sk, in
 	inet->inet_dport = 0;
 	sock_rps_reset_rxhash(sk);
 	sk->sk_bound_dev_if = 0;
-	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
+	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
 		inet_reset_saddr(sk);
+		if (sk->sk_prot->rehash &&
+		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK))
+			sk->sk_prot->rehash(sk);
+	}
 
 	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
 		sk->sk_prot->unhash(sk);


