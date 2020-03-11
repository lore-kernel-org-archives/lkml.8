Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C15DC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938DE20734
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgCKRrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:47:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33080 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgCKRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:47:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id C9A522912DD
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
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 3/6] hantro: Use v4l2_m2m_buf_done_and_job_finish
Date:   Wed, 11 Mar 2020 14:42:57 -0300
Message-Id: <20200311174300.19407-4-ezequiel@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200311174300.19407-1-ezequiel@collabora.com>
References: <20200311174300.19407-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the core sort out the nuances of returning buffers
to userspace, by using the v4l2_m2m_buf_done_and_job_finish
helper.

This change also removes usage of buffer sequence fields,
which shouldn't have any meaning for stateless decoders.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/hantro/hantro_drv.c | 27 ++++++++---------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 0b1200fc0e1a..ec889d755cd6 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -94,32 +94,23 @@ static void hantro_job_finish(struct hantro_dev *vpu,
 			      unsigned int bytesused,
 			      enum vb2_buffer_state result)
 {
-	struct vb2_v4l2_buffer *src, *dst;
 	int ret;
 
 	pm_runtime_mark_last_busy(vpu->dev);
 	pm_runtime_put_autosuspend(vpu->dev);
 	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
 
-	src = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	dst = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
-	if (WARN_ON(!src))
-		return;
-	if (WARN_ON(!dst))
-		return;
-
-	src->sequence = ctx->sequence_out++;
-	dst->sequence = ctx->sequence_cap++;
-
-	ret = ctx->buf_finish(ctx, &dst->vb2_buf, bytesused);
-	if (ret)
-		result = VB2_BUF_STATE_ERROR;
+	if (ctx->buf_finish) {
+		struct vb2_v4l2_buffer *dst;
 
-	v4l2_m2m_buf_done(src, result);
-	v4l2_m2m_buf_done(dst, result);
+		dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+		ret = ctx->buf_finish(ctx, &dst->vb2_buf, bytesused);
+		if (ret)
+			result = VB2_BUF_STATE_ERROR;
+	}
 
-	v4l2_m2m_job_finish(vpu->m2m_dev, ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
+					 result);
 }
 
 void hantro_irq_done(struct hantro_dev *vpu, unsigned int bytesused,
-- 
2.25.0

