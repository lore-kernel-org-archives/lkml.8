Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB2EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A761246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698103;
	bh=4gpuPKxIJXblhGLDI+y2KBiclaBaNI5Q/MfBXm87de0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ihXQJ/RWyEDgfRHmq496ttF4nEkwNHV/sK4LzinWo9Q3XqEskST6g1TvWhVFtCa76
	 wWYQlVL5HoX49ZUaZGSLxg9dMz9bGQUhxQaGcVpL0UwudCK6qylLcJJpYWpk6HU12Z
	 GEWtrD6qHCoNjY+3R7kQnXoqPS02vZDWL2g+uDvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406209AbgBNQfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406004AbgBNQYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1230E247AC;
        Fri, 14 Feb 2020 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697492;
        bh=4gpuPKxIJXblhGLDI+y2KBiclaBaNI5Q/MfBXm87de0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHTlbB3l66WE/HZryLYiLqIVPfq1ujj/Q6oDzIymNHF+/RXBiPyzAruCB/fTgXMbG
         TwBz0dzb7bNf4PxQ99BnCPzCPjp8XcsvsyEbWfGbJs/BJQHwydHvKXV8qOMcLZfvy2
         E3A8X+TkcB+a2UGa9rU+k7HlC+YA/ki2Pd+IxQJ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 022/100] drm/amdgpu: remove set but not used variable 'dig_connector'
Date:   Fri, 14 Feb 2020 11:23:06 -0500
Message-Id: <20200214162425.21071-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit 5bea7fedb7fe4d5e6d3ba9f385dd3619fb004ce7 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/atombios_dp.c: In function
‘amdgpu_atombios_dp_get_panel_mode’:
drivers/gpu/drm/amd/amdgpu/atombios_dp.c:364:36: warning: variable
‘dig_connector’ set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 7f85c2c1d6815..120a5fd992081 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -363,7 +363,6 @@ int amdgpu_atombios_dp_get_panel_mode(struct drm_encoder *encoder,
 			       struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
-	struct amdgpu_connector_atom_dig *dig_connector;
 	int panel_mode = DP_PANEL_MODE_EXTERNAL_DP_MODE;
 	u16 dp_bridge = amdgpu_connector_encoder_get_dp_bridge_encoder_id(connector);
 	u8 tmp;
@@ -371,8 +370,6 @@ int amdgpu_atombios_dp_get_panel_mode(struct drm_encoder *encoder,
 	if (!amdgpu_connector->con_priv)
 		return panel_mode;
 
-	dig_connector = amdgpu_connector->con_priv;
-
 	if (dp_bridge != ENCODER_OBJECT_ID_NONE) {
 		/* DP bridge chips */
 		if (drm_dp_dpcd_readb(&amdgpu_connector->ddc_bus->aux,
-- 
2.20.1

