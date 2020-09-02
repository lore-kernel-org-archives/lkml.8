Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756ECC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F6B20639
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063528;
	bh=20rwtaupDb1aKHEooDzQl/rU/dgCpdJe5nG7WDKkIQo=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=NavKaL4fxXO6WwexnblnQFxbQz18voD2IVYaQAj+byFFXMdlfvtFKzkEjoxMtvq20
	 NzDFKN0S48Lj2sWXnPEpSmai743ortuqFiPAO7h/h5+jGi5XkpnM/oTLf3JVOOYUI8
	 SB36K/n50xO0r1uyNrd4ffoxz1cqibeaalxW3pQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgIBQSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgIBQKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:10:47 -0400
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B2C20BED;
        Wed,  2 Sep 2020 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063046;
        bh=20rwtaupDb1aKHEooDzQl/rU/dgCpdJe5nG7WDKkIQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7Ydg7tr6cIAabckT8QZ+dQywwCWAHNr54q6yEDZ0ogV5DvrWeCuEL/fTKSPZNE7l
         dvQddlUG516QXmMdSznl9IbkJAB9a+D3AlMk8bpcJ+Lkg0qYDNg6YNbbZd3UpOJgxz
         FdqXwEsrpFrojPjmeXXodDfrFizyaFHu8ZeuD084=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kDVLP-000tAD-Vy; Wed, 02 Sep 2020 18:10:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/38] media: vivid: move the create queues to a separate function
Date:   Wed,  2 Sep 2020 18:10:16 +0200
Message-Id: <42219ecf5014d677d6fb65ae70086b7ae3b36931.1599062230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599062230.git.mchehab+huawei@kernel.org>
References: <cover.1599062230.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of placing everything inside vivid_create_instance(),
we can move the part which creates per-type video queues
into a separate function.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vivid/vivid-core.c | 175 +++++++++---------
 1 file changed, 92 insertions(+), 83 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 3340b61e68c0..69cc8456a323 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -1218,6 +1218,93 @@ static int vivid_init_dv_timings(struct vivid_dev *dev)
 	return 0;
 }
 
