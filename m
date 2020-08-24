Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9772A207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258909;
	bh=D+Vmybzmzen28AV30V9SfoitNCjmhrlbMMUqq2jVhw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRuEow2hi1FgtOamUdhk5Po+4hI657zKJjcrUfqYKG5khXByTSqeDfX9ig4492P2j
	 frMY5nbw0X3BHU/HtyZemET+9pltl5tEUGFVpdCagemuqHDqhiuigGR7zlExwaaOz2
	 JNwEJIU+DgwYRg95Q+qS4hDOFLnnv/37aVBz3dJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgHXIs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbgHXIsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:48:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8323F204FD;
        Mon, 24 Aug 2020 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258884;
        bh=D+Vmybzmzen28AV30V9SfoitNCjmhrlbMMUqq2jVhw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00y9SttHYIr7OEDDTWtoLvfKE/db2gHcXGgCm88EINZNAr1HUeFMGQj9hpYlQcRFP
         UL03j2TIkDf1J3/owI7hUkcm6A32RvjHktzqQGGkRKqhTekbTKb0OSj3gJJePnTDHL
         tH7vt+Rg/sha4zCX/rfq08Ctr+6/KqGfP3nMkHXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 071/107] can: j1939: transport: j1939_simple_recv(): ignore local J1939 messages send not by J1939 stack
Date:   Mon, 24 Aug 2020 10:30:37 +0200
Message-Id: <20200824082408.639964158@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit b43e3a82bc432c1caaed8950e7662c143470c54c ]

In current J1939 stack implementation, we process all locally send
messages as own messages. Even if it was send by CAN_RAW socket.

To reproduce it use following commands:
testj1939 -P -r can0:0x80 &
cansend can0 18238040#0123

This step will trigger false positive not critical warning:
j1939_simple_recv: Received already invalidated message

With this patch we add additional check to make sure, related skb is own
echo message.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20200807105200.26441-2-o.rempel@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/j1939/socket.c    | 1 +
 net/can/j1939/transport.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 1b7dc1a8547f3..bf9fd6ee88fe0 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -398,6 +398,7 @@ static int j1939_sk_init(struct sock *sk)
 	spin_lock_init(&jsk->sk_session_queue_lock);
 	INIT_LIST_HEAD(&jsk->sk_session_queue);
 	sk->sk_destruct = j1939_sk_sock_destruct;
+	sk->sk_protocol = CAN_J1939;
 
 	return 0;
 }
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 5bfe6bf15a999..30957c9a8eb7a 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -2032,6 +2032,10 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 	if (!skb->sk)
 		return;
 
+	if (skb->sk->sk_family != AF_CAN ||
+	    skb->sk->sk_protocol != CAN_J1939)
+		return;
+
 	j1939_session_list_lock(priv);
 	session = j1939_session_get_simple(priv, skb);
 	j1939_session_list_unlock(priv);
-- 
2.25.1



