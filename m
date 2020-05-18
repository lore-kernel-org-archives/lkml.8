Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2275C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE50320715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824616;
	bh=qQJ8XuGD1yqiYvBBlA+XTk9Ka7sBVbNnfFgy4ubIWrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZyAuZ2Er6SoKfSUpVnped/U5bUTgGlKpl7Uh7w+KjKV71r3hpTqFo1Hlv3H0GT6k3
	 wey3At9fWAcJ9Y+rkrI95Gd5m1aahSl3Z7i/UAoZeutsWQAT6A1zEEGU+zncVhF3mo
	 CP83rpAsBSX2WSABzmsa8kcI4gWzi4goOXnzdVBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgERR4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731705AbgERR4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:56:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253E020674;
        Mon, 18 May 2020 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824612;
        bh=qQJ8XuGD1yqiYvBBlA+XTk9Ka7sBVbNnfFgy4ubIWrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qg1gSl5a+YwEJlTbPJMdTUNVAgyG2xoeAEej3HIGjJhPYQKBIWUAr2yXD6idGdE7x
         H9aF13CBDXiWoIOd2CCCvyfTYuLZx5JyDiH7xsgLx0POFNJoEtRRXVcCe1vjiu4iLM
         c7h9BvrJYi5MGK7v9EAY+QJ0dL/G06htDk2fCZm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Tiecheng Zhou <Tiecheng.Zhou@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/147] drm/amd/powerplay: avoid using pm_en before it is initialized revised
Date:   Mon, 18 May 2020 19:36:07 +0200
Message-Id: <20200518173519.543648334@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>

[ Upstream commit 690ae30be163d5262feae01335b2a6f30569e5aa ]

hwmgr->pm_en is initialized at hwmgr_hw_init.

during amdgpu_device_init, there is amdgpu_asic_reset that calls to
soc15_asic_reset (for V320 usecase, Vega10 asic), in which:
1) soc15_asic_reset_method calls to pp_get_asic_baco_capability (pm_en)
2) soc15_asic_baco_reset calls to pp_set_asic_baco_state (pm_en)

pm_en is used in the above two cases while it has not yet been initialized

So avoid using pm_en in the above two functions for V320 passthrough.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index d306cc7119976..8bb5fbef7de0f 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1425,7 +1425,8 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -1459,7 +1460,8 @@ static int pp_set_asic_baco_state(void *handle, int state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_asic_baco_state)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->set_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.20.1



