Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CB3C3B1B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C192187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703993;
	bh=UNXwE98Mu85rA9p2dkQ9MB+eiVe3mpaGpj4PfdIK/5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nASe4VxMbIRJ9QS6BxKCiN7zoaR7YPMDLG9a1Khsvkl3Mp3tj3sKjBSksv42YYlX/
	 aD+H8/xBBZWDxu7pT8I6W39+pom/d6uXZGpr+wMyRCF1IFUjetQoFNRbKvHlpQHdyT
	 djIQr4+ZC/jqq3mnDHX+uGVS+aRNUS5ZxWy8dms8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgBNPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730998AbgBNPwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B925E222C4;
        Fri, 14 Feb 2020 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695549;
        bh=UNXwE98Mu85rA9p2dkQ9MB+eiVe3mpaGpj4PfdIK/5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p64KxhxlvlJexcXidOY5I2kpmSykadOODJ5rzSw8xyfJn9EezOA0dClmInDNjIvMq
         IR4QE0QUy5LQmkQEm5h+w//SE4+Eb1agXgwjqbud48SCJO2EfzxNuMMv37Zojvkykx
         6O350G24nUdDtJf0L5s4iePINaK4z1nyvGJjvmxI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 165/542] drm/radeon: remove set but not used variable 'blocks'
Date:   Fri, 14 Feb 2020 10:42:37 -0500
Message-Id: <20200214154854.6746-165-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
index c18ae15189f36..87794123e5e4d 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -2638,7 +2638,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 {
 	struct drm_device *dev = rdev->ddev;
 	u16 offset, misc, misc2 = 0;
-	u8 rev, blocks, tmp;
+	u8 rev, tmp;
 	int state_index = 0;
 	struct radeon_i2c_bus_rec i2c_bus;
 
@@ -2731,7 +2731,6 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 		offset = combios_get_table_offset(dev, COMBIOS_POWERPLAY_INFO_TABLE);
 		if (offset) {
 			rev = RBIOS8(offset);
-			blocks = RBIOS8(offset + 0x2);
 			/* power mode 0 tends to be the only valid one */
 			rdev->pm.power_state[state_index].num_clock_modes = 1;
 			rdev->pm.power_state[state_index].clock_info[0].mclk = RBIOS32(offset + 0x5 + 0x2);
-- 
2.20.1

