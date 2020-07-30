Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D8EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F332C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096401;
	bh=hmR68HHAxwJGc9KMOu2OPGMn7a+StS9X8sZSVsjPbws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zt79BfnV4H4t2cOqqxOs3iUQOL5yaraK16+hOkf/RpWoU9YX1PZSdRg5+f9gTeJGk
	 RZUVyUy3e3N7yyZjXyjX1/OoKli2p9Lw1HCLYu2KibbWrZdMZK03L5N0ngVOS2EK3A
	 0Kzs0E0tDhdr7XZOy+lRzqsLpR9SMXAYZnozFOxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgG3IGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgG3IGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:06:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C25E920656;
        Thu, 30 Jul 2020 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096372;
        bh=hmR68HHAxwJGc9KMOu2OPGMn7a+StS9X8sZSVsjPbws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crlIvxhaka63oLYOcBaPmh3kJh+8yrvOEPE392vIrKP2oA6f/zw8DA2P5L/nfMJhM
         0qwYX8I2nw93vFaYQKPSdTjzF29pnQcxqtXAazkJLzt3Be5SX4WIibyLZu/qrQQxRY
         F+OgJHSXVIfGpDfqrR0fKTTYtfmAxGWRT3U9t1WI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 16/19] udp: Improve load balancing for SO_REUSEPORT.
Date:   Thu, 30 Jul 2020 10:04:18 +0200
Message-Id: <20200730074421.306947214@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.502923740@linuxfoundation.org>
References: <20200730074420.502923740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.co.jp>

[ Upstream commit efc6b6f6c3113e8b203b9debfb72d81e0f3dcace ]

Currently, SO_REUSEPORT does not work well if connected sockets are in a
UDP reuseport group.

Then reuseport_has_conns() returns true and the result of
reuseport_select_sock() is discarded. Also, unconnected sockets have the
same score, hence only does the first unconnected socket in udp_hslot
always receive all packets sent to unconnected sockets.

So, the result of reuseport_select_sock() should be used for load
balancing.

The noteworthy point is that the unconnected sockets placed after
connected sockets in sock_reuseport.socks will receive more packets than
others because of the algorithm in reuseport_select_sock().

    index | connected | reciprocal_scale | result
    ---------------------------------------------
    0     | no        | 20%              | 40%
    1     | no        | 20%              | 20%
    2     | yes       | 20%              | 0%
    3     | no        | 20%              | 40%
    4     | yes       | 20%              | 0%

If most of the sockets are connected, this can be a problem, but it still
works better than now.

Fixes: acdcecc61285 ("udp: correct reuseport selection with connected sockets")
CC: Willem de Bruijn <willemb@google.com>
Reviewed-by: Benjamin Herrenschmidt <benh@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |   15 +++++++++------
 net/ipv6/udp.c |   15 +++++++++------
 2 files changed, 18 insertions(+), 12 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -413,7 +413,7 @@ static struct sock *udp4_lib_lookup2(str
 				     struct udp_hslot *hslot2,
 				     struct sk_buff *skb)
 {
-	struct sock *sk, *result;
+	struct sock *sk, *result, *reuseport_result;
 	int score, badness;
 	u32 hash = 0;
 
@@ -423,17 +423,20 @@ static struct sock *udp4_lib_lookup2(str
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
+			reuseport_result = NULL;
+
 			if (sk->sk_reuseport &&
 			    sk->sk_state != TCP_ESTABLISHED) {
 				hash = udp_ehashfn(net, daddr, hnum,
 						   saddr, sport);
-				result = reuseport_select_sock(sk, hash, skb,
-							sizeof(struct udphdr));
-				if (result && !reuseport_has_conns(sk, false))
-					return result;
+				reuseport_result = reuseport_select_sock(sk, hash, skb,
+									 sizeof(struct udphdr));
+				if (reuseport_result && !reuseport_has_conns(sk, false))
+					return reuseport_result;
 			}
+
+			result = reuseport_result ? : sk;
 			badness = score;
-			result = sk;
 		}
 	}
 	return result;
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -148,7 +148,7 @@ static struct sock *udp6_lib_lookup2(str
 		int dif, int sdif, struct udp_hslot *hslot2,
 		struct sk_buff *skb)
 {
-	struct sock *sk, *result;
+	struct sock *sk, *result, *reuseport_result;
 	int score, badness;
 	u32 hash = 0;
 
@@ -158,17 +158,20 @@ static struct sock *udp6_lib_lookup2(str
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
+			reuseport_result = NULL;
+
 			if (sk->sk_reuseport &&
 			    sk->sk_state != TCP_ESTABLISHED) {
 				hash = udp6_ehashfn(net, daddr, hnum,
 						    saddr, sport);
 
-				result = reuseport_select_sock(sk, hash, skb,
-							sizeof(struct udphdr));
-				if (result && !reuseport_has_conns(sk, false))
-					return result;
+				reuseport_result = reuseport_select_sock(sk, hash, skb,
+									 sizeof(struct udphdr));
+				if (reuseport_result && !reuseport_has_conns(sk, false))
+					return reuseport_result;
 			}
-			result = sk;
+
+			result = reuseport_result ? : sk;
 			badness = score;
 		}
 	}


