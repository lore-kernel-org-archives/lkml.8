Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271A7C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED72D24955
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339739;
	bh=1bJXgS9EGSsKXLluKrL63N6r/YnFN67KmUdN1uqhg/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NlcC+y3Qx/aE6eJk0yziZvgp480b2czZdaOKooPyyrlSJ4+CQc6IkiAo7gDDkzqJz
	 /e+kpfKKfI6fi/YMiEr6bC3oBYaPlwVyHyhF54AL6dHc0KvgcNbyQ67wO8LJUtMqHv
	 xEBvV8/dcdnDc4wKi+LtDvEU9dkIo+QXzepqndiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgEAN25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbgEAN2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:28:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502602166E;
        Fri,  1 May 2020 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339733;
        bh=1bJXgS9EGSsKXLluKrL63N6r/YnFN67KmUdN1uqhg/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqbKJZ1A8y32RvaxKDhdLeAX10XcBO559KezjV46U/CTUK6gNmf7dZmmUH6eethHv
         ykVqe5gCAGllN5QNt3bP94/Iytb+U87ynuqY03yAjnN0WrS/WwROgi3Q7lbkUL5NZB
         DXqIkvx2C2df6H01tjve01nMMmvQKbqYV83kZkrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 24/80] net/x25: Fix x25_neigh refcnt leak when receiving frame
Date:   Fri,  1 May 2020 15:21:18 +0200
Message-Id: <20200501131522.247780294@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit f35d12971b4d814cdb2f659d76b42f0c545270b6 ]

x25_lapb_receive_frame() invokes x25_get_neigh(), which returns a
reference of the specified x25_neigh object to "nb" with increased
refcnt.

When x25_lapb_receive_frame() returns, local variable "nb" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one path of
x25_lapb_receive_frame(). When pskb_may_pull() returns false, the
function forgets to decrease the refcnt increased by x25_get_neigh(),
causing a refcnt leak.

Fix this issue by calling x25_neigh_put() when pskb_may_pull() returns
false.

Fixes: cb101ed2c3c7 ("x25: Handle undersized/fragmented skbs")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/x25/x25_dev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/x25/x25_dev.c
+++ b/net/x25/x25_dev.c
@@ -120,8 +120,10 @@ int x25_lapb_receive_frame(struct sk_buf
 		goto drop;
 	}
 
-	if (!pskb_may_pull(skb, 1))
+	if (!pskb_may_pull(skb, 1)) {
+		x25_neigh_put(nb);
 		return 0;
+	}
 
 	switch (skb->data[0]) {
 


