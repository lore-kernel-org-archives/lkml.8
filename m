Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBCC55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E81320700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731565;
	bh=wMtdi2mSKs8GJKWAFYEXR4EYW0aiS/Rd2QRsf2QSWoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsCl2IRPETIB/ZRtaYKwHGKg4I+ZuLI97bUO/Qv4Xlip4F2rwfRdphCF5H0pjKP7T
	 r9AJW9+IZ5vrJcAGR3Jsr3rqht9+6UVFOHqxNo2ILSWVmpnCBsCo2TszMrZpYLr2kb
	 BzARTwvHJkgKhxo3ejGh+fVExCq97YkqcoJbmPHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgDXMco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgDXMWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:22:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9938D20767;
        Fri, 24 Apr 2020 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730973;
        bh=wMtdi2mSKs8GJKWAFYEXR4EYW0aiS/Rd2QRsf2QSWoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhSGRyp/oaUG45ZW3eaWzgsjbOlib8ciaO8MslVsah2JYpDLocpgqkRZO3dtF31t/
         KzqunRojp15/TI+f2hHy+Ed9c7bxhty7dob5KMBAdde3KzUo16OoCbbs3VJD5/hrnC
         18cUJYlHaQDpi+phLIkM3H3S1RW+WbmbV2alvxFs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 14/38] drm/amdgpu: fix wrong vram lost counter increment V2
Date:   Fri, 24 Apr 2020 08:22:12 -0400
Message-Id: <20200424122237.9831-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 028cfb2444b94d4f394a6fa4ca46182481236e91 ]

Vram lost counter is wrongly increased by two during baco reset.

V2: assumed vram lost for mode1 reset on all ASICs

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/cik.c           |  2 --
 drivers/gpu/drm/amd/amdgpu/nv.c            |  4 ----
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ----
 drivers/gpu/drm/amd/amdgpu/vi.c            |  2 --
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c8bf9cb3cebf2..f184cdca938de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1953,8 +1953,24 @@ static void amdgpu_device_fill_reset_magic(struct amdgpu_device *adev)
  */
 static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 {
-	return !!memcmp(adev->gart.ptr, adev->reset_magic,
-			AMDGPU_RESET_MAGIC_NUM);
+	if (memcmp(adev->gart.ptr, adev->reset_magic,
+			AMDGPU_RESET_MAGIC_NUM))
+		return true;
+
+	if (!adev->in_gpu_reset)
+		return false;
+
+	/*
+	 * For all ASICs with baco/mode1 reset, the VRAM is
+	 * always assumed to be lost.
+	 */
+	switch (amdgpu_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_BACO:
+	case AMD_RESET_METHOD_MODE1:
+		return true;
+	default:
+		return false;
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 006f21ef7ddf0..62635e58e45ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1358,8 +1358,6 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = cik_asic_pci_config_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2d1bebdf1603d..cc3a79029376b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -351,8 +351,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 
 	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		ret = smu_baco_enter(smu);
 		if (ret)
 			return ret;
@@ -360,8 +358,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		if (ret)
 			return ret;
 	} else {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		ret = nv_asic_mode1_reset(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d8945c31b622c..132a67a041a24 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -569,14 +569,10 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 
 	switch (soc15_asic_reset_method(adev)) {
 		case AMD_RESET_METHOD_BACO:
-			if (!adev->in_suspend)
-				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_baco_reset(adev);
 		case AMD_RESET_METHOD_MODE2:
 			return amdgpu_dpm_mode2_reset(adev);
 		default:
-			if (!adev->in_suspend)
-				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_mode1_reset(adev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 78b35901643bc..3ce10e05d0d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -765,8 +765,6 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = vi_asic_pci_config_reset(adev);
-- 
2.20.1

