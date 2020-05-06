Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8FC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D226206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCw0B/Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgEFFCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbgEFFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:01:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1DC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 22:01:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so288539pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 22:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRH6mP5DkzvDWC4BDrXU46q1GfnJROfRsSs9Enh6Aj8=;
        b=oCw0B/XiMV8seZdiFN6gUWTR0Y153v/PDpXeWEGiBgetI4eVkDccMuQaAEk607OF3X
         Q7/zPDc1KnH+3AbqlpwwsiKDForB2mZVM+HQINTsxSPjQh+cw9VIn49svgZyfWeF8x9q
         SHXK3mCi2hPaGJ8UWMwbQOKV5I35WHHMRowqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRH6mP5DkzvDWC4BDrXU46q1GfnJROfRsSs9Enh6Aj8=;
        b=VKWTLkRB0Pix6e/1PkmTUiCglUSCEACbpm8wDNomE10hC2Q5nu78DbPILTgttOBt1m
         35NNP2DNSCooeBqRDqm7Zk2U7DhEx16LQwcQEDXVgVFTXs6DqxmxiMtSYVY+olAvPKaa
         cqd2y8SwtajryEFZVjQDdze6HGG7DTnqFa+lLTyh68iC11xEBOtd9P4gmKhGjE6L2Lkv
         a7vYJhyqa4Gdr+5PcKRtrMsMu+Dl0R6Xfdmlx7atfWhzVsB2oALAUBKH9DLtPXN/qTN3
         iUun4HEsMTke/XBl3P8A7q3zfGx0BVOL1Gi6miCwwkJgHRgSrlBtYH5LPOTbp9BnnWCN
         ybUw==
X-Gm-Message-State: AGi0Puas+OAKG6FPrpfjRvYoO6/WrmHqQ59RdVdytNSOTaNDanaISFIe
        dzru8dmAtGfE+5Bo9/kXXC8uhxbvekQ=
X-Google-Smtp-Source: APiQypKPe+BFKl0nmU6VwfRqKkFP56+voyr9ECvJUtW0PAP3CNx9OxXNwP82M75LqkF/fVSOBs1lUw==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr6895190pjb.146.1588741318495;
        Tue, 05 May 2020 22:01:58 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id 14sm512613pfy.38.2020.05.05.22.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 22:01:57 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Francois Buergisser <fbuergisser@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Enric Balletbo I Serra <enric.balletbo@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] [media] mtk-mdp: Remove states for format checks
Date:   Wed,  6 May 2020 15:01:37 +1000
Message-Id: <20200506150122.v2.1.If64533ce7519a22cbd584fff07214bcf9cb9260b@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francois Buergisser <fbuergisser@chromium.org>

The mtk-mdp driver uses states to check if the formats have been set
on the capture and output when turning the streaming on, setting
controls or setting the selection rectangles.
Those states are reset when 0 buffers are requested like when checking
capabilities.
This patch removes all format checks and set one by default as queues in
V4L2 are expected to always have a format set.

https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/vidioc-streamon.html
https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/vidioc-g-ctrl.html
https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/vidioc-g-selection.html

Signed-off-by: Francois Buergisser <fbuergisser@chromium.org>
Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
Reviewed-by: Enric Balletbo I Serra <enric.balletbo@collabora.com>
---

 drivers/media/platform/mtk-mdp/mtk_mdp_core.h |  2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c  | 90 +++++++------------
 2 files changed, 34 insertions(+), 58 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.h b/drivers/media/platform/mtk-mdp/mtk_mdp_core.h
index bafcccd71f31..dd130cc218c9 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.h
@@ -28,8 +28,6 @@
 #define MTK_MDP_FMT_FLAG_CAPTURE	BIT(1)
 
 #define MTK_MDP_VPU_INIT		BIT(0)
