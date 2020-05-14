Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DDDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3912420734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ut8CN91E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENGXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:23:03 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11588 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgENGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:22:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebce3b50000>; Wed, 13 May 2020 23:22:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 23:22:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 May 2020 23:22:57 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 06:22:57 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 14 May 2020 06:22:57 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ebce3bd0003>; Wed, 13 May 2020 23:22:56 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V3 2/8] usb: gadget: tegra-xudc: Add vbus_draw support
Date:   Thu, 14 May 2020 11:52:37 +0530
Message-ID: <1589437363-16727-3-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589437365; bh=QIrSOgashcQZQOkj7X99YKOXC+8KTj9YocqUEBpgy58=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ut8CN91E2PDKeQel9ydmny52SrssCT1d4y7wJP6d3rH/9LFrlcNgdzBkHvEqMKPWw
         EiKi5d56kgCZKs/dznixgvYu05DSG321YjAKhxmLoMzePUWguRSkw/59+yMCOLYx1J
         idH88urf8ZslpkFFXfiYrQI17jei6LFOE1L6OUwkwElapXWxc7o66qJRJOMOvPpk5g
         bCI3hdDpF/uOlxCWYZfEAKXwhD0mfG9Wi4Y7ryBag+nMsg1fE9u3ptOQj9ynRl93QE
         A1/GLHTyYOL05a453AHkWx4YtP8mHzF/5DCF29zZG1xLg/t1SwpNGz4Qoksev/ojm+
         QuHwkssmUbE6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register vbus_draw to gadget ops and update corresponding vbus
draw current to usb_phy.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V3:
 - Propogated usb_phy->set_power error to vbus_draw caller.
---
V2:
 - Patch re-based.
---
 drivers/usb/gadget/udc/tegra-xudc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 52a6add..53e2d1c 100644
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
 
@@ -2042,6 +2044,20 @@ static int tegra_xudc_gadget_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
+static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
+						unsigned int m_a)
+{
+	int ret = 0;
+	struct tegra_xudc *xudc = to_xudc(gadget);
+
+	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
+
+	if (xudc->curr_usbphy->chg_type == SDP_TYPE)
+		ret = usb_phy_set_power(xudc->curr_usbphy, m_a);
+
+	return ret;
+}
+
 static int tegra_xudc_set_selfpowered(struct usb_gadget *gadget, int is_on)
 {
 	struct tegra_xudc *xudc = to_xudc(gadget);
@@ -2058,6 +2074,7 @@ static struct usb_gadget_ops tegra_xudc_gadget_ops = {
 	.pullup = tegra_xudc_gadget_pullup,
 	.udc_start = tegra_xudc_gadget_start,
 	.udc_stop = tegra_xudc_gadget_stop,
+	.vbus_draw = tegra_xudc_gadget_vbus_draw,
 	.set_selfpowered = tegra_xudc_set_selfpowered,
 };
 
-- 
2.7.4

