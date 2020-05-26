Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01F420706
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="1xj6bvuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbgEZDZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 23:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388601AbgEZDZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:25:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B00C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:25:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a23so15180436qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icdvv+zfVuWkK4xKk9F2ehGRQ03Uhs0Am8XJGkVDSbM=;
        b=1xj6bvuoqjBpZEVkxfou8Q3ppYNrSKIhJY7OiNgLIYUxccjHMvjuj9EpmQVKOPK73O
         9Jb2a89k/uzEQDFXBYLtw96EptlnL+LfrFThRHG9pp5lseLS6WFc14MKYaPe3lQxciVh
         20bxvVGYa2weN15/fghuS1/6XBpu8c7EPOysysXbzVDm/qjkuedz3sl5apseVgy9n27A
         m0YtprD2izsLmxfaYOlDDyBN7cLUMW9ye6/SR4+L6WltPjtSodkwfDl+vBI/92bAqRl1
         n3TbLVcj2DrEI1n7/PqIgM0qn8Tu9YUzNe+m8N0QvsiI44k4OVLInLM6Vdp+saWMqPMY
         U5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icdvv+zfVuWkK4xKk9F2ehGRQ03Uhs0Am8XJGkVDSbM=;
        b=gMketDUxSmOs7w0syPQX42lr6QIIw+cWWEpSs+Tqt20Lp7ovF6JiKSseKMritSBmD7
         9t7QRQrjaiga0TL6IEEuJKshXIUn6h8tAbZwqyZvUUhiVUb5KR8j6ww/tqZjBdTamvwu
         JJV0zzj0wiogLeOv7ezKjXn3WRUBqrzpAOdX2wnOO6SkCCCufPYlGDLBN5AQDo4hZ/+L
         f2f78NRAfbX1TxXzib1HhlVEE49dIr/pTmF2wSSDdYiHELvyusHJt7o89Nq7S9F4UNv+
         iA0AEUVTRGE+FnjgYrQy9ZqG1spU4lAn/2hBhtJ+SEW7c08/ztATXADKHw7RKc5qZQ5c
         n5bw==
X-Gm-Message-State: AOAM533IAXHOuxpnSMmkLJP2gCHCv1slbhp6ud5QopaGSoEoZbtkO+xA
        LHgmmZGRHgMcEUyjmAiMq068jQ==
X-Google-Smtp-Source: ABdhPJyZzwf65VwCV0TDaHoKmrKJSyHqssK1cp/VoAI3e786WgRYm7yHNvsC4LeGPByGfjqim7eFtg==
X-Received: by 2002:ac8:18a3:: with SMTP id s32mr31078692qtj.102.1590463518849;
        Mon, 25 May 2020 20:25:18 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id n123sm15955760qkf.23.2020.05.25.20.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 20:25:18 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: set ubwc config for A640 and A650
Date:   Mon, 25 May 2020 23:25:13 -0400
Message-Id: <20200526032514.22198-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for A640 and A650 to be able to share UBWC-compressed
images with other HW such as display, which expect this configuration.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 ++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6f335ae179c8..aa004a261277 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -289,6 +289,37 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	gpu_write(gpu, REG_A6XX_RBBM_CLOCK_CNTL, state ? 0x8aa8aa02 : 0);
 }
 
+static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	u32 lower_bit = 2;
+	u32 amsbc = 0;
+	u32 rgb565_predicator = 0;
+	u32 uavflagprd_inv = 0;
+
+	/* a618 is using the hw default values */
+	if (adreno_is_a618(adreno_gpu))
+		return;
+
+	if (adreno_is_a640(adreno_gpu))
+		amsbc = 1;
+
+	if (adreno_is_a650(adreno_gpu)) {
+		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
+		lower_bit = 3;
+		amsbc = 1;
+		rgb565_predicator = 1;
+		uavflagprd_inv = 2;
+	}
+
+	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
+		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
+	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
+	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
+		uavflagprd_inv >> 4 | lower_bit << 1);
+	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
+}
+
 static int a6xx_cp_init(struct msm_gpu *gpu)
 {
 	struct msm_ringbuffer *ring = gpu->rb[0];
@@ -478,12 +509,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	/* Select CP0 to always count cycles */
 	gpu_write(gpu, REG_A6XX_CP_PERFCTR_CP_SEL_0, PERF_CP_ALWAYS_COUNT);
 
-	if (adreno_is_a630(adreno_gpu)) {
-		gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL, 2 << 1);
-		gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, 2 << 1);
-		gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, 2 << 1);
-		gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, 2 << 21);
-	}
+	a6xx_set_ubwc_config(gpu);
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL,
-- 
2.26.1

