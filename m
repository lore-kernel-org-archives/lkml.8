Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCF822D0B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073045;
	bh=BUZN2iYRYEWpPGvZM9TCQ2IgpLUABmspH7+7b8Y+DXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=La6LH3Jc0ijVKrs9rTF6gGCQXZlcHl0gY5mOsUzk+Q9qjGJyNeQ0Svf04sn2CBm/a
	 CkzIj0UBZuMV4jzJnTo+PsX0ZwuQFAs3rNWCe7GqoXnshcib9ZMSWJbqlo2EtL+RtD
	 M60hmyf/lqiVbQ0mnuv7gkW1wqsuDU+R5Y8m2ypg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHJPYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgHJPX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:23:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CECF922B4B;
        Mon, 10 Aug 2020 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073037;
        bh=BUZN2iYRYEWpPGvZM9TCQ2IgpLUABmspH7+7b8Y+DXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xO6reyXAXk5D51i3v+gvZQJkgWrChRGhr41BmK3rU2zaryFMIgbAC5qEGhWAgkSF0
         wWyCLruF/OW+ZsX2QLOx4+GsCyUdHFnVOh/haDJnrAM4SG1LyoJdS+Tu/sUSEeTgvA
         L6UkAt5gEgOpfWinp5hVK6lPVFHjYa/KKaoN2qsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 45/79] net: ethernet: mtk_eth_soc: Always call mtk_gmac0_rgmii_adjust() for mt7623
Date:   Mon, 10 Aug 2020 17:21:04 +0200
Message-Id: <20200810151814.497793574@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: René van Dorst <opensource@vdorst.com>

[ Upstream commit 19016d93bfc335f0c158c0d9e3b9d06c4dd53d39 ]

Modify mtk_gmac0_rgmii_adjust() so it can always be called.
mtk_gmac0_rgmii_adjust() sets-up the TRGMII clocks.

Signed-off-by: René van Dorst <opensource@vdorst.com>
Signed-off-By: David Woodhouse <dwmw2@infradead.org>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b743d8b56c848..82f5690ff4d30 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -171,11 +171,21 @@ static int mt7621_gmac0_rgmii_adjust(struct mtk_eth *eth,
 	return 0;
 }
 
-static void mtk_gmac0_rgmii_adjust(struct mtk_eth *eth, int speed)
+static void mtk_gmac0_rgmii_adjust(struct mtk_eth *eth,
+				   phy_interface_t interface, int speed)
 {
 	u32 val;
 	int ret;
 
+	if (interface == PHY_INTERFACE_MODE_TRGMII) {
+		mtk_w32(eth, TRGMII_MODE, INTF_MODE);
+		val = 500000000;
+		ret = clk_set_rate(eth->clks[MTK_CLK_TRGPLL], val);
+		if (ret)
+			dev_err(eth->dev, "Failed to set trgmii pll: %d\n", ret);
+		return;
+	}
+
 	val = (speed == SPEED_1000) ?
 		INTF_MODE_RGMII_1000 : INTF_MODE_RGMII_10_100;
 	mtk_w32(eth, val, INTF_MODE);
@@ -262,10 +272,9 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 							      state->interface))
 					goto err_phy;
 			} else {
-				if (state->interface !=
-				    PHY_INTERFACE_MODE_TRGMII)
-					mtk_gmac0_rgmii_adjust(mac->hw,
-							       state->speed);
+				mtk_gmac0_rgmii_adjust(mac->hw,
+						       state->interface,
+						       state->speed);
 
 				/* mt7623_pad_clk_setup */
 				for (i = 0 ; i < NUM_TRGMII_CTRL; i++)
-- 
2.25.1



