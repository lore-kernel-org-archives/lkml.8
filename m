Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D928520786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgHZKjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:39:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:31782 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgHZKjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:39:13 -0400
IronPort-SDR: BxAuspFbbuMlxK/2SL1UDQjNlX0FMMaAzungJbSeBEsVIJBMFn95KTKYKA6ctO2aufzFglMWiE
 vuJuDGI5U12Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="156256935"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="156256935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 03:39:13 -0700
IronPort-SDR: ACAIHj2r3pc7To2YpFjLT03tqkADnn9ok+F/dobSkxuRuV8CE9U/LKyAtS2zvYVqTRwxHo+76/
 uGo/YRt9ll+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="403025660"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 03:39:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8D249352; Wed, 26 Aug 2020 13:39:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Subject: [PATCH v1] extcon: ptn5150: Deduplicate parts of dev_err_probe()
Date:   Wed, 26 Aug 2020 13:39:10 +0300
Message-Id: <20200826103910.81413-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() is designed to be used like

	return dev_err_probe(dev, ret, "Error message\n");

Hence no need to have a separate return statement. Besides that
dev_err_probe() prints already returned error code, no need to repeat
that either.

Fixes: 48cbf8c6653c ("extcon: ptn5150: Reduce the amount of logs on deferred probe")
Cc: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 8ba706fad887..051bf374b43f 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -242,8 +242,7 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 			dev_info(dev, "No VBUS GPIO, ignoring VBUS control\n");
 			info->vbus_gpiod = NULL;
 		} else {
-			dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
-			return ret;
+			return dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
 		}
 	}
 
@@ -253,10 +252,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 
 	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
 	if (IS_ERR(info->regmap)) {
-		ret = PTR_ERR(info->regmap);
-		dev_err_probe(info->dev, ret, "failed to allocate register map: %d\n",
-			      ret);
-		return ret;
+		return dev_err_probe(info->dev, PTR_ERR(info->regmap),
+				     "failed to allocate register map\n");
 	}
 
 	if (i2c->irq > 0) {
@@ -264,9 +261,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	} else {
 		info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
 		if (IS_ERR(info->int_gpiod)) {
-			ret = PTR_ERR(info->int_gpiod);
-			dev_err_probe(dev, ret, "failed to get INT GPIO\n");
-			return ret;
+			return dev_err_probe(dev, PTR_ERR(info->int_gpiod),
+					     "failed to get INT GPIO\n");
 		}
 
 		info->irq = gpiod_to_irq(info->int_gpiod);
-- 
2.28.0

