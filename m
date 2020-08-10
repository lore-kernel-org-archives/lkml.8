Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F84C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E964D206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="NlGHA52p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgHJEdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:33:38 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:29604 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgHJEdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:33:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQ34Y2gQgzNH;
        Mon, 10 Aug 2020 06:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597034013; bh=MhjhYNJo44yILv7eZOljgAyOg8eZi+5Vl6obSphAmSs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=NlGHA52pES4fcguiVmy93RwZKRb080C7bHH2cbWt8M8u/iPdZ3h9eIaZZgsuqkGh/
         /R/F2/IO1AbstDJ9btS0Man15QTbLG4W6QJGtgkKP24cDUARUfqqR32LtROkh96bdh
         CwCydk5MpHumXNegwv8l1TabeS9wfA3oKZZ/O2KahMzFhnoRjGqqLlJkrVLsPQ935b
         jwto/f63SlMCbsEh06DHKi1Z5Ash++cCS5QeHJZCCFGSkWqVjc3t6F96LD0R5BTWxs
         3RBr//ea9mXeoLOB/2moN+o0BotuQ7i5iEDaQv/t6JZtEPaQfCXNXBhYGmHnTW+cgH
         1PzQPZStKCHHw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 06:33:32 +0200
Message-Id: <42393f66dcc4d80dcd9797be45216b4035aa96cb.1597032945.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/3] regulator: remove locking around
 regulator_notifier_call_chain()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator_notifier_call_chain() doesn't need rdev lock and rdev's
existence is assumed in the code anyway. Remove the locks from drivers.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/da9055-regulator.c   |  2 --
 drivers/regulator/da9062-regulator.c   |  2 --
 drivers/regulator/da9063-regulator.c   |  2 --
 drivers/regulator/da9210-regulator.c   |  4 ----
 drivers/regulator/da9211-regulator.c   |  4 ----
 drivers/regulator/lp8755.c             |  6 ------
 drivers/regulator/ltc3589.c            | 10 ++--------
 drivers/regulator/ltc3676.c            | 10 ++--------
 drivers/regulator/pv88060-regulator.c  | 10 ++--------
 drivers/regulator/pv88080-regulator.c  | 10 ++--------
 drivers/regulator/pv88090-regulator.c  | 10 ++--------
 drivers/regulator/slg51000-regulator.c |  4 ----
 drivers/regulator/stpmic1_regulator.c  |  4 ----
 drivers/regulator/wm831x-dcdc.c        |  4 ----
 drivers/regulator/wm831x-isink.c       |  2 --
 drivers/regulator/wm831x-ldo.c         |  2 --
 drivers/regulator/wm8350-regulator.c   |  2 --
 17 files changed, 10 insertions(+), 78 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index c025ccb1a30a..73ff5fc7d8d7 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -485,10 +485,8 @@ static irqreturn_t da9055_ldo5_6_oc_irq(int irq, void *data)
 {
 	struct da9055_regulator *regulator = data;
 
-	regulator_lock(regulator->rdev);
 	regulator_notifier_call_chain(regulator->rdev,
 				      REGULATOR_EVENT_OVER_CURRENT, NULL);
-	regulator_unlock(regulator->rdev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index d8112f56e94e..1a6324001027 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -907,10 +907,8 @@ static irqreturn_t da9062_ldo_lim_event(int irq, void *data)
 			continue;
 
 		if (BIT(regl->info->oc_event.lsb) & bits) {
-			regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
-			regulator_unlock(regl->rdev);
 			handled = IRQ_HANDLED;
 		}
 	}
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index fe65b5acaf28..cf7d5341750e 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -574,10 +574,8 @@ static irqreturn_t da9063_ldo_lim_event(int irq, void *data)
 			continue;
 
 		if (BIT(regl->info->oc_event.lsb) & bits) {
-			regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
-			regulator_unlock(regl->rdev);
 		}
 	}
 
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 0cdeb6186529..f5b0ad02964c 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -77,8 +77,6 @@ static irqreturn_t da9210_irq_handler(int irq, void *data)
 	if (error < 0)
 		goto error_i2c;
 
