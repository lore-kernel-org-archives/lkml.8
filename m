Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8966C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE8206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wspQop88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgFLN4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgFLNyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:54:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F95C08C5D1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:54:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z9so11144582ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gKPskW6+VadYDY7Xc9bQAKR0XT5AIKa1wPS7cKR7Irw=;
        b=wspQop88s6nKhLixjHTH34ZpKon9yCCPrsHGssaZDIhwIBbEoEmoi6TpGycCA6o5TI
         tJkAotNowd7GmU25fZtL94m6SavL9yel6Huls1JOQZcLs41Mjmw+RPTnM2fMdHezeJyC
         LU/Y2Fe9HQkfXVqI6s0QhNAsrawVle2QWxrhj8/sv27My9h79Fr99gI0OTb5UR99dcvk
         fTxxgxhYJ+WoS7R6XgZeHQBG07wor9QOzXVf+ZoL/DZJ1jdeV0ieeWIYRayxSIWoN6xt
         ZPaoRJhW5TSSakiFf5CRblGXdrA/kcYkhwxT9ZCmA2rUJOVtLd3SsAoKxm6EZ19t0lQW
         AvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gKPskW6+VadYDY7Xc9bQAKR0XT5AIKa1wPS7cKR7Irw=;
        b=UJxuljJa8Yp/noW9n0qD8X8/QTabDGcOFRIvQLIXwB3F5ryiNlat/iB5vv0OkfC0mw
         f1O8TtWScr7Vm8I+bJTOek5MHO4j/WK1UggMtrj1+9epqcpa2hsptAdamKoLGDiMdHDb
         3ApH9LI50/10rdodzGTL7xcfOrKlyZOd8CW4ufUEjQyW3zoL5V+4zhpflNUNJsbFUECd
         owO/fnlB4CKLj+tSJoLPzpb9GR4/dZAZiXE6COZOKUI4A8lySeMjt4TMmX/GIdxrZVrX
         oCza/LobYMVdo+iyhxerzr54a+WO+rNMibCKB5X+fL1EmnmzF1fFmtaruRe8VXVT8U58
         n8ZQ==
X-Gm-Message-State: AOAM533hpbfK50Mi8OgcqxX08U/ajmQ/0Vs5mKz0TtXCb66Liidy3hMA
        2rymZM9UqVcfVmUYTG2wHInFDw==
X-Google-Smtp-Source: ABdhPJz+JYUf+tlxFxSG8Qs2lfPgCAXMbaHI27nV91a2VNgw3bQwKhJz24D3Q/JDYll1Jb7AyXBnFw==
X-Received: by 2002:a2e:b0f9:: with SMTP id h25mr7095009ljl.18.1591970069282;
        Fri, 12 Jun 2020 06:54:29 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id a1sm2414415lfi.36.2020.06.12.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:54:27 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v5 05/10] media: i2c: imx290: Add configurable link frequency and pixel rate
Date:   Fri, 12 Jun 2020 16:53:50 +0300
Message-Id: <20200612135355.30286-6-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612135355.30286-1-andrey.konovalov@linaro.org>
References: <20200612135355.30286-1-andrey.konovalov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

IMX290 operates with multiple link frequency and pixel rate combinations.
The initial driver used a single setting for both but since we now have
the lane count support in place, let's add configurable link frequency
and pixel rate.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/i2c/imx290.c | 148 +++++++++++++++++++++++++++----------
 1 file changed, 109 insertions(+), 39 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index ffb393962ffc..152b65cb7cbc 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -32,8 +32,6 @@
 #define IMX290_PHY_LANE_NUM 0x3407
 #define IMX290_CSI_LANE_MODE 0x3443
 
