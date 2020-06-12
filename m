Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92351C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70051206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peiWVTRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgFLNyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgFLNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:54:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A221CC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:54:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so11141069ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WjXebY5QtcvN7Odp1pbuemzpCVQPCaprQRcJnauls1g=;
        b=peiWVTRCg47yjNrbsYphiBIijTqsAzjWx9osQFgAUKmC+mGepQFCBp5l/aKJvlvkeP
         kEsVlus8op6mYV7IM+SLiQvI/CylTH3wWYDRW3VHtFlWEGJgn/qmmso+Q4Hwh3JhxFwR
         iPP3fLIQFq1EXGOeCp7hQ2nPpp7nOEWMxS7UB1c4ecVUwPbjN43PI9GtMqGKbZVOFuhT
         6muQJDOeyLcROlONSPImTEc+PR2jvaCL4+5/ZzF7cAmNml9t8zxpXDHWORfCjtyfJqFr
         uOYMFumdUg/x8IDf1z02ly+Fh+XCeHrFVk4rLTy4yzJtVN247opTQVDJRchjzfAbU0gn
         3Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WjXebY5QtcvN7Odp1pbuemzpCVQPCaprQRcJnauls1g=;
        b=eFYkIn+MeFHS1bFY0JUefpyoMDk8RmlS+aHs3vYiBE7/p4iP7I3GwBqqH9V4RDGUgr
         sKv1V3nT0rCal9N6vOGq8GxCifmDop7PvXwc1zc+cMCpFBjE96BaTBcJk6vp5VxNYVU7
         UO0JMMSC3rBTJCZI2TGKTcmaoZyh+UM23ogcnJTh85Sll6tPXZEoH+59yts41isBCSR2
         TQ7q87sUnOChsCLH0PMhrWwfPFJQcGzpHCLBuxASJZOgjkQxvjvrzsT3HtRzhjSkRGbN
         NDSHujC91tcHrC3XQykNNl/P33YD/4kq2R4AY+zxtb0nx6lgJTG1AKSIilJnAUT3xuRv
         l8ng==
X-Gm-Message-State: AOAM531BhnkddgVFvs6RPJrgDTJ021+6QhEZjzdFKfjjhLiowdZb6b1d
        bmvwhJ6JLIn8JoXRx7bvGBne0TZb64gqBQ==
X-Google-Smtp-Source: ABdhPJxcv+jl4/HmYNqG8iVDXXsnFmqnNSDaduV7uDXPdrWHcwqkw07kSFpRlzIn/Z3C39XRFY/MOQ==
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr7286504ljp.177.1591970078000;
        Fri, 12 Jun 2020 06:54:38 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id a1sm2414415lfi.36.2020.06.12.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:54:37 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v5 06/10] media: i2c: imx290: Add support for test pattern generation
Date:   Fri, 12 Jun 2020 16:53:51 +0300
Message-Id: <20200612135355.30286-7-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612135355.30286-1-andrey.konovalov@linaro.org>
References: <20200612135355.30286-1-andrey.konovalov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add support for generating following test patterns by IMX290:

* Sequence Pattern 1
* Horizontal Color-bar Chart
* Vertical Color-bar Chart
* Sequence Pattern 2
* Gradation Pattern 1
* Gradation Pattern 2
* 000/555h Toggle Pattern

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/i2c/imx290.c | 41 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 152b65cb7cbc..67725a5aabd3 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -26,12 +26,19 @@
 #define IMX290_REGHOLD 0x3001
 #define IMX290_XMSTA 0x3002
 #define IMX290_FR_FDG_SEL 0x3009
+#define IMX290_BLKLEVEL_LOW 0x300a
+#define IMX290_BLKLEVEL_HIGH 0x300b
 #define IMX290_GAIN 0x3014
 #define IMX290_HMAX_LOW 0x301c
 #define IMX290_HMAX_HIGH 0x301d
+#define IMX290_PGCTRL 0x308c
 #define IMX290_PHY_LANE_NUM 0x3407
 #define IMX290_CSI_LANE_MODE 0x3443
 
+#define IMX290_PGCTRL_REGEN BIT(0)
+#define IMX290_PGCTRL_THRU BIT(1)
+#define IMX290_PGCTRL_MODE(n) ((n) << 4)
+
 static const char * const imx290_supply_name[] = {
 	"vdda",
 	"vddd",
@@ -91,6 +98,17 @@ static const struct regmap_config imx290_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static const char * const imx290_test_pattern_menu[] = {
+	"Disabled",
+	"Sequence Pattern 1",
+	"Horizontal Color-bar Chart",
+	"Vertical Color-bar Chart",
+	"Sequence Pattern 2",
+	"Gradation Pattern 1",
+	"Gradation Pattern 2",
+	"000/555h Toggle Pattern",
+};
+
 static const struct imx290_regval imx290_global_init_settings[] = {
 	{ 0x3007, 0x00 },
 	{ 0x3018, 0x65 },
@@ -448,6 +466,22 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_GAIN:
 		ret = imx290_set_gain(imx290, ctrl->val);
 		break;
+	case V4L2_CID_TEST_PATTERN:
+		if (ctrl->val) {
+			imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW, 0x00);
+			imx290_write_reg(imx290, IMX290_BLKLEVEL_HIGH, 0x00);
+			msleep(10);
+			imx290_write_reg(imx290, IMX290_PGCTRL,
+					 (u8)(IMX290_PGCTRL_REGEN |
+					 IMX290_PGCTRL_THRU |
+					 IMX290_PGCTRL_MODE(ctrl->val)));
+		} else {
+			imx290_write_reg(imx290, IMX290_PGCTRL, 0x00);
+			msleep(10);
+			imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW, 0x3c);
+			imx290_write_reg(imx290, IMX290_BLKLEVEL_HIGH, 0x00);
+		}
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -959,7 +993,7 @@ static int imx290_probe(struct i2c_client *client)
 	 */
 	imx290_entity_init_cfg(&imx290->sd, NULL);
 
-	v4l2_ctrl_handler_init(&imx290->ctrls, 3);
+	v4l2_ctrl_handler_init(&imx290->ctrls, 4);
 
 	v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
 			  V4L2_CID_GAIN, 0, 72, 1, 0);
@@ -977,6 +1011,11 @@ static int imx290_probe(struct i2c_client *client)
 					       1, INT_MAX, 1,
 					       imx290_calc_pixel_rate(imx290));
 
+	v4l2_ctrl_new_std_menu_items(&imx290->ctrls, &imx290_ctrl_ops,
+				     V4L2_CID_TEST_PATTERN,
+				     ARRAY_SIZE(imx290_test_pattern_menu) - 1,
+				     0, 0, imx290_test_pattern_menu);
+
 	imx290->sd.ctrl_handler = &imx290->ctrls;
 
 	if (imx290->ctrls.error) {
-- 
2.17.1

