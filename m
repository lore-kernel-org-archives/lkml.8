Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2A5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24612073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034578;
	bh=O73O6S6qOVS2JIbuuOEQjpAjk2e+6PhdeVNPmkNtvVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nVB+x/Re5pSXowaWKKAp+vfZjD0PWBSgWIPLNMmE4EuttgHHIm1R+pk1zQAGa/Yv1
	 3acc7nsdqMmzkkvu2x1bBE9pxJp8/wAj/3sjIK4KdE0YZFAPGQQxeHS2f7JoT+0IlA
	 PgRGXBUGOCiHTCP+7jlH+DzQO8MtAdEAG9gBeokY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgFASC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgFASCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:02:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241432065C;
        Mon,  1 Jun 2020 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034570;
        bh=O73O6S6qOVS2JIbuuOEQjpAjk2e+6PhdeVNPmkNtvVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGS+gvpW8EwJJNNt32kT5EhTz8adCe5DqBK9h43cTHOTIm+/+Oel+OdkN6DT1/4nZ
         rt2DHd/qBdKfKR4cS16I1sRoYCcu9bA7yrIeZdupEdAPksO3WaZVzD9EBvLrLqBgDo
         rNC97s6uhgd03viXqNdx/sp4SfsFUvYicCjJvTz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jere=20Lepp=C3=A4nen?= <jere.leppanen@nokia.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 13/95] sctp: Start shutdown on association restart if in SHUTDOWN-SENT state and socket is closed
Date:   Mon,  1 Jun 2020 19:53:13 +0200
Message-Id: <20200601174022.984293668@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jere Lepp‰nen" <jere.leppanen@nokia.com>

[ Upstream commit d3e8e4c11870413789f029a71e72ae6e971fe678 ]

Commit bdf6fa52f01b ("sctp: handle association restarts when the
socket is closed.") starts shutdown when an association is restarted,
if in SHUTDOWN-PENDING state and the socket is closed. However, the
rationale stated in that commit applies also when in SHUTDOWN-SENT
state - we don't want to move an association to ESTABLISHED state when
the socket has been closed, because that results in an association
that is unreachable from user space.

The problem scenario:

1.  Client crashes and/or restarts.

2.  Server (using one-to-one socket) calls close(). SHUTDOWN is lost.

3.  Client reconnects using the same addresses and ports.

4.  Server's association is restarted. The association and the socket
    move to ESTABLISHED state, even though the server process has
    closed its descriptor.

Also, after step 4 when the server process exits, some resources are
leaked in an attempt to release the underlying inet sock structure in
ESTABLISHED state:

    IPv4: Attempt to release TCP socket in state 1 00000000377288c7

Fix by acting the same way as in SHUTDOWN-PENDING state. That is, if
an association is restarted in SHUTDOWN-SENT state and the socket is
closed, then start shutdown and don't move the association or the
socket to ESTABLISHED state.

Fixes: bdf6fa52f01b ("sctp: handle association restarts when the socket is closed.")
Signed-off-by: Jere Lepp√§nen <jere.leppanen@nokia.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/sm_statefuns.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1871,12 +1871,13 @@ static enum sctp_disposition sctp_sf_do_
 	/* Update the content of current association. */
 	sctp_add_cmd_sf(commands, SCTP_CMD_UPDATE_ASSOC, SCTP_ASOC(new_asoc));
 	sctp_add_cmd_sf(commands, SCTP_CMD_EVENT_ULP, SCTP_ULPEVENT(ev));
-	if (sctp_state(asoc, SHUTDOWN_PENDING) &&
+	if ((sctp_state(asoc, SHUTDOWN_PENDING) ||
+	     sctp_state(asoc, SHUTDOWN_SENT)) &&
 	    (sctp_sstate(asoc->base.sk, CLOSING) ||
 	     sock_flag(asoc->base.sk, SOCK_DEAD))) {
-		/* if were currently in SHUTDOWN_PENDING, but the socket
-		 * has been closed by user, don't transition to ESTABLISHED.
-		 * Instead trigger SHUTDOWN bundled with COOKIE_ACK.
+		/* If the socket has been closed by user, don't
+		 * transition to ESTABLISHED. Instead trigger SHUTDOWN
+		 * bundled with COOKIE_ACK.
 		 */
 		sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(repl));
 		return sctp_sf_do_9_2_start_shutdown(net, ep, asoc,