-#define IMX290_DEFAULT_LINK_FREQ 445500000
-
 static const char * const imx290_supply_name[] = {
 	"vdda",
 	"vddd",
@@ -51,8 +49,7 @@ struct imx290_mode {
 	u32 width;
 	u32 height;
 	u32 hmax;
-	u32 pixel_rate;
-	u32 link_freq_index;
+	u8 link_freq_index;
 
 	const struct imx290_regval *data;
 	u32 data_size;
@@ -243,29 +240,54 @@ static const struct imx290_regval imx290_10bit_settings[] = {
 };
 
 /* supported link frequencies */
-static const s64 imx290_link_freq[] = {
-	IMX290_DEFAULT_LINK_FREQ,
+#define FREQ_INDEX_1080P	0
+#define FREQ_INDEX_720P		1
+static const s64 imx290_link_freq_2lanes[] = {
+	[FREQ_INDEX_1080P] = 445500000,
+	[FREQ_INDEX_720P] = 297000000,
+};
+static const s64 imx290_link_freq_4lanes[] = {
+	[FREQ_INDEX_1080P] = 222750000,
+	[FREQ_INDEX_720P] = 148500000,
 };
 
+/*
+ * In this function and in the similar ones below We rely on imx290_probe()
+ * to ensure that nlanes is either 2 or 4.
+ */
+static inline const s64 *imx290_link_freqs_ptr(const struct imx290 *imx290)
+{
+	if (imx290->nlanes == 2)
+		return imx290_link_freq_2lanes;
+	else
+		return imx290_link_freq_4lanes;
+}
+
+static inline int imx290_link_freqs_num(const struct imx290 *imx290)
+{
+	if (imx290->nlanes == 2)
+		return ARRAY_SIZE(imx290_link_freq_2lanes);
+	else
+		return ARRAY_SIZE(imx290_link_freq_4lanes);
+}
+
 /* Mode configs */
 static const struct imx290_mode imx290_modes_2lanes[] = {
 	{
 		.width = 1920,
 		.height = 1080,
 		.hmax = 0x1130,
+		.link_freq_index = FREQ_INDEX_1080P,
 		.data = imx290_1080p_settings,
 		.data_size = ARRAY_SIZE(imx290_1080p_settings),
-		.pixel_rate = 178200000,
-		.link_freq_index = 0,
 	},
 	{
 		.width = 1280,
 		.height = 720,
 		.hmax = 0x19c8,
+		.link_freq_index = FREQ_INDEX_720P,
 		.data = imx290_720p_settings,
 		.data_size = ARRAY_SIZE(imx290_720p_settings),
-		.pixel_rate = 178200000,
-		.link_freq_index = 0,
 	},
 };
 
@@ -274,25 +296,22 @@ static const struct imx290_mode imx290_modes_4lanes[] = {
 		.width = 1920,
 		.height = 1080,
 		.hmax = 0x0898,
+		.link_freq_index = FREQ_INDEX_1080P,
 		.data = imx290_1080p_settings,
 		.data_size = ARRAY_SIZE(imx290_1080p_settings),
-		.pixel_rate = 178200000,
-		.link_freq_index = 0,
 	},
 	{
 		.width = 1280,
 		.height = 720,
 		.hmax = 0x0ce4,
+		.link_freq_index = FREQ_INDEX_720P,
 		.data = imx290_720p_settings,
 		.data_size = ARRAY_SIZE(imx290_720p_settings),
-		.pixel_rate = 178200000,
-		.link_freq_index = 0,
 	},
 };
 
 static inline const struct imx290_mode *imx290_modes_ptr(const struct imx290 *imx290)
 {
-	/* We rely on imx290_probe() to ensure that nlanes is either 2 or 4 */
 	if (imx290->nlanes == 2)
 		return imx290_modes_2lanes;
 	else
@@ -477,6 +496,30 @@ static int imx290_get_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static inline u8 imx290_get_link_freq_index(struct imx290 *imx290)
+{
+	return imx290->current_mode->link_freq_index;
+}
+
+static s64 imx290_get_link_freq(struct imx290 *imx290)
+{
+	u8 index = imx290_get_link_freq_index(imx290);
+
+	return *(imx290_link_freqs_ptr(imx290) + index);
+}
+
+static u64 imx290_calc_pixel_rate(struct imx290 *imx290)
+{
+	s64 link_freq = imx290_get_link_freq(imx290);
+	u8 nlanes = imx290->nlanes;
+	u64 pixel_rate;
+
+	/* pixel rate = link_freq * 2 * nr_of_lanes / bits_per_sample */
+	pixel_rate = link_freq * 2 * nlanes;
+	do_div(pixel_rate, 10);
+	return pixel_rate;
+}
+
 static int imx290_set_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_pad_config *cfg,
 		      struct v4l2_subdev_format *fmt)
@@ -509,10 +552,14 @@ static int imx290_set_fmt(struct v4l2_subdev *sd,
 		format = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
 	} else {
 		format = &imx290->current_format;
-		__v4l2_ctrl_s_ctrl(imx290->link_freq, mode->link_freq_index);
-		__v4l2_ctrl_s_ctrl_int64(imx290->pixel_rate, mode->pixel_rate);
-
 		imx290->current_mode = mode;
+
+		if (imx290->link_freq)
+			__v4l2_ctrl_s_ctrl(imx290->link_freq,
+					   imx290_get_link_freq_index(imx290));
+		if (imx290->pixel_rate)
+			__v4l2_ctrl_s_ctrl_int64(imx290->pixel_rate,
+						 imx290_calc_pixel_rate(imx290));
 	}
 
 	*format = fmt->format;
@@ -536,12 +583,11 @@ static int imx290_entity_init_cfg(struct v4l2_subdev *subdev,
 	return 0;
 }
 
-static int imx290_write_current_format(struct imx290 *imx290,
-				       struct v4l2_mbus_framefmt *format)
+static int imx290_write_current_format(struct imx290 *imx290)
 {
 	int ret;
 
-	switch (format->code) {
+	switch (imx290->current_format.code) {
 	case MEDIA_BUS_FMT_SRGGB10_1X10:
 		ret = imx290_set_register_array(imx290, imx290_10bit_settings,
 						ARRAY_SIZE(
@@ -592,8 +638,8 @@ static int imx290_start_streaming(struct imx290 *imx290)
 		return ret;
 	}
 
-	/* Set current frame format */
-	ret = imx290_write_current_format(imx290, &imx290->current_format);
+	/* Apply the register values related to current frame format */
+	ret = imx290_write_current_format(imx290);
 	if (ret < 0) {
 		dev_err(imx290->dev, "Could not set frame format\n");
 		return ret;
@@ -776,13 +822,34 @@ static const struct media_entity_operations imx290_subdev_entity_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
+/*
+ * Returns 0 if all link frequencies used by the driver for the given number
+ * of MIPI data lanes are mentioned in the device tree, or the value of the
+ * first missing frequency otherwise.
+ */
+static s64 imx290_check_link_freqs(const struct imx290 *imx290)
+{
+	int i, j;
+	const s64 *freqs = imx290_link_freqs_ptr(imx290);
+	int freqs_count = imx290_link_freqs_num(imx290);
+
+	for (i = 0; i < freqs_count; i++) {
+		for (j = 0; j < imx290->ep.nr_of_link_frequencies; j++)
+			if (freqs[i] == imx290->ep.link_frequencies[j])
+				break;
+		if (j == imx290->ep.nr_of_link_frequencies)
+			return freqs[i];
+	}
+	return 0;
+}
+
 static int imx290_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct fwnode_handle *endpoint;
 	struct imx290 *imx290;
 	u32 xclk_freq;
-	u32 default_pixel_rate;
+	s64 fq;
 	int ret;
 
 	imx290 = devm_kzalloc(dev, sizeof(*imx290), GFP_KERNEL);
@@ -825,8 +892,10 @@ static int imx290_probe(struct i2c_client *client)
 		goto free_err;
 	}
 
-	if (imx290->ep.link_frequencies[0] != IMX290_DEFAULT_LINK_FREQ) {
-		dev_err(dev, "Unsupported link frequency\n");
+	/* Check that link frequences for all the modes are in device tree */
+	fq = imx290_check_link_freqs(imx290);
+	if (fq) {
+		dev_err(dev, "Link frequency of %lld is not supported\n", fq);
 		ret = -EINVAL;
 		goto free_err;
 	}
@@ -883,26 +952,30 @@ static int imx290_probe(struct i2c_client *client)
 
 	mutex_init(&imx290->lock);
 
+	/*
+	 * Initialize the frame format. In particular, imx290->current_mode
+	 * and imx290->bpp are set to defaults: imx290_calc_pixel_rate() call
+	 * below relies on these fields.
+	 */
+	imx290_entity_init_cfg(&imx290->sd, NULL);
+
 	v4l2_ctrl_handler_init(&imx290->ctrls, 3);
 
 	v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
 			  V4L2_CID_GAIN, 0, 72, 1, 0);
+
 	imx290->link_freq =
-		v4l2_ctrl_new_int_menu(&imx290->ctrls,
-				       &imx290_ctrl_ops,
+		v4l2_ctrl_new_int_menu(&imx290->ctrls, &imx290_ctrl_ops,
 				       V4L2_CID_LINK_FREQ,
-				       ARRAY_SIZE(imx290_link_freq) - 1,
-				       0, imx290_link_freq);
+				       imx290_link_freqs_num(imx290) - 1, 0,
+				       imx290_link_freqs_ptr(imx290));
 	if (imx290->link_freq)
 		imx290->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
-	default_pixel_rate = imx290->nlanes == 2 ?
-			     imx290_modes_2lanes[0].pixel_rate :
-			     imx290_modes_4lanes[0].pixel_rate;
 	imx290->pixel_rate = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
-					       V4L2_CID_PIXEL_RATE, 1,
-					       INT_MAX, 1,
-					       default_pixel_rate);
+					       V4L2_CID_PIXEL_RATE,
+					       1, INT_MAX, 1,
+					       imx290_calc_pixel_rate(imx290));
 
 	imx290->sd.ctrl_handler = &imx290->ctrls;
 
@@ -926,9 +999,6 @@ static int imx290_probe(struct i2c_client *client)
 		goto free_ctrl;
 	}
 
-	/* Initialize the frame format (this also sets imx290->current_mode) */
-	imx290_entity_init_cfg(&imx290->sd, NULL);
-
 	ret = v4l2_async_register_subdev(&imx290->sd);
 	if (ret < 0) {
 		dev_err(dev, "Could not register v4l2 device\n");
-- 
2.17.1

