Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8B720658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLiimlWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCFRVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:21:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34018 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCFRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:21:20 -0500
Received: by mail-pj1-f68.google.com with SMTP id gc16so1862398pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZCslXV7+BYNwc16oI1VHhg6O3Q9jB+EK4lVW99vpz8A=;
        b=tLiimlWZypLzW+H9Kkg20KNLErAOSyI8M6Exl4NgiZ8El8PMltlSPN5E95HHHxKgL5
         okf2t5tC3kDKwAZCojVrWeZTrtZ896CZIyKHeDuIxTxRu6JRzCCUkefu97O0fZ4P8PSB
         rZya3kschpxwcwfWImQ+GxrlkwyUCAyPmKfn5obLROrFtbFTE786KMG4MIab6eOl4tGO
         0ZgBGyDoDiQN3xiIeHSKU7xIoTZtpYLtEKVzerkyyIt2TMYuZ5JMaDsNgz4xGoDHzILm
         bbuGmCsEcmrHozIekbU3aG8yCkr5GAEB7siX4hrSj62WASLbm4X2Laqv6guk/zrRevD9
         7G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZCslXV7+BYNwc16oI1VHhg6O3Q9jB+EK4lVW99vpz8A=;
        b=EnAp5BfF1TaD2HoqRq1aUpkTp9NXkvXnWBaSOgqFv8D+94UNSYJkIJUtWhEMSlA/Ap
         ZoWwWJyzQHPy4E1r5LFLan1u3n7h5aIO/x8rd9VNgRoxRFYB9m0/xBbfFkhsadgSJtWj
         7M0Yax+wZqtqcvEzmSwypiE3XqgrMje9fWSQL51NtX7tNjlaw5dxhG93ppmCYM6dBVWm
         1QS6R8fYEBVMFpL0XGNGLLPRwMXnMgzjvxg4tsxdESgDCG+B1jC2yl7mEiFvpuN1xcsC
         VKPcIvl4lkGzPR3/1qnA0833uahp8YSclF+qvY2lI8jEt4QufRa4CXeYeyKG+oWMtabU
         mUcQ==
X-Gm-Message-State: ANhLgQ2dffapMBAt+Yc8JUHOrcpBe7f5OzS6gj6f2zfp6yJREJQZXtHO
        SYJ1pg+GJUPZz2V5U6kIyHB5IC1cKyM=
X-Google-Smtp-Source: ADFU+vvqp7tpD24ATuMs8NWAlMf5JlfX9cjLBq6me/SQRkgMh1asrJUC2dtdLV6SGav3wK81WYUpuQ==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr4227371plv.194.1583515279031;
        Fri, 06 Mar 2020 09:21:19 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id mp5sm9956189pjb.48.2020.03.06.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 09:21:18 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3] reset: hi6220: Add support for AO reset controller
Date:   Fri,  6 Mar 2020 17:21:13 +0000
Message-Id: <20200306172113.50738-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

This is required to bring Mali450 gpu out of reset.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Enrico Weigelt <info@metux.net>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
[jstultz: Added comment, Fix void return build issue
Reported-by: kbuild test robot <lkp@intel.com>]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Updated to v2 of Peter's patch from here:
    https://lkml.org/lkml/2019/4/19/253
* Added a comment to explain ordering question brought
  up on the list.
v3:
* Fix build issue Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/reset/hisilicon/hi6220_reset.c | 69 +++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 24e6d420b26b..19926506d033 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -33,6 +33,7 @@
 enum hi6220_reset_ctrl_type {
 	PERIPHERAL,
 	MEDIA,
+	AO,
 };
 
 struct hi6220_reset_data {
@@ -92,6 +93,65 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
 	.deassert = hi6220_media_deassert,
 };
 
+#define AO_SCTRL_SC_PW_CLKEN0     0x800
+#define AO_SCTRL_SC_PW_CLKDIS0    0x804
+
+#define AO_SCTRL_SC_PW_RSTEN0     0x810
+#define AO_SCTRL_SC_PW_RSTDIS0    0x814
+
+#define AO_SCTRL_SC_PW_ISOEN0     0x820
+#define AO_SCTRL_SC_PW_ISODIS0    0x824
+#define AO_MAX_INDEX              12
+
+static int hi6220_ao_assert(struct reset_controller_dev *rc_dev,
+			       unsigned long idx)
+{
+	struct hi6220_reset_data *data = to_reset_data(rc_dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTEN0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));
+	return ret;
+}
+
+static int hi6220_ao_deassert(struct reset_controller_dev *rc_dev,
+				 unsigned long idx)
+{
+	struct hi6220_reset_data *data = to_reset_data(rc_dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+
+	/*
+	 * It was suggested to disable isolation before enabling
+	 * the clocks and deasserting reset, to avoid glitches.
+	 * But this order is preserved to keep it matching the
+	 * vendor code.
+	 */
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_CLKEN0, BIT(idx));
+	return ret;
+}
+
+static const struct reset_control_ops hi6220_ao_reset_ops = {
+	.assert = hi6220_ao_assert,
+	.deassert = hi6220_ao_deassert,
+};
+
 static int hi6220_reset_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -117,9 +177,12 @@ static int hi6220_reset_probe(struct platform_device *pdev)
 	if (type == MEDIA) {
 		data->rc_dev.ops = &hi6220_media_reset_ops;
 		data->rc_dev.nr_resets = MEDIA_MAX_INDEX;
-	} else {
+	} else if (type == PERIPHERAL) {
 		data->rc_dev.ops = &hi6220_peripheral_reset_ops;
 		data->rc_dev.nr_resets = PERIPH_MAX_INDEX;
+	} else {
+		data->rc_dev.ops = &hi6220_ao_reset_ops;
+		data->rc_dev.nr_resets = AO_MAX_INDEX;
 	}
 
 	return reset_controller_register(&data->rc_dev);
@@ -134,6 +197,10 @@ static const struct of_device_id hi6220_reset_match[] = {
 		.compatible = "hisilicon,hi6220-mediactrl",
 		.data = (void *)MEDIA,
 	},
+	{
+		.compatible = "hisilicon,hi6220-aoctrl",
+		.data = (void *)AO,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, hi6220_reset_match);
-- 
2.17.1

