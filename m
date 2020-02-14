Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71049C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CF9206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699424;
	bh=2Y6eV85ieDxJyfSOITSybtXd1SZP3IK8M43xp668pP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DVgrd5eJhZ8LUeyJPkTdFBa+xOKdu5XucjLMhWbQiB9ceGuMpMMn4Nycmpajlu7p0
	 2ESsx65of5vOWyFeWCm75E6i92aYcqXnTTrshsCVy1sf0KQbHqaXeZQBEMrFAR6ONz
	 JxnOcSlg5PHZuU8pq+lOC+RqLR92uHiYbN0t1Tm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404571AbgBNQRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:17:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392640AbgBNQQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B8DE246EA;
        Fri, 14 Feb 2020 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697004;
        bh=2Y6eV85ieDxJyfSOITSybtXd1SZP3IK8M43xp668pP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EULdgRVxsk2xfu8sNGYkWrjL2R6DcpmtGvw140D5EhoD8vEgYlGVyjDPWe1Fdb+Sg
         e/2mlum83zG8FWw+Osc1S4BnTZB4vstj7QwfQXVS7iMBY7OvHLOXro7pUpOlSA3FOf
         E3RBg1pHXLk2hTM7RaMe5d01xDOrg7csGNhHcADY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 236/252] radeon: insert 10ms sleep in dce5_crtc_load_lut
Date:   Fri, 14 Feb 2020 11:11:31 -0500
Message-Id: <20200214161147.15842-236-sashal@kernel.org>
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

From: Daniel Vetter <daniel.vetter@ffwll.ch>

[ Upstream commit ec3d65082d7dabad6fa8f66a8ef166f2d522d6b2 ]

Per at least one tester this is enough magic to recover the regression
introduced for some people (but not all) in

commit b8e2b0199cc377617dc238f5106352c06dcd3fa2
Author: Peter Rosin <peda@axentia.se>
Date:   Tue Jul 4 12:36:57 2017 +0200

    drm/fb-helper: factor out pseudo-palette

which for radeon had the side-effect of refactoring out a seemingly
redudant writing of the color palette.

10ms in a fairly slow modeset path feels like an acceptable form of
duct-tape, so maybe worth a shot and see what sticks.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Michel Dänzer <michel.daenzer@amd.com>
References: https://bugzilla.kernel.org/show_bug.cgi?id=198123
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 109915e914218..3a895307290a4 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -121,6 +121,8 @@ static void dce5_crtc_load_lut(struct drm_crtc *crtc)
 
 	DRM_DEBUG_KMS("%d\n", radeon_crtc->crtc_id);
 
+	msleep(10);
+
 	WREG32(NI_INPUT_CSC_CONTROL + radeon_crtc->crtc_offset,
 	       (NI_INPUT_CSC_GRPH_MODE(NI_INPUT_CSC_BYPASS) |
 		NI_INPUT_CSC_OVL_MODE(NI_INPUT_CSC_BYPASS)));
-- 
2.20.1

