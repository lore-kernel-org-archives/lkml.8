Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A496DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77792246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696764;
	bh=MKNm3DH+iFG/2MKS7mW0IPl2gpbcCAHThyKYruf9gXM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W9RRN0qiASqq8D4QV9I1/gkEmvfWqeawpC0hRuIFvoAjFJP5BXt2wTYZiPQdHYC/m
	 eCQ2t5CFZH1EP0ubXnSpdCjkn2BHpHcd/oyEqOxQkuh+NC77kB2P56odEipnjBeQBA
	 Lkome99z5w+Rfss9gE6vq85J2qMGgPgA9P2hwU3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392047AbgBNQMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391851AbgBNQLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A919222C2;
        Fri, 14 Feb 2020 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696709;
        bh=MKNm3DH+iFG/2MKS7mW0IPl2gpbcCAHThyKYruf9gXM=;
        h=From:To:Cc:Subject:Date:From;
        b=Z4Oh62ci8HZzM61xAIyouudBRbxEve7eXRxatUKe8UOM4Wo4XgP8mT5MuHfH4vbG9
         tu9GintuoQGixsUQRDO+U7HowWSMVU9DRpCvxcNOeTmG0Bx9giPuz6QmvQ4/+pwiAS
         F8Jr7IbNjqC87w1yqeQ46iIVAEzqa7gffkfrd7OU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 001/252] drm/amdgpu: remove set but not used variable 'mc_shared_chmap' from 'gfx_v6_0.c' and 'gfx_v7_0.c'
Date:   Fri, 14 Feb 2020 11:07:36 -0500
Message-Id: <20200214161147.15842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit 747a397d394fac0001e4b3c03d7dce3a118af567 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c: In function
‘gfx_v6_0_constants_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:1579:6: warning: variable
‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c: In function
‘gfx_v7_0_gpu_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:4262:6: warning: variable
‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
Fixes: d93f3ca706b8 ("drm/amdgpu/gfx7: rework gpu_init()")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index de184a8860573..016756cec0d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1555,7 +1555,7 @@ static void gfx_v6_0_config_init(struct amdgpu_device *adev)
 static void gfx_v6_0_gpu_init(struct amdgpu_device *adev)
 {
 	u32 gb_addr_config = 0;
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 sx_debug_1;
 	u32 hdp_host_path_cntl;
 	u32 tmp;
@@ -1657,7 +1657,6 @@ static void gfx_v6_0_gpu_init(struct amdgpu_device *adev)
 
 	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
 
-	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);
 	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
 	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 95452c5a9df6e..8bdcc4a6655af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4323,7 +4323,7 @@ static int gfx_v7_0_late_init(void *handle)
 static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
 {
 	u32 gb_addr_config;
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 dimm00_addr_map, dimm01_addr_map, dimm10_addr_map, dimm11_addr_map;
 	u32 tmp;
 
@@ -4400,7 +4400,6 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);
 	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
 	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
 
-- 
2.20.1

