Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8019C3B1A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A315724676
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695542;
	bh=CgOBLdHrxGOXZAzERnI7Kbvc+MZaRctwhAPR2UygNZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FKQESV39sQmy1TBwBwXwWyQBaq+8lz0mBL2TUf7e2IXizDofSRUe7NZBReAgRaG1B
	 ESuZiqk1Qmw4pSezFvJ2xUyWyNOOVWyzUN5adX3Wnm5H64mZcRmTlcOwTudF2wjv5S
	 qaSA/JB938FwCLsn/5DW2Jq11BJc/m8T+aA3dOtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgBNPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:52:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbgBNPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D541324682;
        Fri, 14 Feb 2020 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695518;
        bh=CgOBLdHrxGOXZAzERnI7Kbvc+MZaRctwhAPR2UygNZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luVmgP85q9laazLl9+MVub0IsqgxoX9B05u+OetQba6LWaSHHLF2J4yDM6IRcfZVT
         XurcHmgQrq5VaElQXZTqI1lXkmIvTh+4c48MkjWbVyMidhNK1TIqhDqT2qd21KWQ14
         wZi5gxD6G/5yHnkMD9sKE0L2NiXm2uodevLISIO0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 141/542] drm/amdgpu: remove set but not used variable 'dig'
Date:   Fri, 14 Feb 2020 10:42:13 -0500
Message-Id: <20200214154854.6746-141-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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

