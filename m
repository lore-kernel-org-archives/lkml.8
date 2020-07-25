Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA159C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881352070B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fPNOlVxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGYTFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:05:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33386 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGYTFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:05:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06PJ528S094490;
        Sat, 25 Jul 2020 14:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595703902;
        bh=bjijwM5wLlYottlTMUB+TbvoEqhfsmpWFsJ76hQjz3o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fPNOlVxRrBSk/wByd+lZohSG6838ZJOLK+mVOJ3RpwJ9NOu9lajPOvu+zBDCQrY6Z
         79mSoQ7UDTHBOYpdnAdopmvYrFOiI1G1PRBX+Vn75v7uTJZ2ah51cH2BkGu8G2zhxB
         CM388ndM/w/wdkcSCfjnGGZgd5LVEZrB6EvI/y6k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06PJ529H054120;
        Sat, 25 Jul 2020 14:05:02 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 25
 Jul 2020 14:05:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 25 Jul 2020 14:05:02 -0500
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06PJ4uAI024528;
        Sat, 25 Jul 2020 14:05:00 -0500
From:   Sekhar Nori <nsekhar@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/3] phy: ti: am654: simplify return handling
Date:   Sun, 26 Jul 2020 00:34:54 +0530
Message-ID: <20200725190455.43500-3-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200725190455.43500-1-nsekhar@ti.com>
References: <20200725190455.43500-1-nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking return value after each regfield write becomes
hard to read quickly as number of writes increase.

Simplify by checking for error only once.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 48 +++++++++++++------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index ed7669c6a7a0..f3d58853553d 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -163,34 +163,32 @@ static void serdes_am654_disable_pll(struct serdes_am654 *phy)
 
 static int serdes_am654_enable_txrx(struct serdes_am654 *phy)
 {
-	int ret;
+	int ret = 0;
 
 	/* Enable TX */
-	ret = regmap_field_write(phy->fields[TX0_ENABLE], TX0_ENABLE_STATE);
-	if (ret)
-		return ret;
+	ret |= regmap_field_write(phy->fields[TX0_ENABLE], TX0_ENABLE_STATE);
 
 	/* Enable RX */
-	ret = regmap_field_write(phy->fields[RX0_ENABLE], RX0_ENABLE_STATE);
+	ret |= regmap_field_write(phy->fields[RX0_ENABLE], RX0_ENABLE_STATE);
+
 	if (ret)
-		return ret;
+		return -EIO;
 
 	return 0;
 }
 
 static int serdes_am654_disable_txrx(struct serdes_am654 *phy)
 {
-	int ret;
+	int ret = 0;
 
 	/* Disable TX */
-	ret = regmap_field_write(phy->fields[TX0_ENABLE], TX0_DISABLE_STATE);
-	if (ret)
-		return ret;
+	ret |= regmap_field_write(phy->fields[TX0_ENABLE], TX0_DISABLE_STATE);
 
 	/* Disable RX */
-	ret = regmap_field_write(phy->fields[RX0_ENABLE], RX0_DISABLE_STATE);
+	ret |= regmap_field_write(phy->fields[RX0_ENABLE], RX0_DISABLE_STATE);
+
 	if (ret)
-		return ret;
+		return -EIO;
 
 	return 0;
 }
@@ -313,19 +311,14 @@ static int serdes_am654_usb3_init(struct serdes_am654 *phy)
 
 static int serdes_am654_pcie_init(struct serdes_am654 *phy)
 {
-	int ret;
+	int ret = 0;
 
-	ret = regmap_field_write(phy->fields[CONFIG_VERSION], VERSION_VAL);
-	if (ret)
-		return ret;
+	ret |= regmap_field_write(phy->fields[CONFIG_VERSION], VERSION_VAL);
+	ret |= regmap_field_write(phy->fields[CMU_MASTER_CDN], 0x1);
+	ret |= regmap_field_write(phy->fields[L1_MASTER_CDN], 0x1);
 
-	ret = regmap_field_write(phy->fields[CMU_MASTER_CDN], 0x1);
 	if (ret)
-		return ret;
-
-	ret = regmap_field_write(phy->fields[L1_MASTER_CDN], 0x1);
-	if (ret)
-		return ret;
+		return -EIO;
 
 	return 0;
 }
@@ -347,20 +340,19 @@ static int serdes_am654_init(struct phy *x)
 static int serdes_am654_reset(struct phy *x)
 {
 	struct serdes_am654 *phy = phy_get_drvdata(x);
-	int ret;
+	int ret = 0;
 
 	serdes_am654_disable_pll(phy);
 	serdes_am654_disable_txrx(phy);
 
-	ret = regmap_field_write(phy->fields[POR_EN], 0x1);
-	if (ret)
-		return ret;
+	ret |= regmap_field_write(phy->fields[POR_EN], 0x1);
 
 	mdelay(1);
 
-	ret = regmap_field_write(phy->fields[POR_EN], 0x0);
+	ret |= regmap_field_write(phy->fields[POR_EN], 0x0);
+
 	if (ret)
-		return ret;
+		return -EIO;
 
 	return 0;
 }
-- 
2.17.1

