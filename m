Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E1C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C717221D91
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDRDof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:44:35 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:9789 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgDRDof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 23:44:35 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 5EFF5663B47;
        Sat, 18 Apr 2020 11:44:32 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] amdgpu_amdkfd_gpuvm_free_memory_of_gpu, reduce noneed mutex_lock area
Date:   Fri, 17 Apr 2020 20:44:24 -0700
Message-Id: <1587181464-114215-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VIS09CQkJDSUNISENNSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6NBw*NTgxPA49Hys#H00f
        NzYwCSFVSlVKTkNMSkNKT0xJTUlCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSU5KTTcG
X-HM-Tid: 0a718b634b279373kuws5eff5663b47
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe we could reduce the mutex_lock(&mem->lock)`s protected code area,
and noneed to protect pr_debug.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 327317c..3c3769e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1285,17 +1285,18 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	struct bo_vm_reservation_context ctx;
 	struct ttm_validate_buffer *bo_list_entry;
 	int ret;
+	unsigned int mapped_to_gpu_memory;
 
 	mutex_lock(&mem->lock);
+	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
+	mutex_unlock(&mem->lock);
 
-	if (mem->mapped_to_gpu_memory > 0) {
+	if (mapped_to_gpu_memory > 0) {
 		pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
 				mem->va, bo_size);
-		mutex_unlock(&mem->lock);
 		return -EBUSY;
 	}
 
-	mutex_unlock(&mem->lock);
 	/* lock is not needed after this, since mem is unused and will
 	 * be freed anyway
 	 */
-- 
2.7.4

