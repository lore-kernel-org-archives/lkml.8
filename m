Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC84C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E5721D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047457;
	bh=Lbzwri5nAQnSVBDvl0p+EY0f92hs81UTtQlOYaKPuEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nLo+cAnz7Ri6AR03t3LZZi1QsiQqBg8xD2xxSvzZw3jtUE3upufAVn4rNjykSYS4G
	 8ub+xLC2FFZVqnDujBzBBnpdtpfSy+Ix8jMfmhocm0dttQsQComt90kARXhJ36ow80
	 fI/3WmDHWHflYjcYPHFcmNcwjPTUXoQ/82WeOoj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394283AbgDPOay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409549AbgDPOB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:01:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3878420786;
        Thu, 16 Apr 2020 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045716;
        bh=Lbzwri5nAQnSVBDvl0p+EY0f92hs81UTtQlOYaKPuEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dS6naBGqG6l41IbpYStg6V8cNFTsqd2Xkns1neuuVo4qRQ1+GqiGpJqO3EO7VUsb4
         hIvforfUcuMTl2at2Bh1sGpI93u6zO60Pj/dNvpTTTsWKs3q99Bu/z6NAS1JOVeHVG
         GiagVM37YxyTHF4xdwdEVruzzSREIl1q8zVvBT1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>,
        Mengbing Wang <Mengbing.Wang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 248/254] drm/amdgpu: fix gfx hang during suspend with video playback (v2)
Date:   Thu, 16 Apr 2020 15:25:37 +0200
Message-Id: <20200416131356.670036614@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 487eca11a321ef33bcf4ca5adb3c0c4954db1b58 ]

The system will be hang up during S3 suspend because of SMU is pending
for GC not respose the register CP_HQD_ACTIVE access request.This issue
root cause of accessing the GC register under enter GFX CGGPG and can
be fixed by disable GFX CGPG before perform suspend.

v2: Use disable the GFX CGPG instead of RLC safe mode guard.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b8975857d60d6..48e2863461b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2285,8 +2285,6 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -3309,6 +3307,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		}
 	}
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	amdgpu_amdkfd_suspend(adev);
 
 	amdgpu_ras_suspend(adev);
-- 
2.20.1