+static int vivid_create_queues(struct vivid_dev *dev)
+{
+	int ret;
+
+	/* start creating the vb2 queues */
+	if (dev->has_vid_cap) {
+		/* initialize vid_cap queue */
+		ret = vivid_create_queue(dev, &dev->vb_vid_cap_q,
+					 V4L2_BUF_TYPE_VIDEO_CAPTURE, 2,
+					 &vivid_vid_cap_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_vid_out) {
+		/* initialize vid_out queue */
+		ret = vivid_create_queue(dev, &dev->vb_vid_out_q,
+					 V4L2_BUF_TYPE_VIDEO_OUTPUT, 2,
+					 &vivid_vid_out_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_vbi_cap) {
+		/* initialize vbi_cap queue */
+		ret = vivid_create_queue(dev, &dev->vb_vbi_cap_q,
+					 V4L2_BUF_TYPE_VBI_CAPTURE, 2,
+					 &vivid_vbi_cap_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_vbi_out) {
+		/* initialize vbi_out queue */
+		ret = vivid_create_queue(dev, &dev->vb_vbi_out_q,
+					 V4L2_BUF_TYPE_VBI_OUTPUT, 2,
+					 &vivid_vbi_out_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_sdr_cap) {
+		/* initialize sdr_cap queue */
+		ret = vivid_create_queue(dev, &dev->vb_sdr_cap_q,
+					 V4L2_BUF_TYPE_SDR_CAPTURE, 8,
+					 &vivid_sdr_cap_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_meta_cap) {
+		/* initialize meta_cap queue */
+		ret = vivid_create_queue(dev, &dev->vb_meta_cap_q,
+					 V4L2_BUF_TYPE_META_CAPTURE, 2,
+					 &vivid_meta_cap_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_meta_out) {
+		/* initialize meta_out queue */
+		ret = vivid_create_queue(dev, &dev->vb_meta_out_q,
+					 V4L2_BUF_TYPE_META_OUTPUT, 1,
+					 &vivid_meta_out_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_touch_cap) {
+		/* initialize touch_cap queue */
+		ret = vivid_create_queue(dev, &dev->vb_touch_cap_q,
+					 V4L2_BUF_TYPE_VIDEO_CAPTURE, 1,
+					 &vivid_touch_cap_qops);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->has_fb) {
+		/* Create framebuffer for testing capture/output overlay */
+		ret = vivid_fb_init(dev);
+		if (ret)
+			return ret;
+		v4l2_info(&dev->v4l2_dev, "Framebuffer device registered as fb%d\n",
+			  dev->fb_info.node);
+	}
+	return 0;
+}
 
 static int vivid_create_instance(struct platform_device *pdev, int inst)
 {
@@ -1399,8 +1486,8 @@ static int vivid_create_instance(struct platform_device *pdev, int inst)
 	 * Same as create_singlethread_workqueue, but now I can use the
 	 * string formatting of alloc_ordered_workqueue.
 	 */
-	dev->cec_workqueue =
-		alloc_ordered_workqueue("vivid-%03d-cec", WQ_MEM_RECLAIM, inst);
+	dev->cec_workqueue = alloc_ordered_workqueue("vivid-%03d-cec",
+						     WQ_MEM_RECLAIM, inst);
 	if (!dev->cec_workqueue) {
 		ret = -ENOMEM;
 		goto unreg_dev;
@@ -1409,87 +1496,9 @@ static int vivid_create_instance(struct platform_device *pdev, int inst)
 	if (allocators[inst] == 1)
 		dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 
-	/* start creating the vb2 queues */
-	if (dev->has_vid_cap) {
-		/* initialize vid_cap queue */
-		ret = vivid_create_queue(dev, &dev->vb_vid_cap_q,
-					 V4L2_BUF_TYPE_VIDEO_CAPTURE, 2,
-					 &vivid_vid_cap_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_vid_out) {
-		/* initialize vid_out queue */
-		ret = vivid_create_queue(dev, &dev->vb_vid_out_q,
-					 V4L2_BUF_TYPE_VIDEO_OUTPUT, 2,
-					 &vivid_vid_out_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_vbi_cap) {
-		/* initialize vbi_cap queue */
-		ret = vivid_create_queue(dev, &dev->vb_vbi_cap_q,
-					 V4L2_BUF_TYPE_VBI_CAPTURE, 2,
-					 &vivid_vbi_cap_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_vbi_out) {
-		/* initialize vbi_out queue */
-		ret = vivid_create_queue(dev, &dev->vb_vbi_out_q,
-					 V4L2_BUF_TYPE_VBI_OUTPUT, 2,
-					 &vivid_vbi_out_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_sdr_cap) {
-		/* initialize sdr_cap queue */
-		ret = vivid_create_queue(dev, &dev->vb_sdr_cap_q,
-					 V4L2_BUF_TYPE_SDR_CAPTURE, 8,
-					 &vivid_sdr_cap_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_meta_cap) {
-		/* initialize meta_cap queue */
-		ret = vivid_create_queue(dev, &dev->vb_meta_cap_q,
-					 V4L2_BUF_TYPE_META_CAPTURE, 2,
-					 &vivid_meta_cap_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_meta_out) {
-		/* initialize meta_out queue */
-		ret = vivid_create_queue(dev, &dev->vb_meta_out_q,
-					 V4L2_BUF_TYPE_META_OUTPUT, 1,
-					 &vivid_meta_out_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_touch_cap) {
-		/* initialize touch_cap queue */
-		ret = vivid_create_queue(dev, &dev->vb_touch_cap_q,
-					 V4L2_BUF_TYPE_VIDEO_CAPTURE, 1,
-					 &vivid_touch_cap_qops);
-		if (ret)
-			goto unreg_dev;
-	}
-
-	if (dev->has_fb) {
-		/* Create framebuffer for testing capture/output overlay */
-		ret = vivid_fb_init(dev);
-		if (ret)
-			goto unreg_dev;
-		v4l2_info(&dev->v4l2_dev, "Framebuffer device registered as fb%d\n",
-			  dev->fb_info.node);
-	}
+	ret = vivid_create_queues(dev);
+	if (ret)
+		goto unreg_dev;
 
 #ifdef CONFIG_VIDEO_VIVID_CEC
 	if (dev->has_vid_cap && in_type_counter[HDMI]) {
-- 
2.26.2

