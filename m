Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874C5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555B52187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698559;
	bh=9Et37cIllYVrbRLcETJX4azs8dFhX5iB0xAVVervu7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJu0tktKXGN2ALz/mkwVuCQ1e3XNWSp6w/kfqvTBFKbTOyiEOYVfVHsl+Nwgnp6Xs
	 OoPY6O1I/kEgdqFx1jhLmVRJqCduYlld9LG8tWH2fvCG4grVJbiws0gXFu+l71tOUC
	 osSt+/ZWe3rnZvSuvDDoIbA4jDobD8rFB2Lvbqi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405951AbgBNQmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:42:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405428AbgBNQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450582473C;
        Fri, 14 Feb 2020 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697337;
        bh=9Et37cIllYVrbRLcETJX4azs8dFhX5iB0xAVVervu7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blYfuMWmBX0zgWuVBBwNNJXmI2rvRGlrCe3odFDW/HlGilg5yINUMtkgHjzh4jsyn
         poLC3kbCAZHItmw+XM+Q0sOFMxEkA9qaa01VvUOtzNoqNnIptudEUo0peun2kItR7e
         eGIrlJehqOZDbeFD9rolQS4GGNBEKAeKfk++vCKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 043/141] drm/radeon: remove set but not used variable 'backbias_response_time'
Date:   Fri, 14 Feb 2020 11:19:43 -0500
Message-Id: <20200214162122.19794-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit ac52caecbcf2c30ce95b2536c1caf2643c49b91c ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/si_dpm.c: In function si_program_response_times:
drivers/gpu/drm/radeon/si_dpm.c:3640:29: warning: variable backbias_response_time set but not used [-Wunused-but-set-variable]

It is introduced by commit a9e61410921b ("drm/radeon/kms:
add dpm support for SI (v7)"), but never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/si_dpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index ac7ae206f2e71..06c7244a1f9c5 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -3695,14 +3695,13 @@ static int si_notify_smc_display_change(struct radeon_device *rdev,
 
 static void si_program_response_times(struct radeon_device *rdev)
 {
-	u32 voltage_response_time, backbias_response_time, acpi_delay_time, vbi_time_out;
+	u32 voltage_response_time, acpi_delay_time, vbi_time_out;
 	u32 vddc_dly, acpi_dly, vbi_dly;
 	u32 reference_clock;
 
 	si_write_smc_soft_register(rdev, SI_SMC_SOFT_REGISTER_mvdd_chg_time, 1);
 
 	voltage_response_time = (u32)rdev->pm.dpm.voltage_response_time;
-	backbias_response_time = (u32)rdev->pm.dpm.backbias_response_time;
 
 	if (voltage_response_time == 0)
 		voltage_response_time = 1000;
-- 
2.20.1

