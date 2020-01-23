Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC1C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8291E206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brkho-com.20150623.gappssmtp.com header.i=@brkho-com.20150623.gappssmtp.com header.b="SDDE6p5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgAWX7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:59:44 -0500
Received: from mail-yb1-f228.google.com ([209.85.219.228]:43767 "EHLO
        mail-yb1-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAWX7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:59:44 -0500
Received: by mail-yb1-f228.google.com with SMTP id k15so57447ybd.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brkho-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvp91oDfTO5JEbLl+0vB/VWGoX6Fo09EsCttVL/w5so=;
        b=SDDE6p5Uv0saoG5w8al+BsZzuZhQZRkbj39+0ueJ6gRLYtLLRHuMi7/EE5OYsH+YtA
         d4aQvHCI+Kd7+ucIl9TW6RVMTjnemxZAl5zJumSYpiZ8meniokDffXmHsmee7aRvjzLD
         5G6eMaG5lDT9O3l0aWAdBjh8kQgoOE5tQ/7AMouPfHQhFdtStWzVlHADBtYyizomkne8
         t9q0j0mJLniJLEvM19Ikh9ywLmee4eNzvwqntVlZiL8Uap6KqjV5mEGE4ieaIs6cRwjP
         7MNIPEssZq8qpBYJ1Eqydj7SUjGSrHWZKTFTHYJ6VTHO3diohnzpmX5aB2HaMM/ayvlX
         lmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvp91oDfTO5JEbLl+0vB/VWGoX6Fo09EsCttVL/w5so=;
        b=OtU+t/f+0w7CI/lnFEcf+8Jh0nvwxGW3upAaKkmDRcNFQLgjqhvqNKLtbV0ZbSxpSf
         xWEcmIOwqHMCJwZxjdplBpHQSM06G7TBJKk0AM074uC7l6pEF8NdU5cvQpmRBJTYldIO
         S6gGJnQmiEvPW2f7NuxmrSTte6fL8qrUmnXzz1Q07nnFpdYx/3nO13m81Q7+x+XY5Ryo
         r91EwPu99SSijmOORH7mmhd2NJNz3JXSj/KNQ4BAPGtfMpSoi23alE7yHsg92t+oUh5S
         TNDa4F7dujlboZPkwKLYyZ8TJPVyTANGv3UYz3tYRcVoPIrZLPD7UIikFTjzZgVB6+cH
         psqQ==
X-Gm-Message-State: APjAAAXF3cJ8vqdTLg5E+I545nkDd+WKEIojdlV/HtPRrxyCqet950zG
        k+EGlvZ05u7a4xBTSTrk9AuqkiI9f62Y3lxwamW7654CKaWiRg==
X-Google-Smtp-Source: APXvYqwFRd5SEYNa4twj8KbvI5uBQGYGOmRAxdq9oHZ+fGUwIuMk48HZYtAsYd0J8WDqs8Vvx3SvxKiQnnq/
X-Received: by 2002:a25:cf08:: with SMTP id f8mr328295ybg.304.1579823981860;
        Thu, 23 Jan 2020 15:59:41 -0800 (PST)
Received: from hob1.nyc.corp.google.com ([100.118.32.120])
        by smtp-relay.gmail.com with ESMTPS id i82sm591239ywg.11.2020.01.23.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:59:41 -0800 (PST)
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
Subject: [PATCH v3 1/2] drm/msm: Add a GPU-wide wait queue
Date:   Thu, 23 Jan 2020 18:57:37 -0500
Message-Id: <20200123235738.48182-2-brian@brkho.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200123235738.48182-1-brian@brkho.com>
References: <20200123235738.48182-1-brian@brkho.com>
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
2.25.0.341.g760bfbb309-goog

