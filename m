Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D8EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93F2204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze4erFzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHMV4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgHMV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:56:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D38C061757;
        Thu, 13 Aug 2020 14:56:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so7854948ljj.4;
        Thu, 13 Aug 2020 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsQa4/wa/hr0FMOOmoE7ekivRXN/hVmPW68FrHf8SvM=;
        b=Ze4erFzxVZru3NYe8ZT3q5z8yGB9elgvo7xXqLgr3HyM8VAXlGsbMRFGm7Vn0nukuD
         iYkmKOCclAEFhHkuONXsFf4vwblr1D366Z/GpDydV78x0rFZ0xoftTPfHf0M+UPcdJ+3
         vavJIqbINSp9T0P/TWNnKjPBg7ekVbBb/O4OnuJI3AYepEXXeN2StzEEmQ4Y5Qhxtil1
         FGfUGs6TCMe8snfF/qGLwUDYVXjU10xrvffpLo1XNOQqx3FFHtJfK3TFq2rxd6JhrJm4
         SOJqamOllhCBPM/6/+oNf83P9OjcrYz72AC/oz0hj/bILw0v9VtBvgAhJWimfZ5COcoL
         olxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsQa4/wa/hr0FMOOmoE7ekivRXN/hVmPW68FrHf8SvM=;
        b=BuZ7KsaY+skJhG1DpcqNIMPz7x1Sud4UPvpdhmPDoSWXM2Wnte541u6jrxlsuFXSys
         kyVTIW2Axc1cCNcKMYApDZQlzZri5L5hg11EIBF78Zm/CKcAyD/15kStnn3ewtlXNjpy
         8ySES4bkWztB3Zw/4pmckrKvOzYbYy5hH1rKoZOD4GyDQ87DYqkQSaDy+Qfj6Zhr87yz
         rOkMJOqjb2RJvXMBdcTw1L+zoZd3UFBc0rFj5ErosWOoiE1Z1yfSUGaRTQZZbv4FZerT
         0xo38sLK0tKkk6OOUPcT0sif3ngOVlgGDVz78URuaAiSuoaDElTBRxiKQJSnGWypZQEd
         rKmg==
X-Gm-Message-State: AOAM533uDuzK1NT8F5V4loUsfEQpg51eyr2RHXZ9ye1K6o3yXHHl0UBb
        B8X3yFSA7GN+IvakQqe7APc=
X-Google-Smtp-Source: ABdhPJxF5FcrTFOve8Js3QSlq60WT7ItL6LDIqEAG+J+TDbZvERjyEBqiXw7AdoTfQFFusczr4OHvg==
X-Received: by 2002:a2e:7c0f:: with SMTP id x15mr3055969ljc.205.1597355791880;
        Thu, 13 Aug 2020 14:56:31 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1349977ljk.97.2020.08.13.14.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:56:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v12 2/4] drm/panel: Read panel orientation for BOE TV101WUM-NL6
Date:   Fri, 14 Aug 2020 00:56:07 +0300
Message-Id: <20200813215609.28643-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813215609.28643-1-digetx@gmail.com>
References: <20200813215609.28643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This reads the DT setting for the panel rotation to set the panel
orientation in the get_modes callback.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index e320aa30b9ae..6824363fcff1 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
@@ -43,6 +44,7 @@ struct boe_panel {
 
 	const struct panel_desc *desc;
 
+	enum drm_panel_orientation orientation;
 	struct regulator *pp1800;
 	struct regulator *avee;
 	struct regulator *avdd;
@@ -740,6 +742,7 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
+	drm_connector_set_panel_orientation(connector, boe->orientation);
 
 	return 1;
 }
@@ -779,6 +782,9 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
+	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
+	if (err < 0)
+		return err;
 
 	err = drm_panel_of_backlight(&boe->base);
 	if (err)
-- 
2.27.0

