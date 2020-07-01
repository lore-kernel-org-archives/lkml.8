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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE10AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B766020890
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOZH3Nn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgGACYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgGACX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:23:59 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A33C03E979;
        Tue, 30 Jun 2020 19:23:58 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t9so12655218lfl.5;
        Tue, 30 Jun 2020 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5nZg8KheWIS8ObVaNA2RcCFchGpMXgRR/HHGM1BHBw=;
        b=WOZH3Nn9evGdNfNdegsmScfv681f/RyxGofCEPnYWGfspTEyGhonNre+yGBHn5bFfa
         sxTcaYeEaMnRWVLKe6dvl953jlQGCQ90o4ua4ivcGyBeLWZRJOINabmsrtxixKEvjfTs
         rbOv9o6+OeD7sJ5vR+COPvihHs5V3r5hDipoEF41JSOpjhY4i1iU3acV2Zg4TXZ1LabF
         J/TkePIkZrTOmGmyxPRnEKauahz/hGAbNE3AhAXj+cq3pUaNCKcoSaLRj/r2e3ZlZj3b
         NageNukvNfawQfIsidTyucHIEs5hhntMok1Rxq3MsKd2uiw0jxmGMBHY+EAUfqj4e1Jt
         6Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5nZg8KheWIS8ObVaNA2RcCFchGpMXgRR/HHGM1BHBw=;
        b=WRTcdkOqwiIHdrLnBxCfFqRZI+cw7tifWscqCCwKKflQBATydbJWRHHR4dflvNuS3h
         tgmumx29mbYJAU5ljYq6BpbQ6Ddd/aT5n/TuCBiYhLDXp5ck2NW02XPmKr3BhdcgMaKY
         viZxcL6Zl+r2n56cJW7Cq1qVWCADCNWrrP4txZHf9CbCvmtjZ2NhwHUCS75LutT8MeUx
         eKioCEk7rdmvnn43Pe3udX6LlgOk+eS6G6R4ajJYWsHNcHbfpS5o2c9IilGZFoch43AF
         kw5fy9cyzTkBA2dnVLwBkdQD0eh/bScJq576TLdctZs2BnyaQfxw2WIpcYswTR8dQ4aO
         h9ng==
X-Gm-Message-State: AOAM530voMtzvE2OqEnnI06v+aCyGJHIZXRKM5AMf+vkP+sg5uIr0p3O
        3I/cEo2l8DejvuKXjRnYDYQ=
X-Google-Smtp-Source: ABdhPJxLkVvzwxeFv14SPpaqlsYj0gMEYB9Z7wtPKtzeNL3g1IL8KbUjYp/yAgjzyzyrDcB8Hs5VPA==
X-Received: by 2002:ac2:569c:: with SMTP id 28mr13540340lfr.195.1593570237240;
        Tue, 30 Jun 2020 19:23:57 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id f21sm1303557ljj.121.2020.06.30.19.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 19:23:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/4] drm/tegra: output: Support DRM bridges
Date:   Wed,  1 Jul 2020 05:21:26 +0300
Message-Id: <20200701022128.12968-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701022128.12968-1-digetx@gmail.com>
References: <20200701022128.12968-1-digetx@gmail.com>
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
2.26.0

