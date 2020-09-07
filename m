Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82730C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D5A207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497700;
	bh=uOc0azX8v4k0GSQ8D2c65Vbw9pkR+3DpUsRWNI9PVYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f+7CO6qEZeIP4OvePb+GEFVktd8GeBhAjygstawbfxE1CzKEfWCwSr5ReITnyhyDU
	 ZpoZzzzywg1eucQ0YkjTrxTVJsuB7qtIUcZn5BMdz7AxwDU4ao/ODhCgBCK7Q1Zta7
	 In52KK952jHDht6YzqsxwuYvaur1NopSlBufWBLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgIGQyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbgIGQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D180121D79;
        Mon,  7 Sep 2020 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496462;
        bh=uOc0azX8v4k0GSQ8D2c65Vbw9pkR+3DpUsRWNI9PVYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQYf5h4sF4825/mVNXiK5HwIvosOgPTBMi5PhhnsRJcSr8PiySMhAaL57i4tqC4L8
         oOsiwxhICxoWyQHzseZkWopqn8wkIhUqySehYaFsffEPM2imnWXS9bRmWPjpJ4TEMm
         Ym48jke7bfG9QDwvtr6C9v5i2UcCtvGrtXuW6Et4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sandeep Raghuraman <sandy.8925@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 41/43] drm/amdgpu: Fix bug in reporting voltage for CIK
Date:   Mon,  7 Sep 2020 12:33:27 -0400
Message-Id: <20200907163329.1280888-41-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Raghuraman <sandy.8925@gmail.com>

[ Upstream commit d98299885c9ea140c1108545186593deba36c4ac ]

On my R9 390, the voltage was reported as a constant 1000 mV.
This was due to a bug in smu7_hwmgr.c, in the smu7_read_sensor()
function, where some magic constants were used in a condition,
to determine whether the voltage should be read from PLANE2_VID
or PLANE1_VID. The VDDC mask was incorrectly used, instead of
the VDDGFX mask.

This patch changes the code to use the correct defined constants
(and apply the correct bitshift), thus resulting in correct voltage reporting.

Signed-off-by: Sandeep Raghuraman <sandy.8925@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index e6da53e9c3f46..3a2a1dc9a786a 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3575,7 +3575,8 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	case AMDGPU_PP_SENSOR_GPU_POWER:
 		return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
 	case AMDGPU_PP_SENSOR_VDDGFX:
-		if ((data->vr_config & 0xff) == 0x2)
+		if ((data->vr_config & VRCONF_VDDGFX_MASK) ==
+		    (VR_SVI2_PLANE_2 << VRCONF_VDDGFX_SHIFT))
 			val_vid = PHM_READ_INDIRECT_FIELD(hwmgr->device,
 					CGS_IND_REG__SMC, PWR_SVI2_STATUS, PLANE2_VID);
 		else
-- 
2.25.1

