Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C86C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE712067D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425387;
	bh=r4h0h0vNmAe26MlCqgqj9TQfWY49lPNNCtdDgv9Pe6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K83YPKRxNg4fiagopTRD5gdjcjLVeqllgK5Zw1feJCgzRLFLdoklcfK/TChBxeKST
	 kW9yi6BkunUhukXutDJyYs070gkPYA+EFoZWumcXAu9xW1o9OL3oUSaVvbccsWJs0c
	 dKcQi2XNrZ9GUGe/DiOZwobGs9bGvc579mo7Ryvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBWCWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbgBWCVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:21:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4572192A;
        Sun, 23 Feb 2020 02:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424509;
        bh=r4h0h0vNmAe26MlCqgqj9TQfWY49lPNNCtdDgv9Pe6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmxzgkbhdK8/m/C2Kqnza6vEp8Q54Do8dT7HLUgMC7lP6vpTG/eqG7gr17gtYnL6F
         1Beldf0czJvQpMAZw4wtP2xvcJWNqE2d6Z+5+0enc6KfaF0s+u5AKRrNDtB1HUd20+
         dCunEmLZ0OuTLvZ8k/CFAYbyOWfEeWD+ZFxdT55o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aric Cyr <aric.cyr@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 24/58] drm/amd/display: Check engine is not NULL before acquiring
Date:   Sat, 22 Feb 2020 21:20:45 -0500
Message-Id: <20200223022119.707-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit 2b63d0ec0daf79ba503fa8bfa25e07dc3da274f3 ]

[Why]
Engine can be NULL in some cases, so we must not acquire it.

[How]
Check for NULL engine before acquiring.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 793c0cec407f9..5fcffb29317e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -398,7 +398,7 @@ static bool acquire(
 {
 	enum gpio_result result;
 
-	if (!is_engine_available(engine))
+	if ((engine == NULL) || !is_engine_available(engine))
 		return false;
 
 	result = dal_ddc_open(ddc, GPIO_MODE_HARDWARE,
-- 
2.20.1

