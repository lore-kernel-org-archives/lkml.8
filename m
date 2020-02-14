Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9DAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665CD206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700338;
	bh=iAqYGLyVkYUetROcmctoKKpzGBAgC5kjLQhn2Fx+Tlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eO+4azLbGVBNyGrNzd0soudsJPZkOKgimvT0evGd7IzTtURfneJv/eakci525CrzD
	 0sZu5aOWWPX/eG6ue/cTUcAj7y0c5kwXwMCuUAMCcqNbiPpEPDh0fQUKOkWIyze30O
	 Fq+kYiIWbh53K0ChVLPGqBA78z5kw6q3FPC57+x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394161AbgBNRMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:12:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389506AbgBNQNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4056824696;
        Fri, 14 Feb 2020 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696787;
        bh=iAqYGLyVkYUetROcmctoKKpzGBAgC5kjLQhn2Fx+Tlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIiaB14iCWs7YjCrRnh9oGBjuuZB/EOeYf5ysKTaKXWpr1jVZAw58eTk5FizJrNDV
         WTfrAdg6HSX+XrQggU+Hr+N18/S/EEp34x1s1lDn7MdI7k30Yc/Mi46Dcv67cLIvIh
         FVyXhtZONPPwjy73H5bPKyRkFp32R3bJm+LOdnMQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 062/252] drm/amd/powerplay: remove set but not used variable 'us_mvdd'
Date:   Fri, 14 Feb 2020 11:08:37 -0500
Message-Id: <20200214161147.15842-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
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

[ Upstream commit 472b36a2ab67880e89d6b0cd0e243830e8cb75e1 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c: In
function ‘vegam_populate_smc_acpi_level’:
drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c:1117:11:
warning: variable 'us_mvdd' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: ac7822b0026f ("drm/amd/powerplay: add smumgr support for VEGAM (v2)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 59113fdd1c1c1..4cde87a3f2388 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1114,7 +1114,6 @@ static int vegam_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	SMIO_Pattern vol_level;
 	uint32_t mvdd;
-	uint16_t us_mvdd;
 
 	table->ACPILevel.Flags &= ~PPSMC_SWSTATE_FLAG_DC;
 
@@ -1168,17 +1167,6 @@ static int vegam_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
 			"in Clock Dependency Table",
 			);
 
-	us_mvdd = 0;
-	if ((SMU7_VOLTAGE_CONTROL_NONE == data->mvdd_control) ||
-			(data->mclk_dpm_key_disabled))
-		us_mvdd = data->vbios_boot_state.mvdd_bootup_value;
-	else {
-		if (!vegam_populate_mvdd_value(hwmgr,
-				data->dpm_table.mclk_table.dpm_levels[0].value,
-				&vol_level))
-			us_mvdd = vol_level.Voltage;
-	}
-
 	if (!vegam_populate_mvdd_value(hwmgr, 0, &vol_level))
 		table->MemoryACPILevel.MinMvdd = PP_HOST_TO_SMC_UL(vol_level.Voltage);
 	else
-- 
2.20.1

