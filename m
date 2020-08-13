Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0338DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A682078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Zey1i9YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHMSoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHMSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:44:28 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D687EC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:44:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so5139724qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i08DjFarJSioJFF+3BzXlzJrV3znYAwGrEz9J75FiX4=;
        b=Zey1i9YKtQygbzUDBlnW/AKCXPLBGNuzu5QshFKXWVoQGiehGBZWCktZt7P3kmrpyp
         etLXXJqJYrSLasI6L4DL57cfA+jq+WuaWJ/dPEgm2kOqm3bplNfFZIpdLzM7qO2fNPq7
         SI5LUPLrMuHlHu1uf/aInNBO05dHYBMtKk/hlVAFeX3t786TTYiuZEzAx4LXnEkK7I0e
         1p8k2gLsGsdxA6VIzuicHGDlI6A8b4Epw4DAlh/QfTuf/VfScE0xJyabJHg11CBxZeHE
         H0gbHy7e4Q3PbTQZ4meSA/pFmvsFfvHNyNKZ3BFuZp2OZnw9nKiJwvbWyHbdD+hYFFnb
         6FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i08DjFarJSioJFF+3BzXlzJrV3znYAwGrEz9J75FiX4=;
        b=TaICjO97X06WQTCz82rHxMwq27khSLcmk0duN2xZleL0uemZO+lMeITUsE/rOdX3tm
         ECNk0UqpFiMlANLJna4/18vve0d6f0UmSeY9ZeciJAX+z2hi3ztV7Qm2q1/v0lUSces/
         Y8yziYwNihoq8ebffo4MGAkTtFiM5ZcJQNVBsRUBf4XZITNNmqgafTfRG2cDji5qa8Sl
         n2ld9SLCz4Ox1y78VwKZzhZ7aJrJrKJMeNgSJjMgQOVdxNkURG9DIIzQwZXh5gMVv6xC
         l7jTE27yCZHgitQ9AZIZqbhAA030EsnPVeg2f6spUSAefqTDRZiLcV1/NQ13qgEaeDu0
         fp3Q==
X-Gm-Message-State: AOAM5304m+8a52m0n9UMVnHe1ZGYdxIFWBPYcKpTqrglKB+mZgEv8+X3
        nbmJLxM4hu4Kjw+bvhVMByVHug==
X-Google-Smtp-Source: ABdhPJyZpBHtFpCwUCN1Y5bRe8UUWA5ZmNxEvgqLYBigYpnTpeGmXkwoWEtaaNHcAVUMDbL7wZ6m1A==
X-Received: by 2002:aed:2946:: with SMTP id s64mr6816571qtd.204.1597344266044;
        Thu, 13 Aug 2020 11:44:26 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k5sm6415227qke.18.2020.08.13.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:44:25 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: fix frequency not always being restored on GMU resume
Date:   Thu, 13 Aug 2020 14:44:18 -0400
Message-Id: <20200813184420.18448-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch reorganizing the set_freq function made it so the gmu resume
doesn't always set the frequency, because a6xx_gmu_set_freq() exits early
when the frequency hasn't been changed. Note this always happens when
resuming GMU after recovering from a hang.

Use a simple workaround to prevent this from happening.

Fixes: 1f60d11423db ("drm: msm: a6xx: send opp instead of a frequency")
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index b67b38c8fadf..bbbd00020f92 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -845,6 +845,7 @@ static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
 	if (IS_ERR_OR_NULL(gpu_opp))
 		return;
 
+	gmu->freq = 0; /* so a6xx_gmu_set_freq() doesn't exit early */
 	a6xx_gmu_set_freq(gpu, gpu_opp);
 	dev_pm_opp_put(gpu_opp);
 }
-- 
2.26.1

