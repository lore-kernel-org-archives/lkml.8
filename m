Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,SPOOFED_FREEMAIL_NO_RDNS,SUBJ_OBFU_PUNCT_FEW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39505 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbgCKPoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:44:00 -0400
From: Rishi Gupta <gupt21@gmail.com>
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        s.trumtrar@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused to prevent build issues
Date: Wed, 11 Mar 2020 21:13:49 +0530
Message-Id: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The __maybe_unused attribute is preferred over CONFIG_PM
to prevent build time issues. This commit replaces CONFIG_PM
with this attribute.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/pwm/pwm-pca9685.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b07bdca..b2a9e77 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -512,8 +512,7 @@ static int pca9685_pwm_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pca9685_pwm_runtime_suspend(struct device *dev)
+static int __maybe_unused pca9685_pwm_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pca9685 *pca = i2c_get_clientdata(client);
@@ -522,7 +521,7 @@ static int pca9685_pwm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int pca9685_pwm_runtime_resume(struct device *dev)
+static int __maybe_unused pca9685_pwm_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pca9685 *pca = i2c_get_clientdata(client);
@@ -530,7 +529,6 @@ static int pca9685_pwm_runtime_resume(struct device *dev)
 	pca9685_set_sleep_mode(pca, false);
 	return 0;
 }
-#endif
 
 static const struct i2c_device_id pca9685_id[] = {
 	{ "pca9685", 0 },
-- 
2.7.4

