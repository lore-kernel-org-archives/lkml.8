Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4B4C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B10820775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCXJkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:40:33 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:43090 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCXJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:40:32 -0400
Received: from localhost (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id 38817BC85C;
        Tue, 24 Mar 2020 17:39:48 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24779T140190699988736S1585042779131734_;
        Tue, 24 Mar 2020 17:39:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d14fd5c272a1ce6963a1ab2f461ea216>
X-RL-SENDER: david.wu@rock-chips.com
X-SENDER: wdc@rock-chips.com
X-LOGIN-NAME: david.wu@rock-chips.com
X-FST-TO: netdev@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   David Wu <david.wu@rock-chips.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, joabreu@synopsys.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
Subject: [RFC,PATCH 2/2] net: stmmac: Change the tx clean lock
Date:   Tue, 24 Mar 2020 17:38:28 +0800
Message-Id: <20200324093828.30019-2-david.wu@rock-chips.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200324093828.30019-1-david.wu@rock-chips.com>
References: <20200324093828.30019-1-david.wu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At tx clean, use a frozen queue instead of blocking
the current queue, could still queue skb, which improve
performance.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index cb7a5bad4cfe..946058bcc9ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1897,7 +1897,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 	unsigned int bytes_compl = 0, pkts_compl = 0;
 	unsigned int entry, count = 0;
 
-	__netif_tx_lock_bh(netdev_get_tx_queue(priv->dev, queue));
+	netif_tx_lock_q(netdev_get_tx_queue(priv->dev, queue));
 
 	priv->xstats.tx_clean++;
 
@@ -1994,7 +1994,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 	if (tx_q->dirty_tx != tx_q->cur_tx)
 		mod_timer(&tx_q->txtimer, STMMAC_COAL_TIMER(priv->tx_coal_timer));
 
-	__netif_tx_unlock_bh(netdev_get_tx_queue(priv->dev, queue));
+	netif_tx_unlock_q(netdev_get_tx_queue(priv->dev, queue));
 
 	return count;
 }
-- 
2.19.1



