Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE94C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E629320825
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fTEgttj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgETI21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgETI2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:28:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF2BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:28:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so1013040ply.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANT05CF+3kv8OvWbcsFu5dGbsqwLagl/gEvFH7hSkdw=;
        b=fTEgttj/CYtdKAIHJj4zRa1BhTmLRlNrp4PPNQypHLkWZu7smhmePORN7jEjMIRf48
         OMqOnUEva5HZnM+21FdcJLej7bxOCXt7WVeS+QK6K4JHPX/wGgedmJs2BUVK1E1LfOoa
         BJYXRNL2tFhBTKK/fzhxaPgjQlgEeUuoWAssI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANT05CF+3kv8OvWbcsFu5dGbsqwLagl/gEvFH7hSkdw=;
        b=c8qIdbBoj2xmG3APKm1I7X57/PfRB/B+yWumLBXDKCpfCvlBd1ztYwnSL+n2+N2TdD
         kMdJsZEVu0JH+bvV7AKMjeo2N4ExDMVaIh9QmfOvylFfqKaLziagY/C0aGgb1SmBqnXq
         Hke5QmAvr8kyRvOT14YxYS8u0RYYiiq7862pWmRo78f79jKVvpFdFff0xO80MqsfFbYM
         m9ho2OwI/WxrHEDzpKEZKCgnBQbnAp4eMdjynPeLDpET5+dbyBbItwRagxkptuKiT6TL
         g4dbJQMY2SuKPZJxvLIq5eirJBkOq8XRjXNOdsXYsLesPF77Koulfl1EUof1NcNguUDe
         7kEA==
X-Gm-Message-State: AOAM533MZDv6b6JiTCczkcbZ2ZRbDWDuYVyjttaRq8r9rn8VyLHRH1kx
        UHsYZIGxvx000YlDebYgzn+otQ==
X-Google-Smtp-Source: ABdhPJx0m4nwG6bvRyDrzI6s3+i20KU5SJHvC+5qJIblV2AjZNK1GYg1nlTu7VITtjvCi7eVr9xD7w==
X-Received: by 2002:a17:902:7881:: with SMTP id q1mr486924pll.84.1589963282172;
        Wed, 20 May 2020 01:28:02 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id gg8sm1447775pjb.39.2020.05.20.01.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:28:01 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 06/10] media: mtk-vcodec: venc: specify supported formats per-chip
