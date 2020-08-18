Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B9AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F5320639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHRG54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:57:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:12594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHRG5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:57:52 -0400
IronPort-SDR: bC9g6SZtiL6K7aMBz0ArjsXbL4wxFBDxCGSUKnVPTAJw8uRTckTuDLEIM+lzX/KdSIjBXEjWTU
 KMbNyBNMekPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="134374134"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="134374134"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 23:57:51 -0700
IronPort-SDR: ckIjH+PUGIUWXsT1B2YXL6SIrJ0ylCBIlqyW3jqEri+kUNz8Es1iLiPZyjD8KOgjxo5zA27v5N
 XXb9aKOWVvUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="471695033"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2020 23:57:49 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     andriy.shevchenko@intel.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 6/9] extcon: extcon-ptn5150: Set and get the VBUS and POLARITY property state
Date:   Tue, 18 Aug 2020 14:57:24 +0800
Message-Id: <20200818065727.50520-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Set and get the VBUS and POLARITY property state.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 75 ++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 31b7cbf1551d..5612dc0ef2af 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -64,6 +64,12 @@ static const unsigned int ptn5150_extcon_cable[] = {
 	EXTCON_NONE,
 };
 
+enum {
+	POLARITY_NC,
+	POLARITY_CC1,
+	POLARITY_CC2,
+};
+
 static const struct regmap_config ptn5150_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -74,9 +80,14 @@ static void ptn5150_irq_work(struct work_struct *work)
 {
 	struct ptn5150_info *info = container_of(work,
 			struct ptn5150_info, irq_work);
-	int ret = 0;
+	int ret = 0, x = 0;
 	unsigned int reg_data;
 	unsigned int int_status;
+	union extcon_property_value vbus_detected;
+	union extcon_property_value flipped;
+	bool host_vbus = false;
+	bool host = false;
+	bool dev = false;
 
 	if (!info->edev)
 		return;
@@ -90,6 +101,11 @@ static void ptn5150_irq_work(struct work_struct *work)
 		return;
 	}
 
+	dev_dbg(info->dev, "CC POLARITY status:%x\n", reg_data);
+	x = FIELD_GET(PTN5150_REG_INT_CABLE_ATTACH_MASK, reg_data);
+	flipped.intval = (x == POLARITY_CC2);
+	vbus_detected.intval = !!(reg_data & PTN5150_REG_CC_VBUS_DETECTION);
+
 	/* Clear interrupt. Read would clear the register */
 	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
 	if (ret) {
@@ -111,6 +127,7 @@ static void ptn5150_irq_work(struct work_struct *work)
 
 			switch (port_status) {
 			case PTN5150_DFP_ATTACHED:
+				dev = true;
 				extcon_set_state_sync(info->edev,
 						EXTCON_USB_HOST, false);
 				gpiod_set_value(info->vbus_gpiod, 0);
@@ -118,6 +135,8 @@ static void ptn5150_irq_work(struct work_struct *work)
 						true);
 				break;
 			case PTN5150_UFP_ATTACHED:
+				host_vbus = !vbus_detected.intval;
+				host = true;
 				extcon_set_state_sync(info->edev, EXTCON_USB,
 						false);
 				vbus = FIELD_GET(PTN5150_REG_CC_VBUS_DETECTION,
@@ -127,6 +146,9 @@ static void ptn5150_irq_work(struct work_struct *work)
 				else
 					gpiod_set_value(info->vbus_gpiod, 1);
 
+				extcon_set_property(info->edev, EXTCON_USB_HOST,
+						    EXTCON_PROP_USB_TYPEC_POLARITY,
+						    flipped);
 				extcon_set_state_sync(info->edev,
 						EXTCON_USB_HOST, true);
 				break;
@@ -145,6 +167,8 @@ static void ptn5150_irq_work(struct work_struct *work)
 		}
 	}
 
+	if (host_vbus)
+		gpiod_set_value(info->vbus_gpiod, host_vbus);
 	/* Clear interrupt. Read would clear the register */
 	ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
 			&int_status);
@@ -155,6 +179,11 @@ static void ptn5150_irq_work(struct work_struct *work)
 		return;
 	}
 
+	extcon_set_property(info->edev, host ? EXTCON_USB_HOST : EXTCON_USB,
+			    EXTCON_PROP_USB_VBUS, vbus_detected);
+	extcon_set_state_sync(info->edev, EXTCON_USB_HOST, host);
+	extcon_set_state_sync(info->edev, EXTCON_USB, dev);
+
 	mutex_unlock(&info->mutex);
 }
 
@@ -227,7 +256,7 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 		dev_err(dev, "failed to get INT GPIO\n");
 		return PTR_ERR(info->int_gpiod);
 	}
-	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
+	info->vbus_gpiod = devm_gpiod_get_optional(&i2c->dev, "vbus", GPIOD_IN);
 	if (IS_ERR(info->vbus_gpiod)) {
 		dev_err(dev, "failed to get VBUS GPIO\n");
 		return PTR_ERR(info->vbus_gpiod);
@@ -250,24 +279,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (info->int_gpiod) {
-		info->irq = gpiod_to_irq(info->int_gpiod);
-		if (info->irq < 0) {
-			dev_err(dev, "failed to get INTB IRQ\n");
-			return info->irq;
-		}
-
-		ret = devm_request_threaded_irq(dev, info->irq, NULL,
-						ptn5150_irq_handler,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						i2c->name, info);
-		if (ret < 0) {
-			dev_err(dev, "failed to request handler for INTB IRQ\n");
-			return ret;
-		}
-	}
-
 	/* Allocate extcon device */
 	info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
 	if (IS_ERR(info->edev)) {
@@ -282,6 +293,30 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	extcon_set_property_capability(info->edev, EXTCON_USB,
+				       EXTCON_PROP_USB_VBUS);
+	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_VBUS);
+	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+
+	info->irq = gpiod_to_irq(info->int_gpiod);
+	if (info->irq < 0) {
+		dev_err(dev, "failed to get INTB IRQ\n");
+		return info->irq;
+	}
+
+	ret = devm_request_threaded_irq(dev, info->irq, NULL, ptn5150_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					i2c->name, info);
+	if (ret < 0) {
+		dev_err(dev, "failed to request handler for INTB IRQ\n");
+		return ret;
+	}
+
+	/* PNT5150 interrupt is level based, read result once in case we */
+	schedule_work(&info->irq_work);
+
 	/* Initialize PTN5150 device and print vendor id and version id */
 	ret = ptn5150_init_dev_type(info);
 	if (ret)
-- 
2.11.0

