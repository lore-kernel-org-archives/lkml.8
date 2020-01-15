Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E62C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3292084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAOHKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 02:10:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:16006 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgAOHKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:10:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 23:10:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; 
   d="scan'208";a="256643652"
Received: from bong5-hp-z440.png.intel.com ([10.221.118.136])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2020 23:10:37 -0800
From:   Ong Boon Leong <boon.leong.ong@intel.com>
To:     netdev@vger.kernel.org
Cc:     Jakub Kicinski <kubakici@wp.pl>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/4] net: stmmac: Fix incorrect location to set real_num_rx|tx_queues
Date:   Wed, 15 Jan 2020 15:10:00 +0800
Message-Id: <20200115071003.42820-2-boon.leong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115071003.42820-1-boon.leong.ong@intel.com>
References: <20200115071003.42820-1-boon.leong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aashish Verma <aashishx.verma@intel.com>

netif_set_real_num_tx_queues() & netif_set_real_num_rx_queues() should be
used to inform network stack about the real Tx & Rx queue (active) number
in both stmmac_open() and stmmac_resume(), therefore, we move the code
from stmmac_dvr_probe() to stmmac_hw_setup().

Fixes: c02b7a914551 ("net: stmmac: use netif_set_real_num_{rx,tx}_queues")
Signed-off-by: Aashish Verma <aashishx.verma@intel.com>
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 80d59b775907..0780e00580a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2624,6 +2624,10 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
 	if (priv->dma_cap.vlins)
 		stmmac_enable_vlan(priv, priv->hw, STMMAC_VLAN_INSERT);
 
+	/* Configure real RX and TX queues */
+	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
+	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
+
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
@@ -4622,10 +4626,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	stmmac_check_ether_addr(priv);
 
-	/* Configure real RX and TX queues */
-	netif_set_real_num_rx_queues(ndev, priv->plat->rx_queues_to_use);
-	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
-
 	ndev->netdev_ops = &stmmac_netdev_ops;
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-- 
2.17.1

