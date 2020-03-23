Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC78C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE702072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgCWNIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:08:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35786 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgCWNIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:08:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id DA357290580
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        kernel@pengutronix.de, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/2] media: coda: be more flexible wrt jpeg dimensions
Date:   Mon, 23 Mar 2020 15:09:37 +0200
Message-Id: <20200323130937.3666244-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323130937.3666244-1-adrian.ratiu@collabora.com>
References: <20200323130937.3666244-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't require jpeg dimensions to exactly match format dimensions,
so we are able to decode and display a wider range jpegs instead
of outright rejecting the ones which don't match.

This is useful in applications which pass jpegs with arbitrary
dimensions, where buffers can be reused to decode smaller jpegs
without having to do expensive renegotiations.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 drivers/media/platform/coda/coda-jpeg.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/platform/coda/coda-jpeg.c b/drivers/media/platform/coda/coda-jpeg.c
index 162ba28a6b95..782a78dcaf4d 100644
--- a/drivers/media/platform/coda/coda-jpeg.c
+++ b/drivers/media/platform/coda/coda-jpeg.c
@@ -302,13 +302,6 @@ int coda_jpeg_decode_header(struct coda_ctx *ctx, struct vb2_buffer *vb)
 	}
 
 	q_data_src = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
-	if (header.frame.height != q_data_src->height ||
-	    header.frame.width != q_data_src->width) {
-		v4l2_err(&dev->v4l2_dev,
-			 "dimensions don't match format: %dx%d\n",
-			 header.frame.width, header.frame.height);
-		return -EINVAL;
-	}
 
 	if (header.frame.num_components != 3) {
 		v4l2_err(&dev->v4l2_dev,
-- 
2.25.2

