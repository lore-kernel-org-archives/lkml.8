Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F66C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A102073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgGVBGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 21:06:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgGVBGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:06:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 86ACFD3762CF24A44D79;
        Wed, 22 Jul 2020 09:06:49 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 09:06:42 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
Subject: [PATCH -next] gpu: drm: Fix spinlock vblank_time_lock use error.
Date:   Wed, 22 Jul 2020 01:05:27 +0000
Message-ID: <20200722010527.52293-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_handle_vblank function is in the interrupt context.
Therefore, the spin lock vblank_time_lock is obtained
from the interrupt context.

Cc: <stable@vger.kernel.org>
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 drivers/gpu/drm/drm_vblank.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f402c75b9d34..4ca63ff33a43 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -229,10 +229,11 @@ static void drm_reset_vblank_timestamp(struct drm_device *dev, unsigned int pipe
 {
 	u32 cur_vblank;
 	bool rc;
+	unsigned long irqflags;
 	ktime_t t_vblank;
 	int count = DRM_TIMESTAMP_MAXRETRIES;
 
-	spin_lock(&dev->vblank_time_lock);
+	spin_lock_irqsave(&dev->vblank_time_lock, irqflags);
 
 	/*
 	 * sample the current counter to avoid random jumps
@@ -257,7 +258,7 @@ static void drm_reset_vblank_timestamp(struct drm_device *dev, unsigned int pipe
 	 */
 	store_vblank(dev, pipe, 1, t_vblank, cur_vblank);
 
-	spin_unlock(&dev->vblank_time_lock);
+	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags);
 }
 
 /*
@@ -1106,11 +1107,12 @@ static int __enable_vblank(struct drm_device *dev, unsigned int pipe)
 static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
+	unsigned long irqflags;
 	int ret = 0;
 
 	assert_spin_locked(&dev->vbl_lock);
 
-	spin_lock(&dev->vblank_time_lock);
+	spin_lock_irqsave(&dev->vblank_time_lock, irqflags);
 
 	if (!vblank->enabled) {
 		/*
@@ -1136,7 +1138,7 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 		}
 	}
 
-	spin_unlock(&dev->vblank_time_lock);
+	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags);
 
 	return ret;
 }
@@ -1917,6 +1919,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	unsigned long irqflags;
+	unsigned long irqflags_vblank;
 	bool disable_irq;
 
 	if (drm_WARN_ON_ONCE(dev, !drm_dev_has_vblank(dev)))
@@ -1931,18 +1934,18 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	 * vblank enable/disable, as this would cause inconsistent
 	 * or corrupted timestamps and vblank counts.
 	 */
-	spin_lock(&dev->vblank_time_lock);
+	spin_lock_irqsave(&dev->vblank_time_lock, irqflags_vblank);
 
 	/* Vblank irq handling disabled. Nothing to do. */
 	if (!vblank->enabled) {
-		spin_unlock(&dev->vblank_time_lock);
+		spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags_vblank);
 		spin_unlock_irqrestore(&dev->event_lock, irqflags);
 		return false;
 	}
 
 	drm_update_vblank_count(dev, pipe, true);
 
-	spin_unlock(&dev->vblank_time_lock);
+	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags_vblank);
 
 	wake_up(&vblank->queue);
 
-- 
2.25.0

