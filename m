Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0C9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CD22078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHSOiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:38:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45700 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgHSOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:38:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A4F2128CF67
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
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v4] media: rkvdec: Drop unneeded per_request driver-specific control flag
Date:   Wed, 19 Aug 2020 11:37:55 -0300
Message-Id: <20200819143755.243103-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814133634.95665-17-ezequiel@collabora.com>
References: <20200814133634.95665-17-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the drivers makes no distinction between per_request
and mandatory, as both are used in the same request validate check.

The driver only cares to know if a given control is
required to be part of a request, so only one flag is needed.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
v4:
* Drop 'mandatory' from DECODE_MODE and START_MODE.
---
 drivers/staging/media/rkvdec/rkvdec.c | 8 +-------
 drivers/staging/media/rkvdec/rkvdec.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7c5129593921..9f59dfb62d3f 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -55,35 +55,29 @@ static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
 
 static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
 	{
-		.per_request = true,
 		.mandatory = true,
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS,
 	},
 	{
-		.per_request = true,
 		.mandatory = true,
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_SPS,
 		.cfg.ops = &rkvdec_ctrl_ops,
 	},
 	{
-		.per_request = true,
 		.mandatory = true,
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_PPS,
 	},
 	{
-		.per_request = true,
 		.mandatory = true,
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX,
 	},
 	{
-		.mandatory = true,
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_DECODE_MODE,
 		.cfg.min = V4L2_MPEG_VIDEO_H264_DECODE_MODE_FRAME_BASED,
 		.cfg.max = V4L2_MPEG_VIDEO_H264_DECODE_MODE_FRAME_BASED,
 		.cfg.def = V4L2_MPEG_VIDEO_H264_DECODE_MODE_FRAME_BASED,
 	},
 	{
-		.mandatory = true,
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_START_CODE,
 		.cfg.min = V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
 		.cfg.def = V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
@@ -615,7 +609,7 @@ static int rkvdec_request_validate(struct media_request *req)
 		u32 id = ctrls->ctrls[i].cfg.id;
 		struct v4l2_ctrl *ctrl;
 
-		if (!ctrls->ctrls[i].per_request || !ctrls->ctrls[i].mandatory)
+		if (!ctrls->ctrls[i].mandatory)
 			continue;
 
 		ctrl = v4l2_ctrl_request_hdl_ctrl_find(hdl, id);
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 2fc9f46b6910..77a137cca88e 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -25,7 +25,6 @@
 struct rkvdec_ctx;
 
 struct rkvdec_ctrl_desc {
-	u32 per_request : 1;
 	u32 mandatory : 1;
 	struct v4l2_ctrl_config cfg;
 };
-- 
2.27.0

