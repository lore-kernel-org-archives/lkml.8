Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D23DC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051A420B1F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgDKGiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 02:38:16 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:24987 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgDKGiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:38:16 -0400
Received: from localhost.localdomain ([93.22.135.18])
        by mwinf5d37 with ME
        id RJeD220060Pz5GD03JeDNh; Sat, 11 Apr 2020 08:38:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 08:38:14 +0200
X-ME-IP: 93.22.135.18
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, paul@crapouillou.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] usb: phy: jz4770: Add a missing '\n' in a log message
Date:   Sat, 11 Apr 2020 08:38:11 +0200
Message-Id: <20200411063811.6767-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: 541368b46b82 ("usb: phy: Add driver for the Ingenic JZ4770 USB transceiver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/phy/phy-jz4770.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
index 3ea1f5b9bcf8..8f62dc2a90ff 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -125,13 +125,13 @@ static int jz4770_phy_init(struct usb_phy *phy)
 
 	err = regulator_enable(priv->vcc_supply);
 	if (err) {
-		dev_err(priv->dev, "Unable to enable VCC: %d", err);
+		dev_err(priv->dev, "Unable to enable VCC: %d\n", err);
 		return err;
 	}
 
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
-		dev_err(priv->dev, "Unable to start clock: %d", err);
+		dev_err(priv->dev, "Unable to start clock: %d\n", err);
 		return err;
 	}
 
@@ -191,7 +191,7 @@ static int jz4770_phy_probe(struct platform_device *pdev)
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
-		dev_err(dev, "Failed to map registers");
+		dev_err(dev, "Failed to map registers\n");
 		return PTR_ERR(priv->base);
 	}
 
@@ -199,7 +199,7 @@ static int jz4770_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk)) {
 		err = PTR_ERR(priv->clk);
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get clock");
+			dev_err(dev, "Failed to get clock\n");
 		return err;
 	}
 
@@ -207,14 +207,14 @@ static int jz4770_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->vcc_supply)) {
 		err = PTR_ERR(priv->vcc_supply);
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "failed to get regulator");
+			dev_err(dev, "Failed to get regulator\n");
 		return err;
 	}
 
 	err = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
 	if (err) {
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Unable to register PHY");
+			dev_err(dev, "Unable to register PHY\n");
 		return err;
 	}
 
-- 
2.20.1

