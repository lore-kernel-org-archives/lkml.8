Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D627C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7282075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGJN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:13:27 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:27804 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEGJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:13:27 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id EC5C5482B05;
        Thu,  7 May 2020 17:13:20 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ori Messinger <Ori.Messinger@amd.com>,
        Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
Date:   Thu,  7 May 2020 02:13:05 -0700
Message-Id: <20200507091311.10898-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPTklLS0tKT0pKT0hDWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6HQw*KDg9Pz88Pws#KgEC
        NT4KCjFVSlVKTkNDQ09JQ0tPSUJDVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBT05ITDcG
X-HM-Tid: 0a71ee69284893bakuwsec5c5482b05
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is DEVICE_ATTR mechanism in separate attribute define.
So this change is to use attr array, also use
sysfs_create_files in init function & sysfs_remove_files in
fini function.
This maybe make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*Use DEVICE_ATTR mechanism

Link for V1:
*https://lore.kernel.org/patchwork/patch/1228076/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 43 ++++++--------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 82a3299e53c0..57bbc70662ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -148,6 +148,15 @@ static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO,
 static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
 		   amdgpu_mem_info_vram_vendor, NULL);
 
+static struct attribute *amdgpu_vram_mgr_attributes[] = {
+	&dev_attr_mem_info_vram_total.attr,
+	&dev_attr_mem_info_vis_vram_total.attr,
+	&dev_attr_mem_info_vram_used.attr,
+	&dev_attr_mem_info_vis_vram_used.attr,
+	&dev_attr_mem_info_vram_vendor.attr,
+	NULL
+};
+
 /**
  * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
  *
@@ -172,31 +181,9 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
 	man->priv = mgr;
 
 	/* Add the two VRAM-related sysfs files */
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
-	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
-		return ret;
-	}
+	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
+	if (ret)
+		DRM_ERROR("Failed to register sysfs\n");
 
 	return 0;
 }
@@ -219,11 +206,7 @@ static int amdgpu_vram_mgr_fini(struct ttm_mem_type_manager *man)
 	spin_unlock(&mgr->lock);
 	kfree(mgr);
 	man->priv = NULL;
-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
-	device_remove_file(adev->dev, &dev_attr_mem_info_vram_vendor);
+	sysfs_remove_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
 	return 0;
 }
 
-- 
2.26.2

