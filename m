Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31DEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C842063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491392;
	bh=fpNrlUUTJSSi/PQgLIPLo6vQitr48svphV9IQte/vuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I7fOiFc8kYOcqe4jOCma/AWU6g26+WnuYZvpt8VtEcSvKqk1FTpJIgoMF3Iaimnw/
	 nzhIs5IPTqB2eYvyxd3g5N8BObM7nMWqdqGTL6sQfb6M8xmcCeHH0WkKHWHfhQOBuO
	 V+XnGDqmXR71/vf1uNbazW8kWz/+xGg2tSMYfYDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDJDqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgDJDqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:46:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1E721473;
        Fri, 10 Apr 2020 03:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490404;
        bh=fpNrlUUTJSSi/PQgLIPLo6vQitr48svphV9IQte/vuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1yYXVGZ30yvktbIV0HYRPY0jycocQPrHhNeVxt5Px1c0dwY34ZYUAw93D93XRYqJ
         IQwvMqQTe3zCTTTmllAPl0+s97T0zr6lmsh34W6eSTnSnHQxQevBXwYWPKw2dkqf8Q
         BqKWhvO8NNtuKblyHlWVdRx2HR/QDk/FxAMYr/24=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.6 07/68] media: staging: rkisp1: use consistent bus_info string for media_dev
Date:   Thu,  9 Apr 2020 23:45:32 -0400
Message-Id: <20200410034634.7731-7-sashal@kernel.org>
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

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit 12d3d8090bc5e8cdda2f56caed2a2a0d70009456 ]

Media device is using a slightly different bus_info string
"platform: rkisp1" (with a space) instead of "platform:rkisp1" used by
the rest of rkisp1 code.
This causes errors when using v4l2-util tools that uses the bus_info
string to identify the device.

Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkisp1/rkisp1-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-dev.c b/drivers/staging/media/rkisp1/rkisp1-dev.c
index 558126e66465c..9b47f41b36e94 100644
--- a/drivers/staging/media/rkisp1/rkisp1-dev.c
+++ b/drivers/staging/media/rkisp1/rkisp1-dev.c
@@ -502,8 +502,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 	strscpy(rkisp1->media_dev.model, RKISP1_DRIVER_NAME,
 		sizeof(rkisp1->media_dev.model));
 	rkisp1->media_dev.dev = &pdev->dev;
-	strscpy(rkisp1->media_dev.bus_info,
-		"platform: " RKISP1_DRIVER_NAME,
+	strscpy(rkisp1->media_dev.bus_info, RKISP1_BUS_INFO,
 		sizeof(rkisp1->media_dev.bus_info));
 	media_device_init(&rkisp1->media_dev);
 
-- 
2.20.1

