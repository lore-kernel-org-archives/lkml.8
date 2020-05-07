Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD69C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97ED620B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588862217;
	bh=0zUgoL8zGPgVJ5XXJhZqITkeX4BLPqERLZPMDtUiQog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=duJ/sVsM2Fl86cAt+lGnaDNRX/+hgCsc+kM++CcB7nfhqykHOtu8xhn48ymAJNLKU
	 QIJzKT1GpwsRpYHYft5GpMj519ckm3Z6celNeapPHmL9g91MZr+5naB8Pu3QWYsaKS
	 1t48MCUDTyjXXmOAxI9ogFfxQQAd8jB5Gi22dV7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEGOg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgEGO2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:28:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7E62084D;
        Thu,  7 May 2020 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861688;
        bh=0zUgoL8zGPgVJ5XXJhZqITkeX4BLPqERLZPMDtUiQog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTrEG8zGrix8TC/GUvQe0Grxu2JXjdVGsxa/A6WOOMTojb2l07ZTRDzZdR4WI0Ut7
         I2gNK+UjUsjQXiR+fs8RtNjEgIdC+TyxV27XzXLs0OrINq6DcGgznGhkm8qhUKPlFM
         Wp4wVHR8bbq2bnInJcg8fSfyfbKbBXoy0QXK/p4M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 33/50] drm/amdgpu: bump version for invalidate L2 before SDMA IBs
Date:   Thu,  7 May 2020 10:27:09 -0400
Message-Id: <20200507142726.25751-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142726.25751-1-sashal@kernel.org>
References: <20200507142726.25751-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Olšák <marek.olsak@amd.com>

[ Upstream commit 9017a4897a20658f010bebea825262963c10afa6 ]

This fixes GPU hangs due to cache coherency issues.
Bump the driver version. Split out from the original patch.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 42f4febe24c6d..8d45a2b662aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -85,9 +85,10 @@
  * - 3.34.0 - Non-DC can flip correctly between buffers with different pitches
  * - 3.35.0 - Add drm_amdgpu_info_device::tcc_disabled_mask
  * - 3.36.0 - Allow reading more status registers on si/cik
+ * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctness
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	36
+#define KMS_DRIVER_MINOR	37
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit = 0;
-- 
2.20.1

