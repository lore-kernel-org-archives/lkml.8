Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B5C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA77B20716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221683;
	bh=yukw8iFO/e+pJMy9+tejUOgDsDRIFqDnRwp12eJT5ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqTt6smroGlFAWwXFhFthyWzFbzEwsbzTfUCRHnZrimzm5C1pnG7EefYo2wP7GUxO
	 xcOswwZWc8tiOqPRTCkbZgFQiJYnEKDyw+QgwTCbzeFKBnfNiMoH59KbrQr3oMRK8G
	 crP4Z+27+5Cuxc6aJfLqmcMrasyPcwg6NWid+dyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbgA1O2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbgA1O1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:27:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D3321739;
        Tue, 28 Jan 2020 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221672;
        bh=yukw8iFO/e+pJMy9+tejUOgDsDRIFqDnRwp12eJT5ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xmpt3SaAyp/+L8SGWiB/V53fWh99JUp30Em5+oEphTxjPv7sdRn4wjLHTU+FWS9zg
         9jP7UDMBk42TFnf8iqlTKx5ExTMrZDwHzw0sXWGJ2vWwCQyCfThw/e+BjjWmBOfgTR
         E5yjEnlGhQXZ1Mhde6y5jPMD6n8FF3XpScPZVzxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 4.19 18/92] Revert "udp: do rmem bulk free even if the rx sk queue is empty"
Date:   Tue, 28 Jan 2020 15:07:46 +0100
Message-Id: <20200128135811.495464186@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit d39ca2590d10712f412add7a88e1dd467a7246f4 ]

This reverts commit 0d4a6608f68c7532dcbfec2ea1150c9761767d03.

Willem reported that after commit 0d4a6608f68c ("udp: do rmem bulk
free even if the rx sk queue is empty") the memory allocated by
an almost idle system with many UDP sockets can grow a lot.

For stable kernel keep the solution as simple as possible and revert
the offending commit.

Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Diagnosed-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: 0d4a6608f68c ("udp: do rmem bulk free even if the rx sk queue is empty")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1305,7 +1305,8 @@ static void udp_rmem_release(struct sock
 	if (likely(partial)) {
 		up->forward_deficit += size;
 		size = up->forward_deficit;
-		if (size < (sk->sk_rcvbuf >> 2))
+		if (size < (sk->sk_rcvbuf >> 2) &&
+		    !skb_queue_empty(&up->reader_queue))
 			return;
 	} else {
 		size += up->forward_deficit;


