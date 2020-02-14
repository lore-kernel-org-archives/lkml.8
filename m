Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90594C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E83222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704108;
	bh=i0s+C8qHpiEsBD8BAnRqp9HW0tJMGETCCnpdyVGRr4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ure8dMJW/sn5/B+iCSUVWBaFsbiKemXn9GmAUBm3N8NEnVx0mtIxyTa1ZR4nXmGm5
	 izAzZnYznZ/Qg5Ts5tHegJJmfOse/N3kBNMb0pUKORKBNmFpWWeiFMi+tGWBXCkERd
	 2mlOMJOKBdl9ukpV27vRaqmLYZEG/PmkDCQika1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404440AbgBNSPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbgBNPwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7547F24673;
        Fri, 14 Feb 2020 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695526;
        bh=i0s+C8qHpiEsBD8BAnRqp9HW0tJMGETCCnpdyVGRr4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEWQXPGasCZLhq17fQpmk2U84ItmGxENVmh4TGraDJH0KM/x9uKcrtRsWurxKjBOa
         SMbr9rGKaPvYFor9HhdkZnt7l5arMc7JE1NM2pbBUumaSfsXC0cbcW1EV5JysCmhdY
         e0ZFzEnpgoMWR2QCXOV+1d3RONPK6Yl/GIzq2jko=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 147/542] drm/amdgpu: remove set but not used variable 'amdgpu_connector'
Date:   Fri, 14 Feb 2020 10:42:19 -0500
Message-Id: <20200214154854.6746-147-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
index 3cadb0b76f221..4e699071d1443 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -690,7 +690,6 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_encoder *amdgpu_encoder;
 	struct drm_connector *connector;
-	struct amdgpu_connector *amdgpu_connector;
 	u32 src_v = 1, dst_v = 1;
 	u32 src_h = 1, dst_h = 1;
 
@@ -702,7 +701,6 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 			continue;
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 		connector = amdgpu_get_connector_for_encoder(encoder);
-		amdgpu_connector = to_amdgpu_connector(connector);
 
 		/* set scaling */
 		if (amdgpu_encoder->rmx_type == RMX_OFF)
-- 
2.20.1

