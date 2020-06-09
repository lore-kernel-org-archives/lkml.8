Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D6BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913A02081A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591724809;
	bh=zkJQSLw/Dy68h6dhKZB4cv7uPLMKQ4BbBcHloBdFfRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N83dgkmTfzDYmriFFGE09jBh0qW6VgDEMdEEpn4Zu2pNGg04ZtRB3woIE7bnbyhMc
	 YvANzk5Rp0ZazDOD18hJFWRSHP7yOidpln1Kc8hBb9sxfD3AXHc9DB61A/Hup50x7J
	 rYWr8hH8/xl8Ydu3nK86zSdpbwWeNNBhWNizrOm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgFIRqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbgFIRqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E856E207ED;
        Tue,  9 Jun 2020 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724798;
        bh=zkJQSLw/Dy68h6dhKZB4cv7uPLMKQ4BbBcHloBdFfRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdHoPdRbTJQgIDrCil1WFGT847E/RZon11QcSq4ktHHK+aurXNZU2gH6bS8D4xUiU
         jW/iAqE7u+uCgfWnTsWHi535HkKVjIDq499+yMxR1E9WZM1Yl/vh7IN3HWskwHvut/
         79oLZtUGQ60U/Q/a8VKDr4g4XEuZ0ZpL0HTaL6yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 21/36] vsock: fix timeout in vsock_accept()
Date:   Tue,  9 Jun 2020 19:44:21 +0200
Message-Id: <20200609173934.543954970@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 7e0afbdfd13d1e708fe96e31c46c4897101a6a43 ]

The accept(2) is an "input" socket interface, so we should use
SO_RCVTIMEO instead of SO_SNDTIMEO to set the timeout.

So this patch replace sock_sndtimeo() with sock_rcvtimeo() to
use the right timeout in the vsock_accept().

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/af_vsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1270,7 +1270,7 @@ static int vsock_accept(struct socket *s
 	/* Wait for children sockets to appear; these are the new sockets
 	 * created upon connection establishment.
 	 */
-	timeout = sock_sndtimeo(listener, flags & O_NONBLOCK);
+	timeout = sock_rcvtimeo(listener, flags & O_NONBLOCK);
 	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&


