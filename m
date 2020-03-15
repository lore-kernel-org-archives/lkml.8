Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8378C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14F2206EB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgCOJzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:55:01 -0400
Received: from mailoutvs50.siol.net ([185.57.226.241]:55161 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728159AbgCOJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:55:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 245EC521C76;
        Sun, 15 Mar 2020 10:54:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m-yTtJ4oR4UU; Sun, 15 Mar 2020 10:54:57 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D192F521D2C;
        Sun, 15 Mar 2020 10:54:57 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 16ACC521C76;
        Sun, 15 Mar 2020 10:54:55 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jernej.skrabec@siol.net,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: cedrus: h264: Fix 4K decoding on H6
Date:   Sun, 15 Mar 2020 10:54:46 +0100
Message-Id: <20200315095446.454882-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to unknown reason, H6 needs larger intraprediction buffer for 4K
videos than other SoCs. This was discovered by playing 4096x2304 video,
which is maximum what H6 VPU is supposed to support.

Fixes: 03e612e701a6 ("media: cedrus: Fix H264 4k support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
index bfb4a4820a67..54ee2aa423e2 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -610,8 +610,12 @@ static int cedrus_h264_start(struct cedrus_ctx *ctx)
 			goto err_mv_col_buf;
 		}
=20
+		/*
+		 * NOTE: Multiplying by two deviates from CedarX logic, but it
+		 * is for some unknown reason needed for H264 4K decoding on H6.
+		 */
 		ctx->codec.h264.intra_pred_buf_size =3D
-			ALIGN(ctx->src_fmt.width, 64) * 5;
+			ALIGN(ctx->src_fmt.width, 64) * 5 * 2;
 		ctx->codec.h264.intra_pred_buf =3D
 			dma_alloc_coherent(dev->dev,
 					   ctx->codec.h264.intra_pred_buf_size,
--=20
2.25.1

