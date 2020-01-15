Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA67C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A68207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brkho-com.20150623.gappssmtp.com header.i=@brkho-com.20150623.gappssmtp.com header.b="JYjuVTSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgAOU5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:57:36 -0500
Received: from mail-ua1-f99.google.com ([209.85.222.99]:41085 "EHLO
        mail-ua1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgAOU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:57:36 -0500
Received: by mail-ua1-f99.google.com with SMTP id f7so6813925uaa.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brkho-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAq6TrEVx22C9NeXV+u5E8p8eBKHJtE8qNPoQl4adsE=;
        b=JYjuVTSotuEa5LKchq1QwLvMiC0miS12YXda9sHdZclwC92lt8XOByu06EK7yqK9r4
         WCBYRHBwJdaS94EIh7jMaUWTVZZYvUhWL9XBklNDK6A8QC9DqQEpnz8v45Z9wC3EflW+
         gwoDaiKJbd4DfyNMo7Bq7JUudOlO+KZVDKdDCjnvAPhSHqmKfD/+2NvMg6rYunAXunQq
         iVwQl8EuDAxN9kmFZjdQhkRqyLfeN8m5DEHs2R9Y8iQmkfWay48vJc1Oa5KrF3tTeDLc
         dhDkGUXfDcG5x4C9tviRSMV0IbElyaH1E/d9I0UdlhbH1f9wRnYLlwq2fZylhxEr/IsU
         Fgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAq6TrEVx22C9NeXV+u5E8p8eBKHJtE8qNPoQl4adsE=;
        b=r1pjBL/p7HQHNUSn14icNy/d0TQU8hFqOAxjT6u67Xo+kRq7LzjQUExLkdfyb4n2/X
         mc5S9IyEtK6iYFD0p4TWviKvMVyShXVMQ9yO0dQRpyA2c2mhZ28BmU4jFFXPcnWB4vF9
         8jDndBqAr8sLaT2oCKwpl+jZ+mB/+AweJZ/1xWEnTnBjflZ1N/jZX1GWjgJbtP5dYwSu
         5EOXS/P0N1z3JfiXQGhOKW9mzcT+c7FHkxnKI1+IwHwmUxVl0ohpP+xP9MKl2LeCXdpQ
         e1x7gRi3WOo7ZYfys9ggLIxVYu09VZka0kP6OnvFc+8wnttjicmpOnxcQlMOOQyAKRRh
         FgYQ==
X-Gm-Message-State: APjAAAXOwzH8wWuswVEPvn9b/8NfRx6+dbl3oXDlsfuRo4naQzh5d/PY
        gWFSQrrI+1THetedtv6RFPa7lcaoqeTa3UzX8yCvLHKceytOZQ==
X-Google-Smtp-Source: APXvYqxjXDMjnFKkSryidbYnjPMiySJ2xbqbi1okq9jcW8s3Bi6lp++0JgkqqYp9Bkjvkqtrqnlfvge183NV
X-Received: by 2002:ab0:422:: with SMTP id 31mr17816176uav.98.1579121855091;
        Wed, 15 Jan 2020 12:57:35 -0800 (PST)
Received: from hob1.nyc.corp.google.com ([100.118.32.120])
        by smtp-relay.gmail.com with ESMTPS id j26sm1472756uak.1.2020.01.15.12.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:57:35 -0800 (PST)
X-Relaying-Domain: brkho.com
From:   Brian Ho <brian@brkho.com>
To:     freedreno@lists.freedesktop.org
Cc:     hoegsberg@chromium.org, robdclark@chromium.org,
        jcrouse@codeaurora.org, Brian Ho <brian@brkho.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm: Add a GPU-wide wait queue
Date:   Wed, 15 Jan 2020 15:56:48 -0500
Message-Id: <20200115205649.12971-2-brian@brkho.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200115205649.12971-1-brian@brkho.com>
References: <20200115205649.12971-1-brian@brkho.com>
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

