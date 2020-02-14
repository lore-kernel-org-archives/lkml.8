Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97629C3B1A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676132468D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698217;
	bh=fFAY4u15hVnQZTtLDHb/0vJN8XTyQ+k5F3zCX4jEDm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oshfFtcWMVChc2s0Vo4CTkuqw8ung6DEOOCplj1YuesGMWUCYO5loMR/ofw3SqmV9
	 pN1MiGjNRuUg8clObZDhmVE7r2le8Errg/JPCGzIKq6YE1V1crLwSbxPFUwAZrg+ag
	 Sey7wWaDoi6hwIgxWDibOQ3JuuHuDciNYLfYxdtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405798AbgBNQYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393192AbgBNQWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D7724748;
        Fri, 14 Feb 2020 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697341;
        bh=fFAY4u15hVnQZTtLDHb/0vJN8XTyQ+k5F3zCX4jEDm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYv/fjGh7bmm/4V+4DpN9qhL8fD8cy0iJ2EwAzSdP9hPFBkLYNFBPCmN48UtJT4fS
         /c2g7CQyzT6M1lDuPdY72W3JylrkVXWqYZAfpeAW+WFdpOiPcB8S9cel+xExGi0Ezw
         GaaA52ZEewSh4avamOGbymT7hv3awwLqJ9u4MssA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 046/141] drm/radeon: remove set but not used variable 'blocks'
Date:   Fri, 14 Feb 2020 11:19:46 -0500
Message-Id: <20200214162122.19794-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 77441f77949807fda4a0aec0bdf3e86ae863fd56 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/radeon_combios.c: In function radeon_combios_get_power_modes:
drivers/gpu/drm/radeon/radeon_combios.c:2638:10: warning: variable blocks set but not used [-Wunused-but-set-variable]

It is introduced by commit 56278a8edace ("drm/radeon/kms:
pull power mode info from bios tables (v3)"), but never used,
so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_combios.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index 3178ba0c537c1..a01e52445ad11 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -2635,7 +2635,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 {
 	struct drm_device *dev = rdev->ddev;
 	u16 offset, misc, misc2 = 0;
-	u8 rev, blocks, tmp;
+	u8 rev, tmp;
 	int state_index = 0;
 	struct radeon_i2c_bus_rec i2c_bus;
 
@@ -2725,7 +2725,6 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 		offset = combios_get_table_offset(dev, COMBIOS_POWERPLAY_INFO_TABLE);
 		if (offset) {
 			rev = RBIOS8(offset);
-			blocks = RBIOS8(offset + 0x2);
 			/* power mode 0 tends to be the only valid one */
 			rdev->pm.power_state[state_index].num_clock_modes = 1;
 			rdev->pm.power_state[state_index].clock_info[0].mclk = RBIOS32(offset + 0x5 + 0x2);
-- 
2.20.1

