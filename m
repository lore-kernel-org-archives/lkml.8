Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E12CC35675
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0AA208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424589;
	bh=Y2gDl/DBouWsnZ7k9yTDr+JWTxGOv496eoFBcZNk5EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tJqpwqRipca5j6i41d11VkbGBCYjAmv2r9V5ISTk+TpmU+0me0sMAI4BgzFCCL2z0
	 81cEanAEQ2uCxkwHc6kXd1U7zjSwzccWWObVzrqk2Ji5+InCg/pa5CnCCqv0a5qVqL
	 1Rzr3M8c6IZoStILKZn66Ga2v6LE9Kljgh22zNEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgBWCXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbgBWCXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C809208C3;
        Sun, 23 Feb 2020 02:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424584;
        bh=Y2gDl/DBouWsnZ7k9yTDr+JWTxGOv496eoFBcZNk5EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyKMpp3SO5eO513O6RHlh8fg8pO/4d//+FUmK6ZzO/VNCNfrakHlvPDwNVjy096Fq
         7PUvkRPmyv8dmgZkZnVqo+ZIOomOZ2r5t705p1H8VgtfRRvho0E5fPdra/VdlA80ns
         JwXaTuSKayKMOtKMzJY8Zf5PPOjvgwOJgOKI/kfc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aric Cyr <aric.cyr@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 23/50] drm/amd/display: Check engine is not NULL before acquiring
Date:   Sat, 22 Feb 2020 21:22:08 -0500
Message-Id: <20200223022235.1404-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022235.1404-1-sashal@kernel.org>
References: <20200223022235.1404-1-sashal@kernel.org>
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
index c3f9f4185ce8d..cf877238fff9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -386,7 +386,7 @@ static bool acquire(
 {
 	enum gpio_result result;
 
-	if (!is_engine_available(engine))
+	if ((engine == NULL) || !is_engine_available(engine))
 		return false;
 
 	result = dal_ddc_open(ddc, GPIO_MODE_HARDWARE,
-- 
2.20.1

