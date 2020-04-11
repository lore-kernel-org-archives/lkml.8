Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D26C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC50206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648993;
	bh=J+3YkxKcZRYQRP+VnnMnH98zYMcjPCiYFjdt5zVCiu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KNLQTUXiW/us7D2ewAOgWSxV1I+LBZjeKUH5RAKBrbr+O8OcyX4vIHSnoqAW1PmDF
	 0BH0t+irUbOx3mRZcqJp/1N4o/xlAqCNsr4l6AnQIfi+yCEsagqU7KlQOsIKh/DBvl
	 LjAbYZ0pUsaDwm+loxcvd/FodOWU7NOEuS/HM6vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgDKXEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgDKXEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2101721744;
        Sat, 11 Apr 2020 23:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646247;
        bh=J+3YkxKcZRYQRP+VnnMnH98zYMcjPCiYFjdt5zVCiu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNGqvAP1vsVZiNED0wN66wA/RbYMC0lFOnH/7s3M41AcsUw164zEZLn/tF4aAEmQ4
         aezUKA1cWQqskN561XamZ0ESs27StxPlTTDCXmFqBqbL+KqBW16Gsb3s7qWNehb/+e
         rQj0CaZOqFWAGrAA4ygHQlkaOIHeiXUdGF3m6USk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 015/149] drm/amd/display: Explicitly disable triplebuffer flips
Date:   Sat, 11 Apr 2020 19:01:32 -0400
Message-Id: <20200411230347.22371-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
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
index b9853fd724d60..f2850f5b0808c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2909,6 +2909,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
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

