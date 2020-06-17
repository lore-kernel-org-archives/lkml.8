Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23799C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0086221556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="ankX+yV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgFQUxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:53:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F418C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:53:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n9so1503575plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rkwd2ka8Z7iO2pJxHXIRpwXonoZgh2tKHVmhTEheWDo=;
        b=ankX+yV3pTmnsA/EifSsAOqJzVbig1w1EwLxdujI9nqFQz069s7Fk775dKVyb77dZz
         lsPW2YGgbcyA3+CjH4idHRgLZ94mALQ2IjTUKoioyiNO8+//px24k4CRWfcNgZThRtrV
         SrVLqkHIkdcIAG+Ajf9KeNtMOuZC+3HGLZ/nRTDRer73f/76QobJZP52SyTCPDWBrtOP
         M7nvex6ZuDmGWg8hUvoB+co44d9rgwp6dVbl3WtsAK5Oz/bvPtC+dxGri4nOmSMHWZVV
         ciZ+p0m+yFcsotHidWlmJg1FcX0M3/PgJG2tzDLv0qYXaNrqFbr4RREJ9ZjJPMJlaxmO
         QEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rkwd2ka8Z7iO2pJxHXIRpwXonoZgh2tKHVmhTEheWDo=;
        b=LtklGP/mv8ZFSndczqmG1GMN74jZUoBs/lxVfFp/3dIu49AGYASGiEw9fV2pa4JvXH
         0jUZ9+48J3SkPiO4RLiJ8Ky9ZkAz/os35yLc+p7RM/cUKg5XVm47n/p2Uh5EsF8vj0cX
         knmr2mwqRiGbpYyJh1mVCt6ipDCQZ0BydaEowGuZ1KnnonBbSpGqa1doeApqqSxSrtZ2
         ueZQReN+/eQfHESZaq1VxV8gToCiSquj9L9m0yxtIMvYseLMIW7AWUg9E9hDqFnqGiJD
         MXhe7nrhjZCFPGPmIzVYm/9m6slXKHDoBMjFIZauafU13HO+mgAMb0JFeZf1wy/gtBS6
         Cv1A==
X-Gm-Message-State: AOAM5331POQGeOD0/S9cSu+jzqJLC0GcY8z2hHuNbOtdMz7sZQMb+byR
        hZ0wyLB7UfsI2vbY+YpOMhEczw==
X-Google-Smtp-Source: ABdhPJwJ2UTlCE2dQ2laBUA/pxpoSp23Y3LfsK2W24qN8hJszwXs3PuSNGnOaofSqf1abQraw6x8yg==
X-Received: by 2002:a17:90a:2683:: with SMTP id m3mr859532pje.196.1592427206091;
        Wed, 17 Jun 2020 13:53:26 -0700 (PDT)
Received: from miranda.anholt.net (c-73-11-63-120.hsd1.or.comcast.net. [73.11.63.120])
        by smtp.gmail.com with ESMTPSA id ca6sm392454pjb.46.2020.06.17.13.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:53:25 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/2] drm/msm: Fix setup of a6xx create_address_space.
Date:   Wed, 17 Jun 2020 13:53:10 -0700
Message-Id: <20200617205310.2183722-2-eric@anholt.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617205310.2183722-1-eric@anholt.net>
References: <20200617205310.2183722-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want it under CONFIG_DRM_MSM_GPU_STATE, we need it all the
time (like the other GPUs do).

Fixes: ccac7ce373c1 ("drm/msm: Refactor address space initialization")
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a1589e040c57..7768557cdfb2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -893,8 +893,8 @@ static const struct adreno_gpu_funcs funcs = {
 #if defined(CONFIG_DRM_MSM_GPU_STATE)
 		.gpu_state_get = a6xx_gpu_state_get,
 		.gpu_state_put = a6xx_gpu_state_put,
-		.create_address_space = adreno_iommu_create_address_space,
 #endif
+		.create_address_space = adreno_iommu_create_address_space,
 	},
 	.get_timestamp = a6xx_get_timestamp,
 };
-- 
2.26.2

