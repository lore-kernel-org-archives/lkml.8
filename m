Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ABDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D970A207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1fRpOHn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgIHUE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgIHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40BC09B051
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:19:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so19539267wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjvSHXG3RI2RmufIBrYIZQgGCbPKahWO302cZe4SW9Q=;
        b=1fRpOHn2lUTg/rLqc5FK572t6QTaVx2cYu+zLDiJpPqs8Msd6mxRGNwuQj7o/RemeB
         lp9id7bzG8bubb29ko3iwRYgZzddu8jc1z5ySmEpJQbi81n/gngRijw8+0G4Hmtjajt3
         VkvFnYnB70FT/9x3O7OLKvsN8UDOhKP5dcVjqfmkLO3lasTdS+d5yCZZxHw7Ga9Zja2n
         1y6vyBkEwXn/0qvCvQTQjk71wPIDCn2g6OnC0vEEUSS8gU1hzC2FE/iYN4+XkIbnAbOg
         otF3YD6EqWDUDKMsSqkb8xASmC62YkldJ00uUh8OxuTRQbumbWBoRkx7YxQGBkWdFmmm
         Szvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjvSHXG3RI2RmufIBrYIZQgGCbPKahWO302cZe4SW9Q=;
        b=Lh4hKNN/NvqxaAAvZsg+nJwUzHGeDP0zrWrWC1r53h9nNBe5DPKevX3HxJXtezZ54N
         FDgsZuoNBZ8fX+XFODsjJxAbP4RIgZkHSSn9ubrqHGgUjO8A1nr3nFnSH6ggW1bM5ohT
         bepox0GOapyCeah7xOqpIq6oYbV3mUla2TNh0jEtUKbeWUy8gSVxqLXMX8ztylwYDyO+
         By/b0h+Km6m3we83CDEF/KAWYJvEoliLMMBHt78UsjDgvv0woi0dCKT9cv3ZhbEirgXi
         Bq9T5VNXK0SFC7UyeYmA3kdpp33zh3cP86VCFTBEocoNxKYbvuX2/S96QHClFGZVRtZk
         vdew==
X-Gm-Message-State: AOAM530jE2QRZituKE6L2n5G3t/CIFK/fqZXCxo8hmEQGvm5GNV4dboh
        oTQULHp70HUZ+WoVXYbUIseUvA==
X-Google-Smtp-Source: ABdhPJyN+wVgZwcIGrsQVVJMowKAn9fgE7m5lBvFEuTQvke5O9KsubvDObKWcbTu0XD7mkbW64TA/Q==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr110043wro.319.1599578342220;
        Tue, 08 Sep 2020 08:19:02 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d25sm10004886wra.25.2020.09.08.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:19:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/5] drm/panfrost: add support for reset quirk
Date:   Tue,  8 Sep 2020 17:18:51 +0200
Message-Id: <20200908151853.4837-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908151853.4837-1-narmstrong@baylibre.com>
References: <20200908151853.4837-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T820, G31 & G52 GPUs integratewd by Amlogic in the respective GXM, G12A/SM1 & G12B
SoCs needs a quirk in the PWR registers at the GPU reset time.

This adds a callback in the device compatible struct of permit this.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 3 +++
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 2cf1a6a13af8..4c9cd5452ba5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -73,6 +73,9 @@ struct panfrost_compatible {
 
 	/* IOMMU quirks flags */
 	unsigned long pgtbl_quirks;
+
+	/* Vendor implementation quirks at reset time callback */
+	void (*vendor_reset_quirk)(struct panfrost_device *pfdev);
 };
 
 struct panfrost_device {
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index e0f190e43813..c129aaf77790 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -62,6 +62,10 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_SOFT_RESET);
 
+	/* The Amlogic GPU integration needs quirks at this stage */
+	if (pfdev->comp->vendor_reset_quirk)
+		pfdev->comp->vendor_reset_quirk(pfdev);
+
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + GPU_INT_RAWSTAT,
 		val, val & GPU_IRQ_RESET_COMPLETED, 100, 10000);
 
-- 
2.22.0

