Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A46EC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185DE20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861752;
	bh=qQJ8XuGD1yqiYvBBlA+XTk9Ka7sBVbNnfFgy4ubIWrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pllnBTMC3ZWZuJraGOMIsooWfKwuyUT6d8G5ULd9F+tvxIOWdJMmmbBB9xJsJUwZC
	 uWbNEDAjXjKOGqahvSOPeZGTkHNGMihGuv+zRrbcNUYWJKN99Fqcs0HX3EkOrzOxoA
	 0W7RHyzxJQ4vAVUt4zsVgekCIaUp54ieJM7H+ECk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgEGO3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgEGO3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:29:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6867420936;
        Thu,  7 May 2020 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861742;
        bh=qQJ8XuGD1yqiYvBBlA+XTk9Ka7sBVbNnfFgy4ubIWrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJdrr8Zrai7DJiuWpxowo157HHyG+CGPCf9fhx+IDHebxJ68G0Xzr3mJD3t3Mmh9E
         0m+goOARxxZn3AIs1hFSDTipR83bQF22Wg/uOhm1s0XYCLpHsUnRlVQ5YEacn+TJuD
         7IvPZSplajp9BuJPHM8oVZPuYyFxdcaM6vy9W3DE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiecheng Zhou <Tiecheng.Zhou@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 25/35] drm/amd/powerplay: avoid using pm_en before it is initialized revised
Date:   Thu,  7 May 2020 10:28:19 -0400
Message-Id: <20200507142830.26239-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142830.26239-1-sashal@kernel.org>
References: <20200507142830.26239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>

[ Upstream commit 690ae30be163d5262feae01335b2a6f30569e5aa ]

hwmgr->pm_en is initialized at hwmgr_hw_init.

during amdgpu_device_init, there is amdgpu_asic_reset that calls to
soc15_asic_reset (for V320 usecase, Vega10 asic), in which:
1) soc15_asic_reset_method calls to pp_get_asic_baco_capability (pm_en)
2) soc15_asic_baco_reset calls to pp_set_asic_baco_state (pm_en)

pm_en is used in the above two cases while it has not yet been initialized

So avoid using pm_en in the above two functions for V320 passthrough.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index d306cc7119976..8bb5fbef7de0f 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1425,7 +1425,8 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -1459,7 +1460,8 @@ static int pp_set_asic_baco_state(void *handle, int state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_asic_baco_state)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->set_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.20.1

