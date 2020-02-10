Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95169C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8DE20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339191;
	bh=EyBX9TayLiTZralYPtUvJHjj8z/fIq3LyoI4StE/270=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lzJ1lsAdqfrs1++c1WN1XSH9CtQWng7hJBZVxtNslbLKiOZEXW0DKC1i7TSkDgXi8
	 udCgxyG1HsC95coBQS3MOAAxUoUyJyj2kCmsvlP5t4ZPHJb036eUgrgMVzAsPgPt4/
	 lSclBiDzPQHn48S4LLKpxSj7bMPJ/OXBt1pbhvFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgBJMxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbgBJMmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:14 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73F621569;
        Mon, 10 Feb 2020 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338533;
        bh=EyBX9TayLiTZralYPtUvJHjj8z/fIq3LyoI4StE/270=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpT2vUmr4wRY8iqI7qyfCiwAwEjv6Jjhisv8wv4jMJf0SzI7WK5CUYgBhQFt2wHGh
         DJ6qL9f4UKW8bciCEnn4OFW9h5A9k/kYva8yvoyb6TylISdo5Rxe/NmSW9OC8N3rCW
         ioP6WbwWdLQQu/eBiocZeT0SQhxLrvzU0Vy/JJYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 360/367] rxrpc: Fix service call disconnection
Date:   Mon, 10 Feb 2020 04:34:33 -0800
Message-Id: <20200210122455.612514463@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit b39a934ec72fa2b5a74123891f25273a38378b90 ]

The recent patch that substituted a flag on an rxrpc_call for the
connection pointer being NULL as an indication that a call was disconnected
puts the set_bit in the wrong place for service calls.  This is only a
problem if a call is implicitly terminated by a new call coming in on the
same connection channel instead of a terminating ACK packet.

In such a case, rxrpc_input_implicit_end_call() calls
__rxrpc_disconnect_call(), which is now (incorrectly) setting the
disconnection bit, meaning that when rxrpc_release_call() is later called,
it doesn't call rxrpc_disconnect_call() and so the call isn't removed from
the peer's error distribution list and the list gets corrupted.

KASAN finds the issue as an access after release on a call, but the
position at which it occurs is confusing as it appears to be related to a
different call (the call site is where the latter call is being removed
from the error distribution list and either the next or pprev pointer
points to a previously released call).

Fix this by moving the setting of the flag from __rxrpc_disconnect_call()
to rxrpc_disconnect_call() in the same place that the connection pointer
was being cleared.

Fixes: 5273a191dca6 ("rxrpc: Fix NULL pointer deref due to call->conn being cleared on disconnect")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/conn_object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index c0b3154f7a7e1..19e141eeed17d 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -171,8 +171,6 @@ void __rxrpc_disconnect_call(struct rxrpc_connection *conn,
 
 	_enter("%d,%x", conn->debug_id, call->cid);
 
-	set_bit(RXRPC_CALL_DISCONNECTED, &call->flags);
-
 	if (rcu_access_pointer(chan->call) == call) {
 		/* Save the result of the call so that we can repeat it if necessary
 		 * through the channel, whilst disposing of the actual call record.
@@ -225,6 +223,7 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 	__rxrpc_disconnect_call(conn, call);
 	spin_unlock(&conn->channel_lock);
 
+	set_bit(RXRPC_CALL_DISCONNECTED, &call->flags);
 	conn->idle_timestamp = jiffies;
 }
 
-- 
2.20.1