Date:   Wed, 20 May 2020 17:27:19 +0900
Message-Id: <20200520082723.96136-7-acourbot@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200520082723.96136-1-acourbot@chromium.org>
References: <20200520082723.96136-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different chips have different supported bitrate ranges. Move the list
of supported formats to the platform data, and split the output and
capture formats into two lists to make it easier to find the default
format for each queue.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |   8 ++
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 122 +++++++-----------
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  40 ++++++
 3 files changed, 95 insertions(+), 75 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index b8f913de8d80..59b4b750666b 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -313,6 +313,10 @@ enum mtk_chip {
  * @has_lt_irq: whether the encoder uses the LT irq
  * @min_birate: minimum supported encoding bitrate
  * @max_bitrate: maximum supported encoding bitrate
+ * @capture_formats: array of supported capture formats
+ * @num_capture_formats: number of entries in capture_formats
+ * @output_formats: array of supported output formats
+ * @num_output_formats: number of entries in output_formats
  */
 struct mtk_vcodec_enc_pdata {
 	enum mtk_chip chip;
@@ -321,6 +325,10 @@ struct mtk_vcodec_enc_pdata {
 	bool has_lt_irq;
 	unsigned long min_bitrate;
 	unsigned long max_bitrate;
+	const struct mtk_video_fmt *capture_formats;
+	size_t num_capture_formats;
+	const struct mtk_video_fmt *output_formats;
+	size_t num_output_formats;
 };
 
 /**
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 50ba9da59153..05743a745a11 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -23,47 +23,9 @@
 #define DFT_CFG_WIDTH	MTK_VENC_MIN_W
 #define DFT_CFG_HEIGHT	MTK_VENC_MIN_H
 #define MTK_MAX_CTRLS_HINT	20
-#define OUT_FMT_IDX		0
-#define CAP_FMT_IDX		4
-
 
 static void mtk_venc_worker(struct work_struct *work);
 
-static const struct mtk_video_fmt mtk_video_formats[] = {
-	{
-		.fourcc = V4L2_PIX_FMT_NV12M,
-		.type = MTK_FMT_FRAME,
-		.num_planes = 2,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_NV21M,
-		.type = MTK_FMT_FRAME,
-		.num_planes = 2,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_YUV420M,
-		.type = MTK_FMT_FRAME,
-		.num_planes = 3,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_YVU420M,
-		.type = MTK_FMT_FRAME,
-		.num_planes = 3,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_H264,
-		.type = MTK_FMT_ENC,
-		.num_planes = 1,
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_VP8,
-		.type = MTK_FMT_ENC,
-		.num_planes = 1,
-	},
-};
-
-#define NUM_FORMATS ARRAY_SIZE(mtk_video_formats)
-
 static const struct mtk_codec_framesizes mtk_venc_framesizes[] = {
 	{
 		.fourcc	= V4L2_PIX_FMT_H264,
@@ -156,27 +118,17 @@ static const struct v4l2_ctrl_ops mtk_vcodec_enc_ctrl_ops = {
 	.s_ctrl = vidioc_venc_s_ctrl,
 };
 
-static int vidioc_enum_fmt(struct v4l2_fmtdesc *f, bool output_queue)
+static int vidioc_enum_fmt(struct v4l2_fmtdesc *f,
+			   const struct mtk_video_fmt *formats,
+			   size_t num_formats)
 {
-	const struct mtk_video_fmt *fmt;
-	int i, j = 0;
+	if (f->index >= num_formats)
+		return -EINVAL;
 
-	for (i = 0; i < NUM_FORMATS; ++i) {
-		if (output_queue && mtk_video_formats[i].type != MTK_FMT_FRAME)
-			continue;
-		if (!output_queue && mtk_video_formats[i].type != MTK_FMT_ENC)
-			continue;
+	f->pixelformat = formats[f->index].fourcc;
+	memset(f->reserved, 0, sizeof(f->reserved));
 
-		if (j == f->index) {
-			fmt = &mtk_video_formats[i];
-			f->pixelformat = fmt->fourcc;
-			memset(f->reserved, 0, sizeof(f->reserved));
-			return 0;
-		}
-		++j;
-	}
-
-	return -EINVAL;
+	return 0;
 }
 
 static int vidioc_enum_framesizes(struct file *file, void *fh,
@@ -202,13 +154,21 @@ static int vidioc_enum_framesizes(struct file *file, void *fh,
 static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 				   struct v4l2_fmtdesc *f)
 {
-	return vidioc_enum_fmt(f, false);
+	const struct mtk_vcodec_enc_pdata *pdata =
+		fh_to_ctx(priv)->dev->venc_pdata;
+
+	return vidioc_enum_fmt(f, pdata->capture_formats,
+			       pdata->num_capture_formats);
 }
 
 static int vidioc_enum_fmt_vid_out(struct file *file, void *priv,
 				   struct v4l2_fmtdesc *f)
 {
-	return vidioc_enum_fmt(f, true);
+	const struct mtk_vcodec_enc_pdata *pdata =
+		fh_to_ctx(priv)->dev->venc_pdata;
+
+	return vidioc_enum_fmt(f, pdata->output_formats,
+			       pdata->num_output_formats);
 }
 
 static int vidioc_venc_querycap(struct file *file, void *priv,
@@ -266,13 +226,20 @@ static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_ctx *ctx,
 	return &ctx->q_data[MTK_Q_DATA_DST];
 }
 
-static const struct mtk_video_fmt *mtk_venc_find_format(struct v4l2_format *f)
+static const struct mtk_video_fmt *mtk_venc_find_format(struct v4l2_format *f,
+	const struct mtk_vcodec_enc_pdata *pdata)
 {
 	const struct mtk_video_fmt *fmt;
 	unsigned int k;
 
-	for (k = 0; k < NUM_FORMATS; k++) {
-		fmt = &mtk_video_formats[k];
+	for (k = 0; k < pdata->num_capture_formats; k++) {
+		fmt = &pdata->capture_formats[k];
+		if (fmt->fourcc == f->fmt.pix.pixelformat)
+			return fmt;
+	}
+
+	for (k = 0; k < pdata->num_output_formats; k++) {
+		fmt = &pdata->output_formats[k];
 		if (fmt->fourcc == f->fmt.pix.pixelformat)
 			return fmt;
 	}
@@ -414,6 +381,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data;
 	int i, ret;
@@ -436,10 +404,10 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	fmt = mtk_venc_find_format(f);
+	fmt = mtk_venc_find_format(f, pdata);
 	if (!fmt) {
-		f->fmt.pix.pixelformat = mtk_video_formats[CAP_FMT_IDX].fourcc;
-		fmt = mtk_venc_find_format(f);
+		fmt = &ctx->dev->venc_pdata->capture_formats[0];
+		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 
 	q_data->fmt = fmt;
@@ -476,6 +444,7 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data;
 	int ret, i;
@@ -499,10 +468,10 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	fmt = mtk_venc_find_format(f);
+	fmt = mtk_venc_find_format(f, pdata);
 	if (!fmt) {
-		f->fmt.pix.pixelformat = mtk_video_formats[OUT_FMT_IDX].fourcc;
-		fmt = mtk_venc_find_format(f);
+		fmt = &ctx->dev->venc_pdata->output_formats[0];
+		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 
 	pix_fmt_mp->height = clamp(pix_fmt_mp->height,
@@ -580,11 +549,12 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 {
 	const struct mtk_video_fmt *fmt;
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
-	fmt = mtk_venc_find_format(f);
+	fmt = mtk_venc_find_format(f, pdata);
 	if (!fmt) {
-		f->fmt.pix.pixelformat = mtk_video_formats[CAP_FMT_IDX].fourcc;
-		fmt = mtk_venc_find_format(f);
+		fmt = &ctx->dev->venc_pdata->capture_formats[0];
+		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 	f->fmt.pix_mp.colorspace = ctx->colorspace;
 	f->fmt.pix_mp.ycbcr_enc = ctx->ycbcr_enc;
@@ -598,11 +568,13 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 					 struct v4l2_format *f)
 {
 	const struct mtk_video_fmt *fmt;
+	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
-	fmt = mtk_venc_find_format(f);
+	fmt = mtk_venc_find_format(f, pdata);
 	if (!fmt) {
-		f->fmt.pix.pixelformat = mtk_video_formats[OUT_FMT_IDX].fourcc;
-		fmt = mtk_venc_find_format(f);
+		fmt = &ctx->dev->venc_pdata->output_formats[0];
+		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 	if (!f->fmt.pix_mp.colorspace) {
 		f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
@@ -1187,7 +1159,7 @@ void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
 	q_data->coded_height = DFT_CFG_HEIGHT;
 	q_data->field = V4L2_FIELD_NONE;
 
-	q_data->fmt = &mtk_video_formats[OUT_FMT_IDX];
+	q_data->fmt = &ctx->dev->venc_pdata->output_formats[0];
 
 	v4l_bound_align_image(&q_data->coded_width,
 				MTK_VENC_MIN_W,
@@ -1216,7 +1188,7 @@ void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
 	memset(q_data, 0, sizeof(struct mtk_q_data));
 	q_data->coded_width = DFT_CFG_WIDTH;
 	q_data->coded_height = DFT_CFG_HEIGHT;
-	q_data->fmt = &mtk_video_formats[CAP_FMT_IDX];
+	q_data->fmt = &ctx->dev->venc_pdata->capture_formats[0];
 	q_data->field = V4L2_FIELD_NONE;
 	ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =
 		DFT_CFG_WIDTH * DFT_CFG_HEIGHT;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 221fa0303075..c8a4b85a81c4 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -26,6 +26,42 @@
 module_param(mtk_v4l2_dbg_level, int, S_IRUGO | S_IWUSR);
 module_param(mtk_vcodec_dbg, bool, S_IRUGO | S_IWUSR);
 
+static const struct mtk_video_fmt mtk_video_formats_output_mt8173[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV12M,
+		.type = MTK_FMT_FRAME,
+		.num_planes = 2,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV21M,
+		.type = MTK_FMT_FRAME,
+		.num_planes = 2,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUV420M,
+		.type = MTK_FMT_FRAME,
+		.num_planes = 3,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YVU420M,
+		.type = MTK_FMT_FRAME,
+		.num_planes = 3,
+	},
+};
+
+static const struct mtk_video_fmt mtk_video_formats_capture_mt8173[] =  {
+	{
+		.fourcc = V4L2_PIX_FMT_H264,
+		.type = MTK_FMT_ENC,
+		.num_planes = 1,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_VP8,
+		.type = MTK_FMT_ENC,
+		.num_planes = 1,
+	},
+};
+
 /* Wake up context wait_queue */
 static void wake_up_ctx(struct mtk_vcodec_ctx *ctx, unsigned int reason)
 {
@@ -380,6 +416,10 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 static const struct mtk_vcodec_enc_pdata mt8173_pdata = {
 	.chip = MTK_MT8173,
 	.has_lt_irq = true,
+	.capture_formats = mtk_video_formats_capture_mt8173,
+	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_mt8173),
+	.output_formats = mtk_video_formats_output_mt8173,
+	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output_mt8173),
 	.min_bitrate = 1,
 	.max_bitrate = 4000000,
 };
-- 
2.26.2.761.g0e0b3e54be-goog

