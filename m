Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F66FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5001E20738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586569;
	bh=0YfuMbFx9l4rztSMus9UB0yQ2JVVa35hHbGtP153sd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeIhIlPdMvQOmkdRmG64FPgu+VATqmC3g4Eys6pjh+wote5/Ji+Dd54D3VitGhJ6F
	 4u73yZfFWvBE7InOUREqOqLsuYr50+AVq7Lyelfz+45d7q2c4J6ptJ9JLJdzW8vOqw
	 OhDxUIusHvc2vjuMBJHDlyeQB4Qz6dpEnAH7reSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgIHRgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731214AbgIHQOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CEE24818;
        Tue,  8 Sep 2020 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579827;
        bh=0YfuMbFx9l4rztSMus9UB0yQ2JVVa35hHbGtP153sd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mly1D0Oa48gNtfW+NBhBB4+PweHJRD3jomW5qbr1GFsBO8+09QBbo9sszIUrBqF+7
         HySH+/kLiQ/n4KxNJZZCRmE+wpjRl8pdj9d6IGoLhGf08S47SAvsNMoeFBkC9tw2DX
         eoHsJtb5niGP8lyGnf8jka99Mw9eIeiteYHfW/AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 010/129] drm/msm/a6xx: fix gmu start on newer firmware
Date:   Tue,  8 Sep 2020 17:24:11 +0200
Message-Id: <20200908152230.209249459@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



