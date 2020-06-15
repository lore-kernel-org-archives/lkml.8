Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E642C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657B1206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9dTqLFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgFOGMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgFOGMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:12:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89560C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:12:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id x189so7476040iof.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MpaNV/qQKz10iqV54hZ3d06qChO86uOpWp9hsgu+lWY=;
        b=R9dTqLFqtzTAkZcs7wraz0nABjqsFyXZgImHWAjW/JRpifRBjCvM4fhxHp9/gej4n5
         DNMG3Ht6UnmJefKwqtmlhhw6gIS51mdT1Y03Dnl9+jenWXLpeSk0+rwg8O4nQtCext1X
         nN6yPFGPJ+ELR06ivu2dPofx7LFNSa56L2y+2g3mphJQsRxGkMX1+fAFWN3JLabu4yBa
         O0YY12KchtNRz8i9AUYqDcaxqSQcOnKPDZ8O/HCnOaFRm4DSY0kKjelxhtlSXgZ0kMnS
         I1pPgussUNro4NKXQN6Zm8TzPLvyU8Ak5siiRMN+2tg6y27KxK1az6mPo3c1JgSpplOw
         J5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MpaNV/qQKz10iqV54hZ3d06qChO86uOpWp9hsgu+lWY=;
        b=sCFBGmwEwgmXaBxhgu9CsW6hEOjr06R2ytjIgGB2DjkWY629xExswEG6X0DmHy5oER
         B9+sYq1BaE1jVo3qRi4cLqCRQ/1HzR4eQ637Q6N8VO8avuz+171FZVfxUMDNuvGQcNeZ
         W02cRPzT+lPVWOKCgfczHYGblL0hni/aWjIamdA2HaU0ad3jtZ60FhrQ/zA6vFoGgxaB
         190Ir+WPaU3d1d2XJXICIGxYHPEDrS8/b86o3Es+W6viEwi9G9mRRpQXVj2naXhrzadZ
         Vw+qlT+WG02dXESgJnLnPnuJ95iCNgOIbR6pWHZ00eXutuRvZ6XiqArp7UpVGu1ctjca
         We0A==
X-Gm-Message-State: AOAM53143S+C9VmJW9SVT5koqYTFS5E+bCZLfu2viGk/CDaySuYWz/pz
        zHB3s5d0aKEq7k+SW0FRw0YGxPIw/ok=
X-Google-Smtp-Source: ABdhPJyzcnYLaAIqOamesc01+OyA8JCS1/7QXApZEWy/YVtyVV5vBZBB6DNo4QZqY8CgYo+qQnFOqw==
X-Received: by 2002:a05:6638:d05:: with SMTP id q5mr19398438jaj.2.1592201551850;
        Sun, 14 Jun 2020 23:12:31 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id c3sm7421822ilr.45.2020.06.14.23.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 23:12:31 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, andy.shevchenko@gmail.com,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH v2] drm/etnaviv: fix ref count leak via pm_runtime_get_sync
Date:   Mon, 15 Jun 2020 01:12:20 -0500
Message-Id: <20200615061220.68711-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75VcLR2w9Ym0YOqUT9G8xT9qWrdD1-wP4UA-1wtuwCNxqSA@mail.gmail.com>
References: <CAHp75VcLR2w9Ym0YOqUT9G8xT9qWrdD1-wP4UA-1wtuwCNxqSA@mail.gmail.com>
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
Changes in v2:
	- replace pm_runtime_put with  pm_runtime_put_noidle
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a31eeff2b297..7c9f3f9ba123 100644
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
+			pm_runtime_put_noidle(gpu->dev);
 			return NULL;
+		}
 		submit->runtime_resumed = true;
 	}
 
@@ -1326,6 +1331,7 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
 	ret = event_alloc(gpu, nr_events, event);
 	if (ret) {
 		DRM_ERROR("no free events\n");
+		pm_runtime_put_noidle(gpu->dev);
 		return NULL;
 	}
 
-- 
2.17.1

