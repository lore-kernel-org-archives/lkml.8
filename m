Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E8C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4707207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193080;
	bh=43IpqdQaWzPH8hN72dXndhwU9UA/oomVVHL1K91Yszw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dW9FvpE74gE7I4GYdnkJ7HARpxTwCIwZozVVbXXLUxcbwRcdpkbL4Wij20rErialO
	 SPz5TtpcTNyJ3mc9pkEl4A4tY4tT20TfIUYzV/ZbUqSwCbfYPLoFxVMm0keQqdE5c6
	 dpIJBC4oQhD5Qctlu+QcwEl+VjP5Cn6pNT0g5p/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgAPQoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgAPQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:44:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68118208C3;
        Thu, 16 Jan 2020 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193075;
        bh=43IpqdQaWzPH8hN72dXndhwU9UA/oomVVHL1K91Yszw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfXBe3FxWcQGdUswqAW8lqQ867j3J5QQvHuRpN5t48IzIUKnJ+3vxtwpCmr6uG2ea
         u+smZdMrlBUh6IgWTAqdfE2YSyaDZ7F8vVc4rQmR08SLSCXCLCXT+V5NeWoZ3HCrL7
         wSpV4BF4QK0pvPcAbG+043ToSNZPO8a2WW8JXbtQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 019/205] drm/amdgpu: remove excess function parameter description
Date:   Thu, 16 Jan 2020 11:39:54 -0500
Message-Id: <20200116164300.6705-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit d0580c09c65cff211f589a40e08eabc62da463fb ]

Fixes gcc warning:

drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:431: warning: Excess function
parameter 'sw' description in 'vcn_v2_5_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:550: warning: Excess function
parameter 'sw' description in 'vcn_v2_5_enable_clock_gating'

Fixes: cbead2bdfcf1 ("drm/amdgpu: add VCN2.5 VCPU start and stop")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 395c2259f979..9d778a0b2c5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -423,7 +423,6 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Disable clock gating for VCN block
  */
@@ -542,7 +541,6 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
  * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Enable clock gating for VCN block
  */
-- 
2.20.1

