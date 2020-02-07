Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E758C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1504B22464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfIrgn8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGF1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:27:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40922 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgBGF1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:27:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so517863plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 21:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xpmN6rVRpQ9+/BKl26/gWkRoJrUlmctwTSJRjJCc9M=;
        b=EfIrgn8KJTdEPRV6t2D01u2C1tbZ2N5L+zz7+zq66y1iSVivuP8DBp9QrRPb2KxMeQ
         /ektvloYsjEAqIXPfLcxnAAUqVeqhAJibeu5lQbfMyCx5VI1xcyHGPq//k6mqcmQ0gfS
         CPinmVfCOSlqIHxC/KFn8Uqs9YBoRyqsFwy9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xpmN6rVRpQ9+/BKl26/gWkRoJrUlmctwTSJRjJCc9M=;
        b=Z0qXgCiyAnNetJhee7Ay3p9rrqHalRytutDOUeA5//JcpYvS2paOITMhSV7OgNRtUZ
         oQLGL5ERatmi/Wf8g8sixNmxJ9EmDgDs//k0605WR7r2zuG0Fy4VFv3UHUE2CPCclgiC
         swvPnhd/0JNARshP9kDorXLFXZUI0WGwzlRiGhicdMMXyzd5XDlfEhaPWhZUVyTbwX8/
         yKiNcoCClF3Ui83cX3Lsl62RhtwWCTnggezozmZZUdR2wQe7TTSasb65oxmBchdeqCVK
         rrptxXx7NDWJqdEa4juCwDJAhF8eJ/lP2iVnfDSaLPyvOXwX+vf9qqVM7hKqrlQIwbxo
         q/SQ==
X-Gm-Message-State: APjAAAXzHTAn+y+e7dbfjvK8esqvB4sZW2aMQ2OgO8woDnUHYwjC7c6y
        D2O1XGadEkI+40WjnLAAistN4w==
X-Google-Smtp-Source: APXvYqzX299A08Kcu0qlzSD8JRvc5zkotFDW+fzSDBqKgJ0Ds/rXQnBQim49TnwlSOj3Rct3QjyFZg==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr8017343pls.127.1581053219763;
        Thu, 06 Feb 2020 21:26:59 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id i66sm1174485pfg.85.2020.02.06.21.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 21:26:59 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
Subject: [PATCH v4 3/7] drm/panfrost: Improve error reporting in panfrost_gpu_power_on
Date:   Fri,  7 Feb 2020 13:26:23 +0800
Message-Id: <20200207052627.130118-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207052627.130118-1-drinkcat@chromium.org>
References: <20200207052627.130118-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to know which component cannot be powered on.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
---

Was useful when trying to probe Bifrost GPU, to understand what
issue we are facing.

v4:
 - No change
v3:
 - Rebased on https://patchwork.kernel.org/patch/11325689/

 drivers/gpu/drm/panfrost/panfrost_gpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 460fc190de6e815..856f2fd1fa8ed27 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -308,17 +308,20 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 	gpu_write(pfdev, L2_PWRON_LO, pfdev->features.l2_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
 		val, val == pfdev->features.l2_present, 100, 1000);
+	if (ret)
+		dev_err(pfdev->dev, "error powering up gpu L2");
 
 	gpu_write(pfdev, SHADER_PWRON_LO, pfdev->features.shader_present);
-	ret |= readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
+	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
 		val, val == pfdev->features.shader_present, 100, 1000);
+	if (ret)
+		dev_err(pfdev->dev, "error powering up gpu shader");
 
 	gpu_write(pfdev, TILER_PWRON_LO, pfdev->features.tiler_present);
-	ret |= readl_relaxed_poll_timeout(pfdev->iomem + TILER_READY_LO,
+	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_READY_LO,
 		val, val == pfdev->features.tiler_present, 100, 1000);
-
 	if (ret)
-		dev_err(pfdev->dev, "error powering up gpu");
+		dev_err(pfdev->dev, "error powering up gpu tiler");
 }
 
 void panfrost_gpu_power_off(struct panfrost_device *pfdev)
-- 
2.25.0.341.g760bfbb309-goog

