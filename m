Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02035C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FCD2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599591768;
	bh=P2MC/YP6p1guc9B/2z+SRDFbG5v6erQYKBki/Y+23eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHfDgo33FT6fQ9rt5BIdKEXRvxP/qI6/ERPGMg3cPTFVgchYmajjoelW/1kKRqqeN
	 /dlMeJm29DWaJpz5ymDs9CejDfTxJgcRARaX9BIDAV5TNf58yn+9BRPcEuQRpM9X/l
	 12A3qnhNq2I0oqGibKskP+Mym/sLHEWnfsk7aiWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgIHTCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbgIHQIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:08:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2A523ECD;
        Tue,  8 Sep 2020 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580048;
        bh=P2MC/YP6p1guc9B/2z+SRDFbG5v6erQYKBki/Y+23eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iy61xoxyg3REfMJrl34sSayM3CjA1uVpHl6pxJVO0mT/sf85Xe8LU6u48R5xjEAIQ
         yM2MHkFsA1YXUNReaAWjdZAuI/lhTBPGG9q+TWAfRGlHjM4VrEbPtpS2E6igbeOeDN
         Oq7UQnZLd21s8yH7mxGpm70f0UWBUoOFnvP7ja5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/88] drm/msm/a6xx: fix gmu start on newer firmware
Date:   Tue,  8 Sep 2020 17:25:11 +0200
Message-Id: <20200908152221.607307745@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
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
index 9cde79a7335c8..739ca9c2081a6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -117,12 +117,22 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
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
 		dev_err(gmu->dev, "GMU firmware initialization timed out\n");
-- 
2.25.1



