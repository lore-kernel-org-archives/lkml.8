Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F7FCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC53A24AD1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NZpMTNSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgEMNNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:13:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49462 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbgEMNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:13:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DDD7JG044270
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589375587;
        bh=jbWEqBFjeKp3BVaopojDNa8AUqqo/0PJjO2dFwUfoBU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NZpMTNSC5jmBDF1YrdI5beZKlef87C7flYXtFfn8z6mDDZUxo6QN8yJWdlk4tEGUL
         MN2aAZfXv0x11PVqxrE6APMsYy7OnzGJTWH1b+HlupLbuBS0Fh1mLex6HcXOrnlSOH
         JFd5Ck1WaxCw+euZTMNWhkEHyysnSIcNLOKkw1eg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DDD7tB093933
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:13:07 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 08:13:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 08:13:06 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DDD16e043420;
        Wed, 13 May 2020 08:13:05 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <vigneshr@ti.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] phy: ti: am654: add support for USB super-speed
Date:   Wed, 13 May 2020 16:12:54 +0300
Message-ID: <20200513131254.10497-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513131254.10497-1-rogerq@ti.com>
References: <20200513131254.10497-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SERDES PHY can support USB super-speed lane.
Add support for that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 103 +++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 29e34d29895a..0a166d5a6414 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -201,9 +201,91 @@ static int serdes_am654_power_off(struct phy *x)
 	return 0;
 }
 
