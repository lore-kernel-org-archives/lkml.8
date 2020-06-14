Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D91C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE56206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpz6lloD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFNGqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNGqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:46:08 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4FDC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:46:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id x189so5436471iof.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kNRgWSDrAxCQwXvPM8GfVhkSvHW0aGR2LY+D+JUgFPs=;
        b=tpz6lloDe6hYvlh6jsWmIipsRXWnPP0UiedPptwWGRKELFOHp/S4yk/xo3VPtk7RBd
         b8BFXR91yWxOWHo61kM6nPkTbM42uoBFw9J9MkGRlwsK++gjZyLouPCkub8FImugIyHD
         gQjzKQI8AU15T1efls+KhXfuI7SJm/+61arQDI1rwg80tqlkK3ojzpFaaHplhjzAWxxH
         qFdeORV4dtDSkk3i0W8wPQ1LR0WFdLrLCXWjQ4lqnaD+NOx5lYGizDu4Jng23mrTwoD+
         35vusyT4LgYIvIyLsCA3X3CVASUFkJSCVowZ7588w2xOJiYWn+WtI+MShm6sx1TzcyvN
         jh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kNRgWSDrAxCQwXvPM8GfVhkSvHW0aGR2LY+D+JUgFPs=;
        b=BNWkwlhNxGkriN+QSL5AQuJK392qh+YspwsjfcahssGHQ/17Pp92LkO5wdxwKRukzZ
         8SpZg4tauk96NM4ABRyAEcRYeBBWIXqmMx00L90bvSB7qyFZURQof36gi/vg8Hm242te
         jrY/bMwnfOj1MxOIi3CgAk/CeBEgCEzqcmmTSbhhJnAZ46U479YTUsuCOt58GhuGXR/U
         dxIgaidbWctOs5dQov7MVMCgsc7F5ftnFm8d6Kj6KQitBEzfBAmgvXH/FRlrLt1KrNa7
         nnEb2ZNE4s9CUdtj29yQL9Ic/fA3zlM8ftN89mqy5ldWb6wA2NCd7r4Iwnfd32ZCCFrx
         IOjg==
X-Gm-Message-State: AOAM533rWhPGTaWRYRNAQsfIzqaCf6J6DyepGo77iQDEyF1QsF3EInft
        Itf07wW/hunyc6O9DXnKcJ0=
X-Google-Smtp-Source: ABdhPJxsK9CUvgdKD6ZCZBAqfWYD1gdpJNSlmVez8DOhmPECL9S8rEWBfYR3H4BqgrwtUNAZdstTGw==
X-Received: by 2002:a05:6602:22d6:: with SMTP id e22mr21867513ioe.128.1592117167830;
        Sat, 13 Jun 2020 23:46:07 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id m5sm5744932ioj.52.2020.06.13.23.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:46:07 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/etnaviv: fix ref count leak via pm_runtime_get_sync
Date:   Sun, 14 Jun 2020 01:46:01 -0500
Message-Id: <20200614064601.7872-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in etnaviv_gpu_submit, etnaviv_gpu_recover_hang, etnaviv_gpu_debugfs,
and etnaviv_gpu_init the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a31eeff2b297..16f5bc65771a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -722,7 +722,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	ret = pm_runtime_get_sync(gpu->dev);
 	if (ret < 0) {
 		dev_err(gpu->dev, "Failed to enable GPU power domain\n");
-		return ret;
+		goto pm_put;
 	}
 
 	etnaviv_hw_identify(gpu);
@@ -819,6 +819,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 
 fail:
 	pm_runtime_mark_last_busy(gpu->dev);
+pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
 
 	return ret;
@@ -859,7 +860,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 
 	ret = pm_runtime_get_sync(gpu->dev);
 	if (ret < 0)
-		return ret;
+		goto pm_put;
 
 	dma_lo = gpu_read(gpu, VIVS_FE_DMA_LOW);
 	dma_hi = gpu_read(gpu, VIVS_FE_DMA_HIGH);
@@ -1003,6 +1004,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 	ret = 0;
 
 	pm_runtime_mark_last_busy(gpu->dev);
+pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
 
 	return ret;
@@ -1016,7 +1018,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 	dev_err(gpu->dev, "recover hung GPU!\n");
 
 	if (pm_runtime_get_sync(gpu->dev) < 0)
-		return;
+		goto pm_put;
 
 	mutex_lock(&gpu->lock);
 
@@ -1035,6 +1037,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 
 	mutex_unlock(&gpu->lock);
 	pm_runtime_mark_last_busy(gpu->dev);
+pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
 }
 
@@ -1308,8 +1311,10 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
 
 	if (!submit->runtime_resumed) {
 		ret = pm_runtime_get_sync(gpu->dev);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put(gpu->dev);
 			return NULL;
+		}
 		submit->runtime_resumed = true;
 	}
 
@@ -1326,6 +1331,7 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
 	ret = event_alloc(gpu, nr_events, event);
 	if (ret) {
 		DRM_ERROR("no free events\n");
+		pm_runtime_put(gpu->dev);
 		return NULL;
 	}
 
-- 
2.17.1

