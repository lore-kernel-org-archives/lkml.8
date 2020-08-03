Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE512177B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457812;
	bh=ChVaTdwZsimVO9XXRPpvGgqVvr8Bhfap1whGtgk08Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J/u2cRZb2zhWSknIHqUZc5A7hr0OmMRgeaC8ZFWiTyHLjFllJUBiwIAied67Vb2yh
	 Am43rVtlrVFJWQxYcIfoEjziiobpHX23dJG+7vX/4F7mOSO2PzEfj1w1+ZuURydqB6
	 AIUitgs34+3320LyuSGJEqLN3I/YMRj19+aNmTnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHCMaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgHCM35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:29:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4AB204EC;
        Mon,  3 Aug 2020 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457795;
        bh=ChVaTdwZsimVO9XXRPpvGgqVvr8Bhfap1whGtgk08Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYAepXKRnasVAaQI3pPuhEzhiXdas+ZfTYzojCJa+oYJRnzmroSvrZ5ZCyZQiruu5
         SeVN7gAO5lWVhRw6AB7mmqUA5WiosS6xAKc7JBmMDt6WqTq28Q2cP9KMpThZgcvqhl
         GGNxOLHujWp+iXDQRmbE5p7TUi72UZ3Ne3EPBjLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 77/90] net: ethernet: ravb: exit if re-initialization fails in tx timeout
Date:   Mon,  3 Aug 2020 14:19:39 +0200
Message-Id: <20200803121901.344477818@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 015c5d5e6aa3523c758a70eb87b291cece2dbbb4 ]

According to the report of [1], this driver is possible to cause
the following error in ravb_tx_timeout_work().

ravb e6800000.ethernet ethernet: failed to switch device to config mode

This error means that the hardware could not change the state
from "Operation" to "Configuration" while some tx and/or rx queue
are operating. After that, ravb_config() in ravb_dmac_init() will fail,
and then any descriptors will be not allocaled anymore so that NULL
pointer dereference happens after that on ravb_start_xmit().

To fix the issue, the ravb_tx_timeout_work() should check
the return values of ravb_stop_dma() and ravb_dmac_init().
If ravb_stop_dma() fails, ravb_tx_timeout_work() re-enables TX and RX
and just exits. If ravb_dmac_init() fails, just exits.

[1]
https://lore.kernel.org/linux-renesas-soc/20200518045452.2390-1-dirk.behme@de.bosch.com/

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 26 ++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3f165c137236d..30cdabf64ccc1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1444,6 +1444,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct ravb_private *priv = container_of(work, struct ravb_private,
 						 work);
 	struct net_device *ndev = priv->ndev;
+	int error;
 
 	netif_tx_stop_all_queues(ndev);
 
@@ -1452,15 +1453,36 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_stop(ndev);
 
 	/* Wait for DMA stopping */
-	ravb_stop_dma(ndev);
+	if (ravb_stop_dma(ndev)) {
+		/* If ravb_stop_dma() fails, the hardware is still operating
+		 * for TX and/or RX. So, this should not call the following
+		 * functions because ravb_dmac_init() is possible to fail too.
+		 * Also, this should not retry ravb_stop_dma() again and again
+		 * here because it's possible to wait forever. So, this just
+		 * re-enables the TX and RX and skip the following
+		 * re-initialization procedure.
+		 */
+		ravb_rcv_snd_enable(ndev);
+		goto out;
+	}
 
 	ravb_ring_free(ndev, RAVB_BE);
 	ravb_ring_free(ndev, RAVB_NC);
 
 	/* Device init */
-	ravb_dmac_init(ndev);
+	error = ravb_dmac_init(ndev);
+	if (error) {
+		/* If ravb_dmac_init() fails, descriptors are freed. So, this
+		 * should return here to avoid re-enabling the TX and RX in
+		 * ravb_emac_init().
+		 */
+		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
+			   __func__, error);
+		return;
+	}
 	ravb_emac_init(ndev);
 
+out:
 	/* Initialise PTP Clock driver */
 	if (priv->chip_id == RCAR_GEN2)
 		ravb_ptp_init(ndev, priv->pdev);
-- 
2.25.1



