Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21059C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6757B204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHFQdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:33:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50371 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgHFQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:32:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3eWM-0002Xr-4q; Thu, 06 Aug 2020 11:57:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: fix spelling mistake "unsupport" -> "unsupported"
Date:   Thu,  6 Aug 2020 12:57:17 +0100
Message-Id: <20200806115717.59613-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in some dev_err messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index f8d616f08b51..25312903f27e 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -2588,7 +2588,7 @@ static int atomisp_g_parm(struct file *file, void *fh,
 	struct atomisp_device *isp = video_get_drvdata(vdev);
 
 	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
-		dev_err(isp->dev, "unsupport v4l2 buf type\n");
+		dev_err(isp->dev, "unsupported v4l2 buf type\n");
 		return -EINVAL;
 	}
 
@@ -2610,7 +2610,7 @@ static int atomisp_s_parm(struct file *file, void *fh,
 	int fps;
 
 	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
-		dev_err(isp->dev, "unsupport v4l2 buf type\n");
+		dev_err(isp->dev, "unsupported v4l2 buf type\n");
 		return -EINVAL;
 	}
 
@@ -2668,7 +2668,7 @@ static int atomisp_s_parm_file(struct file *file, void *fh,
 	struct atomisp_device *isp = video_get_drvdata(vdev);
 
 	if (parm->type != V4L2_BUF_TYPE_VIDEO_OUTPUT) {
-		dev_err(isp->dev, "unsupport v4l2 buf type for output\n");
+		dev_err(isp->dev, "unsupported v4l2 buf type for output\n");
 		return -EINVAL;
 	}
 
-- 
2.27.0

