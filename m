Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B4F206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgHFRgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgHFRfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:35:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB1C0086A1;
        Thu,  6 Aug 2020 08:18:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A216129959B
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
Subject: [PATCH v2 08/14] media: uapi: h264: Drop SLICE_PARAMS 'size' field
Date:   Thu,  6 Aug 2020 12:13:04 -0300
Message-Id: <20200806151310.98624-9-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806151310.98624-1-ezequiel@collabora.com>
References: <20200806151310.98624-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SLICE_PARAMS control is intended for slice-based
devices. In this mode, the OUTPUT buffer contains
a single slice, and so the buffer's plane payload size
can be used to query the slice size.

To reduce the API surface drop the size from the
SLICE_PARAMS control.

A follow-up change will remove other members in SLICE_PARAMS
so we don't need to add padding fields here.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 3 ---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c          | 7 +++----
 include/media/h264-ctrls.h                                | 3 ---
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 427fc5727ec0..fff74b7bf32a 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1760,9 +1760,6 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
     :stub-columns: 0
     :widths:       1 1 2
 
-    * - __u32
-      - ``size``
-      -
     * - __u32
       - ``start_byte_offset``
         Offset (in bytes) from the beginning of the OUTPUT buffer to the start
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index a9ba78b15907..8b6f05aadbe8 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -324,17 +324,16 @@ static void cedrus_set_params(struct cedrus_ctx *ctx,
 	struct vb2_buffer *src_buf = &run->src->vb2_buf;
 	struct cedrus_dev *dev = ctx->dev;
 	dma_addr_t src_buf_addr;
-	u32 len = slice->size * 8;
+	size_t slice_bytes = vb2_get_plane_payload(src_buf, 0);
 	unsigned int pic_width_in_mbs;
 	bool mbaff_pic;
 	u32 reg;
 
-	cedrus_write(dev, VE_H264_VLD_LEN, len);
+	cedrus_write(dev, VE_H264_VLD_LEN, slice_bytes * 8);
 	cedrus_write(dev, VE_H264_VLD_OFFSET, 0);
 
 	src_buf_addr = vb2_dma_contig_plane_dma_addr(src_buf, 0);
-	cedrus_write(dev, VE_H264_VLD_END,
-		     src_buf_addr + vb2_get_plane_payload(src_buf, 0));
+	cedrus_write(dev, VE_H264_VLD_END, src_buf_addr + slice_bytes);
 	cedrus_write(dev, VE_H264_VLD_ADDR,
 		     VE_H264_VLD_ADDR_VAL(src_buf_addr) |
 		     VE_H264_VLD_ADDR_FIRST | VE_H264_VLD_ADDR_VALID |
diff --git a/include/media/h264-ctrls.h b/include/media/h264-ctrls.h
index 4f05ee265997..f74736fcfa00 100644
--- a/include/media/h264-ctrls.h
+++ b/include/media/h264-ctrls.h
@@ -158,9 +158,6 @@ struct v4l2_h264_reference {
 };
 
 struct v4l2_ctrl_h264_slice_params {
-	/* Size in bytes, including header */
-	__u32 size;
-
 	/* Offset in bytes to the start of slice in the OUTPUT buffer. */
 	__u32 start_byte_offset;
 
-- 
2.27.0

