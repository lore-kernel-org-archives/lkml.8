Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C34C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352682070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCYVfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:35:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39854 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgCYVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:35:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 097D0293EA8
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v3 2/7] hantro: Set buffers' zeroth plane payload in .buf_prepare
Date:   Wed, 25 Mar 2020 18:34:33 -0300
Message-Id: <20200325213439.16509-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200325213439.16509-1-ezequiel@collabora.com>
References: <20200325213439.16509-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffers' zeroth plane payload size is calculated at format
negotiation time, and so it can be set in .buf_prepare.

Keep in mind that, to make this change easier, hantro_buf_prepare
is refactored, using the cedrus driver as reference. This results
in cleaner code as byproduct.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/hantro/hantro_v4l2.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index f4ae2cee0f18..3142ab6697d5 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -608,7 +608,7 @@ hantro_queue_setup(struct vb2_queue *vq, unsigned int *num_buffers,
 }
 
 static int
-hantro_buf_plane_check(struct vb2_buffer *vb, const struct hantro_fmt *vpu_fmt,
+hantro_buf_plane_check(struct vb2_buffer *vb,
 		       struct v4l2_pix_format_mplane *pixfmt)
 {
 	unsigned int sz;
@@ -630,12 +630,18 @@ static int hantro_buf_prepare(struct vb2_buffer *vb)
 {
 	struct vb2_queue *vq = vb->vb2_queue;
 	struct hantro_ctx *ctx = vb2_get_drv_priv(vq);
+	struct v4l2_pix_format_mplane *pix_fmt;
+	int ret;
 
 	if (V4L2_TYPE_IS_OUTPUT(vq->type))
-		return hantro_buf_plane_check(vb, ctx->vpu_src_fmt,
-						  &ctx->src_fmt);
-
-	return hantro_buf_plane_check(vb, ctx->vpu_dst_fmt, &ctx->dst_fmt);
+		pix_fmt = &ctx->src_fmt;
+	else
+		pix_fmt = &ctx->dst_fmt;
+	ret = hantro_buf_plane_check(vb, pix_fmt);
+	if (ret)
+		return ret;
+	vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
+	return 0;
 }
 
 static void hantro_buf_queue(struct vb2_buffer *vb)
-- 
2.26.0.rc2

