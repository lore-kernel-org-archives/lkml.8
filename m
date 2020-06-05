Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDD2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF443208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366628;
	bh=O5JZywhz7iAfb7m4Z4WcOq4q0ejSwcFYHqTjUmqM/h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuNKXWzgQ/BVi14pFn+Sm62vI+Ef7e11Ik6lGnD70r9rwwJpvulGRIxWGrwqaFFnB
	 NiAKV0cs3l+5y5SkyTLT5GfN7HG+sWMHESwUIARdy6Xj/zO7gZ7e/zWZW38/RLc2T/
	 cgk/F0NdsWMY0MWjAcqtxQPu+YtxbY+QZUouPhT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFEORI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgFEORC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:17:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E59B20820;
        Fri,  5 Jun 2020 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366621;
        bh=O5JZywhz7iAfb7m4Z4WcOq4q0ejSwcFYHqTjUmqM/h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rri9CENTStIQxe68OqdBc1VarHtHXh9BvaMOFutzsrGeA+9/oqxFrwEiCpl1rO0px
         9jhtmyjggNxK7n80mGxTp5seCMavd1+siWzGX09KziWYUPm2rpoq9ulJpjqmSFJr2k
         hc6JvYv9XOzCyy68jUaGF4T4X9BXpiv+JOWliuGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan McDowell <noodles@earth.li>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 27/43] net: ethernet: stmmac: Enable interface clocks on probe for IPQ806x
Date:   Fri,  5 Jun 2020 16:14:57 +0200
Message-Id: <20200605140153.945772434@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
References: <20200605140152.493743366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan McDowell <noodles@earth.li>

[ Upstream commit a96ac8a0045e3cbe3e5af6d1b3c78c6c2065dec5 ]

The ipq806x_gmac_probe() function enables the PTP clock but not the
appropriate interface clocks. This means that if the bootloader hasn't
done so attempting to bring up the interface will fail with an error
like:

[   59.028131] ipq806x-gmac-dwmac 37600000.ethernet: Failed to reset the dma
[   59.028196] ipq806x-gmac-dwmac 37600000.ethernet eth1: stmmac_hw_setup: DMA engine initialization failed
[   59.034056] ipq806x-gmac-dwmac 37600000.ethernet eth1: stmmac_open: Hw setup failed

This patch, a slightly cleaned up version of one posted by Sergey
Sergeev in:

https://forum.openwrt.org/t/support-for-mikrotik-rb3011uias-rm/4064/257

correctly enables the clock; we have already configured the source just
before this.

Tested on a MikroTik RB3011.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 6ae13dc19510..02102c781a8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -319,6 +319,19 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	/* Enable PTP clock */
 	regmap_read(gmac->nss_common, NSS_COMMON_CLK_GATE, &val);
 	val |= NSS_COMMON_CLK_GATE_PTP_EN(gmac->id);
+	switch (gmac->phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val |= NSS_COMMON_CLK_GATE_RGMII_RX_EN(gmac->id) |
+			NSS_COMMON_CLK_GATE_RGMII_TX_EN(gmac->id);
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		val |= NSS_COMMON_CLK_GATE_GMII_RX_EN(gmac->id) |
+				NSS_COMMON_CLK_GATE_GMII_TX_EN(gmac->id);
+		break;
+	default:
+		/* We don't get here; the switch above will have errored out */
+		unreachable();
+	}
 	regmap_write(gmac->nss_common, NSS_COMMON_CLK_GATE, val);
 
 	if (gmac->phy_mode == PHY_INTERFACE_MODE_SGMII) {
-- 
2.25.1



