Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB03C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C845F2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428939;
	bh=apxNGTTawxO88AhaRt5S23Z7rTLns5Lk95jgyvF3/SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w1y3+IlOivZX5dvmVk3a/eY9Ng7CT2P1tyTmrzo3+1pVYmne1ABJCBVjcbL55fmvG
	 tBy6XCFHlU+87HJMluz9ijim1HLWaEF9Rn0jcyFC0zsOZCD6ggmT3aBEobTnkYaF7q
	 3b4DSqzFG1ZKmzt4XuAMeNUwsdFH5XdDZXahLymk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgCERWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbgCERN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:13:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1660E2166E;
        Thu,  5 Mar 2020 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428437;
        bh=apxNGTTawxO88AhaRt5S23Z7rTLns5Lk95jgyvF3/SA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcz/2oswnYUZTcyl/uqXNbSEokJjxU3pwudTbJXkyBd7TTTf4Lq9abNMExkNQKHpj
         Eqfvz/uWSm6lZDNwziJIRo92u30OyyvgJNcepQlhYSxnDFvi8tUasb2ZvTLQKn+z+e
         f+3Zqa3xyPbqQKqrhSf4F4gN0sMaYazzTmAPvEXg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Esben Haabendal <esben@geanix.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 35/67] net: ll_temac: Fix race condition causing TX hang
Date:   Thu,  5 Mar 2020 12:12:36 -0500
Message-Id: <20200305171309.29118-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben@geanix.com>

[ Upstream commit 84823ff80f7403752b59e00bb198724100dc611c ]

It is possible that the interrupt handler fires and frees up space in
the TX ring in between checking for sufficient TX ring space and
stopping the TX queue in temac_start_xmit. If this happens, the
queue wake from the interrupt handler will occur before the queue is
stopped, causing a lost wakeup and the adapter's transmit hanging.

To avoid this, after stopping the queue, check again whether there is
sufficient space in the TX ring. If so, wake up the queue again.

This is a port of the similar fix in axienet driver,
commit 7de44285c1f6 ("net: axienet: Fix race condition causing TX hang").

Fixes: 23ecc4bde21f ("net: ll_temac: fix checksum offload logic")
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 21c1b4322ea78..fd578568b3bff 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -788,6 +788,9 @@ static void temac_start_xmit_done(struct net_device *ndev)
 		stat = be32_to_cpu(cur_p->app0);
 	}
 
+	/* Matches barrier in temac_start_xmit */
+	smp_mb();
+
 	netif_wake_queue(ndev);
 }
 
@@ -830,9 +833,19 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
 
 	if (temac_check_tx_bd_space(lp, num_frag + 1)) {
-		if (!netif_queue_stopped(ndev))
-			netif_stop_queue(ndev);
-		return NETDEV_TX_BUSY;
+		if (netif_queue_stopped(ndev))
+			return NETDEV_TX_BUSY;
+
+		netif_stop_queue(ndev);
+
+		/* Matches barrier in temac_start_xmit_done */
+		smp_mb();
+
+		/* Space might have just been freed - check again */
+		if (temac_check_tx_bd_space(lp, num_frag))
+			return NETDEV_TX_BUSY;
+
+		netif_wake_queue(ndev);
 	}
 
 	cur_p->app0 = 0;
-- 
2.20.1

