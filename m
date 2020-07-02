Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD44C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAFD207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGBC1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:27:55 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37976 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbgGBC1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:27:54 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH94gRv1e+DFOAA--.2312S2;
        Thu, 02 Jul 2020 10:27:45 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu/drm: Remove debug info about CPU address
Date:   Thu,  2 Jul 2020 10:27:43 +0800
Message-Id: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxH94gRv1e+DFOAA--.2312S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48CrW5Jr1fuFW8Jr1UWrg_yoW5Wr18pF
        4fCF90kr9Yvw1jv347CFyUXFyFkw47WayrGFnrC34a9w45ZF10yr13Aw47XrW8Wayvyr42
        qr1Du3y8X3WjkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JV
        WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5X0eJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I update the latest kernel, I see the following "____ptrval____" boot
messages.

[    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
[    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu addr 0x0000000040056038 and cpu addr 0x(____ptrval____)

Both radeon_fence_driver_start_ring() and amdgpu_fence_driver_start_ring()
have the similar issue, there exists the following two methods to solve it:
(1) Use "%pK" instead of "%p" so that the CPU address can be printed when
the kptr_restrict sysctl is set to 1.
(2) Just completely drop the CPU address suggested by Christian, because
the CPU address was useful in the past, but isn't any more. We now have a
debugfs file to read the current fence values.

Since the CPU address is not much useful, just remove the debug info about
CPU address.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - Just remove the debug info about CPU address suggested by Christian
  - Modify the patch subject and update the commit message

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
 drivers/gpu/drm/radeon/radeon_fence.c     | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d878fe7..a29f2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -422,9 +422,8 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 	ring->fence_drv.irq_type = irq_type;
 	ring->fence_drv.initialized = true;
 
-	DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr "
-		      "0x%016llx, cpu addr 0x%p\n", ring->name,
-		      ring->fence_drv.gpu_addr, ring->fence_drv.cpu_addr);
+	DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr 0x%016llx\n",
+		      ring->name, ring->fence_drv.gpu_addr);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 43f2f93..8735bf2 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -865,8 +865,8 @@ int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring)
 	}
 	radeon_fence_write(rdev, atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
 	rdev->fence_drv[ring].initialized = true;
-	dev_info(rdev->dev, "fence driver on ring %d use gpu addr 0x%016llx and cpu addr 0x%p\n",
-		 ring, rdev->fence_drv[ring].gpu_addr, rdev->fence_drv[ring].cpu_addr);
+	dev_info(rdev->dev, "fence driver on ring %d use gpu addr 0x%016llx\n",
+		 ring, rdev->fence_drv[ring].gpu_addr);
 	return 0;
 }
 
-- 
2.1.0

