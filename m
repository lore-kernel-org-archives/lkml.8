Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B02C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9402C207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpvcCjXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgHNJFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgHNJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:05:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4FC061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 9so6863310wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRT5IxQW31/cWLOlxefHWhvflnlqyP6TcqmdhPBQu3E=;
        b=gpvcCjXtfa5TJBoLojYNhodiFxl3dssIiiPpW649i3FkUCzofAQNFBgI2yb253DFIC
         lBiYPbCeC8SxI6QDBwFngeQb2jQjKlPzBkCouDkvqswPWCnJrwQA7gX5a1I15kJLOqfG
         F9I7Ysi0hU6EnabUyIBQv44uT/aWJP/pWQOoMdzsDK1qz7I+uo8c8YOkspG3natl9Ead
         KDYP5Rr2ZcGnl+L+xFTFbf3IOb3vLs38Zh+Sm+RR1u65PV6jaJZF/MH2DvtgSKCU8NPT
         UgkQdQthlDrYbN8RZglMawQqC0ZePiKF2SQr7eWH4+kyt5z11uirIIWYkCijVD+H1B3c
         EGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRT5IxQW31/cWLOlxefHWhvflnlqyP6TcqmdhPBQu3E=;
        b=SajfeMY1O/UXy9sqE99VD2qUGBrWfvG4v1ovbe9QOcS69t4F5yJbwZlX5/vDC6TAw5
         WJ4iebTB74/99l5S3jEn+pl82myH6gTbqBYhx12IzVRXNGeaAVoE9D0ZavLpw0mohU9i
         MqvFwLDW4RemcTKg3UUVUZhDSdI8m63dZlEImff6sPcQo6N3jGBqgQpAuyUTv58lCAZf
         2cs44E8Zry+1yyDRh+/OG+Ka+d0P1wIWGwjfQiGpoJyQxqUAsIwMCqtu5L/kxCzrKzSM
         YXblhnk5CX2N74LACSesElpoiOv4LhSJ9Su4AS5I/bYc3KD7gZ8Rwu7qn5bM7B8fuKKH
         0b5g==
X-Gm-Message-State: AOAM532Kzrf/pt1XtW84ABA3cBshX77LdbunK5TvFwDt1zcSrZJVSU1O
        eOYIBFCSEGhuS3YTj5qOsPSMhw/aZsV36w==
X-Google-Smtp-Source: ABdhPJxFOVHTXeF5CW+md3xRzIj05YXUjn0KLfX6SFojUdOXMVIJ6AB7QEqc/h1xOAQRM/T/Ef0U8g==
X-Received: by 2002:a1c:38b:: with SMTP id 133mr1580959wmd.153.1597395933750;
        Fri, 14 Aug 2020 02:05:33 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id m14sm14046745wrx.76.2020.08.14.02.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 02:05:33 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] drm/etnaviv: add total hi bandwidth perfcounter
Date:   Fri, 14 Aug 2020 11:05:03 +0200
Message-Id: <20200814090512.151416-4-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814090512.151416-1-christian.gmeiner@gmail.com>
References: <20200814090512.151416-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two perf counters represent the total read and write
GPU bandwidth in terms of 64bits.

The used sequence was taken from Vivante kernel driver.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 35 ++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index 782732e6ce72..b37459f022d7 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -69,6 +69,29 @@ static u32 pipe_perf_reg_read(struct etnaviv_gpu *gpu,
 	return value;
 }
 
+static u32 pipe_reg_read(struct etnaviv_gpu *gpu,
+	const struct etnaviv_pm_domain *domain,
+	const struct etnaviv_pm_signal *signal)
+{
+	u32 clock = gpu_read(gpu, VIVS_HI_CLOCK_CONTROL);
+	u32 value = 0;
+	unsigned i;
+
+	for (i = 0; i < gpu->identity.pixel_pipes; i++) {
+		clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
+		clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(i);
+		gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
+		value += gpu_read(gpu, signal->data);
+	}
+
+	/* switch back to pixel pipe 0 to prevent GPU hang */
+	clock &= ~(VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE__MASK);
+	clock |= VIVS_HI_CLOCK_CONTROL_DEBUG_PIXEL_PIPE(0);
+	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, clock);
+
+	return value;
+}
+
 static u32 hi_total_cycle_read(struct etnaviv_gpu *gpu,
 	const struct etnaviv_pm_domain *domain,
 	const struct etnaviv_pm_signal *signal)
@@ -102,8 +125,18 @@ static const struct etnaviv_pm_domain doms_3d[] = {
 		.name = "HI",
 		.profile_read = VIVS_MC_PROFILE_HI_READ,
 		.profile_config = VIVS_MC_PROFILE_CONFIG2,
-		.nr_signals = 5,
+		.nr_signals = 7,
 		.signal = (const struct etnaviv_pm_signal[]) {
+			{
+				"TOTAL_READ_BYTES8",
+				VIVS_HI_PROFILE_READ_BYTES8,
+				&pipe_reg_read,
+			},
+			{
+				"TOTAL_WRITE_BYTES8",
+				VIVS_HI_PROFILE_WRITE_BYTES8,
+				&pipe_reg_read,
+			},
 			{
 				"TOTAL_CYCLES",
 				0,
-- 
2.26.2

