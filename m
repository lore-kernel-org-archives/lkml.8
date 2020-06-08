Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E401CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF8F20774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657683;
	bh=3YAXEK4s/GPg8WqzWmTln3TcNkCmuYxwrw8nQ+1yss8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6VIP1F6HFfWt7O/RooQr7rl3aS/gaGWmKOBoiib+gMrOZVc2SCGcMUC/xD5yza/o
	 nBISFf5nNGSAUg3jOnMuo46DE4f8Iu8C3B8FM+qmAqq1D4QbrjPpq3R3GOfiGwueYh
	 +FJ6P3TcvCoDceyB8/dp0egpxeV5vj1uRyoJhsRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgFHXID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgFHXHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7592087E;
        Mon,  8 Jun 2020 23:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657635;
        bh=3YAXEK4s/GPg8WqzWmTln3TcNkCmuYxwrw8nQ+1yss8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0M7iczwC3xP1ohFOKS+sb3j8fD4sIcxZe3gd9Y0jx0Xa/0+azREVde1sB8M/mlA5z
         /p5x8Fx26+my98Oqq4qyXLMJd5Esr9UaN7jJ9/ewkted4U/0+ADDFULD6vnZBXxfM5
         Fa+IjrL/49VPuJND3+ksyeXiGTV4WkQl6oX+b4OE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 053/274] media: i2c: imx219: Fix a bug in imx219_enum_frame_size
Date:   Mon,  8 Jun 2020 19:02:26 -0400
Message-Id: <20200608230607.3361041-53-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

[ Upstream commit b2bbf1aac61186ef904fd28079e847d3feadb89e ]

When enumerating the frame sizes, the value sent to
imx219_get_format_code should be fse->code
(the code from the ioctl) and not imx219->fmt.code
which is the code set currently in the driver.

Fixes: 22da1d56e982 ("media: i2c: imx219: Add support for RAW8 bit bayer format")
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Reviewed-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index cb03bdec1f9c..86e0564bfb4f 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -781,7 +781,7 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
 	if (fse->index >= ARRAY_SIZE(supported_modes))
 		return -EINVAL;
 
-	if (fse->code != imx219_get_format_code(imx219, imx219->fmt.code))
+	if (fse->code != imx219_get_format_code(imx219, fse->code))
 		return -EINVAL;
 
 	fse->min_width = supported_modes[fse->index].width;
-- 
2.25.1

