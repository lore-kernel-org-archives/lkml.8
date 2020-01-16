Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A00C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724FB21582
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193598;
	bh=Tnd+SAke6nIVxhIP5axtAjn7GdI/o/v7fMl1nJaRVNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lTpdCqq6Idl7m4q92uhlGOSi63Z7beEcy1Bt7LWcEu1Vro0G8YZ6RwRYg41FoYDa5
	 UGre64OTLj6Aeht2S3218NtYxLXnUQW6CqKt+1v8VaMBcSyVwoud7RXVy4mNsVZ627
	 lVnceyAEkrFqMJVNeQZkqxhAwMf7uvMFoqzqpNRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgAPQxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730639AbgAPQxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 332462073A;
        Thu, 16 Jan 2020 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193584;
        bh=Tnd+SAke6nIVxhIP5axtAjn7GdI/o/v7fMl1nJaRVNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgcd8RxBJumX0/yNtan2KKToa+Lrfl/tOOjQYGWHifF89aakOk49IPTxeFH26ywZw
         02jZjsYiA/gFwk1/DqCmPOU5oq7iC0fzlmzgUb+Z1jScL1p8DYqRne8BxfwW5jUFrz
         I0q9tWpXx4KD4QoRxzhZzv3311/GStToFFHveLCE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 125/205] media: hantro: Set H264 FIELDPIC_FLAG_E flag correctly
Date:   Thu, 16 Jan 2020 11:41:40 -0500
Message-Id: <20200116164300.6705-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit a2cbf80a842add9663522bf898cf13cb2ac4e423 ]

The FIELDPIC_FLAG_E bit should be set when field_pic_flag exists in stream,
it is currently set based on field_pic_flag of current frame.
The PIC_FIELDMODE_E bit is correctly set based on the field_pic_flag.

Fix this by setting the FIELDPIC_FLAG_E bit when frame_mbs_only is not set.

Fixes: dea0a82f3d22 ("media: hantro: Add support for H264 decoding on G1")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/hantro/hantro_g1_h264_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_g1_h264_dec.c b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
index 636bf972adcf..5f29b7a836db 100644
--- a/drivers/staging/media/hantro/hantro_g1_h264_dec.c
+++ b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
@@ -63,7 +63,7 @@ static void set_params(struct hantro_ctx *ctx)
 	/* always use the matrix sent from userspace */
 	reg |= G1_REG_DEC_CTRL2_TYPE1_QUANT_E;
 
-	if (slices[0].flags &  V4L2_H264_SLICE_FLAG_FIELD_PIC)
+	if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
 		reg |= G1_REG_DEC_CTRL2_FIELDPIC_FLAG_E;
 	vdpu_write_relaxed(vpu, reg, G1_REG_DEC_CTRL2);
 
-- 
2.20.1

