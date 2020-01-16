Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCB1C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9B6206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201964;
	bh=QrGStWXLRGtV0dW5HjUA+rWs8Ry45kt+M4hNFi79nmg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JJCLzQ2U9rGgVN9IlG7Uq+euHJByVyGJfOrz5DbCZc3rtUS7aZSKO+zftmhxzCEYE
	 HOv9uPd7+JUd6rnM8l8/bssSTEdOGJBY2IrRpHnW3ZFZrE+bc8rSbJJUqot/dAjnrk
	 DmazQqVOwLv7jx1hBYRyt/or6wp7iZqhkWbutNyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgAPQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbgAPQ7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:59:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4DC20728;
        Thu, 16 Jan 2020 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193985;
        bh=QrGStWXLRGtV0dW5HjUA+rWs8Ry45kt+M4hNFi79nmg=;
        h=From:To:Cc:Subject:Date:From;
        b=Xy/mm0BNHP9Htuc7RNiB+ZzO3p+iCwHUTN6fRVkrV+oOmse717QfVXdihMvBwiG6h
         t5lK0rs0JUWGQPLAm1sJjozmSL7ZSj2WEwWT8+Uz02IY2jz8LVg/8ITbjU/1D16sx1
         U+aif0Nwi7GE8RlE85kK7VLT9sNH2OMVUlZu02Uk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 118/671] media: s5p-jpeg: Correct step and max values for V4L2_CID_JPEG_RESTART_INTERVAL
Date:   Thu, 16 Jan 2020 11:50:27 -0500
Message-Id: <20200116165940.10720-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>

[ Upstream commit 19c624c6b29e244c418f8b44a711cbf5e82e3cd4 ]

This commit corrects max and step values for v4l2 control for
V4L2_CID_JPEG_RESTART_INTERVAL. Max should be 0xffff and step should be 1.
It was found by using v4l2-compliance tool and checking result of
VIDIOC_QUERY_EXT_CTRL/QUERYMENU test.
Previously it was complaining that step was bigger than difference
between max and min.

Fixes: 15f4bc3b1f42 ("[media] s5p-jpeg: Add JPEG controls support")

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 350afaa29a62..fa7c42cf4b4e 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -2005,7 +2005,7 @@ static int s5p_jpeg_controls_create(struct s5p_jpeg_ctx *ctx)
 
 		v4l2_ctrl_new_std(&ctx->ctrl_handler, &s5p_jpeg_ctrl_ops,
 				  V4L2_CID_JPEG_RESTART_INTERVAL,
-				  0, 3, 0xffff, 0);
+				  0, 0xffff, 1, 0);
 		if (ctx->jpeg->variant->version == SJPEG_S5P)
 			mask = ~0x06; /* 422, 420 */
 	}
-- 
2.20.1

