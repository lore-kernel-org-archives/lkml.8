Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9DCC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E0921D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYenw0CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgDRRH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgDRRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:07:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF0C061A0F;
        Sat, 18 Apr 2020 10:07:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so4419266lfc.5;
        Sat, 18 Apr 2020 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vFP2Xgl/P5L3A3AOxfNfJFdvZnWq+GhQQ62axDeZbgY=;
        b=OYenw0CFf7zJ1WnF4hUB8e1e8MLRJoH1OEtXGLd7Ae53R+7MH2FWi38JrkdktSsUt1
         11sfyc/W4Bgr1qDrzOE3hRjwQtx/il8SCvF9rv16zSI4qUbgtKNALQv91YStbqzTFdMr
         ad0cU7OIcqiQEZZYg0UoEuVNFPF/PtisVryWUU5VwsbjF5egyNrmX/ZohokOJNxGzoY4
         U39WK0niOGFOwgGGEZ4rsQMZmpygkDNR4bgxsSPo+IMZnW9IvCA7eH4DRcKYKFC4TDZi
         VLkC6o1pgTDlX+jD08MA9riDalmztx3p4lnM+C6CLefTecn+h1D6KmHVk9dZFbRhOUAy
         ZJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFP2Xgl/P5L3A3AOxfNfJFdvZnWq+GhQQ62axDeZbgY=;
        b=O0SrpBqikU6LkfY4KcZQM3rIVtKFjGsDWLHkQWWfrXl7Sw2nT9htMg5fyoVtmXCn/0
         1ewoGf9JRDgxou7ChkCdcOuG90LcuQCMqMkBy4GuEueP/gaJsL376c2dnX5HU/d5P6xV
         SZjtqyn9/oGhJS5/Y/WZChFSZy8zGQ+mtVRmejfFYBZvSi4A1ALMUPMNMUBCgC8QCoD8
         B5eGGKbIzN+GBqP99VuY4k9iQUA5erhdMGHGBkKZvWvBmGitKsSgTkAMMRMR0Pi/d3Md
         8ISSYbkhdqBQec1FgJM2tWvrJNSP0OIXwDjrRaeuj1ENI2gKhyXlz0sUjmdRPhbqDeNX
         26dw==
X-Gm-Message-State: AGi0PubAH/iCpqdAhZQ4VQQdHszppEXUwc0TbVVIzJB4E0wJAhcHj+nm
        kFlx7CH65t4AvaG0Eq0u4S2jJvuQ
X-Google-Smtp-Source: APiQypIlefeTuO41RijFbk6d9TIcAjiDCdxxSql5D26sOBd/08siAd8F6UP9uMfaUABbUEzgSij3sA==
X-Received: by 2002:ac2:5f5b:: with SMTP id 27mr5376939lfz.136.1587229642863;
        Sat, 18 Apr 2020 10:07:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id e15sm8768909ljb.25.2020.04.18.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:07:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] drm/tegra: output: rgb: Support LVDS encoder bridge
Date:   Sat, 18 Apr 2020 20:07:02 +0300
Message-Id: <20200418170703.1583-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418170703.1583-1-digetx@gmail.com>
References: <20200418170703.1583-1-digetx@gmail.com>
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

