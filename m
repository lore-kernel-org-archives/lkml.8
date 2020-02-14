Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702BEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D50A24694
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697620;
	bh=BbCk7mBFBR2oC8Uwed7GuHX0ecD3lV9N3sMcICAK6qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2oQywBtpEdOp9K2KjhyrRZOTzQlNeeYNePWPrNxl55Qrex7oNLZSWjc15FxLV5fdW
	 8Oa7kTbzGWKFcKbV64CgbNrWZ9hXD2t3XhpMY9jnqNTP2xMa8DtpcetDViJ02Ivxmp
	 7kKPrFzfnr1SHCv1D8Vk5NeRaP8Z2NSYVq7ZuvFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406536AbgBNQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406035AbgBNQZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:25:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CBAE24791;
        Fri, 14 Feb 2020 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697505;
        bh=BbCk7mBFBR2oC8Uwed7GuHX0ecD3lV9N3sMcICAK6qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wwO8xE5pA/v1TGrM7QoT532a88ujl4mxLBu+KRRtY8GjfFi+jO9UneZFx9jh7R6a
         Mmw8yiCkKEOlbPGTSfchafrjaWMWnmQAjFDm22qnNV5YIgdaKjEgluzBWPQeIQBTY3
         oOmsnk7DDp4ivR7T1qNFv+XakrZUXAlVmtF8Tuz8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 032/100] drm/radeon: remove set but not used variable 'dig_connector'
Date:   Fri, 14 Feb 2020 11:23:16 -0500
Message-Id: <20200214162425.21071-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 3f47f0301594c4f930a32bd7d8125cfdeb6b4b6e ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/atombios_dp.c: In function radeon_dp_get_panel_mode:
drivers/gpu/drm/radeon/atombios_dp.c:415:36: warning: variable dig_connector set but not used [-Wunused-but-set-variable]

It is not used since commit 379dfc25e257 ("drm/radeon/dp:
switch to the common i2c over aux code")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/atombios_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
index 0c6216a6ee9e0..7eef575da63fa 100644
--- a/drivers/gpu/drm/radeon/atombios_dp.c
+++ b/drivers/gpu/drm/radeon/atombios_dp.c
@@ -413,7 +413,6 @@ int radeon_dp_get_panel_mode(struct drm_encoder *encoder,
 	struct drm_device *dev = encoder->dev;
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
-	struct radeon_connector_atom_dig *dig_connector;
 	int panel_mode = DP_PANEL_MODE_EXTERNAL_DP_MODE;
 	u16 dp_bridge = radeon_connector_encoder_get_dp_bridge_encoder_id(connector);
 	u8 tmp;
@@ -424,8 +423,6 @@ int radeon_dp_get_panel_mode(struct drm_encoder *encoder,
 	if (!radeon_connector->con_priv)
 		return panel_mode;
 
-	dig_connector = radeon_connector->con_priv;
-
 	if (dp_bridge != ENCODER_OBJECT_ID_NONE) {
 		/* DP bridge chips */
 		if (drm_dp_dpcd_readb(&radeon_connector->ddc_bus->aux,
-- 
2.20.1

