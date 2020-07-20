Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9E6C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97C62064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261247;
	bh=AOn2YYO7GwFI7nIw9oLg2N5x/AZFeWr7soddxRHeJ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kAkC9RhNohyVbXeUjj84o21SBvMDNKI+n3M4eAkYayaEQBzcFGZ10YyG7+ggm7fcr
	 fFVPSwu7I7GhL3JqiaynXOWq19W46wrRZQgYCjPn4zQ608INPzEXO1bsS64mdQ6qMi
	 novJdP184YfQna+kFVeZoIGB3L2qKuXFulBqV2Nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgGTQH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733151AbgGTQHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:07:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239DA206E9;
        Mon, 20 Jul 2020 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261240;
        bh=AOn2YYO7GwFI7nIw9oLg2N5x/AZFeWr7soddxRHeJ7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHBCNy2kuW7TP/gZVGFsniMVYZ27t+8Ffe4blbZckgmmRJKi6cgFT0SWE2IlD+oyE
         11tR7YtUdbIbcuVnjM+R5lZAnM02JnTVeWxHpYI0IdCY3YYeGaCkxbVvwX9h+teDsa
         8xeKnb/IBTflhwgikG7zBH5IOf6GB7geFL2Y50wM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 014/244] tcp: fix SO_RCVLOWAT possible hangs under high mem pressure
Date:   Mon, 20 Jul 2020 17:34:45 +0200
Message-Id: <20200720152826.554510843@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ba3bb0e76ccd464bb66665a1941fabe55dadb3ba ]

Whenever tcp_try_rmem_schedule() returns an error, we are under
trouble and should make sure to wakeup readers so that they
can drain socket queues and eventually make room.

Fixes: 03f45c883c6f ("tcp: avoid extra wakeups for SO_RCVLOWAT users")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4570,6 +4570,7 @@ static void tcp_data_queue_ofo(struct so
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
+		sk->sk_data_ready(sk);
 		tcp_drop(sk, skb);
 		return;
 	}
@@ -4816,6 +4817,7 @@ queue_and_out:
 			sk_forced_mem_schedule(sk, skb->truesize);
 		else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+			sk->sk_data_ready(sk);
 			goto drop;
 		}
 


