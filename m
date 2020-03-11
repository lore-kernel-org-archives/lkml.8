Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0306C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9832073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgCKRr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:47:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33096 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgCKRr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:47:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 80D4C2912DA
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
Subject: [PATCH 4/6] hantro: Remove unneeded hantro_dec_buf_finish
Date:   Wed, 11 Mar 2020 14:42:58 -0300
Message-Id: <20200311174300.19407-5-ezequiel@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200311174300.19407-1-ezequiel@collabora.com>
References: <20200311174300.19407-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now .buf_prepare takes care of setting the
buffer payload size, we can get rid of this,
at least for decoders.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/hantro/hantro_drv.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index ec889d755cd6..bd204da6c669 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -80,15 +80,6 @@ hantro_enc_buf_finish(struct hantro_ctx *ctx, struct vb2_buffer *buf,
 	return 0;
 }
 
-static int
-hantro_dec_buf_finish(struct hantro_ctx *ctx, struct vb2_buffer *buf,
-		      unsigned int bytesused)
-{
-	/* For decoders set bytesused as per the output picture. */
-	buf->planes[0].bytesused = ctx->dst_fmt.plane_fmt[0].sizeimage;
-	return 0;
-}
-
 static void hantro_job_finish(struct hantro_dev *vpu,
 			      struct hantro_ctx *ctx,
 			      unsigned int bytesused,
@@ -422,7 +413,6 @@ static int hantro_open(struct file *filp)
 		ctx->buf_finish = hantro_enc_buf_finish;
 	} else if (func->id == MEDIA_ENT_F_PROC_VIDEO_DECODER) {
 		allowed_codecs = vpu->variant->codec & HANTRO_DECODERS;
-		ctx->buf_finish = hantro_dec_buf_finish;
 	} else {
 		ret = -ENODEV;
 		goto err_ctx_free;
-- 
2.25.0

