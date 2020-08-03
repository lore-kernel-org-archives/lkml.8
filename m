Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9269F207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457369;
	bh=MzvC0SzQQy0EfpmYN0ilLTsswtI6TXw1PE6HFXBRtOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jnczSZd8sReqw63DgxvnD1tDwbqcdcKHQh0jQYeoAggg6XI1u3YEpUJAU4A8YILTn
	 8vV2ffqH20v4VCJrH5IVNsxrx6M1+eCmPSVBXJg8OLll4B7ofF1+nzWfpRSK87uwPC
	 OxevSTVz8N3tWXGDRbfr3zYrvxzK4TL+vtp6kCnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHCMWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgHCMWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:22:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C302076E;
        Mon,  3 Aug 2020 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457358;
        bh=MzvC0SzQQy0EfpmYN0ilLTsswtI6TXw1PE6HFXBRtOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5L5/BEP4eeyoFQ3t/JJ3vrctfJNowqgn3Akwr5xvPedYBwDOaO228HYS6L+D0SQ0
         NWHiAbH2S0yGFj86w9hHVUpbRy2V1sWQZRoZbfIeAkCKYlKOGZ/kLaaG5seopcB4U2
         pi2BoB62Fn6cuOQPkKOL9KlwOKln3jADXtWkVl4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Cagney <cagney@libreswan.org>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 039/120] espintcp: recv() should return 0 when the peer socket is closed
Date:   Mon,  3 Aug 2020 14:18:17 +0200
Message-Id: <20200803121904.729469676@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit e229c877cde141a4c46cb603a341ce8c909e9a98 ]

man 2 recv says:

    RETURN VALUE

    When a stream socket peer has performed an orderly shutdown, the
    return value will be 0 (the traditional "end-of-file" return).

Currently, this works for blocking reads, but non-blocking reads will
return -EAGAIN. This patch overwrites that return value when the peer
won't send us any more data.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Reported-by: Andrew Cagney <cagney@libreswan.org>
Tested-by: Andrew Cagney <cagney@libreswan.org>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/espintcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 5a0ff665b71a8..024470fb2d856 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -101,8 +101,11 @@ static int espintcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	flags |= nonblock ? MSG_DONTWAIT : 0;
 
 	skb = __skb_recv_datagram(sk, &ctx->ike_queue, flags, &off, &err);
-	if (!skb)
+	if (!skb) {
+		if (err == -EAGAIN && sk->sk_shutdown & RCV_SHUTDOWN)
+			return 0;
 		return err;
+	}
 
 	copied = len;
 	if (copied > skb->len)
-- 
2.25.1



