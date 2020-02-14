Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2342168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o3233FPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbgBNTIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:08:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54338 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbgBNTIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01EJ8GE4119659
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:08:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581707296;
        bh=bbClUN90t+mxvEe+omlsh7y6yJ76+M6R4CEUoguIV2U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=o3233FPmLBgosaxE/jmm4QOuQLfn0u95wse9uwGuzmjsIlURiZHEvxEHACEQ2WXLX
         v8aXfjb+u2OZRIKiMtZcNDyMsgAeaqpBorW7IL72HTa4LD6vsc/h6jlzPIm9W8W5XL
         lltfmTGfL+3m1PvfzSe8YmQ/LCkzSKk7LpdhdSHE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01EJ8GVa058301
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:08:16 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 13:08:15 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 13:08:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01EJ8EnH065349;
        Fri, 14 Feb 2020 13:08:15 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] phy: ti: gmii-sel: fix set of copy-paste errors
Date:   Fri, 14 Feb 2020 21:08:00 +0200
Message-ID: <20200214190801.3030-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214190801.3030-1-grygorii.strashko@ti.com>
References: <20200214190801.3030-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- under PHY_INTERFACE_MODE_MII the 'mode' func parameter is assigned
instead of 'gmii_sel_mode' and it's working only because the default value
'gmii_sel_mode' is set to 0.

- console outputs use 'rgmii_id' and 'mode' values to print PHY mode
instead of using 'submode' value which is representing PHY interface mode
now.

This patch fixes above two cases.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index a28bd15297f5..e998e9cd8d1f 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -80,20 +80,19 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		break;
 
 	case PHY_INTERFACE_MODE_MII:
-		mode = AM33XX_GMII_SEL_MODE_MII;
+		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
 
 	default:
-		dev_warn(dev,
-			 "port%u: unsupported mode: \"%s\". Defaulting to MII.\n",
-			 if_phy->id, phy_modes(rgmii_id));
+		dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
+			 if_phy->id, phy_modes(submode));
 		return -EINVAL;
 	}
 
 	if_phy->phy_if_mode = submode;
 
 	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
-		__func__, if_phy->id, mode, rgmii_id,
+		__func__, if_phy->id, submode, rgmii_id,
 		if_phy->rmii_clock_external);
 
 	regfield = if_phy->fields[PHY_GMII_SEL_PORT_MODE];
-- 
2.17.1