-static int serdes_am654_init(struct phy *x)
+#define SERDES_AM654_CFG(offset, a, b, val) \
+	regmap_update_bits(phy->regmap, (offset),\
+			   GENMASK((a), (b)), (val) << (b))
+
+static int serdes_am654_usb3_init(struct serdes_am654 *phy)
+{
+	SERDES_AM654_CFG(0x0000, 31, 24, 0x17);
+	SERDES_AM654_CFG(0x0004, 15, 8, 0x02);
+	SERDES_AM654_CFG(0x0004, 7, 0, 0x0e);
+	SERDES_AM654_CFG(0x0008, 23, 16, 0x2e);
+	SERDES_AM654_CFG(0x0008, 31, 24, 0x2e);
+	SERDES_AM654_CFG(0x0060, 7, 0, 0x4b);
+	SERDES_AM654_CFG(0x0060, 15, 8, 0x98);
+	SERDES_AM654_CFG(0x0060, 23, 16, 0x60);
+	SERDES_AM654_CFG(0x00d0, 31, 24, 0x45);
+	SERDES_AM654_CFG(0x00e8, 15, 8, 0x0e);
+	SERDES_AM654_CFG(0x0220, 7, 0, 0x34);
+	SERDES_AM654_CFG(0x0220, 15, 8, 0x34);
+	SERDES_AM654_CFG(0x0220, 31, 24, 0x37);
+	SERDES_AM654_CFG(0x0224, 7, 0, 0x37);
+	SERDES_AM654_CFG(0x0224, 15, 8, 0x37);
+	SERDES_AM654_CFG(0x0228, 23, 16, 0x37);
+	SERDES_AM654_CFG(0x0228, 31, 24, 0x37);
+	SERDES_AM654_CFG(0x022c, 7, 0, 0x37);
+	SERDES_AM654_CFG(0x022c, 15, 8, 0x37);
+	SERDES_AM654_CFG(0x0230, 15, 8, 0x2a);
+	SERDES_AM654_CFG(0x0230, 23, 16, 0x2a);
+	SERDES_AM654_CFG(0x0240, 23, 16, 0x10);
+	SERDES_AM654_CFG(0x0240, 31, 24, 0x34);
+	SERDES_AM654_CFG(0x0244, 7, 0, 0x40);
+	SERDES_AM654_CFG(0x0244, 23, 16, 0x34);
+	SERDES_AM654_CFG(0x0248, 15, 8, 0x0d);
+	SERDES_AM654_CFG(0x0258, 15, 8, 0x16);
+	SERDES_AM654_CFG(0x0258, 23, 16, 0x84);
+	SERDES_AM654_CFG(0x0258, 31, 24, 0xf2);
+	SERDES_AM654_CFG(0x025c, 7, 0, 0x21);
+	SERDES_AM654_CFG(0x0260, 7, 0, 0x27);
+	SERDES_AM654_CFG(0x0260, 15, 8, 0x04);
+	SERDES_AM654_CFG(0x0268, 15, 8, 0x04);
+	SERDES_AM654_CFG(0x0288, 15, 8, 0x2c);
+	SERDES_AM654_CFG(0x0330, 31, 24, 0xa0);
+	SERDES_AM654_CFG(0x0338, 23, 16, 0x03);
+	SERDES_AM654_CFG(0x0338, 31, 24, 0x00);
+	SERDES_AM654_CFG(0x033c, 7, 0, 0x00);
+	SERDES_AM654_CFG(0x0344, 31, 24, 0x18);
+	SERDES_AM654_CFG(0x034c, 7, 0, 0x18);
+	SERDES_AM654_CFG(0x039c, 23, 16, 0x3b);
+	SERDES_AM654_CFG(0x0a04, 7, 0, 0x03);
+	SERDES_AM654_CFG(0x0a14, 31, 24, 0x3c);
+	SERDES_AM654_CFG(0x0a18, 15, 8, 0x3c);
+	SERDES_AM654_CFG(0x0a38, 7, 0, 0x3e);
+	SERDES_AM654_CFG(0x0a38, 15, 8, 0x3e);
+	SERDES_AM654_CFG(0x0ae0, 7, 0, 0x07);
+	SERDES_AM654_CFG(0x0b6c, 23, 16, 0xcd);
+	SERDES_AM654_CFG(0x0b6c, 31, 24, 0x04);
+	SERDES_AM654_CFG(0x0b98, 23, 16, 0x03);
+	SERDES_AM654_CFG(0x1400, 7, 0, 0x3f);
+	SERDES_AM654_CFG(0x1404, 23, 16, 0x6f);
+	SERDES_AM654_CFG(0x1404, 31, 24, 0x6f);
+	SERDES_AM654_CFG(0x140c, 7, 0, 0x6f);
+	SERDES_AM654_CFG(0x140c, 15, 8, 0x6f);
+	SERDES_AM654_CFG(0x1410, 15, 8, 0x27);
+	SERDES_AM654_CFG(0x1414, 7, 0, 0x0c);
+	SERDES_AM654_CFG(0x1414, 23, 16, 0x07);
+	SERDES_AM654_CFG(0x1418, 23, 16, 0x40);
+	SERDES_AM654_CFG(0x141c, 7, 0, 0x00);
+	SERDES_AM654_CFG(0x141c, 15, 8, 0x1f);
+	SERDES_AM654_CFG(0x1428, 31, 24, 0x08);
+	SERDES_AM654_CFG(0x1434, 31, 24, 0x00);
+	SERDES_AM654_CFG(0x1444, 7, 0, 0x94);
+	SERDES_AM654_CFG(0x1460, 31, 24, 0x7f);
+	SERDES_AM654_CFG(0x1464, 7, 0, 0x43);
+	SERDES_AM654_CFG(0x1464, 23, 16, 0x6f);
+	SERDES_AM654_CFG(0x1464, 31, 24, 0x43);
+	SERDES_AM654_CFG(0x1484, 23, 16, 0x8f);
+	SERDES_AM654_CFG(0x1498, 7, 0, 0x4f);
+	SERDES_AM654_CFG(0x1498, 23, 16, 0x4f);
+	SERDES_AM654_CFG(0x007c, 31, 24, 0x0d);
+	SERDES_AM654_CFG(0x0b90, 15, 8, 0x0f);
+
+	return 0;
+}
+
+static int serdes_am654_pcie_init(struct serdes_am654 *phy)
 {
-	struct serdes_am654 *phy = phy_get_drvdata(x);
 	int ret;
 
 	ret = regmap_field_write(phy->config_version, VERSION);
@@ -221,11 +303,28 @@ static int serdes_am654_init(struct phy *x)
 	return 0;
 }
 
+static int serdes_am654_init(struct phy *x)
+{
+	struct serdes_am654 *phy = phy_get_drvdata(x);
+
+	switch (phy->type) {
+	case PHY_TYPE_PCIE:
+		return serdes_am654_pcie_init(phy);
+	case PHY_TYPE_USB3:
+		return serdes_am654_usb3_init(phy);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int serdes_am654_reset(struct phy *x)
 {
 	struct serdes_am654 *phy = phy_get_drvdata(x);
 	int ret;
 
+	serdes_am654_disable_pll(phy);
+	serdes_am654_disable_txrx(phy);
+
 	ret = regmap_field_write(phy->por_en, 0x1);
 	if (ret)
 		return ret;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