-	regulator_lock(chip->rdev);
-
 	if (val & DA9210_E_OVCURR) {
 		regulator_notifier_call_chain(chip->rdev,
 					      REGULATOR_EVENT_OVER_CURRENT,
@@ -103,8 +101,6 @@ static irqreturn_t da9210_irq_handler(int irq, void *data)
 		handled |= DA9210_E_VMAX;
 	}
 
-	regulator_unlock(chip->rdev);
-
 	if (handled) {
 		/* Clear handled events */
 		error = regmap_write(chip->regmap, DA9210_REG_EVENT_B, handled);
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 297b3aa7c753..c8ca28aa360d 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -332,10 +332,8 @@ static irqreturn_t da9211_irq_handler(int irq, void *data)
 		goto error_i2c;
 
 	if (reg_val & DA9211_E_OV_CURR_A) {
-	        regulator_lock(chip->rdev[0]);
 		regulator_notifier_call_chain(chip->rdev[0],
 			REGULATOR_EVENT_OVER_CURRENT, NULL);
-	        regulator_unlock(chip->rdev[0]);
 
 		err = regmap_write(chip->regmap, DA9211_REG_EVENT_B,
 			DA9211_E_OV_CURR_A);
@@ -346,10 +344,8 @@ static irqreturn_t da9211_irq_handler(int irq, void *data)
 	}
 
 	if (reg_val & DA9211_E_OV_CURR_B) {
-	        regulator_lock(chip->rdev[1]);
 		regulator_notifier_call_chain(chip->rdev[1],
 			REGULATOR_EVENT_OVER_CURRENT, NULL);
-	        regulator_unlock(chip->rdev[1]);
 
 		err = regmap_write(chip->regmap, DA9211_REG_EVENT_B,
 			DA9211_E_OV_CURR_B);
diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 4291df077c39..0f93273fc115 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -369,11 +369,9 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 		if ((flag0 & (0x4 << icnt))
 		    && (pchip->irqmask & (0x04 << icnt))
 		    && (pchip->rdev[icnt] != NULL)) {
-			regulator_lock(pchip->rdev[icnt]);
 			regulator_notifier_call_chain(pchip->rdev[icnt],
 						      LP8755_EVENT_PWR_FAULT,
 						      NULL);
-			regulator_unlock(pchip->rdev[icnt]);
 		}
 
 	/* read flag1 register */
@@ -389,22 +387,18 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 	if ((flag1 & 0x01) && (pchip->irqmask & 0x01))
 		for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
 			if (pchip->rdev[icnt] != NULL) {
-				regulator_lock(pchip->rdev[icnt]);
 				regulator_notifier_call_chain(pchip->rdev[icnt],
 							      LP8755_EVENT_OCP,
 							      NULL);
-				regulator_unlock(pchip->rdev[icnt]);
 			}
 
 	/* send OVP event to all regulator devices */
 	if ((flag1 & 0x02) && (pchip->irqmask & 0x02))
 		for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
 			if (pchip->rdev[icnt] != NULL) {
-				regulator_lock(pchip->rdev[icnt]);
 				regulator_notifier_call_chain(pchip->rdev[icnt],
 							      LP8755_EVENT_OVP,
 							      NULL);
-				regulator_unlock(pchip->rdev[icnt]);
 			}
 	return IRQ_HANDLED;
 
diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 9a037fdc5fc5..26dce68e053b 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -357,22 +357,16 @@ static irqreturn_t ltc3589_isr(int irq, void *dev_id)
 
 	if (irqstat & LTC3589_IRQSTAT_THERMAL_WARN) {
 		event = REGULATOR_EVENT_OVER_TEMP;
-		for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
-		        regulator_lock(ltc3589->regulators[i]);
+		for (i = 0; i < LTC3589_NUM_REGULATORS; i++)
 			regulator_notifier_call_chain(ltc3589->regulators[i],
 						      event, NULL);
-		        regulator_unlock(ltc3589->regulators[i]);
-		}
 	}
 
 	if (irqstat & LTC3589_IRQSTAT_UNDERVOLT_WARN) {
 		event = REGULATOR_EVENT_UNDER_VOLTAGE;
-		for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
-		        regulator_lock(ltc3589->regulators[i]);
+		for (i = 0; i < LTC3589_NUM_REGULATORS; i++)
 			regulator_notifier_call_chain(ltc3589->regulators[i],
 						      event, NULL);
-		        regulator_unlock(ltc3589->regulators[i]);
-		}
 	}
 
 	/* Clear warning condition */
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 093b3e4a6303..3e66515423df 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -276,23 +276,17 @@ static irqreturn_t ltc3676_isr(int irq, void *dev_id)
 	if (irqstat & LTC3676_IRQSTAT_THERMAL_WARN) {
 		dev_warn(dev, "Over-temperature Warning\n");
 		event = REGULATOR_EVENT_OVER_TEMP;
-		for (i = 0; i < LTC3676_NUM_REGULATORS; i++) {
-			regulator_lock(ltc3676->regulators[i]);
+		for (i = 0; i < LTC3676_NUM_REGULATORS; i++)
 			regulator_notifier_call_chain(ltc3676->regulators[i],
 						      event, NULL);
-			regulator_unlock(ltc3676->regulators[i]);
-		}
 	}
 
 	if (irqstat & LTC3676_IRQSTAT_UNDERVOLT_WARN) {
 		dev_info(dev, "Undervoltage Warning\n");
 		event = REGULATOR_EVENT_UNDER_VOLTAGE;
-		for (i = 0; i < LTC3676_NUM_REGULATORS; i++) {
-			regulator_lock(ltc3676->regulators[i]);
+		for (i = 0; i < LTC3676_NUM_REGULATORS; i++)
 			regulator_notifier_call_chain(ltc3676->regulators[i],
 						      event, NULL);
-			regulator_unlock(ltc3676->regulators[i]);
-		}
 	}
 
 	/* Clear warning condition */
diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 787ced918372..48238846f45c 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -233,13 +233,10 @@ static irqreturn_t pv88060_irq_handler(int irq, void *data)
 
 	if (reg_val & PV88060_E_VDD_FLT) {
 		for (i = 0; i < PV88060_MAX_REGULATORS; i++) {
-			if (chip->rdev[i] != NULL) {
-				regulator_lock(chip->rdev[i]);
+			if (chip->rdev[i] != NULL)
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_UNDER_VOLTAGE,
 					NULL);
-				regulator_unlock(chip->rdev[i]);
-			}
 		}
 
 		err = regmap_write(chip->regmap, PV88060_REG_EVENT_A,
@@ -252,13 +249,10 @@ static irqreturn_t pv88060_irq_handler(int irq, void *data)
 
 	if (reg_val & PV88060_E_OVER_TEMP) {
 		for (i = 0; i < PV88060_MAX_REGULATORS; i++) {
-			if (chip->rdev[i] != NULL) {
-				regulator_lock(chip->rdev[i]);
+			if (chip->rdev[i] != NULL)
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_OVER_TEMP,
 					NULL);
-				regulator_unlock(chip->rdev[i]);
-			}
 		}
 
 		err = regmap_write(chip->regmap, PV88060_REG_EVENT_A,
diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index a444f68af1a8..2a74cc05acfe 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -334,13 +334,10 @@ static irqreturn_t pv88080_irq_handler(int irq, void *data)
 
 	if (reg_val & PV88080_E_VDD_FLT) {
 		for (i = 0; i < PV88080_MAX_REGULATORS; i++) {
-			if (chip->rdev[i] != NULL) {
-			        regulator_lock(chip->rdev[i]);
+			if (chip->rdev[i] != NULL)
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_UNDER_VOLTAGE,
 					NULL);
-			        regulator_unlock(chip->rdev[i]);
-			}
 		}
 
 		err = regmap_write(chip->regmap, PV88080_REG_EVENT_A,
@@ -353,13 +350,10 @@ static irqreturn_t pv88080_irq_handler(int irq, void *data)
 
 	if (reg_val & PV88080_E_OVER_TEMP) {
 		for (i = 0; i < PV88080_MAX_REGULATORS; i++) {
-			if (chip->rdev[i] != NULL) {
-			        regulator_lock(chip->rdev[i]);
+			if (chip->rdev[i] != NULL)
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_OVER_TEMP,
 					NULL);
-			        regulator_unlock(chip->rdev[i]);
-			}
 		}
 
 		err = regmap_write(chip->regmap, PV88080_REG_EVENT_A,
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 784729ec2182..a80176bdf8ec 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -226,13 +226,10 @@ static irqreturn_t pv88090_irq_handler(int irq, void *data)
 
 	if (reg_val & PV88090_E_VDD_FLT) {
 		for (i = 0; i < PV88090_MAX_REGULATORS; i++) {
-			if (chip->rdev[i] != NULL) {
-			        regulator_lock(chip->rdev[i]);
+			if (chip->rdev[i] != NULL)
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_UNDER_VOLTAGE,
 					NULL);
-			        regulator_unlock(chip->rdev[i]);
-			}
 		}
 
 		err = regmap_write(chip->regmap, PV88090_REG_EVENT_A,
@@ -245,13 +242,10 @@ static irqreturn_t pv88090_irq_handler(int irq, void *data)
 
 	if (reg_val & PV88090_E_OVER_TEMP) {
 		for (i = 0; i < PV88090_MAX_REGULATORS; i++) {
-			if (chip->rdev[i] != NULL) {
-			        regulator_lock(chip->rdev[i]);
+			if (chip->rdev[i] != NULL)
 				regulator_notifier_call_chain(chip->rdev[i],
 					REGULATOR_EVENT_OVER_TEMP,
 					NULL);
-			        regulator_unlock(chip->rdev[i]);
-			}
 		}
 
 		err = regmap_write(chip->regmap, PV88090_REG_EVENT_A,
diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 44e4cecbf6de..0f8041981436 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -386,10 +386,8 @@ static irqreturn_t slg51000_irq_handler(int irq, void *data)
 	for (i = 0; i < SLG51000_MAX_REGULATORS; i++) {
 		if (!(evt[i][R2] & SLG51000_IRQ_ILIM_FLAG_MASK) &&
 		    (evt[i][R0] & SLG51000_EVT_ILIM_FLAG_MASK)) {
-			regulator_lock(chip->rdev[i]);
 			regulator_notifier_call_chain(chip->rdev[i],
 					    REGULATOR_EVENT_OVER_CURRENT, NULL);
-			regulator_unlock(chip->rdev[i]);
 
 			if (evt[i][R1] & SLG51000_STA_ILIM_FLAG_MASK)
 				dev_warn(chip->dev,
@@ -403,10 +401,8 @@ static irqreturn_t slg51000_irq_handler(int irq, void *data)
 		for (i = 0; i < SLG51000_MAX_REGULATORS; i++) {
 			if (!(evt[i][R1] & SLG51000_STA_ILIM_FLAG_MASK) &&
 			    (evt[i][R1] & SLG51000_STA_VOUT_OK_FLAG_MASK)) {
-				regulator_lock(chip->rdev[i]);
 				regulator_notifier_call_chain(chip->rdev[i],
 					       REGULATOR_EVENT_OVER_TEMP, NULL);
-				regulator_unlock(chip->rdev[i]);
 			}
 		}
 		handled = IRQ_HANDLED;
diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 73e0ab2baeaa..cf10fdb72e32 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -505,15 +505,11 @@ static irqreturn_t stpmic1_curlim_irq_handler(int irq, void *data)
 {
 	struct regulator_dev *rdev = (struct regulator_dev *)data;
 
-	regulator_lock(rdev);
-
 	/* Send an overcurrent notification */
 	regulator_notifier_call_chain(rdev,
 				      REGULATOR_EVENT_OVER_CURRENT,
 				      NULL);
 
-	regulator_unlock(rdev);
-
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index ad2203d11a88..e43ed4d93f71 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -178,11 +178,9 @@ static irqreturn_t wm831x_dcdc_uv_irq(int irq, void *data)
 {
 	struct wm831x_dcdc *dcdc = data;
 
-	regulator_lock(dcdc->regulator);
 	regulator_notifier_call_chain(dcdc->regulator,
 				      REGULATOR_EVENT_UNDER_VOLTAGE,
 				      NULL);
-	regulator_unlock(dcdc->regulator);
 
 	return IRQ_HANDLED;
 }
@@ -191,11 +189,9 @@ static irqreturn_t wm831x_dcdc_oc_irq(int irq, void *data)
 {
 	struct wm831x_dcdc *dcdc = data;
 
-	regulator_lock(dcdc->regulator);
 	regulator_notifier_call_chain(dcdc->regulator,
 				      REGULATOR_EVENT_OVER_CURRENT,
 				      NULL);
-	regulator_unlock(dcdc->regulator);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index ff3d2bf50410..eade3ae3e333 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -99,11 +99,9 @@ static irqreturn_t wm831x_isink_irq(int irq, void *data)
 {
 	struct wm831x_isink *isink = data;
 
-	regulator_lock(isink->regulator);
 	regulator_notifier_call_chain(isink->regulator,
 				      REGULATOR_EVENT_OVER_CURRENT,
 				      NULL);
-	regulator_unlock(isink->regulator);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index 7b6cf4810cb7..e091b189ecc0 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -46,11 +46,9 @@ static irqreturn_t wm831x_ldo_uv_irq(int irq, void *data)
 {
 	struct wm831x_ldo *ldo = data;
 
-	regulator_lock(ldo->regulator);
 	regulator_notifier_call_chain(ldo->regulator,
 				      REGULATOR_EVENT_UNDER_VOLTAGE,
 				      NULL);
-	regulator_unlock(ldo->regulator);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 2e7bfdf7c87b..6579bfdb0c26 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1089,7 +1089,6 @@ static irqreturn_t pmic_uv_handler(int irq, void *data)
 {
 	struct regulator_dev *rdev = (struct regulator_dev *)data;
 
-	regulator_lock(rdev);
 	if (irq == WM8350_IRQ_CS1 || irq == WM8350_IRQ_CS2)
 		regulator_notifier_call_chain(rdev,
 					      REGULATOR_EVENT_REGULATION_OUT,
@@ -1098,7 +1097,6 @@ static irqreturn_t pmic_uv_handler(int irq, void *data)
 		regulator_notifier_call_chain(rdev,
 					      REGULATOR_EVENT_UNDER_VOLTAGE,
 					      NULL);
-	regulator_unlock(rdev);
 
 	return IRQ_HANDLED;
 }
-- 
2.20.1

