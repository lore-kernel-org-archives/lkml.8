Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D44AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C372070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mt41gbUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgHDKCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:02:44 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38285 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgHDKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596535362; x=1628071362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RIOk/K4fsWoGOLlY/G/ysd9kmGKlzTuOgw4zjbVRBlU=;
  b=Mt41gbUGaRpOQz1sdD2PUCGq04Ui6xELlDlRG2pvK7IKTjFxTWEDXEV5
   cOYieMrVKxlIU/cbybK4axc6t3vS3gIIVzXz9nYZlj8YS2tKVoaLBu/92
   UhFuEtOxRsbI6Jxuwd7PZYXPLuhNI11KqSQIzfNbczjWJ+Rlt6A7BlUcK
   f55qXW9LE9jkyZkkFSlz7I71dhN7l8N0NLFGWDO5MbTpCHnyMOIxvKy4S
   DDhXuEEO+9x83rJWQTUgAbQt2YelR4iBBG1HpKqcF9ZiVwuq5CaYD/RdU
   v90SicXv4CCkfAEsuOaPy7H+t+RD3hVvssxXsUD4a3d1cQklpM5xALshf
   Q==;
IronPort-SDR: mQl2TR9LFVYxLEU4H4O5XVeqXxRMdUTsruFi4nHyVy21Fz9llFmUb7tEaomkRewFXTUJtT1QTV
 tIZ1en8CmeWILNwsD0haAY3BM0iCJBq4nLxspFaph5JA6smmy7VhTxZoRRO7MFQ2cyv4v/EhY/
 KjQZDRukFc/KZMSU5hFobu+C5vjpRFHjHmcaayg0Kw7at1jdEmbpCnLOacCOKn+CgVXR57uXXL
 kjcwAzArki9bNZW1fKcJK5x3HAwNcoLjm0HCRpRUJ8CAZ2r9sy05j5YwxOAjLSoAu678Xshyal
 eL8=
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="21668511"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2020 03:02:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 03:02:38 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 4 Aug 2020 03:02:08 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <wsa@kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>,
        <kamel.bouhara@bootlin.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 4/4] i2c: at91: Move to generic GPIO bus recovery
Date:   Tue, 4 Aug 2020 12:59:26 +0300
Message-ID: <20200804095926.205643-5-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200804095926.205643-1-codrin.ciubotariu@microchip.com>
References: <20200804095926.205643-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the Microchip at91 driver the first to use the generic GPIO bus
recovery support from the I2C core and discard the driver implementation.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes from RFC:
 - none;

 drivers/i2c/busses/i2c-at91-master.c | 69 ++--------------------------
 drivers/i2c/busses/i2c-at91.h        |  3 --
 2 files changed, 3 insertions(+), 69 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index 363d540a8345..66864f9cf7ac 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -816,79 +816,16 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	return ret;
 }
 
-static void at91_prepare_twi_recovery(struct i2c_adapter *adap)
-{
-	struct at91_twi_dev *dev = i2c_get_adapdata(adap);
-
-	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_gpio);
-}
-
-static void at91_unprepare_twi_recovery(struct i2c_adapter *adap)
-{
-	struct at91_twi_dev *dev = i2c_get_adapdata(adap);
-
-	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_default);
-}
-
 static int at91_init_twi_recovery_gpio(struct platform_device *pdev,
 				       struct at91_twi_dev *dev)
 {
 	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
 
-	dev->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (!dev->pinctrl || IS_ERR(dev->pinctrl)) {
+	rinfo->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!rinfo->pinctrl || IS_ERR(rinfo->pinctrl)) {
 		dev_info(dev->dev, "can't get pinctrl, bus recovery not supported\n");
-		return PTR_ERR(dev->pinctrl);
+		return PTR_ERR(rinfo->pinctrl);
 	}
-
-	dev->pinctrl_pins_default = pinctrl_lookup_state(dev->pinctrl,
-							 PINCTRL_STATE_DEFAULT);
-	dev->pinctrl_pins_gpio = pinctrl_lookup_state(dev->pinctrl,
-						      "gpio");
-	if (IS_ERR(dev->pinctrl_pins_default) ||
-	    IS_ERR(dev->pinctrl_pins_gpio)) {
-		dev_info(&pdev->dev, "pinctrl states incomplete for recovery\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * pins will be taken as GPIO, so we might as well inform pinctrl about
-	 * this and move the state to GPIO
-	 */
-	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_gpio);
-
-	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
-	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl",
-					  GPIOD_OUT_HIGH_OPEN_DRAIN);
-	if (PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	if (IS_ERR(rinfo->sda_gpiod) ||
-	    IS_ERR(rinfo->scl_gpiod)) {
-		dev_info(&pdev->dev, "recovery information incomplete\n");
-		if (!IS_ERR(rinfo->sda_gpiod)) {
-			gpiod_put(rinfo->sda_gpiod);
-			rinfo->sda_gpiod = NULL;
-		}
-		if (!IS_ERR(rinfo->scl_gpiod)) {
-			gpiod_put(rinfo->scl_gpiod);
-			rinfo->scl_gpiod = NULL;
-		}
-		pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_default);
-		return -EINVAL;
-	}
-
-	/* change the state of the pins back to their default state */
-	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_default);
-
-	dev_info(&pdev->dev, "using scl, sda for recovery\n");
-
-	rinfo->prepare_recovery = at91_prepare_twi_recovery;
-	rinfo->unprepare_recovery = at91_unprepare_twi_recovery;
-	rinfo->recover_bus = i2c_generic_scl_recovery;
 	dev->adapter.bus_recovery_info = rinfo;
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index 7e7b4955ca7f..eae673ae786c 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -157,9 +157,6 @@ struct at91_twi_dev {
 	struct at91_twi_dma dma;
 	bool slave_detected;
 	struct i2c_bus_recovery_info rinfo;
-	struct pinctrl *pinctrl;
-	struct pinctrl_state *pinctrl_pins_default;
-	struct pinctrl_state *pinctrl_pins_gpio;
 #ifdef CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL
 	unsigned smr;
 	struct i2c_client *slave;
-- 
2.25.1

