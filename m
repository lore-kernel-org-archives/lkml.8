Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B56C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B82206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgEENl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729028AbgEENl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:41:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE61CC061A0F;
        Tue,  5 May 2020 06:41:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 435832A0998
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        gustavo.padovan@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v3 1/3] media: rkvdec: Fix .buf_prepare
Date:   Tue,  5 May 2020 10:41:08 -0300
Message-Id: <20200505134110.3435-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200505134110.3435-1-ezequiel@collabora.com>
References: <20200505134110.3435-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should only set the payload on .buf_prepare
if the buffer is CAPTURE type, or if an OUTPUT buffer
has a zeroed payload.

Fix it.

Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 225eeca73356..4df2a248ab96 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -456,7 +456,15 @@ static int rkvdec_buf_prepare(struct vb2_buffer *vb)
 		if (vb2_plane_size(vb, i) < sizeimage)
 			return -EINVAL;
 	}
-	vb2_set_plane_payload(vb, 0, f->fmt.pix_mp.plane_fmt[0].sizeimage);
+
+	/*
+	 * Buffer's bytesused is written by the driver for CAPTURE buffers,
+	 * or if the application passed zero bytesused on an OUTPUT buffer.
+	 */
+	if (!V4L2_TYPE_IS_OUTPUT(vq->type) ||
+	    (V4L2_TYPE_IS_OUTPUT(vq->type) && !vb2_get_plane_payload(vb, 0)))
+		vb2_set_plane_payload(vb, 0,
+				      f->fmt.pix_mp.plane_fmt[0].sizeimage);
 	return 0;
 }
 
-- 
2.26.0.rc2

