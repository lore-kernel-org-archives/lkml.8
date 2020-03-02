Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D4C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CA524673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FA0toS2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCBRkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:40:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44246 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgCBRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:40:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so41660plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mimd8L0KkuEU3z0SotImD5hnuEckWKEuDddwOjBPweo=;
        b=FA0toS2TJ35J4SYiSuP9vUMDFMhFen/aWgOBpH1DNn0wPewzhpyYK9wYqc0nliBdhh
         QvvhQf5kdDrdDCoD9sDN7up5hR9MxhopeBEZUdHD7Cp/EM0BshYO0MtNG4ufKsbT1bdQ
         2wX8HnXHdPY5T9ZM8DO4386+uwLh6JrGQ8ZpqHQNBUdhexlEOzdtqsy/ChMzUcTbg+zE
         MlYQoer3Gnx2r5msXaN2SXxxgRIX6lWGwE4j4IOu7uKTGaSDgzOxCR73RwqXYSUSo+EV
         oGdNfAteZf2MxUIaE5asCzGWdkZOrSoX4gwpuXFn/wCVY+ecGGzk31Qsf6LkHDOFHxeB
         zEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mimd8L0KkuEU3z0SotImD5hnuEckWKEuDddwOjBPweo=;
        b=lwcuMVrx56LR4Xa413K+yJcPSMrIfmHBipSsAia2yZgPDjE2FTtZFi/ds2wFZalzjt
         QNhcZjq27KRP4gnolZ9IzL8QiwFHYsDNv38O3188itWhvdNAXdTPo3Ub+vJuUw4CSdip
         8V9dsdm0skrhW6kEZT5Fv25mh7+2Dj9KrGSK1VV5svZkXk9q3L0Y1PJ4mpEwMGnMogBr
         ZmxmYYxeI4EqN0QNzsTzpuDwbv/1ZEzN4/dB2JUouKLGY8z6BdgOxtKShTvaNA+nrOcT
         0kr56CMDpjTMTSs+ehsX//WOTTNmjoFNjvObIYsogevK1mpt6DWPw8evZRejSUyRbK3y
         eWgQ==
X-Gm-Message-State: ANhLgQ2LxoCe9CdD3/1xYo3aDDekbTZVFHtGE+N39cFj/I8HxLB6+GmM
        TGjjUehSW78LWM2CpkPG8Rn6+WKxN4Y=
X-Google-Smtp-Source: ADFU+vtRSmzvVppFbky+IP0O5uIEaF2zwuYdCebEmTKJg+sSXwxFIwVfettFZlUJXjbAjb5qNYD67Q==
X-Received: by 2002:a17:90a:3364:: with SMTP id m91mr48721pjb.112.1583170822136;
        Mon, 02 Mar 2020 09:40:22 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id k24sm20738947pgf.59.2020.03.02.09.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:40:21 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2] reset: hi6220: Add support for AO reset controller
Date:   Mon,  2 Mar 2020 17:40:15 +0000
Message-Id: <20200302174015.52363-1-john.stultz@linaro.org>
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
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Updated to v2 of Peter's patch from here:
    https://lkml.org/lkml/2019/4/19/253
* Added a comment to explain ordering question brought
  up on the list.
---
 drivers/reset/hisilicon/hi6220_reset.c | 71 +++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 24e6d420b26b..a85ed276ab83 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -33,6 +33,7 @@
 enum hi6220_reset_ctrl_type {
 	PERIPHERAL,
 	MEDIA,
+	AO,
 };
 
 struct hi6220_reset_data {
@@ -92,6 +93,67 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
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
+	if (ret)
+		return ret;
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
+	if (ret)
+		return ret;
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
@@ -117,9 +179,12 @@ static int hi6220_reset_probe(struct platform_device *pdev)
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
@@ -134,6 +199,10 @@ static const struct of_device_id hi6220_reset_match[] = {
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

