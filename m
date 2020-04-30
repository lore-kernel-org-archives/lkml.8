Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52750C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E784206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255880;
	bh=1LZPEe39UMnjvcdUsIgtXXcaZV3h47Euw7lnX/jEmRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFVH141+8hIseuWXENwcuA3b6waFLuc849L4hcUud0dTTu8l9cUIMc6d0Ir/46Un+
	 p7WxIvXm5KJGvlv6QNuB+Hfn8mNLoDWFn3CB+NqKA/P5cJoCsxeN6Z3JftP9MR3Zb7
	 bUYZWIsYpog6+D9D2+qU4/S2kObTgAZ1SWU0Msag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD3OLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbgD3Nv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:51:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D06BB2137B;
        Thu, 30 Apr 2020 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254687;
        bh=1LZPEe39UMnjvcdUsIgtXXcaZV3h47Euw7lnX/jEmRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2V4ankSg1LXv2x+qjUkv3aFSLRX9KbEtHQlXnGY6AuUBvGXEJ5FdWjmutKUDz3uo
         J480RKbzpW4i33ufxdJOvXTaYq24Yoad3RlBSGGE90cAueWM6Z0i2kJDYHSkURtH+U
         C1Gx3Ng+AUslP65vq07jScIfvYh/1mAPT9FuBglE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prike Liang <Prike.Liang@amd.com>,
        Mengbing Wang <Mengbing.Wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 38/79] drm/amd/powerplay: fix resume failed as smu table initialize early exit
Date:   Thu, 30 Apr 2020 09:50:02 -0400
Message-Id: <20200430135043.19851-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 45a5e639548c459a5accebad340078e4e6e0e512 ]

When the amdgpu in the suspend/resume loop need notify the dpm disabled,
otherwise the smu table will be uninitialize and result in resume failed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index f7a1ce37227cd..4a52c310058d1 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -889,12 +889,17 @@ static int renoir_read_sensor(struct smu_context *smu,
 
 static bool renoir_is_dpm_running(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	/*
 	 * Util now, the pmfw hasn't exported the interface of SMU
 	 * feature mask to APU SKU so just force on all the feature
 	 * at early initial stage.
 	 */
-	return true;
+	if (adev->in_suspend)
+		return false;
+	else
+		return true;
 
 }
 
-- 
2.20.1

