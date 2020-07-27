Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F9C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8844206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GTSMij9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgG0TqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:46:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50658 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbgG0TqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:46:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk90T060443;
        Mon, 27 Jul 2020 14:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595879169;
        bh=0vY0hgXxukHP9jtOcK8qFQQ+zGOyKifCN+foC5RX9i4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GTSMij9k+0Iaia2eJZjG1PjtlsIi3gX7CjA10a21/k8S4faQdjaAKJZidybIu4C5y
         L3doTEp05UD+Z8IjWCIgwvWXH7QW+bwaFJNOp/65tUR11GNcNOMYvmZzi9ui/lGNxv
         AMgNZxuKd5tY2lMaw8IFKwbs7cO1C0hFXtMWr3NM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06RJk93w009461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 14:46:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 14:46:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 14:46:09 -0500
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk3mY036731;
        Mon, 27 Jul 2020 14:46:08 -0500
From:   Sekhar Nori <nsekhar@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 2/3] phy: ti: am654: simplify return handling
Date:   Tue, 28 Jul 2020 01:16:02 +0530
Message-ID: <20200727194603.44636-3-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727194603.44636-1-nsekhar@ti.com>
References: <20200727194603.44636-1-nsekhar@ti.com>
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
index 836193a71018..e73432a7bf0c 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -161,34 +161,32 @@ static void serdes_am654_disable_pll(struct serdes_am654 *phy)
 
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
@@ -311,19 +309,14 @@ static int serdes_am654_usb3_init(struct serdes_am654 *phy)
 
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
@@ -345,20 +338,19 @@ static int serdes_am654_init(struct phy *x)
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

