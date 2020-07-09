Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA07BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4833207FB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGIQhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:37:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60292 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:37:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 3C1B626D012
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 1/2] rkvdec: h264: Refuse to decode unsupported bitstream
Date:   Thu,  9 Jul 2020 13:36:34 -0300
Message-Id: <20200709163635.42996-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709163635.42996-1-ezequiel@collabora.com>
References: <20200709163635.42996-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware only supports 4:2:2, 4:2:0 or 4:0:0 (monochrome),
8-bit or 10-bit depth content.

Verify that the SPS refers to a supported bitstream, and refuse
unsupported bitstreams by failing at TRY_EXT_CTRLS time.

The driver is currently broken on 10-bit and 4:2:2
so disallow those as well.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/staging/media/rkvdec/rkvdec.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 225eeca73356..accb4a902fdd 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -27,6 +27,32 @@
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
 
+static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
+{
+	if (ctrl->id == V4L2_CID_MPEG_VIDEO_H264_SPS) {
+		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
+		/*
+		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
+		 * but it's currently broken in the driver.
+		 * Reject them for now, until it's fixed.
+		 */
+		if (sps->chroma_format_idc > 1)
+			/* Only 4:0:0 and 4:2:0 are supported */
+			return -EINVAL;
+		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
+			/* Luma and chroma bit depth mismatch */
+			return -EINVAL;
+		if (sps->bit_depth_luma_minus8 != 0)
+			/* Only 8-bit is supported */
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
+	.try_ctrl = rkvdec_try_ctrl,
+};
+
 static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
 	{
 		.per_request = true,
@@ -42,6 +68,7 @@ static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
 		.per_request = true,
 		.mandatory = true,
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_SPS,
+		.cfg.ops = &rkvdec_ctrl_ops,
 	},
 	{
 		.per_request = true,
-- 
2.27.0

