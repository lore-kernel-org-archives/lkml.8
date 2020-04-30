Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C0EC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F60B2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254865;
	bh=zTXCidyF3h1FOA71xWqDYf/8fU7YbPSRgGWTDwl3/IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jChf2+yPLagED5hqfgQRAYec/+WnFLTG4D6I8V/XXlcLW0rq2vKdESEIQg5PpAVmn
	 Oriz5d3sGoR0bEf9RNybQATqOphKwSvOcyiQghp3iTDMq/VhntMpQ6W74xvvqRgRRJ
	 +6uim/1sYK+MMl9y2gztAGTl7QapqIf1S1ii89yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgD3NyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgD3Nxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E62208DB;
        Thu, 30 Apr 2020 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254822;
        bh=zTXCidyF3h1FOA71xWqDYf/8fU7YbPSRgGWTDwl3/IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x80K6rWUNVPVVhzXUAfnsAbufMZMtsqgihKWVhmrSJIwMzPKzQgfr7jLl1X2Jal2g
         SNy5qJN2xHHqYdcpXD3WizjQDpdGMCuInyrbo4PRk+XNnEqolHujLpOUMTRvxiA9yL
         5g7Uvu1DdZYk9K8BddEysuc8OcndJD/lxFnkW+EM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sandeep Raghuraman <sandy.8925@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 14/30] drm/amdgpu: Correctly initialize thermal controller for GPUs with Powerplay table v0 (e.g Hawaii)
Date:   Thu, 30 Apr 2020 09:53:09 -0400
Message-Id: <20200430135325.20762-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135325.20762-1-sashal@kernel.org>
References: <20200430135325.20762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Raghuraman <sandy.8925@gmail.com>

[ Upstream commit bbc25dadc7ed19f9d6b2e30980f0eb4c741bb8bf ]

Initialize thermal controller fields in the PowerPlay table for Hawaii
GPUs, so that fan speeds are reported.

Signed-off-by: Sandeep Raghuraman <sandy.8925@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/powerplay/hwmgr/processpptables.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
index 925e17104f909..b9e08b06ed5db 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
@@ -983,6 +983,32 @@ static int init_thermal_controller(
 			struct pp_hwmgr *hwmgr,
 			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
+	hwmgr->thermal_controller.ucType =
+			powerplay_table->sThermalController.ucType;
+	hwmgr->thermal_controller.ucI2cLine =
+			powerplay_table->sThermalController.ucI2cLine;
+	hwmgr->thermal_controller.ucI2cAddress =
+			powerplay_table->sThermalController.ucI2cAddress;
+
+	hwmgr->thermal_controller.fanInfo.bNoFan =
+		(0 != (powerplay_table->sThermalController.ucFanParameters &
+			ATOM_PP_FANPARAMETERS_NOFAN));
+
+	hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolution =
+		powerplay_table->sThermalController.ucFanParameters &
+		ATOM_PP_FANPARAMETERS_TACHOMETER_PULSES_PER_REVOLUTION_MASK;
+
+	hwmgr->thermal_controller.fanInfo.ulMinRPM
+		= powerplay_table->sThermalController.ucFanMinRPM * 100UL;
+	hwmgr->thermal_controller.fanInfo.ulMaxRPM
+		= powerplay_table->sThermalController.ucFanMaxRPM * 100UL;
+
+	set_hw_cap(hwmgr,
+		   ATOM_PP_THERMALCONTROLLER_NONE != hwmgr->thermal_controller.ucType,
+		   PHM_PlatformCaps_ThermalController);
+
+	hwmgr->thermal_controller.use_hw_fan_control = 1;
+
 	return 0;
 }
 
-- 
2.20.1

