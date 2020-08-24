Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46142C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240CA2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289620;
	bh=MfEec4LKwZbSGmVBjxEXLp20zqULv2HlhoxMSBkqu10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2wEvnT6C/fTaWXJEYQR2DWlOBa5gxC7O7Na0bEoVsxxwMEzybfiB1Tkz/549gRJv
	 as9ilO7dWxNnLlD6vg1N7ygbLWBKtse3PsZgerFDBph146eDWIOpRwmNBEjiLMb7AK
	 kcc+H2InzYeS0L8MVKdSUJLr5ALKCw4YX+j9TsLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgHXRUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgHXQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:36:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549F922C9F;
        Mon, 24 Aug 2020 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286984;
        bh=MfEec4LKwZbSGmVBjxEXLp20zqULv2HlhoxMSBkqu10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zxwj/o1fYyUj1liI+cCRn4kwLzkhHCMiNQ7bhGIvyAjRt3Mz35YuO2lD3zA1SQEVV
         /Rfa3F5wsBxueX/J0O5u5AmyYlVocKTnlogdumrYEcH6TtMa66uC5QDkIPimA5W5Ea
         N4RSMfm59Hnoo4e67bm0W5MP0i5CXYophD9+VRgE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiansong Chen <Jiansong.Chen@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 58/63] Revert "drm/amdgpu: disable gfxoff for navy_flounder"
Date:   Mon, 24 Aug 2020 12:34:58 -0400
Message-Id: <20200824163504.605538-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiansong Chen <Jiansong.Chen@amd.com>

[ Upstream commit da2446b66b5e2c7f3ab63912c8d999810e35e8b3 ]

This reverts commit 9c9b17a7d19a8e21db2e378784fff1128b46c9d3.
Newly released sdma fw (51.52) provides a fix for the issue.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2c870ff7f8a45..fac77a86c04b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3427,9 +3427,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		break;
 	default:
 		break;
 	}
-- 
2.25.1

