Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F58EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1827720675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEpuudm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGGQ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:29:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DCBC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:29:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so20241690pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cLpFT30Q2wrhHA54qttjA8gJomi+1hYn+159UrQoFZg=;
        b=DEpuudm/4MZv5D+pBETCrXPAcc5pEq0Tn39PHv9h9s9yiek57l85H6pNwvnRrWvFIo
         9ETSoqtWaU/K2OdoBf/cI0ocSqzRNPjdM02muLHprNvlvZnEwsCfzkM5X73rdsGBUO7M
         cM8cM/FYdZRpKjdEZ29mQv+2wRZ9z5V0wjUt4dLbU4+CGeyem9Ywjp41F8pJSLxhpAdi
         foh8zI+7+6gJOjtVf5PUOIzDQDynN6GX5wgUzIwu2qFpLQIqGPrIoLZuKBZts1XorBx5
         gIF/1D5di/wOJTKghjE4Ftdf1HVm7rxJV5zuvOKEA1uF1kP5HyxtGzKV1QF8FD/nC+xt
         d2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cLpFT30Q2wrhHA54qttjA8gJomi+1hYn+159UrQoFZg=;
        b=pjI2CX3v5nQi0T8K95x+NlT8PUgqIW/PD8dSGhsA0igka4zmPHp40ciz5wwTl6IXrZ
         17HsXE3plaJLC4rdI4xF9WC+1QgLq7gu350P92XgNdKvrOU9apbwghwFwpIt7k2vjAWf
         PDwRghnKrnnmkROpDt0BlfZrqEs3RzK3OPtR508xslud7QSC3QnDqJYB1xdzWg8GLyk6
         Dge7SDTqgQWURMjfp8Vt4Tz08vkJ+q4O4BlXn+2CWmXIqxBs6uq8rPeF6VaYVjcAsouo
         /D/bEup7qt5uCiG05e0pmDwGyN1UMSNR0ZmC3Za6VwZudAhr0o0RwJjrqlzr5mPzG38v
         rvSA==
X-Gm-Message-State: AOAM532M5zWOpPK7DLh19DI8LTfX2XWjDJKyMLiaR8QBHveU6zCGBJ4S
        IzXdderIotuEhlqHXGRgyn8=
X-Google-Smtp-Source: ABdhPJx3mJownrF7Uccn5h8F/aE8m3prj8aLp/p7HCftX8fEe/IpDWUoMZCFHCqPz8CQluKsVZQRDA==
X-Received: by 2002:a63:ea02:: with SMTP id c2mr45591701pgi.66.1594139341076;
        Tue, 07 Jul 2020 09:29:01 -0700 (PDT)
Received: from blackclown ([103.88.82.137])
        by smtp.gmail.com with ESMTPSA id q7sm23610785pfn.23.2020.07.07.09.28.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 09:29:00 -0700 (PDT)
Date:   Tue, 7 Jul 2020 21:58:48 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     srrj.967@gmail.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] drm: mipi-dsi: Convert logging to drm_* functions.
Message-ID: <feeec2816debcf4105ac22af1661fd2d491d02b9.1594136880.git.usuraj35@gmail.com>
References: <cover.1594136880.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594136880.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert logging errors from dev_err() to drm_err().

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 07102d8da58f..5dd475e82995 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 
 #include <drm/drm_dsc.h>
+#include <drm/drm_print.h>
 #include <video/mipi_display.h>
 
 /**
@@ -155,19 +156,18 @@ static int mipi_dsi_device_add(struct mipi_dsi_device *dsi)
 static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 {
-	struct device *dev = host->dev;
 	struct mipi_dsi_device_info info = { };
 	int ret;
 	u32 reg;
 
 	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
-		dev_err(dev, "modalias failure on %pOF\n", node);
+		drm_err(host, "modalias failure on %pOF\n", node);
 		return ERR_PTR(-EINVAL);
 	}
 
 	ret = of_property_read_u32(node, "reg", &reg);
 	if (ret) {
-		dev_err(dev, "device node %pOF has no valid reg property: %d\n",
+		drm_err(host, "device node %pOF has no valid reg property: %d\n",
 			node, ret);
 		return ERR_PTR(-EINVAL);
 	}
@@ -202,22 +202,21 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 			      const struct mipi_dsi_device_info *info)
 {
 	struct mipi_dsi_device *dsi;
-	struct device *dev = host->dev;
 	int ret;
 
 	if (!info) {
-		dev_err(dev, "invalid mipi_dsi_device_info pointer\n");
+		drm_err(host, "invalid mipi_dsi_device_info pointer\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (info->channel > 3) {
-		dev_err(dev, "invalid virtual channel: %u\n", info->channel);
+		drm_err(host, "invalid virtual channel: %u\n", info->channel);
 		return ERR_PTR(-EINVAL);
 	}
 
 	dsi = mipi_dsi_device_alloc(host);
 	if (IS_ERR(dsi)) {
-		dev_err(dev, "failed to allocate DSI device %ld\n",
+		drm_err(host, "failed to allocate DSI device %ld\n",
 			PTR_ERR(dsi));
 		return dsi;
 	}
@@ -228,7 +227,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 
 	ret = mipi_dsi_device_add(dsi);
 	if (ret) {
-		dev_err(dev, "failed to add DSI device %d\n", ret);
+		drm_err(host, "failed to add DSI device %d\n", ret);
 		kfree(dsi);
 		return ERR_PTR(ret);
 	}
-- 
2.17.1

