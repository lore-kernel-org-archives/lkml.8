Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C47FC3F35D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DD120578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811384;
	bh=X4Nem2nv1baLv2TXN32g/9BfBUT5HwZTzhkbMysMcXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kW8hSlysyE00cjgOiCyyD9eWYYDKrXPb6dSMhx3HeyMNZhYMOhTphf83C/vxjWczx
	 5qfaZ+JfRlE9F+ecr7CbldpavEYNQg/JBJatmt3Sdq05yBBW5+Ux/mUPz+vavM7VOr
	 L5xOIqaO6k5mfacok1lW+7hV8UNS4yC9w6EXRwNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgB0Ntn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbgB0Nt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:49:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5CA2469F;
        Thu, 27 Feb 2020 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811367;
        bh=X4Nem2nv1baLv2TXN32g/9BfBUT5HwZTzhkbMysMcXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mljzsKPu/EAAfmy8srXAaVdRc1Im4fXpqH4My38vEImvOU7IU6JIfZCPymgIH+JYO
         dq85LcTtQSk9nektLAB1o3AvmrebxzPQMFuJj6XQAoIQIJREShFGd43R5onqlESi/P
         bn5cn012qLpkivt8G1el98Fb19RjeMpeELFtRvU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 105/165] radeon: insert 10ms sleep in dce5_crtc_load_lut
Date:   Thu, 27 Feb 2020 14:36:19 +0100
Message-Id: <20200227132246.490753914@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 8b6f8aa238063..432ad7d73cb9b 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -110,6 +110,8 @@ static void dce5_crtc_load_lut(struct drm_crtc *crtc)
 
 	DRM_DEBUG_KMS("%d\n", radeon_crtc->crtc_id);
 
+	msleep(10);
+
 	WREG32(NI_INPUT_CSC_CONTROL + radeon_crtc->crtc_offset,
 	       (NI_INPUT_CSC_GRPH_MODE(NI_INPUT_CSC_BYPASS) |
 		NI_INPUT_CSC_OVL_MODE(NI_INPUT_CSC_BYPASS)));
-- 
2.20.1



