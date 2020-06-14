Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D814BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41922065C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkVJFgev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFNGxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgFNGxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:53:03 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED76C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:53:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z2so12479371ilq.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l7NqrBVPm55TBMnhB8GUWUjLTUxcL6eNHsDiGUxal5I=;
        b=nkVJFgevcODeA1AiC94JJnvIYyQe+jwYYSgOR8nE5HriFZTKjNPyQJxSzqBnqEngiw
         n5UisSMFNqj6olBJvMBQP+PvjRpqnaOv35p4N3RPkZrtRUgwTY0J475ABpsNm+99wASN
         ATx7iNksqv4nRnhaI4H9/6dXXRXuRlD6Vyex43MJkpfaeWqI1trgomEwHjX0IWNoxMhL
         SgwtpS/S/Z4YgYB6O5z/cOa6GMWpS/QOXrJrwVRAlvpBSurIiBGUgl5cCP7fbqh9GUh1
         ycudI/SXnqFwuEFKYge9EajppLTMMhU3rwik2JFV/pF/V89nqA7+Kyjmx8DlHl7WSNLl
         LpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l7NqrBVPm55TBMnhB8GUWUjLTUxcL6eNHsDiGUxal5I=;
        b=o/LtDch3mUKTC1iRDhutPxS7XuaOTkuZwnnx4/wauq82ABsbQYeTvYMwg/Wmt/cNrh
         ArktUHb9exfHC8GEuHE3XssKNm5/d7UUdITOscYzPnTcKxDm48o81LLGYpNd8KSj+fVZ
         1wzeFDYTJ8qOfsYDagW4LKg5HH8kZFr95W+JhZF7AqTyvJJaTh1mdc+qLEUlNHWl9+Q8
         8WwZY52oq0K9gsyZWGz9suy1LQ4WYh+TeMsdGBU7360U1RHj96+oGDGg1Ozr6Lx6AQGS
         8P+urr/YqG6gWUVqo8xXOzrjKf3kE1ZOlYGDa6iJCgaIzUD6kj8wzuNL5RlMxTH0U4JB
         FqJQ==
X-Gm-Message-State: AOAM530xJNYIUJsFn+RaLbDHTQcIo0p1oKx7nbKt97OmEl3mxYfcqPKl
        0pzkc5pMBd6WiMh3HfLDYLY=
X-Google-Smtp-Source: ABdhPJxaHRK5nnGHScRiGFj7JW23P9/j3SoAXAEFRUS2BO9oz5yv9zNOby9jq9cqp1b66vGrHSFMWA==
X-Received: by 2002:a05:6e02:4a7:: with SMTP id e7mr20934834ils.180.1592117580805;
        Sat, 13 Jun 2020 23:53:00 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id n82sm5821135iod.23.2020.06.13.23.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:53:00 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/vc4: fix ref count leak in vc4_dsi_encoder_enable
Date:   Sun, 14 Jun 2020 01:52:50 -0500
Message-Id: <20200614065251.94106-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in vc4_dsi_encoder_enable, the call to pm_runtime_get_sync increments
the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index eaf276978ee7..e651de9d1c7d 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -838,7 +838,7 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	ret = pm_runtime_get_sync(dev);
 	if (ret) {
 		DRM_ERROR("Failed to runtime PM enable on DSI%d\n", dsi->port);
-		return;
+		goto out;
 	}
 
 	if (debug_dump_regs) {
@@ -916,13 +916,13 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	ret = clk_prepare_enable(dsi->escape_clock);
 	if (ret) {
 		DRM_ERROR("Failed to turn on DSI escape clock: %d\n", ret);
-		return;
+		goto out;
 	}
 
 	ret = clk_prepare_enable(dsi->pll_phy_clock);
 	if (ret) {
 		DRM_ERROR("Failed to turn on DSI PLL: %d\n", ret);
-		return;
+		goto out;
 	}
 
 	hs_clock = clk_get_rate(dsi->pll_phy_clock);
@@ -944,7 +944,7 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	ret = clk_prepare_enable(dsi->pixel_clock);
 	if (ret) {
 		DRM_ERROR("Failed to turn on DSI pixel clock: %d\n", ret);
-		return;
+		goto out;
 	}
 
 	/* How many ns one DSI unit interval is.  Note that the clock
@@ -1088,6 +1088,8 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 		dev_info(&dsi->pdev->dev, "DSI regs after:\n");
 		drm_print_regset32(&p, &dsi->regset);
 	}
+out:
+	pm_runtime_put(dev);
 }
 
 static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
-- 
2.17.1

