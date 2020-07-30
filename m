Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D992CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E2D2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097156;
	bh=AmXDh2gGqF8SVqhoUGaF7BNkNEQUF4kBqRb3Nfd6rZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DIjU3sH4T14ElG7pE/qpV2NFKPCdxvZZ/Ug25COwu/HA6PrhfeEDm3EKRUeL/lF6O
	 gNEi5eXlwx8oPgS6ahj2vHPwxnhTEnQw0aJgYaDSCnCYm4Zu0Ftb2K01K0/9FXjVzy
	 r7ZRz3Q0lQIJjE+X8BvyE6PTbuf8rui1S7UVmxAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgG3ITP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbgG3IIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:08:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84DAB2070B;
        Thu, 30 Jul 2020 08:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096485;
        bh=AmXDh2gGqF8SVqhoUGaF7BNkNEQUF4kBqRb3Nfd6rZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WulxESGNl6C40wCvqnUCYzMsn+Mpi6NIWdrz+Ku8r+mac8+k6bWBMghYD2o8BxAwR
         D4Yaml2qMLo/EbHfZ4zaO1t/gOLyR3WMVgz44Sih7YUkAhJr/KYEynbpolO08tfJ2i
         PF1L5zwiOvig0RclRjKKWi1s7SgLYsajqPd2PUkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/14] rxrpc: Fix sendmsg() returning EPIPE due to recvmsg() returning ENODATA
Date:   Thu, 30 Jul 2020 10:04:50 +0200
Message-Id: <20200730074419.259597562@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074418.882736401@linuxfoundation.org>
References: <20200730074418.882736401@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 639f181f0ee20d3249dbc55f740f0167267180f0 ]

rxrpc_sendmsg() returns EPIPE if there's an outstanding error, such as if
rxrpc_recvmsg() indicating ENODATA if there's nothing for it to read.

Change rxrpc_recvmsg() to return EAGAIN instead if there's nothing to read
as this particular error doesn't get stored in ->sk_err by the networking
core.

Also change rxrpc_sendmsg() so that it doesn't fail with delayed receive
errors (there's no way for it to report which call, if any, the error was
caused by).

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/recvmsg.c |    2 +-
 net/rxrpc/sendmsg.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -445,7 +445,7 @@ try_again:
 	    list_empty(&rx->recvmsg_q) &&
 	    rx->sk.sk_state != RXRPC_SERVER_LISTENING) {
 		release_sock(&rx->sk);
-		return -ENODATA;
+		return -EAGAIN;
 	}
 
 	if (list_empty(&rx->recvmsg_q)) {
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -222,7 +222,7 @@ static int rxrpc_send_data(struct rxrpc_
 	/* this should be in poll */
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
-	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		return -EPIPE;
 
 	more = msg->msg_flags & MSG_MORE;


