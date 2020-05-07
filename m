Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F9C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9472A208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEGUbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:31:33 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:50577 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEGUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:31:32 -0400
Received: from localhost.localdomain ([93.23.14.230])
        by mwinf5d39 with ME
        id bwXV220044xouCl03wXVlj; Thu, 07 May 2020 22:31:31 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 07 May 2020 22:31:31 +0200
X-ME-IP: 93.23.14.230
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     kishon@ti.com, vkoul@kernel.org, tony@atomide.com, pavel@ucw.cz,
        sebastian.reichel@collabora.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] phy: cpcap-usb: Remove some useless code
Date:   Thu,  7 May 2020 22:31:27 +0200
Message-Id: <20200507203127.202197-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axe a clk that is unused in the driver.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 12e71a315a2c..089db0dea703 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -122,7 +122,6 @@ enum cpcap_gpio_mode {
 struct cpcap_phy_ddata {
 	struct regmap *reg;
 	struct device *dev;
-	struct clk *refclk;
 	struct usb_phy phy;
 	struct delayed_work detect_work;
 	struct pinctrl *pins;
@@ -707,7 +706,6 @@ static int cpcap_usb_phy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&ddata->phy);
 	cancel_delayed_work_sync(&ddata->detect_work);
-	clk_unprepare(ddata->refclk);
 	regulator_disable(ddata->vusb);
 
 	return 0;
-- 
2.25.1

