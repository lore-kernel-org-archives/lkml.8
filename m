Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6D1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82492173E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678460;
	bh=05iKHycDZmcIvSow2mGu/p3lmoFOWIEpyO5G7US79J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kFGJdAwNfRXLEMnTE+xm8cEGOs/yozs8B0KSeroN/oaOz5xvnrPJqg8gswc6H8OeC
	 x4J4ok/DbUmi40Y0OnMwFVx4rRBeJUy/+BMpoh8QB1RuxY3wTBHCpAidZZR1GmnMLn
	 hWUmjMiVSmLCQ4UjXZ384vgl50oq31sDdVVW5Jvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgHQPeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbgHQP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:29:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6281723D3C;
        Mon, 17 Aug 2020 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678195;
        bh=05iKHycDZmcIvSow2mGu/p3lmoFOWIEpyO5G7US79J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9ugcQn2mEY1TyCvBZaYUjNFo+G+l1Vh0vzgJEEcecRB/1z6haF2qa6RZ8rYeJUC3
         T7cTuySIij8RVz0iHpKGHitRzBpqgabbR8kjhrN0fsH0+FZ/e/OIVXSe1FPfgJg7ij
         q5jS2OPQRXh4MlQ18ysVl6Br/JBvjbgcDCKa85IA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 249/464] media: s5p-g2d: Fix a memory leak in an error handling path in g2d_probe()
Date:   Mon, 17 Aug 2020 17:13:22 +0200
Message-Id: <20200817143845.723289831@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 94b9ce6870f9c90ac92505482689818b254312f7 ]

Memory allocated with 'v4l2_m2m_init()' must be freed by a corresponding
call to 'v4l2_m2m_release()'

Also reorder the code at the end of the probe function so that
'video_register_device()' is called last.
Update the error handling path accordingly.

Fixes: 5ce60d790a24 ("[media] s5p-g2d: Add DT based discovery support")
Fixes: 918847341af0 ("[media] v4l: add G2D driver for s5p device family")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil-cisco@xs4all.nl: checkpatch: align with parenthesis]
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s5p-g2d/g2d.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index 6932fd47071b0..15bcb7f6e113c 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -695,21 +695,13 @@ static int g2d_probe(struct platform_device *pdev)
 	vfd->lock = &dev->mutex;
 	vfd->v4l2_dev = &dev->v4l2_dev;
 	vfd->device_caps = V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING;
-	ret = video_register_device(vfd, VFL_TYPE_VIDEO, 0);
-	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
-		goto rel_vdev;
-	}
-	video_set_drvdata(vfd, dev);
-	dev->vfd = vfd;
-	v4l2_info(&dev->v4l2_dev, "device registered as /dev/video%d\n",
-								vfd->num);
+
 	platform_set_drvdata(pdev, dev);
 	dev->m2m_dev = v4l2_m2m_init(&g2d_m2m_ops);
 	if (IS_ERR(dev->m2m_dev)) {
 		v4l2_err(&dev->v4l2_dev, "Failed to init mem2mem device\n");
 		ret = PTR_ERR(dev->m2m_dev);
-		goto unreg_video_dev;
+		goto rel_vdev;
 	}
 
 	def_frame.stride = (def_frame.width * def_frame.fmt->depth) >> 3;
@@ -717,14 +709,24 @@ static int g2d_probe(struct platform_device *pdev)
 	of_id = of_match_node(exynos_g2d_match, pdev->dev.of_node);
 	if (!of_id) {
 		ret = -ENODEV;
-		goto unreg_video_dev;
+		goto free_m2m;
 	}
 	dev->variant = (struct g2d_variant *)of_id->data;
 
+	ret = video_register_device(vfd, VFL_TYPE_VIDEO, 0);
+	if (ret) {
+		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
+		goto free_m2m;
+	}
+	video_set_drvdata(vfd, dev);
+	dev->vfd = vfd;
+	v4l2_info(&dev->v4l2_dev, "device registered as /dev/video%d\n",
+		  vfd->num);
+
 	return 0;
 
-unreg_video_dev:
-	video_unregister_device(dev->vfd);
+free_m2m:
+	v4l2_m2m_release(dev->m2m_dev);
 rel_vdev:
 	video_device_release(vfd);
 unreg_v4l2_dev:
-- 
2.25.1



