Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B2FC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286A22076A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgDUMWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:22:32 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:64838 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgDUMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:22:31 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 232B9664480;
        Tue, 21 Apr 2020 20:22:25 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v4] amdgpu: remove unnecessary condition check
Date:   Tue, 21 Apr 2020 05:22:18 -0700
Message-Id: <20200421122218.1849-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVPSkNLS0tJSUpJTklPT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mj46Pjo6OTgxQwMODhYyPhE6
        FxUKFE1VSlVKTkNMT0xKTE9DT0NLVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSEtMQzcG
X-HM-Tid: 0a719cb081279373kuws232b9664480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to if check again, maybe we could merge
into the above else branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*commit message improve
*code style refactoring

Changes since V2:
*code style adjust

Changes since V3:
*find the best way to merge unnecessary if/else check branch

Link for V1:
*https://lore.kernel.org/patchwork/patch/1226587/
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9dff792c9290..acb612c53b9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -660,15 +660,15 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
 
 	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
 				     false, &ctx->duplicates);
-	if (!ret)
-		ctx->reserved = true;
-	else {
-		pr_err("Failed to reserve buffers in ttm\n");
+	if (ret) {
+		pr_err("Failed to reserve buffers in ttm.\n");
 		kfree(ctx->vm_pd);
 		ctx->vm_pd = NULL;
+		return ret;
 	}
 
-	return ret;
+	ctx->reserved = true;
+	return 0;
 }
 
 /**
@@ -733,17 +733,15 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 
 	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
 				     false, &ctx->duplicates);
-	if (!ret)
-		ctx->reserved = true;
-	else
-		pr_err("Failed to reserve buffers in ttm.\n");
-
 	if (ret) {
+		pr_err("Failed to reserve buffers in ttm.\n");
 		kfree(ctx->vm_pd);
 		ctx->vm_pd = NULL;
+		return ret;
 	}
 
-	return ret;
+	ctx->reserved = true;
+	return 0;
 }
 
 /**
-- 
2.26.2