-#define MTK_MDP_SRC_FMT			BIT(1)
-#define MTK_MDP_DST_FMT			BIT(2)
 #define MTK_MDP_CTX_ERROR		BIT(5)
 
 /**
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
index 821f2cf325f0..bb9caaf513bc 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
@@ -369,13 +369,6 @@ void mtk_mdp_ctx_state_lock_set(struct mtk_mdp_ctx *ctx, u32 state)
 	mutex_unlock(&ctx->slock);
 }
 
-static void mtk_mdp_ctx_state_lock_clear(struct mtk_mdp_ctx *ctx, u32 state)
-{
-	mutex_lock(&ctx->slock);
-	ctx->state &= ~state;
-	mutex_unlock(&ctx->slock);
-}
-
 static bool mtk_mdp_ctx_state_is_set(struct mtk_mdp_ctx *ctx, u32 mask)
 {
 	bool ret;
@@ -726,11 +719,6 @@ static int mtk_mdp_m2m_s_fmt_mplane(struct file *file, void *fh,
 		ctx->quant = pix_mp->quantization;
 	}
 
-	if (V4L2_TYPE_IS_OUTPUT(f->type))
-		mtk_mdp_ctx_state_lock_set(ctx, MTK_MDP_SRC_FMT);
-	else
-		mtk_mdp_ctx_state_lock_set(ctx, MTK_MDP_DST_FMT);
-
 	mtk_mdp_dbg(2, "[%d] type:%d, frame:%dx%d", ctx->id, f->type,
 		    frame->width, frame->height);
 
@@ -742,13 +730,6 @@ static int mtk_mdp_m2m_reqbufs(struct file *file, void *fh,
 {
 	struct mtk_mdp_ctx *ctx = fh_to_ctx(fh);
 
-	if (reqbufs->count == 0) {
-		if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
-			mtk_mdp_ctx_state_lock_clear(ctx, MTK_MDP_SRC_FMT);
-		else
-			mtk_mdp_ctx_state_lock_clear(ctx, MTK_MDP_DST_FMT);
-	}
-
 	return v4l2_m2m_reqbufs(file, ctx->m2m_ctx, reqbufs);
 }
 
@@ -758,14 +739,6 @@ static int mtk_mdp_m2m_streamon(struct file *file, void *fh,
 	struct mtk_mdp_ctx *ctx = fh_to_ctx(fh);
 	int ret;
 
-	/* The source and target color format need to be set */
-	if (V4L2_TYPE_IS_OUTPUT(type)) {
-		if (!mtk_mdp_ctx_state_is_set(ctx, MTK_MDP_SRC_FMT))
-			return -EINVAL;
-	} else if (!mtk_mdp_ctx_state_is_set(ctx, MTK_MDP_DST_FMT)) {
-		return -EINVAL;
-	}
-
 	if (!mtk_mdp_ctx_state_is_set(ctx, MTK_MDP_VPU_INIT)) {
 		ret = mtk_mdp_vpu_init(&ctx->vpu);
 		if (ret < 0) {
@@ -899,24 +872,21 @@ static int mtk_mdp_m2m_s_selection(struct file *file, void *fh,
 		frame = &ctx->d_frame;
 
 	/* Check to see if scaling ratio is within supported range */
-	if (mtk_mdp_ctx_state_is_set(ctx, MTK_MDP_DST_FMT | MTK_MDP_SRC_FMT)) {
-		if (V4L2_TYPE_IS_OUTPUT(s->type)) {
-			ret = mtk_mdp_check_scaler_ratio(variant, new_r.width,
-				new_r.height, ctx->d_frame.crop.width,
-				ctx->d_frame.crop.height,
-				ctx->ctrls.rotate->val);
-		} else {
-			ret = mtk_mdp_check_scaler_ratio(variant,
-				ctx->s_frame.crop.width,
-				ctx->s_frame.crop.height, new_r.width,
-				new_r.height, ctx->ctrls.rotate->val);
-		}
+	if (V4L2_TYPE_IS_OUTPUT(s->type))
+		ret = mtk_mdp_check_scaler_ratio(variant, new_r.width,
+			new_r.height, ctx->d_frame.crop.width,
+			ctx->d_frame.crop.height,
+			ctx->ctrls.rotate->val);
+	else
+		ret = mtk_mdp_check_scaler_ratio(variant,
+			ctx->s_frame.crop.width,
+			ctx->s_frame.crop.height, new_r.width,
+			new_r.height, ctx->ctrls.rotate->val);
 
-		if (ret) {
-			dev_info(&ctx->mdp_dev->pdev->dev,
-				"Out of scaler range");
-			return -EINVAL;
-		}
+	if (ret) {
+		dev_info(&ctx->mdp_dev->pdev->dev,
+			"Out of scaler range");
+		return -EINVAL;
 	}
 
 	s->r = new_r;
@@ -989,7 +959,6 @@ static int mtk_mdp_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct mtk_mdp_ctx *ctx = ctrl_to_ctx(ctrl);
 	struct mtk_mdp_dev *mdp = ctx->mdp_dev;
 	struct mtk_mdp_variant *variant = mdp->variant;
-	u32 state = MTK_MDP_DST_FMT | MTK_MDP_SRC_FMT;
 	int ret = 0;
 
 	if (ctrl->flags & V4L2_CTRL_FLAG_INACTIVE)
@@ -1003,17 +972,15 @@ static int mtk_mdp_s_ctrl(struct v4l2_ctrl *ctrl)
 		ctx->vflip = ctrl->val;
 		break;
 	case V4L2_CID_ROTATE:
-		if (mtk_mdp_ctx_state_is_set(ctx, state)) {
-			ret = mtk_mdp_check_scaler_ratio(variant,
-					ctx->s_frame.crop.width,
-					ctx->s_frame.crop.height,
-					ctx->d_frame.crop.width,
-					ctx->d_frame.crop.height,
-					ctx->ctrls.rotate->val);
-
-			if (ret)
-				return -EINVAL;
-		}
+		ret = mtk_mdp_check_scaler_ratio(variant,
+				ctx->s_frame.crop.width,
+				ctx->s_frame.crop.height,
+				ctx->d_frame.crop.width,
+				ctx->d_frame.crop.height,
+				ctx->ctrls.rotate->val);
+
+		if (ret)
+			return -EINVAL;
 
 		ctx->rotation = ctrl->val;
 		break;
@@ -1090,6 +1057,7 @@ static int mtk_mdp_m2m_open(struct file *file)
 	struct video_device *vfd = video_devdata(file);
 	struct mtk_mdp_ctx *ctx = NULL;
 	int ret;
+	struct v4l2_format default_format;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -1144,6 +1112,16 @@ static int mtk_mdp_m2m_open(struct file *file)
 	list_add(&ctx->list, &mdp->ctx_list);
 	mutex_unlock(&mdp->lock);
 
+	/* Default format */
+	memset(&default_format, 0, sizeof(default_format));
+	default_format.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	default_format.fmt.pix_mp.width = 32;
+	default_format.fmt.pix_mp.height = 32;
+	default_format.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_YUV420M;
+	mtk_mdp_m2m_s_fmt_mplane(file, &ctx->fh, &default_format);
+	default_format.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	mtk_mdp_m2m_s_fmt_mplane(file, &ctx->fh, &default_format);
+
 	mtk_mdp_dbg(0, "%s [%d]", dev_name(&mdp->pdev->dev), ctx->id);
 
 	return 0;
-- 
2.26.2.526.g744177e7f7-goog

