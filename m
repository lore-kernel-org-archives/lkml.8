Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076832074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097209;
	bh=0ioCQzJuIh4SZTx9jd4csrdZrxwG7MVYguD9O9348JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsKUbvs1xMOyLt/03Sf+qz9xcq1MixZ9YMeKWHQpz8i19J8WyQSoQUeX80EcfVUoH
	 6bW/o+pUOD0rckHX3eOGmUL3an4DiK7abx/Y6eknfUJ8LvdJ44SV72p0XGpQ8s6DjV
	 U5b0jfOHmCDoX5xznI0khBiFJoNqSksz5mxh4wm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgG3IUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbgG3IHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:07:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A17720672;
        Thu, 30 Jul 2020 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096432;
        bh=0ioCQzJuIh4SZTx9jd4csrdZrxwG7MVYguD9O9348JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ce/85UGTYXUHmyrqAeAgJVcEs2kfUYW7LA6HkqzTb6RZXSLqKlpDtyRk2VIIxBdsv
         J/SHoJAmZlDqPp7RnxJH2nDoc45kK8P1tJg0ubMrj4sT7bsrpopn7NpUyL24qHS7YP
         Fb0egRzQ6dkLdrdKS5d+fEKJDPyae+xGKiWV4/TA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 07/17] net: udp: Fix wrong clean up for IS_UDPLITE macro
Date:   Thu, 30 Jul 2020 10:04:33 +0200
Message-Id: <20200730074420.821498441@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.449233408@linuxfoundation.org>
References: <20200730074420.449233408@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit b0a422772fec29811e293c7c0e6f991c0fd9241d ]

We can't use IS_UDPLITE to replace udp_sk->pcflag when UDPLITE_RECV_CC is
checked.

Fixes: b2bf1e2659b1 ("[UDP]: Clean up for IS_UDPLITE macro")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    2 +-
 net/ipv6/udp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1986,7 +1986,7 @@ static int udp_queue_rcv_skb(struct sock
 	/*
 	 * 	UDP-Lite specific tests, ignored on UDP sockets
 	 */
-	if ((is_udplite & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
+	if ((up->pcflag & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
 
 		/*
 		 * MIB statistics other than incrementing the error count are
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -606,7 +606,7 @@ static int udpv6_queue_rcv_skb(struct so
 	/*
 	 * UDP-Lite specific tests, ignored on UDP sockets (see net/ipv4/udp.c).
 	 */
-	if ((is_udplite & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
+	if ((up->pcflag & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
 
 		if (up->pcrlen == 0) {          /* full coverage was set  */
 			net_dbg_ratelimited("UDPLITE6: partial coverage %d while full coverage %d requested\n",


