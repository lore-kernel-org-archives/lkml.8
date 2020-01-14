Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4004C33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984B9222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kpku5Ruy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgANHQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:16:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42079 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgANHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:16:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so4865782plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Qk1FvG6eeViNWsiravQSfAZxl3lDcu4afmru4xzZG0=;
        b=kpku5RuywKMHl5ZcaerHmBR3blXr+BKVtuWbEftoijf6zbjlLpjhN91tXw35Fo58dn
         xTXhTbMh5ix0EZTaVErnFQDR5hNTEemNwcK4X3OpJEuhr2I/Ckiq0N4cHg4yN3NpUKzq
         PjDj62n+MeAuKGo/riGAaYYSsB4yZ3/JVkYBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Qk1FvG6eeViNWsiravQSfAZxl3lDcu4afmru4xzZG0=;
        b=QdSACkXu4S8H4X2QwelCb5kXaDkJ4IdbYBi5xmrUkt8xzy3lJxwaqrMM9ZblnIBHid
         ic44WV8em9QgDmBIIDp48kyCHiT+M5j8BwFouwDltOdORMDLFEIs8MqBa6c5xHniX5m9
         M5MKSBxEjLft+dHolvxbcQzEKMFYcR0DEnp+EU5qhoA+p2MEhtxgdMe7Ggn0xLrr8Egt
         6F4rZrEh8hN/vg9BeKXgoDEiV3JqAhXQYjftNrIeua3v4HAldxRlFcS6F/8UfDE8p5J9
         9gUw3MtlWiItwuBBXwAAD4ykREmg3YMBnwJl1Gk3ojOSz4Y9BBcU7u1R/pKo/JgF6Ev9
         XaRA==
X-Gm-Message-State: APjAAAUa0NO1vlZXtmbLHBy2Jxnxv+Z19l5ySML1bgDHuinkIVOem6oC
        4OjlAtE6Ru3rhbD7jIT53EcmIw==
X-Google-Smtp-Source: APXvYqwYrMUv22o8QtZJHQxG4oSCOtehemcl4VrfqOdRaxZdRTf/JyTGWfmUwepbFJQPUttZYQitFg==
X-Received: by 2002:a17:90a:3244:: with SMTP id k62mr27867920pjb.43.1578986177409;
        Mon, 13 Jan 2020 23:16:17 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id b4sm17092976pfd.18.2020.01.13.23.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:16:16 -0800 (PST)
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
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v3 3/7] drm/panfrost: Improve error reporting in panfrost_gpu_power_on
Date:   Tue, 14 Jan 2020 15:15:58 +0800
Message-Id: <20200114071602.47627-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200114071602.47627-1-drinkcat@chromium.org>
References: <20200114071602.47627-1-drinkcat@chromium.org>
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
2.25.0.rc1.283.g88dfdc4193-goog

