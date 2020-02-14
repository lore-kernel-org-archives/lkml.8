Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B77C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65F72467D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698602;
	bh=Zis/2J4cNpsMZcqwf9Osp3kP0K7LypCRbA1/0sjuczk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0WMHpyDA77FQlswQfKoiFw0QOIS1vYOxtCy9ISUNUGqB4NnT27p7f1vtn9vKvhaId
	 vGd5Q/OnN1So5iz5fel/htlkuYEZby+Cb5xrX+myzO74ngQMKKJdwoNQ7wirvaLv3+
	 tCMBzWu7FsfglttPndnm4k810HhEV83o1hUGShPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394019AbgBNQnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405387AbgBNQWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8324A246DD;
        Fri, 14 Feb 2020 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697328;
        bh=Zis/2J4cNpsMZcqwf9Osp3kP0K7LypCRbA1/0sjuczk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sHybGuO1Emu90VfjTC9MuxvWIQaiC+RVMowqH9uRtHUAmRDla6rZucp8+TDctWRQD
         2J8KULF9FX5vMzw7Gkbtl4VWXjc+2P5EuSWNBLCrgVGt6/OcfcpVXNjY4t8HfeM92Y
         OuwcqmGGlnlm47tQ3ThLq3LkiUPrePdxaMek7wCQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 036/141] drm/amdgpu: remove set but not used variable 'mc_shared_chmap'
Date:   Fri, 14 Feb 2020 11:19:36 -0500
Message-Id: <20200214162122.19794-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
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

[ Upstream commit e98042db2cb8d0b728cd76e05b9c2e1c84b7f72b ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function
‘gfx_v8_0_gpu_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1713:6: warning: variable
‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

Fixes: 0bde3a95eaa9 ("drm/amdgpu: split gfx8 gpu init into sw and hw parts")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index c8a5cf5365a94..da32c7e49be0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1739,7 +1739,7 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 static int gfx_v8_0_gpu_early_init(struct amdgpu_device *adev)
 {
 	u32 gb_addr_config;
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 dimm00_addr_map, dimm01_addr_map, dimm10_addr_map, dimm11_addr_map;
 	u32 tmp;
 	int ret;
@@ -1932,7 +1932,6 @@ static int gfx_v8_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);
 	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
 	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
 
-- 
2.20.1

