Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12949C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDF820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGOUXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgGOUXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:23:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1DC061755;
        Wed, 15 Jul 2020 13:23:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E8BA12A5281
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 09/10] media: hantro: Don't require unneeded H264_SLICE_PARAMS
Date:   Wed, 15 Jul 2020 17:22:32 -0300
Message-Id: <20200715202233.185680-10-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715202233.185680-1-ezequiel@collabora.com>
References: <20200715202233.185680-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that slice invariant parameters have been moved,
the driver no longer needs this control, so drop it.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/hantro/hantro_drv.c  | 5 -----
 drivers/staging/media/hantro/hantro_h264.c | 5 -----
 drivers/staging/media/hantro/hantro_hw.h   | 2 --
 3 files changed, 12 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 34797507f214..3cd00cc0a364 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -306,11 +306,6 @@ static const struct hantro_ctrl controls[] = {
 		.cfg = {
 			.id = V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS,
 		},
-	}, {
-		.codec = HANTRO_H264_DECODER,
-		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS,
-		},
 	}, {
 		.codec = HANTRO_H264_DECODER,
 		.cfg = {
diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
index 0cbe514dc79a..6887318ed4d8 100644
--- a/drivers/staging/media/hantro/hantro_h264.c
+++ b/drivers/staging/media/hantro/hantro_h264.c
@@ -349,11 +349,6 @@ int hantro_h264_dec_prepare_run(struct hantro_ctx *ctx)
 	if (WARN_ON(!ctrls->decode))
 		return -EINVAL;
 
-	ctrls->slices =
-		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS);
-	if (WARN_ON(!ctrls->slices))
-		return -EINVAL;
-
 	ctrls->sps =
 		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_H264_SPS);
 	if (WARN_ON(!ctrls->sps))
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index f066de6b592d..219283a06f52 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -56,14 +56,12 @@ struct hantro_jpeg_enc_hw_ctx {
  * struct hantro_h264_dec_ctrls
  * @decode:	Decode params
  * @scaling:	Scaling info
- * @slice:	Slice params
  * @sps:	SPS info
  * @pps:	PPS info
  */
 struct hantro_h264_dec_ctrls {
 	const struct v4l2_ctrl_h264_decode_params *decode;
 	const struct v4l2_ctrl_h264_scaling_matrix *scaling;
-	const struct v4l2_ctrl_h264_slice_params *slices;
 	const struct v4l2_ctrl_h264_sps *sps;
 	const struct v4l2_ctrl_h264_pps *pps;
 };
-- 
2.27.0

