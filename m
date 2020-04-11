Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B819C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5AC20787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646446;
	bh=1pVOCMCEVPxh4yJmQWbxZpQ34McUxLlzYHjsDA4Nuxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mwhc/oiOYu6db+VU1n4eDvix6xSNKmj0PiMtdD2DsVWl27gtjCR8vSHfdprjd4Yhi
	 5gfz6fdVyybWDWzRW1n6AhT7rYZ+Bt6JiHxZez+FYZm1veu12+OmHSNBh/5oNcpq2l
	 I8Rr6GfdhPcZSM9oe8gywH5Sn+jZtlwC9JPnWtkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgDKXHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbgDKXHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A1D20708;
        Sat, 11 Apr 2020 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646442;
        bh=1pVOCMCEVPxh4yJmQWbxZpQ34McUxLlzYHjsDA4Nuxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyPh+wsKV/Q0M9cHgkWwvu6MAHKU7rzyG6u26W7dX4s36nmC3eZvOcw6pGQqEYp5H
         pFQ1cyvuemtVS6nL79CT5xWqMUn/Ed1sE/noVXacqwx0IBFQm1DqHI/ZzzDX2tWzPS
         vja69CAwk+n+l3zLB2M+pRqD0+dcDO8XGVOLHerY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 013/121] drm/amd/display: Explicitly disable triplebuffer flips
Date:   Sat, 11 Apr 2020 19:05:18 -0400
Message-Id: <20200411230706.23855-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 2d673560b7b83f8fe4163610f35c51b4d095525c ]

[Why]
This is enabled by default on Renoir but there's userspace/API support
to actually make use of this.

Since we're not passing this down through surface updates, let's
explicitly disable this for now.

This fixes "dcn20_program_front_end_for_ctx" warnings associated with
incorrect/unexpected programming sequences performed while this is
enabled.

[How]
Disable it at the topmost level in DM in case anyone tries to flip this
to enabled for any of the other ASICs like Navi10/14.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 803e59d974111..fb1efdde7a49d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2481,6 +2481,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	if (adev->asic_type != CHIP_CARRIZO && adev->asic_type != CHIP_STONEY)
 		dm->dc->debug.disable_stutter = amdgpu_pp_feature_mask & PP_STUTTER_MODE ? false : true;
 
+	/* No userspace support. */
+	dm->dc->debug.disable_tri_buf = true;
+
 	return 0;
 fail:
 	kfree(aencoder);
-- 
2.20.1

