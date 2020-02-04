Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FAFC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DBD2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VBfoWl5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBDLTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:19:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17817 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBDLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:19:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3953380000>; Tue, 04 Feb 2020 03:19:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:19:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 03:19:34 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:19:34 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 11:19:34 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3953420003>; Tue, 04 Feb 2020 03:19:33 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V4 11/19] usb: gadget: tegra-xudc: use phy_set_mode to set/unset device mode
Date:   Tue, 4 Feb 2020 16:46:57 +0530
Message-ID: <1580815025-10915-12-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
References: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580815160; bh=igVSo2mfNVtagxj3RhNAjOT/siijr7JpRryr9zwiHac=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VBfoWl5oUzNrUo4U8rlxSgjuqavNf377gAWJl1vDsCbipeBe3r9j8DW1EPevv4VFr
         /bPHoHY8u9ZwzuphzVx1MvjxJeFUdTCQQPgsoUujlZO/+6WneCnzUlO1XDOZc8uVA6
         iHYKzmRhQD08k9xSgWn1z6lva2ybECZfWqdkMj+8fpYyskfoPpGBWdXjxiP6c+paGB
         eqAS+zEnHoaalM3okLtsT+cK2Swu4BRHZVuhKZeSiJJa4NXmgEeBlg42oX/wSEz+un
         yLiX1H4+7YqinsOgO4E69eZUhH80688+Tqh8T9iUU5R5bt+LJnrdjLuk1pqHN2t/G9
         vmQ8071pGCblg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device mode is set/uset, VBUS override activity is done via
exported functions from padctl driver. Use phy_set_mode() instead.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V4:
 - Updated commit message as per comments from Thierry.
---
V2-V3:
 - No changes in this version
---
 drivers/usb/gadget/udc/tegra-xudc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 7411dd15..a2299ee 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -612,7 +612,7 @@ static void tegra_xudc_device_mode_on(struct tegra_xudc *xudc)
 
 	dev_dbg(xudc->dev, "device mode on\n");
 
-	tegra_xusb_padctl_set_vbus_override(xudc->padctl, true);
+	phy_set_mode_ext(xudc->utmi_phy, PHY_MODE_USB_OTG, USB_ROLE_DEVICE);
 }
 
 static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
@@ -627,7 +627,7 @@ static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
 
 	reinit_completion(&xudc->disconnect_complete);
 
-	tegra_xusb_padctl_set_vbus_override(xudc->padctl, false);
+	phy_set_mode_ext(xudc->utmi_phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
 
 	pls = (xudc_readl(xudc, PORTSC) & PORTSC_PLS_MASK) >>
 		PORTSC_PLS_SHIFT;
@@ -714,9 +714,11 @@ static void tegra_xudc_plc_reset_work(struct work_struct *work)
 
 		if (pls == PORTSC_PLS_INACTIVE) {
 			dev_info(xudc->dev, "PLS = Inactive. Toggle VBUS\n");
-			tegra_xusb_padctl_set_vbus_override(xudc->padctl,
-							      false);
-			tegra_xusb_padctl_set_vbus_override(xudc->padctl, true);
+			phy_set_mode_ext(xudc->utmi_phy, PHY_MODE_USB_OTG,
+					 USB_ROLE_NONE);
+			phy_set_mode_ext(xudc->utmi_phy, PHY_MODE_USB_OTG,
+					 USB_ROLE_DEVICE);
+
 			xudc->wait_csc = false;
 		}
 	}
-- 
2.7.4

