Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFDBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C98206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="iANo6QFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgF3TvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgF3TvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:51:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BC6C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:51:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so9860549pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iNCHcq75Fyx9uiWciOcCfYEZ90izFqxrP5nDdLzvmsw=;
        b=iANo6QFw3dFn64R//mzh8CGnOtwCTI07fMSLn4iXWhcZaDlm8T4nKjXX4DgWqUtJRm
         WbFCzN0sk0oDeZp//4HbCsw6Qlv5GNGMQFYfegGruuGXSif0Npk15PsG2bkGmZ89pctg
         nJp5i4Oy0O4RxUr2IyBVS/l0x2v5dzMDt9bRTd0oqanImWcBs4fFRlsWSuO9hHppo+j6
         RUgbyhxLIwrYCpX82PUx3p/h//PesgIHOs9qew9s3Vug1klshcKosbbkBxcerjCQo1Bq
         S6yecic8eQtnBLd1o9iPY/GhutpM3W0FLklfmznDv8FGZU/yfIs1/PvyinmthLmkuGNo
         iEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iNCHcq75Fyx9uiWciOcCfYEZ90izFqxrP5nDdLzvmsw=;
        b=H8twPENiya0fJid9PyiUCYmHQ/Db0oq953ekMPso7o1jGgmr5anc8pzCTQTTem+I/i
         W7zvpO1XYEa+kIMx6+XGgzenMQZjU7Qff+uz6tebvL41H01PjEclDfF8ookIOBIiNZ2R
         MZic1YQcPuCeYtPH/mjhnzPxok/JwGjUIwfL/5SS5NzIqaWFw7udFqZeXOIGZIuT+g5i
         x7lECYJlxC2slLFp7ueparIb9qVbMRMdwPdr9mLbHRuEnQjIxxcig2gl3l9mFCfxJLnl
         EWcsmhiKDHfIdJIVfeyPOB4ON6RCwaqO6pQIOHA/k8fes5vTULcrhLafnxKbBoK5H2IB
         DS5Q==
X-Gm-Message-State: AOAM531XCms+aXqjnIE3TQdx3g5bwjRp14mHGUrnKdhu3YMalliTaGn/
        nNs12iBkhNtXTiyHRvFzlI6ALvIIWPFkMg==
X-Google-Smtp-Source: ABdhPJzs9zAJFf8WCGlWWqtREEMo8c7fen5CasqKQOZh6AO2PVKIYYKZ9eCuadpNYQ5qv9MMvJqY1w==
X-Received: by 2002:aa7:818e:: with SMTP id g14mr15142886pfi.27.1593546674145;
        Tue, 30 Jun 2020 12:51:14 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.178])
        by smtp.gmail.com with ESMTPSA id j16sm3376988pgb.33.2020.06.30.12.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 12:51:13 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v8 3/3] media: vimc: Add a control to display info on test image
Date:   Wed,  1 Jul 2020 01:20:52 +0530
Message-Id: <20200630195052.23880-4-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630195052.23880-1-kgupta@es.iitr.ac.in>
References: <20200630195052.23880-1-kgupta@es.iitr.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control in VIMC to display information such as the correct order of
colors for a given test pattern, counter, brightness, hue, saturation,
contrast, width and height at sensor over test image.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/media/test-drivers/vimc/Kconfig       |  2 +
 drivers/media/test-drivers/vimc/vimc-common.h |  1 +
 drivers/media/test-drivers/vimc/vimc-core.c   | 10 +++
 drivers/media/test-drivers/vimc/vimc-sensor.c | 67 +++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/drivers/media/test-drivers/vimc/Kconfig b/drivers/media/test-drivers/vimc/Kconfig
index 4068a67585f9..da4b2ad6e40c 100644
--- a/drivers/media/test-drivers/vimc/Kconfig
+++ b/drivers/media/test-drivers/vimc/Kconfig
@@ -2,6 +2,8 @@
 config VIDEO_VIMC
 	tristate "Virtual Media Controller Driver (VIMC)"
 	depends on VIDEO_DEV && VIDEO_V4L2
+	select FONT_SUPPORT
+	select FONT_8x16
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_VMALLOC
diff --git a/drivers/media/test-drivers/vimc/vimc-common.h b/drivers/media/test-drivers/vimc/vimc-common.h
index ae163dec2459..a289434e75ba 100644
--- a/drivers/media/test-drivers/vimc/vimc-common.h
+++ b/drivers/media/test-drivers/vimc/vimc-common.h
@@ -20,6 +20,7 @@
 #define VIMC_CID_VIMC_CLASS		(0x00f00000 | 1)
 #define VIMC_CID_TEST_PATTERN		(VIMC_CID_VIMC_BASE + 0)
 #define VIMC_CID_MEAN_WIN_SIZE		(VIMC_CID_VIMC_BASE + 1)
+#define VIMC_CID_OSD_TEXT_MODE		(VIMC_CID_VIMC_BASE + 2)
 
 #define VIMC_FRAME_MAX_WIDTH 4096
 #define VIMC_FRAME_MAX_HEIGHT 2160
diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
index 11210aaa2551..4b0ae6f51d76 100644
--- a/drivers/media/test-drivers/vimc/vimc-core.c
+++ b/drivers/media/test-drivers/vimc/vimc-core.c
@@ -5,10 +5,12 @@
  * Copyright (C) 2015-2017 Helen Koike <helen.fornazier@gmail.com>
  */
 
+#include <linux/font.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <media/media-device.h>
+#include <media/tpg/v4l2-tpg.h>
 #include <media/v4l2-device.h>
 
 #include "vimc-common.h"
