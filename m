Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFB0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2582077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="oaG7DDBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgGAV43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:56:29 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:34977 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgGAV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=0xiHf/EPZS5KgOKxBp5LHqsgCsml5CTBxgkvCAuLp0U=;
        b=oaG7DDBWFUen/TUOc2nAiCwWpMf8GuDu15AOQELNHqPfGJvAQ+r8w/QA4l9jz4XImGrp
        YNvZYD0efFzRznaSuFihDOLKHCDOa/W4vbM8HUYL46WZpshFTwKTTdMAdNYNhEkPmrNuAP
        Dw5Cz3YDsJB7PFJWMJmHupna+ZdRtSTmQ=
Received: by filterdrecv-p3iad2-5b55dcd864-9xqm9 with SMTP id filterdrecv-p3iad2-5b55dcd864-9xqm9-19-5EFD0688-4F
        2020-07-01 21:56:24.670333231 +0000 UTC m=+449223.629418375
Received: from bionic.localdomain (unknown)
        by ismtpd0001p1lon1.sendgrid.net (SG) with ESMTP
        id aLw37pONTYiTg-ztRd6k0A
        Wed, 01 Jul 2020 21:56:24.414 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 9/9] media: rkvdec: h264: Support High 10 and 4:2:2 profiles
Date:   Wed, 01 Jul 2020 21:56:24 +0000 (UTC)
Message-Id: <20200701215616.30874-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701215616.30874-1-jonas@kwiboo.se>
References: <20200701215616.30874-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+yXA2aL4Ygs2+xxa?=
 =?us-ascii?Q?Jfoz7k0HLEGmlntHCMwC87Wd0lzFUTskV+GHcHa?=
 =?us-ascii?Q?O8naz4a40=2FWQZcqYNRGJahFMyagv4RaeaNPUy5e?=
 =?us-ascii?Q?HCJukIVxBa1lX95eq20LvOtjjYn6HnU6j8UKg9k?=
 =?us-ascii?Q?1sj8CV1ZjfhGiBC6tA=2FpsLDOY4TUMgZ=2FdwFCbAI?=
 =?us-ascii?Q?Tr2nkN7xTAeaGX6NlQgmQ=3D=3D?=
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support and enable decoding of H264 High 10 and 4:2:2 profiles.

H264 frmsize step_width/height is changed to 64 pixels in order to ensure
proper align for 10-bit formats. Incompatible pixelformats gets rejected in
s_fmt/try_fmt ioctl call.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 31 ++++++++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec.c      | 24 ++++++++---------
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 1cb6af590138..73767e5c752f 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1022,6 +1022,36 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
 	return 0;
 }
 
+static int rkvdec_h264_validate_fmt(struct rkvdec_ctx *ctx, u32 pixelformat)
+{
+	struct v4l2_ctrl *ctrl;
+	const struct v4l2_ctrl_h264_sps *sps;
+	u32 valid_format = 0;
+
+	ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl,
+			      V4L2_CID_MPEG_VIDEO_H264_SPS);
+	sps = ctrl ? ctrl->p_cur.p : NULL;
+	if (!sps)
+		return 0;
+
+	if (sps->bit_depth_luma_minus8 == 0) {
+		if (sps->chroma_format_idc == 2)
+			valid_format = V4L2_PIX_FMT_NV16;
+		else
+			valid_format = V4L2_PIX_FMT_NV12;
+	} else if (sps->bit_depth_luma_minus8 == 2) {
+		if (sps->chroma_format_idc == 2)
+			valid_format = V4L2_PIX_FMT_NV20;
+		else
+			valid_format = V4L2_PIX_FMT_NV15;
+	}
+
+	if (valid_format == pixelformat)
+		return 0;
+
+	return -EINVAL;
+}
+
 static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
 {
 	struct rkvdec_dev *rkvdec = ctx->dev;
@@ -1163,6 +1193,7 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 
 const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
 	.adjust_fmt = rkvdec_h264_adjust_fmt,
+	.validate_fmt = rkvdec_h264_validate_fmt,
 	.start = rkvdec_h264_start,
 	.stop = rkvdec_h264_stop,
 	.run = rkvdec_h264_run,
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 465444c58f13..8d88fa8c4d4e 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -31,19 +31,14 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	if (ctrl->id == V4L2_CID_MPEG_VIDEO_H264_SPS) {
 		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_cur.p;
-		/*
-		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
-		 * but it's currently broken in the driver.
-		 * Reject them for now, until it's fixed.
-		 */
-		if (sps->chroma_format_idc > 1)
-			/* Only 4:0:0 and 4:2:0 are supported */
+		if (sps->chroma_format_idc > 2)
+			/* Only 4:0:0, 4:2:0 and 4:2:2 are supported */
 			return -EINVAL;
 		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
 			/* Luma and chroma bit depth mismatch */
 			return -EINVAL;
-		if (sps->bit_depth_luma_minus8 != 0)
-			/* Only 8-bit is supported */
+		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
+			/* Only 8-bit and 10-bit is supported */
 			return -EINVAL;
 	}
 	return 0;
@@ -97,7 +92,7 @@ static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
 	{
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
 		.cfg.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
-		.cfg.max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+		.cfg.max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422,
 		.cfg.menu_skip_mask =
 			BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
 		.cfg.def = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
@@ -116,16 +111,19 @@ static const struct rkvdec_ctrls rkvdec_h264_ctrls = {
 
 static const u32 rkvdec_h264_decoded_fmts[] = {
 	V4L2_PIX_FMT_NV12,
+	V4L2_PIX_FMT_NV15,
+	V4L2_PIX_FMT_NV16,
+	V4L2_PIX_FMT_NV20,
 };
 
 static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_H264_SLICE,
 		.frmsize = {
-			.min_width = 48,
+			.min_width = 64,
 			.max_width = 4096,
-			.step_width = 16,
-			.min_height = 48,
+			.step_width = 64,
+			.min_height = 64,
 			.max_height = 2304,
 			.step_height = 16,
 		},
-- 
2.17.1

