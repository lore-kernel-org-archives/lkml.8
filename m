Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09E5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4312074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE7s85l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGACYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgGACYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:24:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD5C061755;
        Tue, 30 Jun 2020 19:23:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so9192467ljj.10;
        Tue, 30 Jun 2020 19:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfaJuFdXozXDPR9zng+hgfPKlX3mT8FyISD1FTQ25bo=;
        b=VE7s85l5fyLK0B6o/yt86K8C9cK16DV3MrIuvwOOuc+NBn1BXoVRakQLfb1/3Yg/aZ
         R+HSNymIVAhgmg3e2ojg6/JRCpoBa4x3lmzlk+2suLHFSujns4KhQxR1QLr4D9sFpwCb
         9Q+ZXTqCF+JPPInnPjoTcecuq8t5akEpl/N/smciUfH/pmYq9aHD8SvSiu5k2OiV1o3e
         cEoGjNI+o2cyYd8MlsF4TE/B2SGmBqOTAiO3wyWDwmSd8NuIPVrAQ8Ye/XG1rH6jwVKE
         W2OlthjfiervACVtspzepIMIv3aLd5e4XHJdJcYbuodAlHEygtys3135ZqG/+3iwg43p
         IpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfaJuFdXozXDPR9zng+hgfPKlX3mT8FyISD1FTQ25bo=;
        b=lGfe0FY3O5j5hnl3W5ks2eWxne3WmuLqjZQ58UVsODJeO0YeSncHeY7RcPE7vOJbR5
         yzW/K5DERCn3R3Wjj+t5SwFgGhwhZbQwMLs2wFFbMQ2roAgwonLSlL/y2fK9s4svAxgx
         SQmqobAQw1TcnJBRyibh4EKCzHVl2FVWFfiMOve3rT5T3iqaBHEvj9QQbrAsaEhOJ1oU
         mOhA+40na5vO6Ef5t7psoZ/GkpLVAiY0SPGpncQxXXgBREP0y7EOwuW5b5F8apFMUTff
         x2jcR/kFt8lFZUs+Bid7a8zqxLmz8cwD45uv75zYbc3NEXK2WJa0vzYDCSQaGurpHowe
         qq4Q==
X-Gm-Message-State: AOAM5320ft+TzW/xaCWb7uv3fMEmVrT6LBoltX5aeTIJHnG1JFtOrFD+
        Awwl9+JnFCcKnvboN6vjTGY=
X-Google-Smtp-Source: ABdhPJw8XwqM+o3V3NyT/ahxuvQDzRvny1dTXfsyM+RgMUzYUT+Wa94GwTf+cWLO24giLZ5NMMBl+g==
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr12254508ljp.37.1593570238171;
        Tue, 30 Jun 2020 19:23:58 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id f21sm1303557ljj.121.2020.06.30.19.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 19:23:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/4] drm/tegra: output: rgb: Support LVDS encoder bridge
Date:   Wed,  1 Jul 2020 05:21:27 +0300
Message-Id: <20200701022128.12968-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701022128.12968-1-digetx@gmail.com>
References: <20200701022128.12968-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Tegra device-trees will specify a video output graph, which involves
LVDS encoder bridge. This patch adds support for the LVDS encoder bridge
to the RGB output, allowing us to model the display hardware properly.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/rgb.c | 58 +++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 0562a7eb793f..9a7024ec96bc 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_simple_kms_helper.h>
 
@@ -267,24 +268,63 @@ int tegra_dc_rgb_remove(struct tegra_dc *dc)
 int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc)
 {
 	struct tegra_output *output = dc->rgb;
+	struct drm_connector *connector;
 	int err;
 
 	if (!dc->rgb)
 		return -ENODEV;
 
-	drm_connector_init(drm, &output->connector, &tegra_rgb_connector_funcs,
-			   DRM_MODE_CONNECTOR_LVDS);
-	drm_connector_helper_add(&output->connector,
-				 &tegra_rgb_connector_helper_funcs);
-	output->connector.dpms = DRM_MODE_DPMS_OFF;
-
 	drm_simple_encoder_init(drm, &output->encoder, DRM_MODE_ENCODER_LVDS);
 	drm_encoder_helper_add(&output->encoder,
 			       &tegra_rgb_encoder_helper_funcs);
 
-	drm_connector_attach_encoder(&output->connector,
-					  &output->encoder);
-	drm_connector_register(&output->connector);
+	/*
+	 * Tegra devices that have LVDS panel utilize LVDS encoder bridge
+	 * for converting up to 28 LCD LVTTL lanes into 5/4 LVDS lanes that
+	 * go to display panel's receiver.
+	 *
+	 * Encoder usually have a power-down control which needs to be enabled
+	 * in order to transmit data to the panel.  Historically devices that
+	 * use an older device-tree version didn't model the bridge, assuming
+	 * that encoder is turned ON by default, while today's DRM allows us
+	 * to model LVDS encoder properly.
+	 *
+	 * Newer device-trees utilize LVDS encoder bridge, which provides
+	 * us with a connector and handles the display panel.
+	 *
+	 * For older device-trees we fall back to our own connector and use
+	 * nvidia,panel phandle.
+	 */
+	if (output->bridge) {
+		err = drm_bridge_attach(&output->encoder, output->bridge,
+					NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (err) {
+			dev_err(output->dev, "failed to attach bridge: %d\n",
+				err);
+			return err;
+		}
+
+		connector = drm_bridge_connector_init(drm, &output->encoder);
+		if (IS_ERR(connector)) {
+			dev_err(output->dev,
+				"failed to initialize bridge connector: %pe\n",
+				connector);
+			return PTR_ERR(connector);
+		}
+
+		drm_connector_attach_encoder(connector, &output->encoder);
+	} else {
+		drm_connector_init(drm, &output->connector,
+				   &tegra_rgb_connector_funcs,
+				   DRM_MODE_CONNECTOR_LVDS);
+		drm_connector_helper_add(&output->connector,
+					 &tegra_rgb_connector_helper_funcs);
+		output->connector.dpms = DRM_MODE_DPMS_OFF;
+
+		drm_connector_attach_encoder(&output->connector,
+					     &output->encoder);
+		drm_connector_register(&output->connector);
+	}
 
 	err = tegra_output_init(drm, output);
 	if (err < 0) {
-- 
2.26.0

