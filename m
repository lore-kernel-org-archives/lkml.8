Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8428C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A9A24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700300;
	bh=Go9XzXynqboKcqANq7d1ugkt+yBSYuzkBJKoPqz/wW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kcfc81GzkKm8/RI1cjQwUiRhVml9MLy91KUJXdaGO8OyNGeUSxC4zDtM2Gv1zX09z
	 2Be44ymm0NOYxNEifr9JYxiZpIsXzIdSIwC4vsRaOCAX4YkvgeAvodMUizVK2DEH4t
	 UgauVj53mGg5lOFtXHn3YWdIpUg+hridCERZ5y4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394450AbgBNRLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403855AbgBNQNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61724246AA;
        Fri, 14 Feb 2020 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696800;
        bh=Go9XzXynqboKcqANq7d1ugkt+yBSYuzkBJKoPqz/wW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMhU9s/YBD3V/kThvyx0rTb0cw9M4WSCLIkw/Cb8XSPc592Gali0PEPPvxtybbOcP
         ex10pMbNUzyllKXQ+7b2soTacfDh2fqUJAp98D+jbxBXNz/5UJ50EA2i+eeYG1fnWk
         etLrR+2vahnWvXnbJ4+81dUwo+jBdcnULMkU8OAc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 072/252] drm/radeon: remove set but not used variable 'radeon_connector'
Date:   Fri, 14 Feb 2020 11:08:47 -0500
Message-Id: <20200214161147.15842-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 5952c48993375a9da2de39be30df475cf590b0ce ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/radeon_display.c: In function radeon_crtc_scaling_mode_fixup:
drivers/gpu/drm/radeon/radeon_display.c:1685:27: warning: variable radeon_connector set but not used [-Wunused-but-set-variable]

It is not used since commit 377bd8a98d7d ("drm/radeon:
use a fetch function to get the edid")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index d8e2d7b3b8365..109915e914218 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1681,7 +1681,6 @@ bool radeon_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 	struct radeon_encoder *radeon_encoder;
 	struct drm_connector *connector;
-	struct radeon_connector *radeon_connector;
 	bool first = true;
 	u32 src_v = 1, dst_v = 1;
 	u32 src_h = 1, dst_h = 1;
@@ -1694,7 +1693,6 @@ bool radeon_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 			continue;
 		radeon_encoder = to_radeon_encoder(encoder);
 		connector = radeon_get_connector_for_encoder(encoder);
-		radeon_connector = to_radeon_connector(connector);
 
 		if (first) {
 			/* set scaling */
-- 
2.20.1

