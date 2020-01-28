Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1432DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3400205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220358;
	bh=Gf33xhZUdegBP6CVOaXaMATo4C5s7pCkop+/aO+GMzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WlHiN8697W4WLtj18090ZZDLNVViDwNvH9dvQqiDUM7uDjW89foqSIEEi3jryk9di
	 Mv67xj+JzxpnOjgxgy91B1icaDTeqeZqidGt8vfXB0/crHUATD8kTNg7M8KPMdcZNI
	 nk73CkfwLVN8jSUINRIJIjRyVG0Rg02aFeV7Gv7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgA1OF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgA1OFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:05:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF951205F4;
        Tue, 28 Jan 2020 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220320;
        bh=Gf33xhZUdegBP6CVOaXaMATo4C5s7pCkop+/aO+GMzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCpvTQRxMVeasNNYPuHU2clCB22/2EJmy23Eg2GJpE8tpUPjN/h3bP6oQfuhkeqQn
         VtohtBAgiAxj0iuIvAzIXn+GbCYSYmXwq1IhReGGAo7txYQAhvAMCNR2eaudMCvsuV
         1V8s06oVdeysscy/0ns7JvkVCa3ZDXIKP0ldwpzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>,
        syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com,
        syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 104/104] net/x25: fix nonblocking connect
Date:   Tue, 28 Jan 2020 15:01:05 +0100
Message-Id: <20200128135831.255154807@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>

commit e21dba7a4df4d93da237da65a096084b4f2e87b4 upstream.

This patch fixes 2 issues in x25_connect():

1. It makes absolutely no sense to reset the neighbour and the
connection state after a (successful) nonblocking call of x25_connect.
This prevents any connection from being established, since the response
(call accept) cannot be processed.

2. Any further calls to x25_connect() while a call is pending should
simply return, instead of creating new Call Request (on different
logical channels).

This patch should also fix the "KASAN: null-ptr-deref Write in
x25_connect" and "BUG: unable to handle kernel NULL pointer dereference
in x25_connect" bugs reported by syzbot.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Reported-by: syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com
Reported-by: syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/x25/af_x25.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -760,6 +760,10 @@ static int x25_connect(struct socket *so
 	if (sk->sk_state == TCP_ESTABLISHED)
 		goto out;
 
+	rc = -EALREADY;	/* Do nothing if call is already in progress */
+	if (sk->sk_state == TCP_SYN_SENT)
+		goto out;
+
 	sk->sk_state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
@@ -806,7 +810,7 @@ static int x25_connect(struct socket *so
 	/* Now the loop */
 	rc = -EINPROGRESS;
 	if (sk->sk_state != TCP_ESTABLISHED && (flags & O_NONBLOCK))
-		goto out_put_neigh;
+		goto out;
 
 	rc = x25_wait_for_connection_establishment(sk);
 	if (rc)


