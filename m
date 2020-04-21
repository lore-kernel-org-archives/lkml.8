Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE622071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgDUGsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:48:33 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:63957 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUGsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:48:33 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 7E79D665C28;
        Tue, 21 Apr 2020 14:48:26 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH V3] amdgpu:optimization-- reduce no need mutex_lock area
Date:   Mon, 20 Apr 2020 23:48:18 -0700
Message-Id: <20200421064818.129158-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
Reply-To: 1587181464-114215-1-git-send-email-bernard@vivo.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VNSktLS0tKSEhOSk9PWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6Dhw*MDg5OAMJI04WVj4*
        ShoKCgJVSlVKTkNMT05KTEtCQ0JPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSEtCSzcG
X-HM-Tid: 0a719b7ebdb29373kuws7e79d665c28
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe we could reduce the mutex_lock(&mem->lock)`s protected code area,
and no need to protect pr_debug.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*commit message improve

Changes since V2:
*move comment along with the mutex_unlock

Link for V1:
*https://lore.kernel.org/patchwork/patch/1226588/
Link for V2:
*https://lore.kernel.org/patchwork/patch/1227907/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 327317c54f7c..f03d9843d723 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1285,21 +1285,21 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	struct bo_vm_reservation_context ctx;
 	struct ttm_validate_buffer *bo_list_entry;
 	int ret;
+	unsigned int mapped_to_gpu_memory;
 
 	mutex_lock(&mem->lock);
+	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
+	mutex_unlock(&mem->lock);
+	/* lock is not needed after this, since mem is unused and will
+	 * be freed anyway
+	 */
 
-	if (mem->mapped_to_gpu_memory > 0) {
+	if (mapped_to_gpu_memory > 0) {
 		pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
 				mem->va, bo_size);
-		mutex_unlock(&mem->lock);
 		return -EBUSY;
 	}
 
-	mutex_unlock(&mem->lock);
-	/* lock is not needed after this, since mem is unused and will
-	 * be freed anyway
-	 */
-
 	/* No more MMU notifiers */
 	amdgpu_mn_unregister(mem->bo);
 
-- 
2.26.2

