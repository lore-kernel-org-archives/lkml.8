Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A62C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B16B2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iTr76a5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAVPiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:38:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56344 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgAVPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:38:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00MFc6tR077651;
        Wed, 22 Jan 2020 09:38:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579707486;
        bh=kob/UwlpiIAVRmzihXWH6e8kyXhag43yFDizmSZHPjI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iTr76a5sWaVHRjDaaRoVYUV2SFCQNgSFlLNz2pKoTE2OBgMMdNiqw+ChnfyHfsHu7
         hlyPKGgVx3lP+twLBYVQza8cZO5N+e9Bk2YCWTf2oKO2PtdQPs5hpCueYqpP/orjfh
         ZfoZADPIsNMwiNksp55/CMdNCVYr53gU/O7wX9Hc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00MFc6IE049569
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 09:38:06 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 09:38:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 09:38:06 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00MFc5da114332;
        Wed, 22 Jan 2020 09:38:05 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <bunk@kernel.org>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next 1/2] phy: dp83826: Add phy IDs for DP83826N and 826NC
Date:   Wed, 22 Jan 2020 09:34:54 -0600
Message-ID: <20200122153455.8777-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122153455.8777-1-dmurphy@ti.com>
References: <20200122153455.8777-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add phy IDs to the DP83822 phy driver for the DP83826N
and the DP83826NC devices.  The register map and features
are the same for basic enablement.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/phy/Kconfig   | 4 ++--
 drivers/net/phy/dp83822.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 6b5ee26795a2..cc677ddd2719 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -346,9 +346,9 @@ config DAVICOM_PHY
 	  Currently supports dm9161e and dm9131
 
 config DP83822_PHY
-	tristate "Texas Instruments DP83822/825 PHYs"
+	tristate "Texas Instruments DP83822/825/826 PHYs"
 	---help---
-	  Supports the DP83822 and DP83825I PHYs.
+	  Supports the DP83822, DP83825I, DP83826C and DP83826NC PHYs.
 
 config DP83TC811_PHY
 	tristate "Texas Instruments DP83TC811 PHY"
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 8a4b1d167ce2..5159b28baa0f 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -16,6 +16,8 @@
 
 #define DP83822_PHY_ID	        0x2000a240
 #define DP83825I_PHY_ID		0x2000a150
+#define DP83826C_PHY_ID		0x2000a130
+#define DP83826NC_PHY_ID	0x2000a110
 
 #define DP83822_DEVADDR		0x1f
 
@@ -319,12 +321,16 @@ static int dp83822_resume(struct phy_device *phydev)
 static struct phy_driver dp83822_driver[] = {
 	DP83822_PHY_DRIVER(DP83822_PHY_ID, "TI DP83822"),
 	DP83822_PHY_DRIVER(DP83825I_PHY_ID, "TI DP83825I"),
+	DP83822_PHY_DRIVER(DP83826C_PHY_ID, "TI DP83826C"),
+	DP83822_PHY_DRIVER(DP83826NC_PHY_ID, "TI DP83826NC"),
 };
 module_phy_driver(dp83822_driver);
 
 static struct mdio_device_id __maybe_unused dp83822_tbl[] = {
 	{ DP83822_PHY_ID, 0xfffffff0 },
 	{ DP83825I_PHY_ID, 0xfffffff0 },
+	{ DP83826C_PHY_ID, 0xfffffff0 },
+	{ DP83826NC_PHY_ID, 0xfffffff0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, dp83822_tbl);
-- 
2.25.0

