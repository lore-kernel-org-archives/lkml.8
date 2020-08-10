Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6189AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1619A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087315;
	bh=YWc/jbFi07zz+Mf7kE85aUxzk4vmzQnuoEKGhyIPpeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcr22Ygtsd5gXdNG/tIbmF82md/AjV32Mg4mq7lb05wI8ztAZSTm54R2qQ3tQkrbJ
	 E1ZSMvAQia//wOjqUfnb5BMgqRjS05Ebt526jCuqy1rwpjFJz5flKYKauLgqrWS/LQ
	 Leej5wTWAoxsL89PkJj46WiSMZSAx52dMqijHV3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgHJTVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbgHJTNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:13:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A44207FF;
        Mon, 10 Aug 2020 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086797;
        bh=YWc/jbFi07zz+Mf7kE85aUxzk4vmzQnuoEKGhyIPpeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYMdPdgkpZId1sZCA9Y+rK82JboL9S2o/A2figTNoky02j58XHBjvwkDuMQFHoWaD
         MdaCcmptkvemiqgISuOFSRa1EEmNE3aBInS4ubys9Eyu8QfjBXyK5ow+WslYrqnKi8
         Km5cEsMGU2bCPJT9UOooBgM57AARFXk0XIZP3LlE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 12/31] drm/etnaviv: fix ref count leak via pm_runtime_get_sync
Date:   Mon, 10 Aug 2020 15:12:40 -0400
Message-Id: <20200810191259.3794858-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191259.3794858-1-sashal@kernel.org>
References: <20200810191259.3794858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit c5d5a32ead1e3a61a07a1e59eb52a53e4a6b2a7f ]

in etnaviv_gpu_submit, etnaviv_gpu_recover_hang, etnaviv_gpu_debugfs,
and etnaviv_gpu_init the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 6a859e077ea02..f17fbe6ff7c74 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -694,7 +694,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	ret = pm_runtime_get_sync(gpu->dev);
 	if (ret < 0) {
 		dev_err(gpu->dev, "Failed to enable GPU power domain\n");
-		return ret;
+		goto pm_put;
 	}
 
 	etnaviv_hw_identify(gpu);
@@ -808,6 +808,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	gpu->mmu = NULL;
 fail:
 	pm_runtime_mark_last_busy(gpu->dev);
+pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
 
 	return ret;
@@ -848,7 +849,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 
 	ret = pm_runtime_get_sync(gpu->dev);
 	if (ret < 0)
-		return ret;
+		goto pm_put;
 
 	dma_lo = gpu_read(gpu, VIVS_FE_DMA_LOW);
 	dma_hi = gpu_read(gpu, VIVS_FE_DMA_HIGH);
@@ -971,6 +972,7 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 	ret = 0;
 
 	pm_runtime_mark_last_busy(gpu->dev);
+pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
 
 	return ret;
@@ -985,7 +987,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 	dev_err(gpu->dev, "recover hung GPU!\n");
 
 	if (pm_runtime_get_sync(gpu->dev) < 0)
-		return;
+		goto pm_put;
 
 	mutex_lock(&gpu->lock);
 
@@ -1005,6 +1007,7 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gpu *gpu)
 
 	mutex_unlock(&gpu->lock);
 	pm_runtime_mark_last_busy(gpu->dev);
+pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
 }
 
@@ -1278,8 +1281,10 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
 
 	if (!submit->runtime_resumed) {
 		ret = pm_runtime_get_sync(gpu->dev);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put_noidle(gpu->dev);
 			return NULL;
+		}
 		submit->runtime_resumed = true;
 	}
 
@@ -1296,6 +1301,7 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
 	ret = event_alloc(gpu, nr_events, event);
 	if (ret) {
 		DRM_ERROR("no free events\n");
+		pm_runtime_put_noidle(gpu->dev);
 		return NULL;
 	}
 
-- 
2.25.1

