Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFA4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15B1206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgFDSzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:55:25 -0400
Received: from mailoutvs56.siol.net ([185.57.226.247]:52722 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729141AbgFDSzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:55:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 77EC0521370;
        Thu,  4 Jun 2020 20:55:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 22HNnnPf64Hw; Thu,  4 Jun 2020 20:55:20 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2AD98521295;
        Thu,  4 Jun 2020 20:55:20 +0200 (CEST)
Received: from kista.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id D2A915211F9;
        Thu,  4 Jun 2020 20:55:17 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     paul.kocialkowski@bootlin.com, mripard@kernel.org
Cc:     mchehab@kernel.org, wens@csie.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, jonas@kwiboo.se, nicolas@ndufresne.ca,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] media: cedrus: h264: Fix frame list construction
Date:   Thu,  4 Jun 2020 20:57:45 +0200
Message-Id: <20200604185745.23568-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604185745.23568-1-jernej.skrabec@siol.net>
References: <20200604185745.23568-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current frame list construction algorithm assumes that decoded image
will be output into its own buffer. That is true for progressive content
but not for interlaced where each field is decoded separately into same
buffer.

Fix that by checking if capture buffer is listed in DPB. If it is, reuse
it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
index c87717d17ec5..4f79386315ae 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -102,7 +102,7 @@ static void cedrus_write_frame_list(struct cedrus_ctx=
 *ctx,
 	struct cedrus_dev *dev =3D ctx->dev;
 	unsigned long used_dpbs =3D 0;
 	unsigned int position;
-	unsigned int output =3D 0;
+	int output =3D -1;
 	unsigned int i;
=20
 	cap_q =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE)=
;
@@ -125,6 +125,11 @@ static void cedrus_write_frame_list(struct cedrus_ct=
x *ctx,
 		position =3D cedrus_buf->codec.h264.position;
 		used_dpbs |=3D BIT(position);
=20
+		if (run->dst->vb2_buf.timestamp =3D=3D dpb->reference_ts) {
+			output =3D position;
+			continue;
+		}
+
 		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
 			continue;
=20
@@ -132,13 +137,11 @@ static void cedrus_write_frame_list(struct cedrus_c=
tx *ctx,
 				    dpb->top_field_order_cnt,
 				    dpb->bottom_field_order_cnt,
 				    &pic_list[position]);
-
-		output =3D max(position, output);
 	}
=20
-	position =3D find_next_zero_bit(&used_dpbs, CEDRUS_H264_FRAME_NUM,
-				      output);
-	if (position >=3D CEDRUS_H264_FRAME_NUM)
+	if (output >=3D 0)
+		position =3D output;
+	else
 		position =3D find_first_zero_bit(&used_dpbs, CEDRUS_H264_FRAME_NUM);
=20
 	output_buf =3D vb2_to_cedrus_buffer(&run->dst->vb2_buf);
--=20
2.27.0

