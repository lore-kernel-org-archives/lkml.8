Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55FCC33CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC562187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ithCmGPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgANHQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:16:30 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56074 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgANHQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:16:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so5292450pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5zg+Nyx8gIh15cqNDiymw6e+al01EbMcgFt2zvz0/E=;
        b=ithCmGPBDK/u6wxmb7C8KnWpF6VLxN1iVW9EKRTQdp6gCK/wkyNVGMrjLzSyYPtuZj
         KT0dAo1mqlGPGF8vvWskaLxI8E4PJM7ppHVCuRSeKdX+EsfMf57sl+NMqrMkGaZe+a9e
         jMDmnOEr16LjZs3JxaJxhJ4YKueNcn/vlkQrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5zg+Nyx8gIh15cqNDiymw6e+al01EbMcgFt2zvz0/E=;
        b=LNQB0hkr357dGwowasq6ZUiBeVEEBLbPjHcm4XgOjJ6q/Qmmb4l1q6NDASd7DwnGn2
         Prei/+wL3TSufUb1A02FSbLCDX0gHvHvJxECwzI89rZpUOsd1lmYY5Vd2NGeilLgpNcv
         Ro/M3Wcch2+vK32+c2xEoEfHPGL1ZbNl7n95XChMUlDDGsjS28roE2DIOIS4h3gyHCgH
         Fz2y+fu/pKaxFi2J3+++bX8YxeJMjgL8WGyer/rnsvHiQDv/XQ2ooxsLEa2uJQagzEiU
         HSY16CoNrRzTPPC+3JSJ131AVsLfhIB2NTQKhvKF3XY8fh9zvCIh5PmmNJbj/iHzqhtC
         yVWg==
X-Gm-Message-State: APjAAAUeTFqh3FJdXec3HNhfCDKytUGGclKriT1dzliFl6ucZBwYt6oK
        svmpiDFjI6QQQ1a6Mro+B1o4wQ==
X-Google-Smtp-Source: APXvYqz4laPa/9RzoUxpMClNTomxEKcjjRkPSrqYnULimr14OR/2zncKlcPo6jiMuGgeOUer2Xg6RA==
X-Received: by 2002:a17:902:fe90:: with SMTP id x16mr17202238plm.31.1578986186739;
        Mon, 13 Jan 2020 23:16:26 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id b4sm17092976pfd.18.2020.01.13.23.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:16:26 -0800 (PST)
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
Subject: [PATCH v3 6/7, RFC] drm/panfrost: Add mt8183-mali compatible string
Date:   Tue, 14 Jan 2020 15:16:01 +0800
Message-Id: <20200114071602.47627-7-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200114071602.47627-1-drinkcat@chromium.org>
References: <20200114071602.47627-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing only, the driver doesn't really work yet, AFAICT.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

v3:
 - Match mt8183-mali instead of bifrost, as we require special
   handling for the 2 regulators and 3 power domains.

drivers/gpu/drm/panfrost/panfrost_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 42b87e29e605149..3379a3ea754ccde 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -592,6 +592,13 @@ static const struct panfrost_compatible default_data = {
 	.num_pm_domains = 1, /* optional */
 };
 
+const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
+static const struct panfrost_compatible mediatek_mt8183_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
+	.supply_names = mediatek_mt8183_supplies,
+	.num_pm_domains = 3,
+};
+
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t604", .data = &default_data, },
 	{ .compatible = "arm,mali-t624", .data = &default_data, },
@@ -602,6 +609,8 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t830", .data = &default_data, },
 	{ .compatible = "arm,mali-t860", .data = &default_data, },
 	{ .compatible = "arm,mali-t880", .data = &default_data, },
+	{ .compatible = "mediatek,mt8183-mali",
+		.data = &mediatek_mt8183_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

