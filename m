Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4E924650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698428;
	bh=rHPaUk6u286XrQ+yGXZ96uDdkynwYvW284M6ai2NP80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PmQpdgCCQVFjO1r1O33/Gnjrj881AHpGWkPtyfnLObEWKG7sWUJhWA97hAt+xjpfw
	 6tnIJa+fDLQEXj4S156EycefzT+H6rGZ1CfZMebgdFS3nOP6K49jf20IQwypVlkSjl
	 J8ODRRDETGaWpp8n9dWRymPgc0uFHEZLhMqft6zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393271AbgBNQW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393018AbgBNQVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE0D246B8;
        Fri, 14 Feb 2020 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697295;
        bh=rHPaUk6u286XrQ+yGXZ96uDdkynwYvW284M6ai2NP80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOzYGCmplFPMlNJmmdYZZF8YIavGxK15Kqlmvw8ikvHbzLGmzZaFi0KYsM23bqcrn
         tmktTGGST4YNG/2UdyZ86ocw7/PD8Qj4cnOrWcNAIgu8N0NJSHNzg4mMGwKvp0+ZC9
         yxUPDsCKzTatgOHuXh0jzllTl95WXPosQkUoV2ZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 010/141] media: i2c: mt9v032: fix enum mbus codes and frame sizes
Date:   Fri, 14 Feb 2020 11:19:10 -0500
Message-Id: <20200214162122.19794-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit 1451d5ae351d938a0ab1677498c893f17b9ee21d ]

This driver supports both the mt9v032 (color) and the mt9v022 (mono)
sensors. Depending on which sensor is used, the format from the sensor is
different. The format.code inside the dev struct holds this information.
The enum mbus and enum frame sizes need to take into account both type of
sensors, not just the color one. To solve this, use the format.code in
these functions instead of the hardcoded bayer color format (which is only
used for mt9v032).

[Sakari Ailus: rewrapped commit message]

Suggested-by: Wenyou Yang <wenyou.yang@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/mt9v032.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/mt9v032.c b/drivers/media/i2c/mt9v032.c
index 58eb62f1ba214..a018a76662df7 100644
--- a/drivers/media/i2c/mt9v032.c
+++ b/drivers/media/i2c/mt9v032.c
@@ -423,10 +423,12 @@ static int mt9v032_enum_mbus_code(struct v4l2_subdev *subdev,
 				  struct v4l2_subdev_pad_config *cfg,
 				  struct v4l2_subdev_mbus_code_enum *code)
 {
+	struct mt9v032 *mt9v032 = to_mt9v032(subdev);
+
 	if (code->index > 0)
 		return -EINVAL;
 
-	code->code = MEDIA_BUS_FMT_SGRBG10_1X10;
+	code->code = mt9v032->format.code;
 	return 0;
 }
 
@@ -434,7 +436,11 @@ static int mt9v032_enum_frame_size(struct v4l2_subdev *subdev,
 				   struct v4l2_subdev_pad_config *cfg,
 				   struct v4l2_subdev_frame_size_enum *fse)
 {
-	if (fse->index >= 3 || fse->code != MEDIA_BUS_FMT_SGRBG10_1X10)
+	struct mt9v032 *mt9v032 = to_mt9v032(subdev);
+
+	if (fse->index >= 3)
+		return -EINVAL;
+	if (mt9v032->format.code != fse->code)
 		return -EINVAL;
 
 	fse->min_width = MT9V032_WINDOW_WIDTH_DEF / (1 << fse->index);
-- 
2.20.1

