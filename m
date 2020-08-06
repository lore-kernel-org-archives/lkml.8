Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655D0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC93206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgHFRgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgHFRfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:35:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266AEC0086A3;
        Thu,  6 Aug 2020 08:19:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id CA80829959C
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
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v2 13/14] media: cedrus: h264: Properly configure reference field
Date:   Thu,  6 Aug 2020 12:13:09 -0300
Message-Id: <20200806151310.98624-14-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806151310.98624-1-ezequiel@collabora.com>
References: <20200806151310.98624-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

When interlaced H264 content is being decoded, references must indicate
which field is being referenced. Currently this was done by checking
capture buffer flags. However, that is not correct because capture
buffer may hold both fields.

Fix this by checking newly introduced flags in reference lists.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index 8e31f81358b7..91d88a96badc 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -182,7 +182,6 @@ static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
 	for (i = 0; i < num_ref; i++) {
 		const struct v4l2_h264_dpb_entry *dpb;
 		const struct cedrus_buffer *cedrus_buf;
-		const struct vb2_v4l2_buffer *ref_buf;
 		unsigned int position;
 		int buf_idx;
 		u8 dpb_idx;
@@ -197,12 +196,11 @@ static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
 		if (buf_idx < 0)
 			continue;
 
-		ref_buf = to_vb2_v4l2_buffer(cap_q->bufs[buf_idx]);
-		cedrus_buf = vb2_v4l2_to_cedrus_buffer(ref_buf);
+		cedrus_buf = vb2_to_cedrus_buffer(cap_q->bufs[buf_idx]);
 		position = cedrus_buf->codec.h264.position;
 
 		sram_array[i] |= position << 1;
-		if (ref_buf->field == V4L2_FIELD_BOTTOM)
+		if (ref_list[i].fields & V4L2_H264_DPB_BOTTOM_REF)
 			sram_array[i] |= BIT(0);
 	}
 
-- 
2.27.0

