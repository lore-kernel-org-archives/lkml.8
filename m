Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6652068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvjueiX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgGMGJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgGMGJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:09:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680EC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:09:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k5so5041363plk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIf/kbmDB8xe6X4lo4cpvvB2emLMAc7eYXhbCxEdg7A=;
        b=KvjueiX8a5M7s3DOVR4ub0g5vPoTlo1v0PFdNEE1FbjLLfEJDvO2nItXoNfgBA1n+c
         YD6uQYgUO0k7rfcU7MDnE/e+eZl7lWQaW5zrZdaRTkXnf/wRA56r6LD/PRSI3CpJqgtt
         Zp5Yjj+ERrihJzZWXHtTKO8i44u9M8aRl1eFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIf/kbmDB8xe6X4lo4cpvvB2emLMAc7eYXhbCxEdg7A=;
        b=UfJzgq5+tfmQ8ma3sAS0bOXP94BRrmK8mO4ioCsuasj+xdIvP7EUN9fKRCWe5Ge6zd
         6/4ZjACNxrxk3WJOaLNoPHgQOl/EAYCOmR6RAqkJ+rJBdxxKtr2DJdQmms80HeiE5+3w
         kKMzZNVBIjVpW48XQ6/qpBhTcOBXYYVrx+E4DulG9JtgLprTnxhr90oEPdjmj2AM4ZBX
         cJlpInd24R9dXgKG7Kr8gbXQgf9QpZy679zhtiL23hGs5nrD5UUuN3N2YKk4ElKpEvMH
         OTImI563nb1UCU7p5u8gUalg6r+3tDI8WoPVnLuL+DURcoHllXdIp/NTxWpixajXY2/E
         Q1fQ==
X-Gm-Message-State: AOAM530bM9Wkb59jSNVHvrpxp8q+WCZ+thaVg1GtRfKHO2g5TJjImnZ1
        SsI6XjSZSRexF6r6QcG0/qEDAA==
X-Google-Smtp-Source: ABdhPJyyNgcKwjr4YlNkGt0EkWZx1ghU0v4rcCtbtbVDVnNk7CIEc0d6/O+Z8WYcxD2E/rHe+eUL3A==
X-Received: by 2002:a17:90a:f996:: with SMTP id cq22mr19935477pjb.208.1594620593829;
        Sun, 12 Jul 2020 23:09:53 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id c134sm13134934pfc.115.2020.07.12.23.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:09:53 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v3 14/16] media: mtk-vcodec: venc: support ENUM_FRAMESIZES on OUTPUT formats
Date:   Mon, 13 Jul 2020 15:08:40 +0900
Message-Id: <20200713060842.471356-15-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713060842.471356-1-acourbot@chromium.org>
References: <20200713060842.471356-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2-compliance requires ENUM_FRAMESIZES to support OUTPUT formats.
Reuse mtk_venc_find_format() to make sure both queues are considered
when serving an ENUM_FRAMESIZES.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 71 +++++++++----------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index f8d4fbe927f9..1b79185cf922 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -123,28 +123,44 @@ static int vidioc_enum_fmt(struct v4l2_fmtdesc *f,
 	return 0;
 }
 
+static const struct mtk_video_fmt *mtk_venc_find_format(u32 fourcc,
+	const struct mtk_vcodec_enc_pdata *pdata)
+{
+	const struct mtk_video_fmt *fmt;
+	unsigned int k;
+
+	for (k = 0; k < pdata->num_capture_formats; k++) {
+		fmt = &pdata->capture_formats[k];
+		if (fmt->fourcc == fourcc)
+			return fmt;
+	}
+
+	for (k = 0; k < pdata->num_output_formats; k++) {
+		fmt = &pdata->output_formats[k];
+		if (fmt->fourcc == fourcc)
+			return fmt;
+	}
+
+	return NULL;
+}
+
 static int vidioc_enum_framesizes(struct file *file, void *fh,
 				  struct v4l2_frmsizeenum *fsize)
 {
-	const struct mtk_vcodec_enc_pdata *pdata =
-		fh_to_ctx(fh)->dev->venc_pdata;
-	int i = 0;
+	const struct mtk_video_fmt *fmt;
 
 	if (fsize->index != 0)
 		return -EINVAL;
 
-	for (i = 0; i < pdata->num_capture_formats; ++i) {
-		const struct mtk_video_fmt *fmt = &pdata->capture_formats[i];
+	fmt = mtk_venc_find_format(fsize->pixel_format,
+				   fh_to_ctx(fh)->dev->venc_pdata);
+	if (!fmt)
+		return -EINVAL;
 
-		if (fsize->pixel_format != fmt->fourcc)
-			continue;
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise = mtk_venc_framesizes;
 
-		fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
-		fsize->stepwise = mtk_venc_framesizes;
-		return 0;
-	}
-
-	return -EINVAL;
+	return 0;
 }
 
 static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
@@ -222,27 +238,6 @@ static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_ctx *ctx,
 	return &ctx->q_data[MTK_Q_DATA_DST];
 }
 
-static const struct mtk_video_fmt *mtk_venc_find_format(struct v4l2_format *f,
-	const struct mtk_vcodec_enc_pdata *pdata)
-{
-	const struct mtk_video_fmt *fmt;
-	unsigned int k;
-
-	for (k = 0; k < pdata->num_capture_formats; k++) {
-		fmt = &pdata->capture_formats[k];
-		if (fmt->fourcc == f->fmt.pix.pixelformat)
-			return fmt;
-	}
-
-	for (k = 0; k < pdata->num_output_formats; k++) {
-		fmt = &pdata->output_formats[k];
-		if (fmt->fourcc == f->fmt.pix.pixelformat)
-			return fmt;
-	}
-
-	return NULL;
-}
-
 /* V4L2 specification suggests the driver corrects the format struct if any of
  * the dimensions is unsupported
  */
@@ -403,7 +398,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->capture_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
@@ -467,7 +462,7 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->output_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
@@ -550,7 +545,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->capture_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
@@ -570,7 +565,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->output_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
-- 
2.27.0.383.g050319c2ae-goog

