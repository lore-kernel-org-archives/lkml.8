Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD175C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2622082F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="NpuYUeVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGMWzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGMWzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:55:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1DCC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e11so13971921qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=New9UmLqwAEZ7YVR5w884jDB8P12ia0wbeaOMNqWR50=;
        b=NpuYUeVRDRTXdO3EHACL8xTWzqkqyTLGgKUmKInSBZrQyCqqJxUjcm46yIpObgFD8w
         1olATxpFlcAKhNuAPT1AHSDrCKmwE+Su5hN0RxTEZi4t4B071EJ8SmzUh0MWWMs5Qeah
         LWTPs9g/luhs3MFYiGywu8ulMJ3YwLmvRjaNOg7LZcaKWlGWI0vc8V/zNlEN5azBTuKf
         uOUzltcAp8/mjJJRH+GZJwVbWQX/aiezLPb2crOxf3XUJHkeEKiOfuQbF80SRs2xZAgV
         Kw98JuN6XjH8izK2N/qpTN8/y7PsaDEyfmZnx2y9g2dsPZ6WT+DLZo8LDwaAtIbOvDVq
         mg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=New9UmLqwAEZ7YVR5w884jDB8P12ia0wbeaOMNqWR50=;
        b=oc0Rgmq9rteQB+OywSIf0phorljWfljvWzHcI8sdKO1eKvtlZyaisCIjOfs8Tu2bJA
         9lsHrQktk7JIEqm27clOelv0JuMygaPuyzOV9nhoprWRLkZ8U+kC3SQjoyMgW8dfkFiw
         b5iE5KcwIfKbXxuj03pq7uIB//VKc4BdmIBskL7Bh6rNjvoFIiBKigT2MjTgOoXHf305
         LyoQSOmGP0M1p2462GaJvY4vrQuV2YWF94gMYYUu1Gr6tmyjYKtlefeRjDjMF/IW3quE
         nkKZ8lNN0jL62OqZ4rXkuS2vfQiBHt0L9p5VKDV0I49QQMC1d8rjiiWM9kGREpWfVRO/
         pg3g==
X-Gm-Message-State: AOAM5336sKRZqEdEp5EbzQvi35Uzr2c9Y4RH0Xs4fHojSNb3yq8MXPrt
        /SogNwctNrNmWlMy3woVCgZWrQ==
X-Google-Smtp-Source: ABdhPJwPhMQAQGKtHB2AxxPSDzaZIttG7vUs6x4x2pNtdoh23c7sQy9Cmx61GQ6sVuYVowXuaGif5A==
X-Received: by 2002:a05:620a:1649:: with SMTP id c9mr1886192qko.330.1594680914570;
        Mon, 13 Jul 2020 15:55:14 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id f54sm22405752qte.76.2020.07.13.15.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:55:14 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/3] drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init,cleanup}
Date:   Mon, 13 Jul 2020 18:53:40 -0400
Message-Id: <20200713225345.20556-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713225345.20556-1-jonathan@marek.ca>
References: <20200713225345.20556-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adreno_gpu_init calls pm_runtime_enable, so adreno_gpu_cleanup needs to
call pm_runtime_disable.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 89673c7ed473..ad64d4b7e8d7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1021,11 +1021,14 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 {
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct msm_drm_private *priv = gpu->dev->dev_private;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	pm_runtime_disable(&priv->gpu_pdev->dev);
+
 	icc_put(gpu->icc_path);
 	icc_put(gpu->ocmem_icc_path);
 
-- 
2.26.1

