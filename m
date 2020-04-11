Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07721C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBBA2083E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgDKOEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 10:04:02 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:35886 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgDKOEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 10:04:02 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d41 with ME
        id RS3y2200H0scBcy03S3yw4; Sat, 11 Apr 2020 16:04:00 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 16:04:00 +0200
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, evan.quan@amd.com,
        andrey.grodzovsky@amd.com, Monk.Liu@amd.com, kent.russell@amd.com,
        le.ma@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amdgpu: Add missing '\n' in log messages
Date:   Sat, 11 Apr 2020 16:03:56 +0200
Message-Id: <20200411140356.28211-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

While at it, split some long lines that where not that far.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Most of them have been added in commit bd607166af7f ("drm/amdgpu: Enable reading FRU chip via I2C v3")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 87f7c129c8ce..3d0a50e8c36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3249,25 +3249,25 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = device_create_file(adev->dev, &dev_attr_pcie_replay_count);
 	if (r) {
-		dev_err(adev->dev, "Could not create pcie_replay_count");
+		dev_err(adev->dev, "Could not create pcie_replay_count\n");
 		return r;
 	}
 
 	r = device_create_file(adev->dev, &dev_attr_product_name);
 	if (r) {
-		dev_err(adev->dev, "Could not create product_name");
+		dev_err(adev->dev, "Could not create product_name\n");
 		return r;
 	}
 
 	r = device_create_file(adev->dev, &dev_attr_product_number);
 	if (r) {
-		dev_err(adev->dev, "Could not create product_number");
+		dev_err(adev->dev, "Could not create product_number\n");
 		return r;
 	}
 
 	r = device_create_file(adev->dev, &dev_attr_serial_number);
 	if (r) {
-		dev_err(adev->dev, "Could not create serial_number");
+		dev_err(adev->dev, "Could not create serial_number\n");
 		return r;
 	}
 
@@ -4270,7 +4270,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		job_signaled = true;
 
 	if (job_signaled) {
-		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset\n");
 		goto skip_hw_reset;
 	}
 
@@ -4339,10 +4339,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		if (r) {
 			/* bad news, how to tell it to userspace ? */
-			dev_info(tmp_adev->dev, "GPU reset(%d) failed\n", atomic_read(&tmp_adev->gpu_reset_counter));
+			dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
+				 atomic_read(&tmp_adev->gpu_reset_counter));
 			amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
 		} else {
-			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
+			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n",
+				 atomic_read(&tmp_adev->gpu_reset_counter));
 		}
 	}
 
-- 
2.20.1