@@ -263,11 +265,19 @@ static int vimc_register_devices(struct vimc_device *vimc)
 
 static int vimc_probe(struct platform_device *pdev)
 {
+	const struct font_desc *font = find_font("VGA8x16");
 	struct vimc_device *vimc;
 	int ret;
 
 	dev_dbg(&pdev->dev, "probe");
 
+	if (!font) {
+		dev_err(&pdev->dev, "could not find font\n");
+		return -ENODEV;
+	}
+
+	tpg_set_font(font->data);
+
 	vimc = kzalloc(sizeof(*vimc), GFP_KERNEL);
 	if (!vimc)
 		return -ENOMEM;
diff --git a/drivers/media/test-drivers/vimc/vimc-sensor.c b/drivers/media/test-drivers/vimc/vimc-sensor.c
index a2f09ac9a360..ec9ddd42984c 100644
--- a/drivers/media/test-drivers/vimc/vimc-sensor.c
+++ b/drivers/media/test-drivers/vimc/vimc-sensor.c
@@ -14,11 +14,15 @@
 
 #include "vimc-common.h"
 
+enum osd_mode {OSD_SHOW_ALL = 0, OSD_SHOW_COUNTERS = 1, OSD_SHOW_NONE = 2};
+
 struct vimc_sen_device {
 	struct vimc_ent_device ved;
 	struct v4l2_subdev sd;
 	struct tpg_data tpg;
 	u8 *frame;
+	enum osd_mode osd_value;
+	u64 start_stream_ts;
 	/* The active format */
 	struct v4l2_mbus_framefmt mbus_format;
 	struct v4l2_ctrl_handler hdl;
@@ -187,8 +191,49 @@ static void *vimc_sen_process_frame(struct vimc_ent_device *ved,
 {
 	struct vimc_sen_device *vsen = container_of(ved, struct vimc_sen_device,
 						    ved);
+	const unsigned int line_height = 16;
+	u8 *basep[TPG_MAX_PLANES][2];
+	unsigned int line = 1;
+	char str[100];
 
 	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame);
+	tpg_calc_text_basep(&vsen->tpg, basep, 0, vsen->frame);
+	switch (vsen->osd_value) {
+	case OSD_SHOW_ALL: {
+		const char *order = tpg_g_color_order(&vsen->tpg);
+
+		tpg_gen_text(&vsen->tpg, basep, line++ * line_height,
+			     16, order);
+		snprintf(str, sizeof(str),
+			 "brightness %3d, contrast %3d, saturation %3d, hue %d ",
+			 vsen->tpg.brightness,
+			 vsen->tpg.contrast,
+			 vsen->tpg.saturation,
+			 vsen->tpg.hue);
+		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
+		snprintf(str, sizeof(str), "sensor size: %dx%d",
+			 vsen->mbus_format.width,
+			 vsen->mbus_format.height);
+		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
+	fallthrough;
+	}
+	case OSD_SHOW_COUNTERS: {
+		unsigned int ms;
+
+		ms = (ktime_get_ns() - vsen->start_stream_ts) / 1000000;
+		snprintf(str, sizeof(str), "%02d:%02d:%02d:%03d",
+			 (ms / (60 * 60 * 1000)) % 24,
+			 (ms / (60 * 1000)) % 60,
+			 (ms / 1000) % 60,
+			 ms % 1000);
+		tpg_gen_text(&vsen->tpg, basep, line++ * line_height, 16, str);
+		break;
+	}
+	case OSD_SHOW_NONE:
+	default:
+		break;
+	}
+
 	return vsen->frame;
 }
 
@@ -201,6 +246,8 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
 		const struct vimc_pix_map *vpix;
 		unsigned int frame_size;
 
+		vsen->start_stream_ts = ktime_get_ns();
+
 		/* Calculate the frame size */
 		vpix = vimc_pix_map_by_code(vsen->mbus_format.code);
 		frame_size = vsen->mbus_format.width * vpix->bpp *
@@ -269,6 +316,9 @@ static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_SATURATION:
 		tpg_s_saturation(&vsen->tpg, ctrl->val);
 		break;
+	case VIMC_CID_OSD_TEXT_MODE:
+		vsen->osd_value = ctrl->val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -307,6 +357,22 @@ static const struct v4l2_ctrl_config vimc_sen_ctrl_test_pattern = {
 	.qmenu = tpg_pattern_strings,
 };
 
+static const char * const vimc_ctrl_osd_mode_strings[] = {
+	"All",
+	"Counters Only",
+	"None",
+	NULL,
+};
+
+static const struct v4l2_ctrl_config vimc_sen_ctrl_osd_mode = {
+	.ops = &vimc_sen_ctrl_ops,
+	.id = VIMC_CID_OSD_TEXT_MODE,
+	.name = "Show Information",
+	.type = V4L2_CTRL_TYPE_MENU,
+	.max = ARRAY_SIZE(vimc_ctrl_osd_mode_strings) - 2,
+	.qmenu = vimc_ctrl_osd_mode_strings,
+};
+
 static struct vimc_ent_device *vimc_sen_add(struct vimc_device *vimc,
 					    const char *vcfg_name)
 {
@@ -323,6 +389,7 @@ static struct vimc_ent_device *vimc_sen_add(struct vimc_device *vimc,
 
 	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_class, NULL);
 	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_test_pattern, NULL);
+	v4l2_ctrl_new_custom(&vsen->hdl, &vimc_sen_ctrl_osd_mode, NULL);
 	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
 			  V4L2_CID_VFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
-- 
2.17.1

