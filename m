Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEC4C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BF824959
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340204;
	bh=JY0Nj+7m8acZNs/CIz9lJXTZoivNcgCK7t1p2UfkP9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=16YN4MR7sY2OqMnWXvoJYMmPZTJkL20pRj9zRBvEqJxVNqdndVWSb35bwuzj+RhLn
	 oOvNzbLnhXhKxXkA/ghIn/Xf926BAIdEzqSyXJrEsar7FOdaVsYO17A/dVD2Y2bLVf
	 y4zPTO0CuNwwJNBzb2/4ZNEeSbzp0oN96oXv/wiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgEANgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbgEANge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:36:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8FE208DB;
        Fri,  1 May 2020 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340193;
        bh=JY0Nj+7m8acZNs/CIz9lJXTZoivNcgCK7t1p2UfkP9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PymWCe2/JSM1OSTpSNhi1uBpzhMMLx/PaKgHn8n0bP9ydsJWBUFvlps0kVoVADvrL
         ZPKBTO8nIxdjRTi5J4vCKj0B3+pJr880gygb3C7JrZM6UpZNX9MAQDK3z6gHnSxIYt
         8VvOmd7mubyVcznxjUgnQkZRpFVBcKcjuPG8poe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 13/46] rxrpc: Fix DATA Tx to disable nofrag for UDP on AF_INET6 socket
Date:   Fri,  1 May 2020 15:22:38 +0200
Message-Id: <20200501131503.381140243@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 0e631eee17dcea576ab922fa70e4fdbd596ee452 upstream.

Fix the DATA packet transmission to disable nofrag for UDPv4 on an AF_INET6
socket as well as UDPv6 when trying to transmit fragmentably.

Without this, packets filled to the normal size used by the kernel AFS
client of 1412 bytes be rejected by udp_sendmsg() with EMSGSIZE
immediately.  The ->sk_error_report() notification hook is called, but
rxrpc doesn't generate a trace for it.

This is a temporary fix; a more permanent solution needs to involve
changing the size of the packets being filled in accordance with the MTU,
which isn't currently done in AF_RXRPC.  The reason for not doing so was
that, barring the last packet in an rx jumbo packet, jumbos can only be
assembled out of 1412-byte packets - and the plan was to construct jumbos
on the fly at transmission time.

Also, there's no point turning on IPV6_MTU_DISCOVER, since IPv6 has to
engage in this anyway since fragmentation is only done by the sender.  We
can then condense the switch-statement in rxrpc_send_data_packet().

Fixes: 75b54cb57ca3 ("rxrpc: Add IPv6 support")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rxrpc/local_object.c |    9 ---------
 net/rxrpc/output.c       |   42 +++++++++++-------------------------------
 2 files changed, 11 insertions(+), 40 deletions(-)

--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -169,15 +169,6 @@ static int rxrpc_open_socket(struct rxrp
 			goto error;
 		}
 
-		/* we want to set the don't fragment bit */
-		opt = IPV6_PMTUDISC_DO;
-		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_MTU_DISCOVER,
-					(char *) &opt, sizeof(opt));
-		if (ret < 0) {
-			_debug("setsockopt failed");
-			goto error;
-		}
-
 		/* Fall through and set IPv4 options too otherwise we don't get
 		 * errors from IPv4 packets sent through the IPv6 socket.
 		 */
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -480,41 +480,21 @@ send_fragmentable:
 	skb->tstamp = ktime_get_real();
 
 	switch (conn->params.local->srx.transport.family) {
+	case AF_INET6:
 	case AF_INET:
 		opt = IP_PMTUDISC_DONT;
-		ret = kernel_setsockopt(conn->params.local->socket,
-					SOL_IP, IP_MTU_DISCOVER,
-					(char *)&opt, sizeof(opt));
-		if (ret == 0) {
-			ret = kernel_sendmsg(conn->params.local->socket, &msg,
-					     iov, 2, len);
-			conn->params.peer->last_tx_at = ktime_get_seconds();
-
-			opt = IP_PMTUDISC_DO;
-			kernel_setsockopt(conn->params.local->socket, SOL_IP,
-					  IP_MTU_DISCOVER,
-					  (char *)&opt, sizeof(opt));
-		}
-		break;
-
-#ifdef CONFIG_AF_RXRPC_IPV6
-	case AF_INET6:
-		opt = IPV6_PMTUDISC_DONT;
-		ret = kernel_setsockopt(conn->params.local->socket,
-					SOL_IPV6, IPV6_MTU_DISCOVER,
-					(char *)&opt, sizeof(opt));
-		if (ret == 0) {
-			ret = kernel_sendmsg(conn->params.local->socket, &msg,
-					     iov, 2, len);
-			conn->params.peer->last_tx_at = ktime_get_seconds();
+		kernel_setsockopt(conn->params.local->socket,
+				  SOL_IP, IP_MTU_DISCOVER,
+				  (char *)&opt, sizeof(opt));
+		ret = kernel_sendmsg(conn->params.local->socket, &msg,
+				     iov, 2, len);
+		conn->params.peer->last_tx_at = ktime_get_seconds();
 
-			opt = IPV6_PMTUDISC_DO;
-			kernel_setsockopt(conn->params.local->socket,
-					  SOL_IPV6, IPV6_MTU_DISCOVER,
-					  (char *)&opt, sizeof(opt));
-		}
+		opt = IP_PMTUDISC_DO;
+		kernel_setsockopt(conn->params.local->socket,
+				  SOL_IP, IP_MTU_DISCOVER,
+				  (char *)&opt, sizeof(opt));
 		break;
-#endif
 
 	default:
 		BUG();


