Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D7421531
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888100;
	bh=0YfuMbFx9l4rztSMus9UB0yQ2JVVa35hHbGtP153sd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExGquMy6IjaTLnNHeLtZLBlt5ATWc0yZZ8z2X7j5Y9W5LXwn4HELiIM4LkRbrHkey
	 inkXpRbkSTIH/8uenau+0OiDBOUV7Yep3DwsDUMDTbEKGzqF+AQWF5mNAgO04z5NdB
	 18CLEtF4mZio68BYOrKasPQpQJaRXJcOCPDz3mPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgHaPbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgHaPa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDD1215A4;
        Mon, 31 Aug 2020 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887859;
        bh=0YfuMbFx9l4rztSMus9UB0yQ2JVVa35hHbGtP153sd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBy940Mb9kRYyKp8h5Per8VPjGsMkI1exngY5tFLKmi445TJRn/Lt4r6YIlxeNqGL
         u8OcOO5lx2xFOZS0uxVKR01XegL+Drsio02hCnBqLCtr3gdjOf+NSZXNrN3lYKfpMa
         GLnKWgex1mQKgH8MfD5R1CneljOtdgBgb3omsXuY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 12/23] drm/msm/a6xx: fix gmu start on newer firmware
Date:   Mon, 31 Aug 2020 11:30:28 -0400
Message-Id: <20200831153039.1024302-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153039.1024302-1-sashal@kernel.org>
References: <20200831153039.1024302-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit f5749d6181fa7df5ae741788e5d96f593d3a60b6 ]

New Qualcomm firmware has changed a way it reports back the 'started'
event. Support new register values.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9ea748667fab0..40431a09dc97c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -199,12 +199,22 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
 {
 	int ret;
 	u32 val;
+	u32 mask, reset_val;
+
+	val = gmu_read(gmu, REG_A6XX_GMU_CM3_DTCM_START + 0xff8);
+	if (val <= 0x20010004) {
+		mask = 0xffffffff;
+		reset_val = 0xbabeface;
+	} else {
+		mask = 0x1ff;
+		reset_val = 0x100;
+	}
 
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 0);
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_CM3_FW_INIT_RESULT, val,
-		val == 0xbabeface, 100, 10000);
+		(val & mask) == reset_val, 100, 10000);
 
 	if (ret)
 		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
-- 
2.25.1

