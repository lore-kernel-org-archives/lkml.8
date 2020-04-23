Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC541C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C543320776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="zZ8HZ1o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgDWVKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgDWVKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:10:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90AC09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h26so5898223qtu.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fgzUf6QnEDfHIVtySZxqTUXmeQhARHBty1JtsylcjU=;
        b=zZ8HZ1o55FpeMGGyoBbzrJ6jsc46dJca7Y7OPJRR6q7LBX3Ddruoahhj+KrB3CoOEY
         zJ54PKGO7etEpI+2iMG8IImtDMcVBGu3V+g0DgARo6t1nKu99AolQfRCvggHNnN5ZORv
         c74L9fZYhz89QPicXr6GBW8bg2QETU6LHPT4Bux38DrgLu9rijv5p4npfCOFOh5rnjtQ
         G30b5buCERwZKDmJLR6yjassqlHcnEyteMkIMlJjJtjyUN2kiChCKPuGKO88T8kD3c+u
         WtJraenW5D55nRoputCxW1DNPT3BmBMdoEQrnyIakv2SOCAJLv6QiyTGYkkXKd3u7r5v
         JAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fgzUf6QnEDfHIVtySZxqTUXmeQhARHBty1JtsylcjU=;
        b=F14mf24JD6VdFe2K1qI73HvlvEt5pfV69curfdm49N7E2U0fcpAX70KMGiEYSguaiR
         xMvGGM+cbyFtL8tIFdR+slar4iiQKLsnG1uOje9DASmSaxPzVjh4vld4BKq6T6HUJVjW
         TdXLIGzFIR0nukw7gzFE5p7sei5WKFj9ASC8IAu6GODenL921LYtdiJ5+JxWAWJC08xv
         zXH80K6x9Ueit1Pcef5qtNzkKwok4jet8Ql9BN5vopEOK0aGT+ZRceDxUBf1477UQNSg
         kYNM4IvxtmOuABH52Po6equ6t4hGSNr5s2Mb+HNsPvpjw1KEIYZ9WOFJEkkcmWrOodvV
         QqPA==
X-Gm-Message-State: AGi0PuYq16Lh3K+sgkf98aOv8o4wbCYGevPULf6XhUf30kaXNpUALCCX
        nGsn6swgHogVPt6650YWRZ9Nug==
X-Google-Smtp-Source: APiQypJiwnh2DBra0mtACSdPDanbkps3648UFV+b28FZCOUOJKb8fwtUv495WOpqSapSrnO01vNLTQ==
X-Received: by 2002:ac8:46d1:: with SMTP id h17mr6208939qto.72.1587676233542;
        Thu, 23 Apr 2020 14:10:33 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id n4sm2341495qkh.38.2020.04.23.14.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:10:33 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Masney <masneyb@onstation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/9] drm/msm/a6xx: add A640/A650 to gpulist
Date:   Thu, 23 Apr 2020 17:09:16 -0400
Message-Id: <20200423210946.28867-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423210946.28867-1-jonathan@marek.ca>
References: <20200423210946.28867-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Adreno 640 and 650 GPU info to the gpulist.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 24 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 10 +++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index cb3a6e597d76..1156f72532a4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -189,6 +189,30 @@ static const struct adreno_info gpulist[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init = a6xx_gpu_init,
 		.zapfw = "a630_zap.mdt",
+	}, {
+		.rev = ADRENO_REV(6, 4, 0, ANY_ID),
+		.revn = 640,
+		.name = "A640",
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a640_gmu.bin",
+		},
+		.gmem = SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a640_zap.mdt",
+	}, {
+		.rev = ADRENO_REV(6, 5, 0, ANY_ID),
+		.revn = 650,
+		.name = "A650",
+		.fw = {
+			[ADRENO_FW_SQE] = "a650_sqe.fw",
+			[ADRENO_FW_GMU] = "a650_gmu.bin",
+		},
+		.gmem = SZ_1M + SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a650_zap.mdt",
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 1d5c43c22269..a7647eaacc7a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -197,7 +197,7 @@ int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
 		*value = adreno_gpu->gmem;
 		return 0;
 	case MSM_PARAM_GMEM_BASE:
-		*value = 0x100000;
+		*value = !adreno_is_a650(adreno_gpu) ? 0x100000 : 0;
 		return 0;
 	case MSM_PARAM_CHIP_ID:
 		*value = adreno_gpu->rev.patchid |
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 9ff4e550e7bd..88ae1b2813ef 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -237,6 +237,16 @@ static inline int adreno_is_a630(struct adreno_gpu *gpu)
        return gpu->revn == 630;
 }
 
+static inline int adreno_is_a640(struct adreno_gpu *gpu)
+{
+       return gpu->revn == 640;
+}
+
+static inline int adreno_is_a650(struct adreno_gpu *gpu)
+{
+       return gpu->revn == 650;
+}
+
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
 const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
 		const char *fwname);
-- 
2.26.1

