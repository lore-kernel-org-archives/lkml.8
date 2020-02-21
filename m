Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99191C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FEF24681
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272241;
	bh=c7JCE0FUS+3bdwXpx4DK8SQXjElF8rXBOwR4c3H51RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMFi0q9jU98a2IWMgzXmLRTIxGEXTxwaNwsf7dl5R8Gg5/PMJNDR++67fF2de4oZk
	 QS65x1VWu81s1AArIw9Mxcoo7MlHqwCl/z2rmxpbBKlJMAjcrC1VUOy4rIXuRCqcC1
	 K0JFyJPh8JepI1wBGbkleeCspgPEIQw4tbE/wW1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgBUID7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbgBUID6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:03:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FAA2465D;
        Fri, 21 Feb 2020 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272238;
        bh=c7JCE0FUS+3bdwXpx4DK8SQXjElF8rXBOwR4c3H51RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOEcUhnUOVIZt3siLMsY3uR+/9p3QmNjYZKHYYRCVbSKcPbOu7TgY4Vm3yZEFikJq
         yhZUH/IgZDhaQxZWh3NqHtxpdJv9gNSKHQwqEYG1bKFFiOu2pP4U3bKUD6Qj4Ysqoj
         BEis3nzDChns7ridzjcCpRr4VkXZW/T66/uLrIKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/344] media: i2c: mt9v032: fix enum mbus codes and frame sizes
Date:   Fri, 21 Feb 2020 08:37:14 +0100
Message-Id: <20200221072352.340706566@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4b9b98cf6674c..5bd3ae82992f3 100644
--- a/drivers/media/i2c/mt9v032.c
+++ b/drivers/media/i2c/mt9v032.c
@@ -428,10 +428,12 @@ static int mt9v032_enum_mbus_code(struct v4l2_subdev *subdev,
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
 
@@ -439,7 +441,11 @@ static int mt9v032_enum_frame_size(struct v4l2_subdev *subdev,
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



