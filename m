Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9548F2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288723;
	bh=fT7/KHv1jxEWmpF88afCfjuIPWXcmWAOdkZ5qUcHkNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dSArI2uYLiHOaeC5LC3FJzzRjZ+KJC+YbVXXEa8/0nbwIpxhjMDl8X5wvnj8ajxmT
	 gfGWwQY3fSg5T801BrxM/p57LGnxGrUgirGMD4ZHgk8ZZ5PoyDbQ9HXocgAkgmLV4Z
	 VPi6LMR7/s8cvdCqF90pAfyMapdsz/cHQqNwmeVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHXRFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgHXQie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8EC22EBE;
        Mon, 24 Aug 2020 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287091;
        bh=fT7/KHv1jxEWmpF88afCfjuIPWXcmWAOdkZ5qUcHkNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqZsHftrGdUU6e0m9DREgdBNm9lzUZRh/hBhlNvoj3s9i7VvJVz4K7uThKjcockOu
         KZ5AXo/L2ism9n8GWbWmwwYT9tkND+yGSDljruE3NnPrbNdxJ3C+hWIfkod+DtyTZ2
         KT2+cacu2dD+fKjP+CqP8Tu5zEYdW0ZTZgveLN58=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 15/38] drm/amd/powerplay: correct UVD/VCE PG state on custom pptable uploading
Date:   Mon, 24 Aug 2020 12:37:27 -0400
Message-Id: <20200824163751.606577-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 2c5b8080d810d98e3e59617680218499b17c84a1 ]

The UVD/VCE PG state is managed by UVD and VCE IP. It's error-prone to
assume the bootup state in SMU based on the dpm status.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 08b91c31532ba..947e4fa3c5e68 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -1640,12 +1640,6 @@ static void vega20_init_powergate_state(struct pp_hwmgr *hwmgr)
 
 	data->uvd_power_gated = true;
 	data->vce_power_gated = true;
-
-	if (data->smu_features[GNLD_DPM_UVD].enabled)
-		data->uvd_power_gated = false;
-
-	if (data->smu_features[GNLD_DPM_VCE].enabled)
-		data->vce_power_gated = false;
 }
 
 static int vega20_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
-- 
2.25.1

