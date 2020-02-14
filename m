Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440FEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A35624650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701958;
	bh=CgOBLdHrxGOXZAzERnI7Kbvc+MZaRctwhAPR2UygNZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dNj+oMdfhCmof4eTRZw6sfNP9aXpPxr/8ig6aA+IGtK0MG3J760LY/RukWFb4Z6Ys
	 mvk7JB+HB0ZV4dpLDVc2xMR91Dq/E3GC4eqQSiY29G4KI8I+LpwX8l5SiBNLqoFj1Y
	 Wwo9Kb6Qfuw212j0uTKTdU9ZghLfhkE7CbGa348U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394778AbgBNRjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389956AbgBNQEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:04:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2E524680;
        Fri, 14 Feb 2020 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696270;
        bh=CgOBLdHrxGOXZAzERnI7Kbvc+MZaRctwhAPR2UygNZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAQUOYZOg5E+S3YRR+ecwOcKeAW0J6t4gTIjFDajHZo/9N0wBowy9+ipMU7zT48o3
         RqPd6dlFbf/PVJTcX+QXIw92PQBkvVmO1CsgdyImFmZG823zV1QuY9waHwvfTCYq2c
         qIXuvV/lb7ia91ai0wjni2P6nnwKVcL3+bOir+js=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 121/459] drm/amdgpu: remove set but not used variable 'dig'
Date:   Fri, 14 Feb 2020 10:56:11 -0500
Message-Id: <20200214160149.11681-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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

[ Upstream commit d1d09dc417826f5a983e0f4f212f227beeb65e29 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/atombios_dp.c: In function
‘amdgpu_atombios_dp_link_train’:
drivers/gpu/drm/amd/amdgpu/atombios_dp.c:716:34: warning: variable ‘dig’
set but not used [-Wunused-but-set-variable]

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 94265306ab11f..ea702a64f8074 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -710,7 +710,6 @@ void amdgpu_atombios_dp_link_train(struct drm_encoder *encoder,
 	struct drm_device *dev = encoder->dev;
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
-	struct amdgpu_encoder_atom_dig *dig;
 	struct amdgpu_connector *amdgpu_connector;
 	struct amdgpu_connector_atom_dig *dig_connector;
 	struct amdgpu_atombios_dp_link_train_info dp_info;
@@ -718,7 +717,6 @@ void amdgpu_atombios_dp_link_train(struct drm_encoder *encoder,
 
 	if (!amdgpu_encoder->enc_priv)
 		return;
-	dig = amdgpu_encoder->enc_priv;
 
 	amdgpu_connector = to_amdgpu_connector(connector);
 	if (!amdgpu_connector->con_priv)
-- 
2.20.1

