Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B4C433F8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B9521D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753702;
	bh=hhgV1S39/KwoIvsw3LlMcbHsFuKXUIs8erzHTOy83tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=akwMnJmvb37p9L/DpfYxDJomMf5n+NN5JDAriv/1Abg3o7fmWk+pYJbZoq8RCRaAV
	 eajpjYWwaASlLzu0hgKPblSbQ4wJJcbnfQmxq+kC750RmZiWOf0cH3zVBVlWMu14aX
	 GUL0GMNsHi0C3mTs5BIga/zs7vb7wAiIFx9JjQ1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgGNSu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbgGNSuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:50:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2121207F5;
        Tue, 14 Jul 2020 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752618;
        bh=hhgV1S39/KwoIvsw3LlMcbHsFuKXUIs8erzHTOy83tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFUavhkDDnUOxXABj5PH16ZIFeguii4cIRTWU7O8sLGknNriivLp95lk7xYNlaFoI
         x7SW29pnkmJcbZkoW24foUt4ZZ9n9ifN31tt+hXNgbCvX7IhjzokUVhtFlr41ieP/a
         BCY7caVW0++s7kY61X+RY0O8KpSOgFW803Fnl3Fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 016/109] net: ethernet: mvneta: Fix Serdes configuration for SoCs without comphy
Date:   Tue, 14 Jul 2020 20:43:19 +0200
Message-Id: <20200714184106.299569019@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit b4748553f53f2971e07d2619f13d461daac0f3bb ]

The MVNETA_SERDES_CFG register is only available on older SoCs like the
Armada XP. On newer SoCs like the Armada 38x the fields are moved to
comphy. This patch moves the writes to this register next to the comphy
initialization, so that depending on the SoC either comphy or
MVNETA_SERDES_CFG is configured.
With this we no longer write to the MVNETA_SERDES_CFG on SoCs where it
doesn't exist.

Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 80 +++++++++++++++------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index a10ae28ebc8aa..b0599b205b36e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -104,6 +104,7 @@
 #define      MVNETA_TX_IN_PRGRS                  BIT(1)
 #define      MVNETA_TX_FIFO_EMPTY                BIT(8)
 #define MVNETA_RX_MIN_FRAME_SIZE                 0x247c
+/* Only exists on Armada XP and Armada 370 */
 #define MVNETA_SERDES_CFG			 0x24A0
 #define      MVNETA_SGMII_SERDES_PROTO		 0x0cc7
 #define      MVNETA_QSGMII_SERDES_PROTO		 0x0667
@@ -3164,26 +3165,55 @@ static int mvneta_setup_txqs(struct mvneta_port *pp)
 	return 0;
 }
 
-static int mvneta_comphy_init(struct mvneta_port *pp)
+static int mvneta_comphy_init(struct mvneta_port *pp, phy_interface_t interface)
 {
 	int ret;
 
-	if (!pp->comphy)
-		return 0;
-
-	ret = phy_set_mode_ext(pp->comphy, PHY_MODE_ETHERNET,
-			       pp->phy_interface);
+	ret = phy_set_mode_ext(pp->comphy, PHY_MODE_ETHERNET, interface);
 	if (ret)
 		return ret;
 
 	return phy_power_on(pp->comphy);
 }
 
+static int mvneta_config_interface(struct mvneta_port *pp,
+				   phy_interface_t interface)
+{
+	int ret = 0;
+
+	if (pp->comphy) {
+		if (interface == PHY_INTERFACE_MODE_SGMII ||
+		    interface == PHY_INTERFACE_MODE_1000BASEX ||
+		    interface == PHY_INTERFACE_MODE_2500BASEX) {
+			ret = mvneta_comphy_init(pp, interface);
+		}
+	} else {
+		switch (interface) {
+		case PHY_INTERFACE_MODE_QSGMII:
+			mvreg_write(pp, MVNETA_SERDES_CFG,
+				    MVNETA_QSGMII_SERDES_PROTO);
+			break;
+
+		case PHY_INTERFACE_MODE_SGMII:
+		case PHY_INTERFACE_MODE_1000BASEX:
+			mvreg_write(pp, MVNETA_SERDES_CFG,
+				    MVNETA_SGMII_SERDES_PROTO);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	pp->phy_interface = interface;
+
+	return ret;
+}
+
 static void mvneta_start_dev(struct mvneta_port *pp)
 {
 	int cpu;
 
-	WARN_ON(mvneta_comphy_init(pp));
+	WARN_ON(mvneta_config_interface(pp, pp->phy_interface));
 
 	mvneta_max_rx_size_set(pp, pp->pkt_size);
 	mvneta_txq_max_tx_size_set(pp, pp->pkt_size);
@@ -3561,14 +3591,10 @@ static void mvneta_mac_config(struct phylink_config *config, unsigned int mode,
 	if (state->speed == SPEED_2500)
 		new_ctrl4 |= MVNETA_GMAC4_SHORT_PREAMBLE_ENABLE;
 
-	if (pp->comphy && pp->phy_interface != state->interface &&
-	    (state->interface == PHY_INTERFACE_MODE_SGMII ||
-	     state->interface == PHY_INTERFACE_MODE_1000BASEX ||
-	     state->interface == PHY_INTERFACE_MODE_2500BASEX)) {
-		pp->phy_interface = state->interface;
-
-		WARN_ON(phy_power_off(pp->comphy));
-		WARN_ON(mvneta_comphy_init(pp));
+	if (pp->phy_interface != state->interface) {
+		if (pp->comphy)
+			WARN_ON(phy_power_off(pp->comphy));
+		WARN_ON(mvneta_config_interface(pp, state->interface));
 	}
 
 	if (new_ctrl0 != gmac_ctrl0)
@@ -4464,20 +4490,10 @@ static void mvneta_conf_mbus_windows(struct mvneta_port *pp,
 }
 
 /* Power up the port */
-static int mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
+static void mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
 {
 	/* MAC Cause register should be cleared */
 	mvreg_write(pp, MVNETA_UNIT_INTR_CAUSE, 0);
-
-	if (phy_mode == PHY_INTERFACE_MODE_QSGMII)
-		mvreg_write(pp, MVNETA_SERDES_CFG, MVNETA_QSGMII_SERDES_PROTO);
-	else if (phy_mode == PHY_INTERFACE_MODE_SGMII ||
-		 phy_interface_mode_is_8023z(phy_mode))
-		mvreg_write(pp, MVNETA_SERDES_CFG, MVNETA_SGMII_SERDES_PROTO);
-	else if (!phy_interface_mode_is_rgmii(phy_mode))
-		return -EINVAL;
-
-	return 0;
 }
 
 /* Device initialization routine */
@@ -4661,11 +4677,7 @@ static int mvneta_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_netdev;
 
-	err = mvneta_port_power_up(pp, phy_mode);
-	if (err < 0) {
-		dev_err(&pdev->dev, "can't power up port\n");
-		goto err_netdev;
-	}
+	mvneta_port_power_up(pp, phy_mode);
 
 	/* Armada3700 network controller does not support per-cpu
 	 * operation, so only single NAPI should be initialized.
@@ -4818,11 +4830,7 @@ static int mvneta_resume(struct device *device)
 		}
 	}
 	mvneta_defaults_set(pp);
-	err = mvneta_port_power_up(pp, pp->phy_interface);
-	if (err < 0) {
-		dev_err(device, "can't power up port\n");
-		return err;
-	}
+	mvneta_port_power_up(pp, pp->phy_interface);
 
 	netif_device_attach(dev);
 
-- 
2.25.1



