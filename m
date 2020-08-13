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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E37C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5F320829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFCLXi/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHMWH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgHMWHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:07:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D48C061757;
        Thu, 13 Aug 2020 15:07:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j22so3848049lfm.2;
        Thu, 13 Aug 2020 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWzvdmgXDHuOtJszdX4J4B9Z4Waxa6XTUameiQDphcY=;
        b=lFCLXi/++Wld7Pef95SQoNaKCO+nuVwKA83lj/LWRH6z1GpTKPIvZgA5QoycREtvh5
         Jdo4w+LW3Mkg1MqCnYz+wIXca7AxkwEy8q+D9I7X2L4Kw0YawnZfLX6TVhiiaAMI+/Du
         Gr3Jv0qPWpGsCBR8yQsjnui7P5NDvMkGgoMdoBQM5KCEWfJ12s0XVlKWfNMR9n3S+348
         RLtZj72ntG+TmiCwaW7D1WMAkaoYvf6c4dUcxXlmw0zvFjuMhxde/Wc34oL04cMFcCTz
         0NlkoALfIqdTnf4Q2EJ+FJq66X97NMUloMese9QHP1AX+p3P5d6JukihtBt+MxOHu1g+
         2o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWzvdmgXDHuOtJszdX4J4B9Z4Waxa6XTUameiQDphcY=;
        b=Y0Tspg7PHZKjz3SY+15r1ll2ZmRi6qklPjK7C7yKfxWXWGulz7VKci3LZcGL/cPYvQ
         NPWJU4fuoIIpnOyQn9RvMMosQRg32fiGCSK6zg+uyr3vgDShUMwg0Kee+5O3hq85B2Bh
         VPWXO/Ht1EAS5Zf6Eg59BEnwjhQXHX1F8IpVjP5mitTwe+H+F1KDIQ8b4NNz4wCepJmc
         o71ebn1kCfAq+d9DP+EHapLgk5nEWPjuVsAcsMgEDknbF5QfXyOMu99kEslyIYAdfyTa
         cfAUNniPUaW4PQJjo8ctY+BDDrKCcXNYiYlczONbcOU75GWarSR3wrHKahJm6rl3nJCB
         NC4g==
X-Gm-Message-State: AOAM533DBCsGb52XzvhIOqN2dtlxwEyyLkPbFdCY5QjLjKMiHmiJbPIs
        baMUcmPqjaJ7b/ihZMEG+DxuOGZ2
X-Google-Smtp-Source: ABdhPJyxqKir1ref2JB/ZBi9uoJB2LHWMxuOvTIGdPa97QGjik3HXoPPQbGgeYDxvzXimJtkPnh0FA==
X-Received: by 2002:a05:6512:20c1:: with SMTP id u1mr3143864lfr.17.1597356426488;
        Thu, 13 Aug 2020 15:07:06 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1354452ljk.97.2020.08.13.15.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 15:07:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v10 2/4] drm/tegra: output: Support DRM bridges
Date:   Fri, 14 Aug 2020 01:06:54 +0300
Message-Id: <20200813220656.30838-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813220656.30838-1-digetx@gmail.com>
References: <20200813220656.30838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Tegra device-trees will specify a video output graph which involves
a bridge. This patch adds initial support for the DRM bridges to the Tegra
DRM output.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/drm.h    |  2 ++
 drivers/gpu/drm/tegra/output.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index b25443255be6..f38de08e0c95 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -12,6 +12,7 @@
 #include <linux/gpio/consumer.h>
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
@@ -116,6 +117,7 @@ struct tegra_output {
 	struct device_node *of_node;
 	struct device *dev;
 
+	struct drm_bridge *bridge;
 	struct drm_panel *panel;
 	struct i2c_adapter *ddc;
 	const struct edid *edid;
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index a6a711d54e88..ccd1421f1b24 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -5,6 +5,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_simple_kms_helper.h>
 
@@ -99,8 +100,19 @@ int tegra_output_probe(struct tegra_output *output)
 	if (!output->of_node)
 		output->of_node = output->dev->of_node;
 
+	err = drm_of_find_panel_or_bridge(output->of_node, -1, -1,
+					  &output->panel, &output->bridge);
+	if (err && err != -ENODEV)
+		return err;
+
 	panel = of_parse_phandle(output->of_node, "nvidia,panel", 0);
 	if (panel) {
+		/*
+		 * Don't mix nvidia,panel phandle with the graph in a
+		 * device-tree.
+		 */
+		WARN_ON(output->panel || output->bridge);
+
 		output->panel = of_drm_find_panel(panel);
 		of_node_put(panel);
 
-- 
2.27.0

