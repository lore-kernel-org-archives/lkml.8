Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D73C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C4520A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEHLty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:49:54 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:11668 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEHLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:49:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5eb5462cfb9-594b8; Fri, 08 May 2020 19:44:45 +0800 (CST)
X-RM-TRANSID: 2eeb5eb5462cfb9-594b8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25eb5462be77-9d5f0;
        Fri, 08 May 2020 19:44:45 +0800 (CST)
X-RM-TRANSID: 2ee25eb5462be77-9d5f0
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] USB: host: ehci: Use the defined variable to simplify code
Date:   Fri,  8 May 2020 19:45:20 +0800
Message-Id: <20200508114520.13332-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the defined variable "dev" to make the code cleaner. And
delete an extra blank line.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/host/ehci-mxc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index c9f91e6c7..a1eb5ee77 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -56,7 +56,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
 		goto err_alloc;
@@ -69,14 +69,14 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	priv = (struct ehci_mxc_priv *) ehci->priv;
 
 	/* enable clocks */
-	priv->usbclk = devm_clk_get(&pdev->dev, "ipg");
+	priv->usbclk = devm_clk_get(dev, "ipg");
 	if (IS_ERR(priv->usbclk)) {
 		ret = PTR_ERR(priv->usbclk);
 		goto err_alloc;
 	}
 	clk_prepare_enable(priv->usbclk);
 
-	priv->ahbclk = devm_clk_get(&pdev->dev, "ahb");
+	priv->ahbclk = devm_clk_get(dev, "ahb");
 	if (IS_ERR(priv->ahbclk)) {
 		ret = PTR_ERR(priv->ahbclk);
 		goto err_clk_ahb;
@@ -84,13 +84,12 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	clk_prepare_enable(priv->ahbclk);
 
 	/* "dr" device has its own clock on i.MX51 */
-	priv->phyclk = devm_clk_get(&pdev->dev, "phy");
+	priv->phyclk = devm_clk_get(dev, "phy");
 	if (IS_ERR(priv->phyclk))
 		priv->phyclk = NULL;
 	if (priv->phyclk)
 		clk_prepare_enable(priv->phyclk);
 
-
 	/* call platform specific init function */
 	if (pdata->init) {
 		ret = pdata->init(pdev);
-- 
2.20.1.windows.1



