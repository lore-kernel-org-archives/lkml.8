Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A43207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKD0gHxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHNJF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgHNJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:05:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F53C061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g8so6872110wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWo7qfLl0wE2i8zg/BhTlkJQXxIbQK+FJtPUS8AfL7g=;
        b=CKD0gHxkwv1aBbvAQxLbB0lfmGaTIXlyHM3IqNHHj4IZZ0xUW1gTSf/qil/iLu4/Y2
         fnToPx6+QVVz0M7gnOS8X9qGFkd4xjV2/T1w0JFywwO3CmgFLWMKtKPOzK8oZF55+/ZP
         cc0xM5H5yppRMbmyfOXY+D0d020uRVnMpV2j/zHRwWGSkxDlCvnUxSRFTC0jt6EeQQmj
         26TVykKdPLJoPSKzutdZqNASsJpsOx6/UtQ86UjMr1TsbTLok+nJGvOjSMv4o/ld56Dq
         sd4vCcAKuWfGPE2AtY+T6BnOjUN+K0eoNYLIW4PSYFEo5q6tzCvD8FNFaievhUStX/Gd
         0lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWo7qfLl0wE2i8zg/BhTlkJQXxIbQK+FJtPUS8AfL7g=;
        b=E1COcL3LC2sV4/9nyr6OojvcSC5qm2jjVbBZIJjhmUV/I78ZDG9WxuCC+OQIoZRjEc
         QSJqgAVT3Hj/GgEw7msZ8AosTxmFRjmCjb3Sogw8eWdAK8h/26ACx8Gb34XODkcVIua9
         +f5KRXE7s6uvl9LNk1yPFhtD8t+7eD/zVvNfa/XzAiw1yZo7OS3yUfJXdOZG1p+7aQF0
         /fDIX9ij/QZIoAdLXsVotkQLXr4ltigdtFq3DJFpjulD8lUjarv6uVmDEHcg5OwJtLTA
         i4y1zmzsLLdPp1TlL4t5Uwdi0OPv1nj8qVgpuRd6IToRKjeOw1ROI4RnYmU4xvGhaXrp
         x4cQ==
X-Gm-Message-State: AOAM530kCwbUjczpkaP+WyPxUDkzVHrWHbXCu1H8fD8OtYU0yNP6TwXO
        WcSzAXxlyCeb64KAWTl/daYAESJkDZkPvg==
X-Google-Smtp-Source: ABdhPJw2g4VEAD+4yHIaD8SWwebBs3rsYJIxKje6Ym86s4qaoAkLOx0vC+saak3csaS+5g51xCGDwA==
X-Received: by 2002:a1c:2854:: with SMTP id o81mr1572302wmo.61.1597395926454;
        Fri, 14 Aug 2020 02:05:26 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id m14sm14046745wrx.76.2020.08.14.02.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 02:05:24 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] drm/etnaviv: rename pipe_reg_read(..)
Date:   Fri, 14 Aug 2020 11:05:01 +0200
Message-Id: <20200814090512.151416-2-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814090512.151416-1-christian.gmeiner@gmail.com>
References: <20200814090512.151416-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pipe_reg_read(..) iterates over all pixel pipes, selects a perf counter
register and sums the actual perf counter value. Rename the function
to reflect more what it is actual doing.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 30 +++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index 75f9db8f7bec..1f0402f7a7de 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -46,7 +46,7 @@ static u32 perf_reg_read(struct etnaviv_gpu *gpu,
 	return gpu_read(gpu, domain->profile_read);
 }
 
-static u32 pipe_reg_read(struct etnaviv_gpu *gpu,
+static u32 pipe_perf_reg_read(struct etnaviv_gpu *gpu,
 	const struct etnaviv_pm_domain *domain,
 	const struct etnaviv_pm_signal *signal)
 {
@@ -141,22 +141,22 @@ static const struct etnaviv_pm_domain doms_3d[] = {
 			{
 				"PIXEL_COUNT_KILLED_BY_COLOR_PIPE",
 				VIVS_MC_PROFILE_CONFIG0_PE_PIXEL_COUNT_KILLED_BY_COLOR_PIPE,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"PIXEL_COUNT_KILLED_BY_DEPTH_PIPE",
 				VIVS_MC_PROFILE_CONFIG0_PE_PIXEL_COUNT_KILLED_BY_DEPTH_PIPE,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"PIXEL_COUNT_DRAWN_BY_COLOR_PIPE",
 				VIVS_MC_PROFILE_CONFIG0_PE_PIXEL_COUNT_DRAWN_BY_COLOR_PIPE,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"PIXEL_COUNT_DRAWN_BY_DEPTH_PIPE",
 				VIVS_MC_PROFILE_CONFIG0_PE_PIXEL_COUNT_DRAWN_BY_DEPTH_PIPE,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			}
 		}
 	},
@@ -184,32 +184,32 @@ static const struct etnaviv_pm_domain doms_3d[] = {
 			{
 				"VS_INST_COUNTER",
 				VIVS_MC_PROFILE_CONFIG0_SH_VS_INST_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"RENDERED_VERTICE_COUNTER",
 				VIVS_MC_PROFILE_CONFIG0_SH_RENDERED_VERTICE_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"VTX_BRANCH_INST_COUNTER",
 				VIVS_MC_PROFILE_CONFIG0_SH_VTX_BRANCH_INST_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"VTX_TEXLD_INST_COUNTER",
 				VIVS_MC_PROFILE_CONFIG0_SH_VTX_TEXLD_INST_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"PXL_BRANCH_INST_COUNTER",
 				VIVS_MC_PROFILE_CONFIG0_SH_PXL_BRANCH_INST_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"PXL_TEXLD_INST_COUNTER",
 				VIVS_MC_PROFILE_CONFIG0_SH_PXL_TEXLD_INST_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			}
 		}
 	},
@@ -237,17 +237,17 @@ static const struct etnaviv_pm_domain doms_3d[] = {
 			{
 				"DEPTH_CLIPPED_COUNTER",
 				VIVS_MC_PROFILE_CONFIG1_PA_DEPTH_CLIPPED_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"TRIVIAL_REJECTED_COUNTER",
 				VIVS_MC_PROFILE_CONFIG1_PA_TRIVIAL_REJECTED_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			},
 			{
 				"CULLED_COUNTER",
 				VIVS_MC_PROFILE_CONFIG1_PA_CULLED_COUNTER,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			}
 		}
 	},
@@ -400,7 +400,7 @@ static const struct etnaviv_pm_domain doms_2d[] = {
 			{
 				"PIXELS_RENDERED_2D",
 				VIVS_MC_PROFILE_CONFIG0_PE_PIXELS_RENDERED_2D,
-				&pipe_reg_read
+				&pipe_perf_reg_read
 			}
 		}
 	}
-- 
2.26.2

