Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE161C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAAD20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490409;
	bh=gRsQNMLbwAKVeC0Gb+JWu5Kd2OwoKKeUa99fqZnlHeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=thD6yMR0nvx9KxW6rY5F4smWUA2QwwSQfAfVi9dvV5WnQpnMKVTKWt690w0t6hXxK
	 HbCcPd2mjG+fA/5F/6J3aaC1o1l1mXG9l/Ow+CW4y9gIyELpFoLZ9Puk1T0PPCGv76
	 NqkRyPadhO+2Yoaxss5nyINvwGrw177ElwsPK9O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgDJDqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgDJDqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:46:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDD32137B;
        Fri, 10 Apr 2020 03:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490402;
        bh=gRsQNMLbwAKVeC0Gb+JWu5Kd2OwoKKeUa99fqZnlHeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzqkF1Ojt7Ydep5NN2mSLv4BRslgpa0JSg5GqjKpBG2hQG3Ixs7OpquD0Yz0/oDUS
         CnNsDVeB7+KPzL8Zgww0VgYEYLFn0HO+ljBeJVokie2vZi9soLD2dWIiO1IZqLqjmt
         MZu1wzAPV03AFZGS8TZ/lPDpWIUr6j8PZdMx5buA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.6 06/68] media: hantro: fix extra MV/MC sync space calculation
Date:   Thu,  9 Apr 2020 23:45:31 -0400
Message-Id: <20200410034634.7731-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit 042584e9055b615ac917239884fb0d65690f56ec ]

Add space for MVs and MC sync data to the capture buffers depending on
whether the post processor will be enabled for the new capture format
passed to TRY_FMT, not the currently set capture format.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/hantro/hantro_v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index 0198bcda26b75..f4ae2cee0f189 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -295,7 +295,7 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f,
 		 * +---------------------------+
 		 */
 		if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE &&
-		    !hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
+		    !hantro_needs_postproc(ctx, fmt))
 			pix_mp->plane_fmt[0].sizeimage +=
 				64 * MB_WIDTH(pix_mp->width) *
 				     MB_WIDTH(pix_mp->height) + 32;
-- 
2.20.1

