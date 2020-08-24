Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E2DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3C12063A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289223;
	bh=iW5TFqh9aHKAWPpFm5d7hKY+aJrXMq3MTvrhKwmjeqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NDiAwgR20m+4nWAQDyJATRXtLsNEwtYxNnGM8Bxel2nMrNlU5l7Rz8MuwfoNeWlw0
	 hYqa0UgSSVVwmK8bQHJaLSh9UlmY9PNbsvQkgNXY7i2NSJzPoaMz75tkxAHbTlXuxB
	 fUF4gBup6Sd4o+SCAsMpoE6+b43E4X39VK0zEaBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgHXRNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgHXQhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:37:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB0E22E00;
        Mon, 24 Aug 2020 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287016;
        bh=iW5TFqh9aHKAWPpFm5d7hKY+aJrXMq3MTvrhKwmjeqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vo9TpUMMMGXWtqj2Y8zaY+GD9P+GzltzFBTeDOYVgz3Mx3XCSM9dMBO8S0lPPPSna
         lJGmIV3SNF7IfWEhI2cE2EOENOvSo7jHPXSskTVaHjpQlQFT0TFNxP41s4UqrQKBDy
         7RwKz2WgsQuGTQjQ1/3poH3JDACCR0UDk/s2iNuI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 16/54] drm/amd/powerplay: correct Vega20 cached smu feature state
Date:   Mon, 24 Aug 2020 12:35:55 -0400
Message-Id: <20200824163634.606093-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 266d81d9eed30f4994d76a2b237c63ece062eefe ]

Correct the cached smu feature state on pp_features sysfs
setting.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 08b6ba39a6d7c..f714d65de07e1 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -985,27 +985,15 @@ static int vega20_disable_all_smu_features(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-	uint64_t features_enabled;
-	int i;
-	bool enabled;
-	int ret = 0;
+	int i, ret = 0;
 
 	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_DisableAllSmuFeatures)) == 0,
 			"[DisableAllSMUFeatures] Failed to disable all smu features!",
 			return ret);
 
-	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
-	PP_ASSERT_WITH_CODE(!ret,
-			"[DisableAllSMUFeatures] Failed to get enabled smc features!",
-			return ret);
-
-	for (i = 0; i < GNLD_FEATURES_MAX; i++) {
-		enabled = (features_enabled & data->smu_features[i].smu_feature_bitmap) ?
-			true : false;
-		data->smu_features[i].enabled = enabled;
-		data->smu_features[i].supported = enabled;
-	}
+	for (i = 0; i < GNLD_FEATURES_MAX; i++)
+		data->smu_features[i].enabled = 0;
 
 	return 0;
 }
@@ -3215,10 +3203,11 @@ static int vega20_get_ppfeature_status(struct pp_hwmgr *hwmgr, char *buf)
 
 static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfeature_masks)
 {
-	uint64_t features_enabled;
-	uint64_t features_to_enable;
-	uint64_t features_to_disable;
-	int ret = 0;
+	struct vega20_hwmgr *data =
+			(struct vega20_hwmgr *)(hwmgr->backend);
+	uint64_t features_enabled, features_to_enable, features_to_disable;
+	int i, ret = 0;
+	bool enabled;
 
 	if (new_ppfeature_masks >= (1ULL << GNLD_FEATURES_MAX))
 		return -EINVAL;
@@ -3247,6 +3236,17 @@ static int vega20_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
 			return ret;
 	}
 
+	/* Update the cached feature enablement state */
+	ret = vega20_get_enabled_smc_features(hwmgr, &features_enabled);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < GNLD_FEATURES_MAX; i++) {
+		enabled = (features_enabled & data->smu_features[i].smu_feature_bitmap) ?
+			true : false;
+		data->smu_features[i].enabled = enabled;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

