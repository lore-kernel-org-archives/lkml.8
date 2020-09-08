Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DB420768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QClkfBuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgIHUEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgIHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66FFC0A3BE3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:19:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so19558563wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2h5/f7B8UduwNBWvSzemM2vuVc1bCQBvZ08jf0eflQ=;
        b=QClkfBuh7zRtKPZhArDNelPuXMie1hFY7FPB3XsPbRlBLzS1TUzcRStoDJaFj+3aVZ
         yTZZExlief7f9/Iaz2xUvIL7RcWsHwZQ+dr9MfSesaQgo3huHMHVokyq2FXgZ8GVlJDl
         1TS2E9clRVHW910paXbN65GvZZV+smkSMxbGfjOBBa0lyhHQztUhkmg7Dmm1Hfq2NVE6
         BmH23sbtkUVAVWuPHKhgTjjrX7RT936M3DSZzYqPmz+fKNSG9gOdKuHoLkvh0mK0u0G7
         awgJf92IvgOMOaHm6N4flJkgsHxhNKL/LKSivxXNIt9SKPgp9zu4AtvEo76gxXM6ojik
         zlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2h5/f7B8UduwNBWvSzemM2vuVc1bCQBvZ08jf0eflQ=;
        b=iMyzyMLYICua3okFsvpUqs3bZZ8CFQZlWynU3ZYFH0OEYzJhDpMTbmCmz+VrOwSAhk
         xm53lwsn3T5+FPCteKSlkO3JCZXVa6KRP1o7FRUJwL+KiDZuzP1LADdkgscHccj61pBJ
         gJzI51twnwEb1hfKs6zHb0qi4UG7psfvz8petKYrgvvwuX9Sj4gIRFUew28Y3Jnyu/KL
         zRRjUnt3636BLhJ9pebqFhjFZMGcPhOopfEA4JPo6Q1ZV6Q7SSxBtgbE0lS188vS4ECo
         iUcggK/wBzWgu3uVqsEHNAWEGaqbhaGK3s+BBHhXbDWO/KlSsctWHeVMXoXgh2PXFkjo
         4n1Q==
X-Gm-Message-State: AOAM531uAnukI9ZZpvrJW6j+CgbvXS7et5c5jEp4Zusr+IfgUY8M1C6e
        Wlpb4jTzbsY/nNIi+GxWMHXkUQ==
X-Google-Smtp-Source: ABdhPJy2ANgwewAvMtdvyK0S7iJLntLssA/HK+zsOS39X389rZIqUtFcfuRkd6xLxKT6uQiYWITGiA==
X-Received: by 2002:adf:e690:: with SMTP id r16mr135272wrm.15.1599578345135;
        Tue, 08 Sep 2020 08:19:05 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d25sm10004886wra.25.2020.09.08.08.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:19:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/5] drm/panfrost: add Amlogic GPU integration quirks
Date:   Tue,  8 Sep 2020 17:18:53 +0200
Message-Id: <20200908151853.4837-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908151853.4837-1-narmstrong@baylibre.com>
References: <20200908151853.4837-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the required GPU quirks, including the quirk in the PWR registers at the GPU
reset time and the IOMMU quirk for shareability issues observed on G52 in Amlogic G12B SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 36463c89e966..efde5e2acc35 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -656,7 +656,25 @@ static const struct panfrost_compatible default_data = {
 	.pm_domain_names = NULL,
 };
 
+static const struct panfrost_compatible amlogic_gxm_data = {
+	.num_supplies = ARRAY_SIZE(default_supplies),
+	.supply_names = default_supplies,
+	.vendor_reset_quirk = panfrost_gpu_amlogic_reset_quirk,
+};
+
+static const struct panfrost_compatible amlogic_g12a_data = {
+	.num_supplies = ARRAY_SIZE(default_supplies),
+	.supply_names = default_supplies,
+	.vendor_reset_quirk = panfrost_gpu_amlogic_reset_quirk,
+	.pgtbl_quirks = IO_PGTABLE_QUIRK_ARM_BROKEN_SH,
+};
+
 static const struct of_device_id dt_match[] = {
+	/* Set first to probe before the generic compatibles */
+	{ .compatible = "amlogic,meson-gxm-mali",
+	  .data = &amlogic_gxm_data, },
+	{ .compatible = "amlogic,meson-g12a-mali",
+	  .data = &amlogic_g12a_data, },
 	{ .compatible = "arm,mali-t604", .data = &default_data, },
 	{ .compatible = "arm,mali-t624", .data = &default_data, },
 	{ .compatible = "arm,mali-t628", .data = &default_data, },
-- 
2.22.0

