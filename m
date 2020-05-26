Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C258C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2809208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519364;
	bh=St9vmDf+nJ7J02SaBNqGIm+NwyPLBt/ZcyaPLZD9Us8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HoVIqPYgyAM2g94Ci4lv8RX9MEcTVsXzXdCkPFNSjNhRlJc/1zHWIHJXwHwsF6PyQ
	 0lNRa8tBE7eUMyeLWEwadFIQIbLCJEYQAy2wiZT/PwOMkWY9k9vIhf2XcCnx9GhMgn
	 II5GWZx+ryAbsdUs8Pv+C3lKgU16jLq7Y94DEukI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbgEZS4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389685AbgEZSz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:55:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E5432086A;
        Tue, 26 May 2020 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519357;
        bh=St9vmDf+nJ7J02SaBNqGIm+NwyPLBt/ZcyaPLZD9Us8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzfdqOLHY4+CTvdtXCWBENAGwx2tVz+8Mrc+jJ2x85PpDEF4u7DyMAl6wnM6AKA8Q
         PlpKEZ/nbxEk1/HCmN3Lv+fx6OdX0dig1nX1ORbyyMA5X+lp3vsv/ZRpOU2AOOVQiU
         6Tqm/vtj2NHJSJAwsJABCB7QU5bp3zYQAvvpswOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Amit Pundir <amit.pundir@linaro.org>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.4 36/65] l2tp: hold session while sending creation notifications
Date:   Tue, 26 May 2020 20:52:55 +0200
Message-Id: <20200526183918.750865149@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <g.nault@alphalink.fr>

commit 5e6a9e5a3554a5b3db09cdc22253af1849c65dff upstream.

l2tp_session_find() doesn't take any reference on the returned session.
Therefore, the session may disappear while sending the notification.

Use l2tp_session_get() instead and decrement session's refcount once
the notification is sent.

Backporting Notes

This is a backport of a backport.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_netlink.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -626,10 +626,12 @@ static int l2tp_nl_cmd_session_create(st
 			session_id, peer_session_id, &cfg);
 
 	if (ret >= 0) {
-		session = l2tp_session_find(net, tunnel, session_id);
-		if (session)
+		session = l2tp_session_get(net, tunnel, session_id, false);
+		if (session) {
 			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
 						  L2TP_CMD_SESSION_CREATE);
+			l2tp_session_dec_refcount(session);
+		}
 	}
 
 out:


