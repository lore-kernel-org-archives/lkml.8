Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314CD20758
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgIJVZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:25:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730992AbgIJOXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9E14CE66F1FAABCAC9F1;
        Thu, 10 Sep 2020 22:06:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:06:48 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/i810: make i810_flush_queue() return void
Date:   Thu, 10 Sep 2020 22:06:10 +0800
Message-ID: <20200910140610.1191578-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function always return '0' and no callers use the return value. So
make it a void function.

This eliminates the following coccicheck warning:

drivers/gpu/drm/i810/i810_dma.c:860:8-11: Unneeded variable: "ret".
Return "0" on line 885

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/i810/i810_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i810/i810_dma.c b/drivers/gpu/drm/i810/i810_dma.c
index 303c2d483c6e..88250860f8e4 100644
--- a/drivers/gpu/drm/i810/i810_dma.c
+++ b/drivers/gpu/drm/i810/i810_dma.c
@@ -853,11 +853,11 @@ static void i810_dma_quiescent(struct drm_device *dev)
 	i810_wait_ring(dev, dev_priv->ring.Size - 8);
 }
 
-static int i810_flush_queue(struct drm_device *dev)
+static void i810_flush_queue(struct drm_device *dev)
 {
 	drm_i810_private_t *dev_priv = dev->dev_private;
 	struct drm_device_dma *dma = dev->dma;
-	int i, ret = 0;
+	int i;
 	RING_LOCALS;
 
 	i810_kernel_lost_context(dev);
@@ -882,7 +882,7 @@ static int i810_flush_queue(struct drm_device *dev)
 			DRM_DEBUG("still on client\n");
 	}
 
-	return ret;
+	return;
 }
 
 /* Must be called with the lock held */
-- 
2.25.4

