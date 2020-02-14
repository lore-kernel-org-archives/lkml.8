Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E22C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4C12477E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697440;
	bh=jn4K9rDlecWTJSRHUz03JEu4YRkIIjvf91FBDrRDW14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fRp0dQMdaMViRXQE8LFC+luZhxor7spF4++wojNFbOmk/Ky3QIniGQYssV7KPQM87
	 X8DjrV3pto8dp3xUjPKHcG4yLxrB72rOllidFEnS9Aidn5D1qThBHOVT5ARAjo0hgh
	 XuqqbM1h/miO+behuInovNlKTIDT+s3msYhNdXng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405776AbgBNQX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387788AbgBNQWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA83246DF;
        Fri, 14 Feb 2020 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697329;
        bh=jn4K9rDlecWTJSRHUz03JEu4YRkIIjvf91FBDrRDW14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PepKEXcFte97Cc2hl/ii68rXDcQtRKm9SBUzaFpxSdkRIXYupe0weqkSFF3++H7oq
         fNTDn5iv9Gb7jJKyAGwSS9nPmQGwriGL9a3C01xDmHXQp7G56vUj8FCcGY6kidpM/Q
         NqT+RiZtEe4ofHR1WVwteVzSS7N7a46gBSpQ378Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 037/141] drm/amdgpu: remove set but not used variable 'amdgpu_connector'
Date:   Fri, 14 Feb 2020 11:19:37 -0500
Message-Id: <20200214162122.19794-37-sashal@kernel.org>
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

[ Upstream commit 4f2922d12d6c63d0f4aa4e859ad95aee6d0d4ea0 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_display.c: In function
‘amdgpu_display_crtc_scaling_mode_fixup’:
drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:693:27: warning: variable
‘amdgpu_connector’ set but not used [-Wunused-but-set-variable]

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 15a2d8f3725d5..f29f025202d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -666,7 +666,6 @@ bool amdgpu_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_encoder *amdgpu_encoder;
 	struct drm_connector *connector;
-	struct amdgpu_connector *amdgpu_connector;
 	u32 src_v = 1, dst_v = 1;
 	u32 src_h = 1, dst_h = 1;
 
@@ -678,7 +677,6 @@ bool amdgpu_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 			continue;
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 		connector = amdgpu_get_connector_for_encoder(encoder);
-		amdgpu_connector = to_amdgpu_connector(connector);
 
 		/* set scaling */
 		if (amdgpu_encoder->rmx_type == RMX_OFF)
-- 
2.20.1

