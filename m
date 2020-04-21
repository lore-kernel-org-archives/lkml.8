Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90274C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769842071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgDULR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:17:28 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:11456 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgDULR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:17:27 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 78102664787;
        Tue, 21 Apr 2020 19:17:24 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        Ori Messinger <Ori.Messinger@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] amdgpu: fixes memleak issue when init failed
Date:   Tue, 21 Apr 2020 04:17:13 -0700
Message-Id: <20200421111715.1231-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VJTklCQkJMQ0lOTUlJTVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6HAw5KDg1PAMQTE43MSFK
        SSIaCgJVSlVKTkNMT01MQ09PQ0tOVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSE1ISzcG
X-HM-Tid: 0a719c74fc629373kuws78102664787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VRAM manager and DRM MM when init failed, there is no operaction
to free kzalloc memory & remove device file.
This will lead to memleak & cause stability issue.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 24 ++++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 82a3299e53c0..4c5fb153e6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -175,30 +175,44 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
-		return ret;
+		goto VRAM_TOTAL_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
-		return ret;
+		goto VIS_VRAM_TOTA_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
-		return ret;
+		goto VRAM_USED_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
-		return ret;
+		goto VIS_VRAM_USED_FAIL;
 	}
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
 	if (ret) {
 		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
-		return ret;
+		goto VRAM_VERDOR_FAIL;
 	}
 
 	return 0;
+
+VRAM_VERDOR_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
+VIS_VRAM_USED_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
+RVAM_USED_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
+VIS_VRAM_TOTA_FAIL:
+	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
+VRAM_TOTAL_FAIL:
+	kfree(mgr);
+	man->priv = NULL;
+
+	return ret;
 }
 
 /**
-- 
2.26.2

