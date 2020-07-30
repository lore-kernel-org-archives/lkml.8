Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D7CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE742074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096445;
	bh=uSbK0NFJ3dg6JgW0DBm6+8lO7nyPkr2+Rw7gWoMalkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhrKaHSOVkAgQZHuEXlAVLrPBcZq6B6cUHXJ9HHOwysK5GHC6M/JbUn+VWkt38S8Q
	 J3ZL5HY5BH8VzJV+evFCzZE2v2d6TsFR5sKE5WuLYBxE5aTHaMv6YaLqF5pWkqbBiG
	 +dXXG574pP5jQkxCWILg/6dxx871+8ZNSnGDSETo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgG3IHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgG3IHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:07:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B88B20838;
        Thu, 30 Jul 2020 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096438;
        bh=uSbK0NFJ3dg6JgW0DBm6+8lO7nyPkr2+Rw7gWoMalkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDr5eJ/7awezSdERahoWlFTMtU8jZvE6APP2ThwsSR2YJgqZHKAqen5NiwROLj1Z4
         0RM3hDBWxkQzvjeCjB1JXP/bN7ybB1FuJqHDzOtmP3JLtZ5CsYuUJHYEnvcwziabqm
         e6NMF4LLot1OPwdMD9YjoW2R4w1wxrXmOw25Bk6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 09/17] rxrpc: Fix sendmsg() returning EPIPE due to recvmsg() returning ENODATA
Date:   Thu, 30 Jul 2020 10:04:35 +0200
Message-Id: <20200730074420.918378888@linuxfoundation.org>
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
@@ -453,7 +453,7 @@ try_again:
 	    list_empty(&rx->recvmsg_q) &&
 	    rx->sk.sk_state != RXRPC_SERVER_LISTENING) {
 		release_sock(&rx->sk);
-		return -ENODATA;
+		return -EAGAIN;
 	}
 
 	if (list_empty(&rx->recvmsg_q)) {
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -278,7 +278,7 @@ static int rxrpc_send_data(struct rxrpc_
 	/* this should be in poll */
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
-	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		return -EPIPE;
 
 	more = msg->msg_flags & MSG_MORE;


