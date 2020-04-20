Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E69EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60129206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387316;
	bh=o1XlVPs9AX/xNlQhb4LGlweciPHFW5GnnHfhtJ1QvDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HZYKVMUzhx3bk5UtyXeLIArFvgOoDoxRSrp60b2UCM0LzcN0BENCobXmNGmPh6g5D
	 K7XurK3GUpoii7kGGsG52n3luvjdDAiYTzHSg8p8ou8oxKlx87NVoG4YrKjXsfZuuE
	 vYZ0kIxRrBpXK7CQsBX9UQNSDLZJAJO6Qrnb5v+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgDTMpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgDTMpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF8C20736;
        Mon, 20 Apr 2020 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386750;
        bh=o1XlVPs9AX/xNlQhb4LGlweciPHFW5GnnHfhtJ1QvDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HukaNLv/4joC9X/RK1hxRevHnJPjT9PwrGuJD67dKB30W61d2MUlZGVte+vDKZEYB
         bK68kxie7/kW6Xt1R4/KIbYXqfedt9gxiqG2Yyz6KHOXP9e3SUqcCf+8q1oE2nBO+6
         m4UEQNab7Z57E6EgYgdRCcSGKVOayg68UwZAcAfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 12/60] net: ethernet: mediatek: move mt7623 settings out off the mt7530
Date:   Mon, 20 Apr 2020 14:38:50 +0200
Message-Id: <20200420121504.762937398@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "René van Dorst" <opensource@vdorst.com>

[ Upstream commit a5d75538295b06bc6ade1b9da07b9bee57d1c677 ]

Moving mt7623 logic out off mt7530, is required to make hardware setting
consistent after we introduce phylink to mtk driver.

Fixes: b8fc9f30821e ("net: ethernet: mediatek: Add basic PHYLINK support")
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: RenÃ© van Dorst <opensource@vdorst.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |   24 +++++++++++++++++++++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |    8 ++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -65,6 +65,17 @@ u32 mtk_r32(struct mtk_eth *eth, unsigne
 	return __raw_readl(eth->base + reg);
 }
 
+u32 mtk_m32(struct mtk_eth *eth, u32 mask, u32 set, unsigned reg)
+{
+	u32 val;
+
+	val = mtk_r32(eth, reg);
+	val &= ~mask;
+	val |= set;
+	mtk_w32(eth, val, reg);
+	return reg;
+}
+
 static int mtk_mdio_busy_wait(struct mtk_eth *eth)
 {
 	unsigned long t_start = jiffies;
@@ -193,7 +204,7 @@ static void mtk_mac_config(struct phylin
 	struct mtk_mac *mac = container_of(config, struct mtk_mac,
 					   phylink_config);
 	struct mtk_eth *eth = mac->hw;
-	u32 mcr_cur, mcr_new, sid;
+	u32 mcr_cur, mcr_new, sid, i;
 	int val, ge_mode, err;
 
 	/* MT76x8 has no hardware settings between for the MAC */
@@ -255,6 +266,17 @@ static void mtk_mac_config(struct phylin
 				    PHY_INTERFACE_MODE_TRGMII)
 					mtk_gmac0_rgmii_adjust(mac->hw,
 							       state->speed);
+
+				/* mt7623_pad_clk_setup */
+				for (i = 0 ; i < NUM_TRGMII_CTRL; i++)
+					mtk_w32(mac->hw,
+						TD_DM_DRVP(8) | TD_DM_DRVN(8),
+						TRGMII_TD_ODT(i));
+
+				/* Assert/release MT7623 RXC reset */
+				mtk_m32(mac->hw, 0, RXC_RST | RXC_DQSISEL,
+					TRGMII_RCK_CTRL);
+				mtk_m32(mac->hw, RXC_RST, 0, TRGMII_RCK_CTRL);
 			}
 		}
 
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -350,10 +350,13 @@
 #define DQSI0(x)		((x << 0) & GENMASK(6, 0))
 #define DQSI1(x)		((x << 8) & GENMASK(14, 8))
 #define RXCTL_DMWTLAT(x)	((x << 16) & GENMASK(18, 16))
+#define RXC_RST			BIT(31)
 #define RXC_DQSISEL		BIT(30)
 #define RCK_CTRL_RGMII_1000	(RXC_DQSISEL | RXCTL_DMWTLAT(2) | DQSI1(16))
 #define RCK_CTRL_RGMII_10_100	RXCTL_DMWTLAT(2)
 
+#define NUM_TRGMII_CTRL		5
+
 /* TRGMII RXC control register */
 #define TRGMII_TCK_CTRL		0x10340
 #define TXCTL_DMWTLAT(x)	((x << 16) & GENMASK(18, 16))
@@ -361,6 +364,11 @@
 #define TCK_CTRL_RGMII_1000	TXCTL_DMWTLAT(2)
 #define TCK_CTRL_RGMII_10_100	(TXC_INV | TXCTL_DMWTLAT(2))
 
+/* TRGMII TX Drive Strength */
+#define TRGMII_TD_ODT(i)	(0x10354 + 8 * (i))
+#define  TD_DM_DRVP(x)		((x) & 0xf)
+#define  TD_DM_DRVN(x)		(((x) & 0xf) << 4)
+
 /* TRGMII Interface mode register */
 #define INTF_MODE		0x10390
 #define TRGMII_INTF_DIS		BIT(0)


