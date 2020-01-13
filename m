Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1171DC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D647021739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brkho-com.20150623.gappssmtp.com header.i=@brkho-com.20150623.gappssmtp.com header.b="Qlt2Jrtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgAMPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:37:21 -0500
Received: from mail-yw1-f100.google.com ([209.85.161.100]:44006 "EHLO
        mail-yw1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:37:21 -0500
Received: by mail-yw1-f100.google.com with SMTP id v126so6324084ywc.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brkho-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAq6TrEVx22C9NeXV+u5E8p8eBKHJtE8qNPoQl4adsE=;
        b=Qlt2JrtxXffRVq9WBDU89WEUScfSt5bAr4nawTezguWtOz2UrnbkFTnmJhBhndv75o
         MUYHSbpZPlkXQgjoxuAJTTfbyZVac1cyRTtpQEgrXqmzbYFtHxAlVax6ogB1d9En28jq
         a1oKICSwZpEwqXmwcsuSIQE44bZHgkNz4twckgnGcC3f9xh68blQ51sGaNJr2Lfhqw7L
         zc73yl6oiVrpCpkUbSl9kzL/gxijXiFYWfGOKnGoAhcRxbsXoJVsar924b9aBb5qK0x1
         uST7IMadkwfISnpzlEPxYX4R4I8pHIEPe2lVcnxD+wy68F8pMI/icsLsFBgHsdwm4p57
         ESrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAq6TrEVx22C9NeXV+u5E8p8eBKHJtE8qNPoQl4adsE=;
        b=eHwd1R3WuiKLfhAeooVFHsxHIbvZ1b2K6cVwwqQBjAERZN7sgzm+1vhlSBN6s7pGg4
         EbtQPw4ZQHPSN2Ln5YTn5rYYb12pMsQZx89qwxPVdgva0yLW5lH7ZO2eZL5vlRZ2r5p/
         3JQ0F+CCPjqhDY7D55YdHoqYDujdwDCl73Hbuy23zkryHg6tOZDpEw5j1dlP750BuzA7
         a4G+uRhZKTEO09Xmk1/M475IUwhAdJMFRoTnBQNs3BATDq/42nGL23w50bZsjpCg0atJ
         bQnh9zP76UhkvDtC7SNU3GHmj1GvZnbYAKNc3Kb9rZHCKhci0aa8WY0RYfw/PBcdFSA4
         Ml+A==
X-Gm-Message-State: APjAAAVu1qTH7o9+YxEhVBFaXbuFwOEG+BfNOrQzCEa/NvQ5iCRRGWhs
        pK6pidPqX2ARd2YeLB2T4qszQIb+/AFOClOzLSJWz8NPRg/AhQ==
X-Google-Smtp-Source: APXvYqzQmLBNNT0a1aEnDqzSaVursng0om65Vx4mgRanu6nthloLlNoHL5C/UNEtGCLK6Btwv8oweeewjFGS
X-Received: by 2002:a81:980e:: with SMTP id p14mr14497442ywg.24.1578929840530;
        Mon, 13 Jan 2020 07:37:20 -0800 (PST)
Received: from hob1.nyc.corp.google.com ([100.118.32.120])
        by smtp-relay.gmail.com with ESMTPS id m193sm1672393ywd.0.2020.01.13.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:37:20 -0800 (PST)
X-Relaying-Domain: brkho.com
From:   Brian Ho <brian@brkho.com>
To:     freedreno@lists.freedesktop.org
Cc:     hoegsberg@chromium.org, robdclark@chromium.org,
        Brian Ho <brian@brkho.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Add a GPU-wide wait queue
Date:   Mon, 13 Jan 2020 10:36:04 -0500
Message-Id: <20200113153605.52350-2-brian@brkho.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200113153605.52350-1-brian@brkho.com>
References: <20200113153605.52350-1-brian@brkho.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wait queue is signaled on all IRQs for a given GPU and will be
used as part of the new MSM_WAIT_IOVA ioctl so userspace can sleep
until the value at a given iova reaches a certain condition.

Signed-off-by: Brian Ho <brian@brkho.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 4 ++++
 drivers/gpu/drm/msm/msm_gpu.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index a052364a5d74..d7310c1336e5 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -779,6 +779,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 static irqreturn_t irq_handler(int irq, void *data)
 {
 	struct msm_gpu *gpu = data;
+	wake_up_all(&gpu->event);
+
 	return gpu->funcs->irq(gpu);
 }
 
@@ -871,6 +873,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	spin_lock_init(&gpu->perf_lock);
 
+	init_waitqueue_head(&gpu->event);
+
 
 	/* Map registers: */
 	gpu->mmio = msm_ioremap(pdev, config->ioname, name);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index ab8f0f9c9dc8..60562f065dbc 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -104,6 +104,9 @@ struct msm_gpu {
 
 	struct msm_gem_address_space *aspace;
 
+	/* GPU-wide wait queue that is signaled on all IRQs */
+	wait_queue_head_t event;
+
 	/* Power Control: */
 	struct regulator *gpu_reg, *gpu_cx;
 	struct clk_bulk_data *grp_clks;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

