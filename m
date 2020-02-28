Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66C5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66C2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKqGBQFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgB1QzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:55:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38420 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgB1QzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:55:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id n64so2634801wme.3;
        Fri, 28 Feb 2020 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5rtCgdvXhrlNYFQWjsDQFMUM6dYurNbdvEC8f0MuiG0=;
        b=OKqGBQFioE/PW01KlWFhSja6sQVxyF9aMvqnliKSuBE7vGMkTsmCQ94QPOKl7dnx4t
         ekFK+8dT0iBJCCz4DZKuop1qxOuWRh+IC9ViZQRFVZ3Gh1/IH1aPIeheGYiJ0nY91FSn
         Sh4xgaV6odFTEHPlDcyy1hkgbi3XZagVXVbpAJ1AoJ1Xw599i0yRXlUQLYJHjfv6vbOh
         4fcfaNt9Z0lpaEt4HgjoaocRap99cCPe33CF7jSIhzhxadOrHFMPOiGAhJSH/Bvryfn0
         MiID7Sq2Cqlje7KXcMCu/xCMlGw1wgiHOZ7gXI0JCaGguXaD/jcC+rmO2B6tJ90aRH8Q
         8A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rtCgdvXhrlNYFQWjsDQFMUM6dYurNbdvEC8f0MuiG0=;
        b=m75P4/XKJHjTFZjRslUs1bQqpVn9FO3BWnqFpSke4Y+98BQCtoSpGyCZmfisWK8784
         n6bdnbNHc7i2TEZ/0UuFykA66qTm5C47RggERwFAsb44Ez4edqv095tugVtgPDV5A7JJ
         k3YXfOprzFthxWcgLmAm45Z5VaSamZtyUZWa29L64lMh2TY9sgJ5VuffdfoxA4inQrZZ
         nugaVionrLwGwT+sVNzrLOCdkL9qNrNkP7mZA1eAUJKHo7lPFnbOCX9ShtJ3W/YYzrc1
         gDOHynLFfDnL24gE1Uz6gEiCftv8WAhLRuXkzgds5VEwUTmWILc6Q2Uq5YyPfhz+96P2
         P7Fg==
X-Gm-Message-State: APjAAAWodRtaoYCcYXkHa1AY5hchrXx96PbwRoQE//4Su9Qo85B9xFNK
        oCgVTTmOwcLEYgUiKW+FVZXw5GIXvIY=
X-Google-Smtp-Source: APXvYqxo6TnPz9yeATJP4sUfmCXkCvrwhC+62X+AyjqRg9X+sAqUj/J/2K/U04odXUid9mW0DLcvtg==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr2860061wmj.28.1582908908294;
        Fri, 28 Feb 2020 08:55:08 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id s1sm13300071wro.66.2020.02.28.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:55:07 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/3] media: i2c: imx219: Fix power sequence
Date:   Fri, 28 Feb 2020 16:55:01 +0000
Message-Id: <20200228165503.18054-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228165503.18054-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200228165503.18054-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When supporting Rpi Camera v2 Module on the RZ/G2E, found the driver had
some issues with rcar mipi-csi driver. The sesnosr never entered into LP-11
state.

The powerup sequence in the datasheet[1] shows the sensor entering into
LP-11 in streaming mode, so to fix this issue transitions are performed
from "standby -> streaming -> standby" in the probe().

With this commit the sensor is able to enter LP-11 mode during power up,
as expected by some CSI-2 controllers.

[1] https://publiclab.org/system/images/photos/000/023/294/original/
RASPBERRY_PI_CAMERA_V2_DATASHEET_IMX219PQH5_7.0.0_Datasheet_XXX.PDF

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index f1effb5a5f66..8b48e148f2d0 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1171,6 +1171,7 @@ static int imx219_check_hwcfg(struct device *dev)
 
 static int imx219_probe(struct i2c_client *client)
 {
+	const struct imx219_reg_list *reg_list;
 	struct device *dev = &client->dev;
 	struct imx219 *imx219;
 	int ret;
@@ -1224,6 +1225,38 @@ static int imx219_probe(struct i2c_client *client)
 	/* Set default mode to max resolution */
 	imx219->mode = &supported_modes[0];
 
+	/* sensor doesn't enter to LP-11 state upon power up until and unless
+	 * streaming is started, so upon power up set the default format and
+	 * switch the modes: standby -> streaming -> standby
+	 */
+	/* getting sensor out of sleep */
+	ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
+			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STANDBY);
+	if (ret < 0)
+		goto error_power_off;
+	usleep_range(100, 110);
+
+	reg_list = &imx219->mode->reg_list;
+	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to default mode\n", __func__);
+		goto error_power_off;
+	}
+
+	/* getting sensor out of sleep */
+	ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
+			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STREAMING);
+	if (ret < 0)
+		goto error_power_off;
+	usleep_range(100, 110);
+
+	/* put sensor back to standby mode */
+	ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
+			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STANDBY);
+	if (ret < 0)
+		goto error_power_off;
+	usleep_range(100, 110);
+
 	ret = imx219_init_controls(imx219);
 	if (ret)
 		goto error_power_off;
-- 
2.20.1

