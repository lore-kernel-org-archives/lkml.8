Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86091C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5592920773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259652;
	bh=n6aGIqkUrCRNSR4SZOUROMAjsSS3vQvpdwJrxU7Ln94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O6zqW3HpVA9rSUOXgLJSwVX+I0RZjJsVNrns+pRQ0k/K1NQLb2NRDy5qKbYLLWGUv
	 7GdGazCj2P3PNQCxmwiQqiWj/PnYJLQLbaLdU/wcWJGPDDn4ifay54htDRsrapWJ64
	 Es0eBsG1p8q87c0adP/31rwJEJcIlwPYhu/Ba0II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgGTPkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgGTPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:40:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7AE22CB3;
        Mon, 20 Jul 2020 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259648;
        bh=n6aGIqkUrCRNSR4SZOUROMAjsSS3vQvpdwJrxU7Ln94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoEHHok+0rWmjxM1XZTG7I923UOU0hQNOoZk3p533qbhUPDOx62YQuX7j8NmFLohK
         I5yF0Ea2/DQhZI8VFPOyCQYJQ8R44C/sXtJpnp7VNkzgqjyqbueDJ2xPHY4OpkQzf/
         4c7N3gfhHdqy9q4UZ0VwLfUoj7coAzJJ437x8Ik8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 28/86] l2tp: remove skb_dst_set() from l2tp_xmit_skb()
Date:   Mon, 20 Jul 2020 17:36:24 +0200
Message-Id: <20200720152754.569038578@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 27d53323664c549b5bb2dfaaf6f7ad6e0376a64e ]

In the tx path of l2tp, l2tp_xmit_skb() calls skb_dst_set() to set
skb's dst. However, it will eventually call inet6_csk_xmit() or
ip_queue_xmit() where skb's dst will be overwritten by:

   skb_dst_set_noref(skb, dst);

without releasing the old dst in skb. Then it causes dst/dev refcnt leak:

  unregister_netdevice: waiting for eth0 to become free. Usage count = 1

This can be reproduced by simply running:

  # modprobe l2tp_eth && modprobe l2tp_ip
  # sh ./tools/testing/selftests/net/l2tp.sh

So before going to inet6_csk_xmit() or ip_queue_xmit(), skb's dst
should be dropped. This patch is to fix it by removing skb_dst_set()
from l2tp_xmit_skb() and moving skb_dst_drop() into l2tp_xmit_core().

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: James Chapman <jchapman@katalix.com>
Tested-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1134,6 +1134,7 @@ static int l2tp_xmit_core(struct l2tp_se
 
 	/* Queue the packet to IP for output */
 	skb->ignore_df = 1;
+	skb_dst_drop(skb);
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tunnel->sock->sk_family == PF_INET6 && !tunnel->v4mapped)
 		error = inet6_csk_xmit(tunnel->sock, skb, NULL);
@@ -1198,10 +1199,6 @@ int l2tp_xmit_skb(struct l2tp_session *s
 		goto out_unlock;
 	}
 
-	/* Get routing info from the tunnel socket */
-	skb_dst_drop(skb);
-	skb_dst_set(skb, sk_dst_check(sk, 0));
-
 	inet = inet_sk(sk);
 	fl = &inet->cork.fl;
 	switch (tunnel->encap) {


