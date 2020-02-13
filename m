Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C8EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5452073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609812;
	bh=MhGbUH1dAkQV7rkFynhtHPmDL7QYfc/Ew0W304b/GjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sgHdEZtxDFUyiDspozxIynMCF5SaB5P3NVRrKueRdnvMO8MQWasaPz9KAXwj3eoTb
	 hycOgxNPHr80Z+Tohx2OwVT/BugGntr0yoLx1L7TY9iDzoRLYie0Kn8miRKUGzY886
	 ij+DUupmWmX1mL4dKdgF+6Jjl8zYbqP9fYya4XTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgBMQDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387412AbgBMPYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:17 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A15246A4;
        Thu, 13 Feb 2020 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607457;
        bh=MhGbUH1dAkQV7rkFynhtHPmDL7QYfc/Ew0W304b/GjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPJbT/6sPCpA3Ts+XpyO4zJWvl0AfQfbfFKlHTy92nX6unVUBZGAQ9ZZhaqBObdsw
         yBHqKg0JnNkQG+eg3DlNOfZ0b3nEZm2LofTdkLLWLQeF7lMxMEDnMxczYLhcGfZrGX
         l3itKoPpyNLKSaC9jKK7ePaSX2MBvAXdKEVFNVlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 096/116] rxrpc: Fix service call disconnection
Date:   Thu, 13 Feb 2020 07:20:40 -0800
Message-Id: <20200213151920.153053666@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
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
index dcf438f677840..e7c89b978587d 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -169,8 +169,6 @@ void __rxrpc_disconnect_call(struct rxrpc_connection *conn,
 
 	_enter("%d,%x", conn->debug_id, call->cid);
 
-	set_bit(RXRPC_CALL_DISCONNECTED, &call->flags);
-
 	if (rcu_access_pointer(chan->call) == call) {
 		/* Save the result of the call so that we can repeat it if necessary
 		 * through the channel, whilst disposing of the actual call record.
@@ -213,6 +211,7 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 	__rxrpc_disconnect_call(conn, call);
 	spin_unlock(&conn->channel_lock);
 
+	set_bit(RXRPC_CALL_DISCONNECTED, &call->flags);
 	conn->idle_timestamp = jiffies;
 }
 
-- 
2.20.1



