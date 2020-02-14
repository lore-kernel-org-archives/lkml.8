Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B82C3B1B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A2F222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703951;
	bh=vMAIxQCEcBteBvTjRTi8zaQHQRbcimfsWflvIWcKtRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OgBXT9ESCjp+72HF+uM2VtUBS9mf3/iP8UyIroTDbIV11gROmWsRjSCZIgLjjqZds
	 c/X14YuNCXIYs1x7sY4BDlwVDt+qfaVhY5YRwZgQ8Lt37juWLvOjJ7oyl6aFm0c2wT
	 UqyIzxMiQpgy7YeR3qpaBEzkHOxRCvC2XpG64aX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgBNPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbgBNPwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EBAA222C4;
        Fri, 14 Feb 2020 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695567;
        bh=vMAIxQCEcBteBvTjRTi8zaQHQRbcimfsWflvIWcKtRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDL04vJppJ0l+GABfBMUIv6b6NtLE2FsRO9U0wMUGo9gTfxkZId1yqNmCYbYSt1SA
         VIicDTk8+PyuIvvX7uVIohyZIK4hneJaJBgaHMVlZ2g5XhvY4pjj4Caq2+W/L5H8wy
         GLBvvxFABO79+xCE/Aw0g/zxdwG+PWAZDME+Xoho=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thong Thai <thong.thai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 179/542] Revert "drm/amdgpu: enable VCN DPG on Raven and Raven2"
Date:   Fri, 14 Feb 2020 10:42:51 -0500
Message-Id: <20200214154854.6746-179-sashal@kernel.org>
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

From: Thong Thai <thong.thai@amd.com>

[ Upstream commit d515959125f24767d02e82587a11e444eeba0e7b ]

This reverts commit a4840d91c984f93b2acdcd44441d624bbc1af0d2.

Reverting due to power efficiency issues seen on Raven 1 and 2
when DPG mode is enabled.

Signed-off-by: Thong Thai <thong.thai@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8e1640bc07aff..04ea7cd692955 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1145,9 +1145,7 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_SDMA_LS |
 				AMD_CG_SUPPORT_VCN_MGCG;
 
-			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
-				AMD_PG_SUPPORT_VCN |
-				AMD_PG_SUPPORT_VCN_DPG;
+			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
 		} else if (adev->pdev->device == 0x15d8) {
 			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 				AMD_CG_SUPPORT_GFX_MGLS |
@@ -1190,9 +1188,7 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_SDMA_LS |
 				AMD_CG_SUPPORT_VCN_MGCG;
 
-			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
-				AMD_PG_SUPPORT_VCN |
-				AMD_PG_SUPPORT_VCN_DPG;
+			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
 		}
 		break;
 	case CHIP_ARCTURUS:
-- 
2.20.1

