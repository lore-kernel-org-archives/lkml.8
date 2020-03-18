Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C770FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4592076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KDE0LBb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgCRKbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:31:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7610 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgCRKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:31:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e71f8300000>; Wed, 18 Mar 2020 03:30:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Mar 2020 03:31:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Mar 2020 03:31:45 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Mar
 2020 10:31:45 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Mar 2020 10:31:44 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e71f88d0000>; Wed, 18 Mar 2020 03:31:44 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jckuo@nvidia.com>, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V1 2/8] usb: gadget: tegra-xudc: Add vbus_draw support
Date:   Wed, 18 Mar 2020 16:01:01 +0530
Message-ID: <1584527467-8058-3-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
References: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584527408; bh=DoJmXrvssZWCJ9gfW/wd+UXHLuO5NPef5jNXe5/k160=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KDE0LBb2XMrBIJKQxfY22UA6GqaQ4x55yYHndKCo9mkuedesAn0z/YKRdbHgFGBBk
         wZc+ATvJoaI95Nlv3T9zr4/dvO1RmTiZ+MOZuRZhADpsd0R8MwCmKO9CA03JBPXCxw
         76v0ysu41bek+kbEmreK1S981l9KOXT6tVq0L0gavqYSJb97Jrw7bShKJ/v81lYnXe
         JFmXYVcqatbt5qz8cwf+1pRTMW+aH6aNBsXLSWE7gPysb9VQEa8bHhZlRNu3HwPaNJ
         iRJetC5m4YuIWUvrFVusdARVBUFsAJb7MU1uGK01qIPo2Rvtp077jbn3O9rydLVmTL
         UpFl6t0eU4QsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register vbus_draw to gadget ops and update corresponding vbus
draw current to usb_phy.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 52a6add..9d3c109 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -492,6 +492,7 @@ struct tegra_xudc {
 	bool powergated;
 
 	struct usb_phy **usbphy;
+	struct usb_phy *curr_usbphy;
 	struct notifier_block vbus_nb;
 
 	struct completion disconnect_complete;
@@ -719,6 +720,7 @@ static int tegra_xudc_vbus_notify(struct notifier_block *nb,
 	if (!xudc->suspended && phy_index != -1) {
 		xudc->curr_utmi_phy = xudc->utmi_phy[phy_index];
 		xudc->curr_usb3_phy = xudc->usb3_phy[phy_index];
+		xudc->curr_usbphy = usbphy;
 		schedule_work(&xudc->usb_role_sw_work);
 	}
 
@@ -2042,6 +2044,19 @@ static int tegra_xudc_gadget_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
+static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
+						unsigned int m_a)
+{
+	struct tegra_xudc *xudc = to_xudc(gadget);
+
+	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
+
+	if (xudc->curr_usbphy->chg_type == SDP_TYPE)
+		usb_phy_set_power(xudc->curr_usbphy, m_a);
+
+	return 0;
+}
+
 static int tegra_xudc_set_selfpowered(struct usb_gadget *gadget, int is_on)
 {
 	struct tegra_xudc *xudc = to_xudc(gadget);
@@ -2058,6 +2073,7 @@ static struct usb_gadget_ops tegra_xudc_gadget_ops = {
 	.pullup = tegra_xudc_gadget_pullup,
 	.udc_start = tegra_xudc_gadget_start,
 	.udc_stop = tegra_xudc_gadget_stop,
+	.vbus_draw = tegra_xudc_gadget_vbus_draw,
 	.set_selfpowered = tegra_xudc_set_selfpowered,
 };
 
-- 
2.7.4

