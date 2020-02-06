Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C0C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA2320658
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgBFWHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:07:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45040 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBFWHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:07:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id DA470295903
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, hverkuil@xs4all.nl,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH] media: staging: rkisp1: rsz: don't ignore set format in bayer mainpath
Date:   Thu,  6 Feb 2020 19:07:10 -0300
Message-Id: <20200206220712.1243438-3-helen.koike@collabora.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200206220712.1243438-1-helen.koike@collabora.com>
References: <20200206220712.1243438-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issue when, in case of raw bayer format in mainpath,
VIDIOC_SUBDEV_S_FMT ioctl didn't have any effect, is wasn't updating the
format of the pad.

There is no crop for mainpath bayer raw data. Remove leftover check in
set_format, since check is already done in crop rkisp1_rsz_set_sink_crop()
function.

Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-resizer.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-resizer.c b/drivers/staging/media/rkisp1/rkisp1-resizer.c
index 8cdc29c1a178..d986953d268b 100644
--- a/drivers/staging/media/rkisp1/rkisp1-resizer.c
+++ b/drivers/staging/media/rkisp1/rkisp1-resizer.c
@@ -537,15 +537,6 @@ static void rkisp1_rsz_set_sink_fmt(struct rkisp1_resizer *rsz,
 	if (which == V4L2_SUBDEV_FORMAT_ACTIVE)
 		rsz->fmt_type = mbus_info->fmt_type;
 
-	if (rsz->id == RKISP1_MAINPATH &&
-	    mbus_info->fmt_type == RKISP1_FMT_BAYER) {
-		sink_crop->left = 0;
-		sink_crop->top = 0;
-		sink_crop->width = sink_fmt->width;
-		sink_crop->height = sink_fmt->height;
-		return;
-	}
-
 	/* Propagete to source pad */
 	src_fmt->code = sink_fmt->code;
 
-- 
2.24.0

