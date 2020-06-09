Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529E72074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO/pDAfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgFIN3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgFIN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:29:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C947C08C5C3;
        Tue,  9 Jun 2020 06:29:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so25073126ljn.4;
        Tue, 09 Jun 2020 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5nZg8KheWIS8ObVaNA2RcCFchGpMXgRR/HHGM1BHBw=;
        b=LO/pDAfKccIgaQ5fHav45do3zAAxpH6cYqZNL4Ks0Nag6rg1TiV7PRLQAgrrwRvF/7
         ScozvkvW1whNFhyUWdR5rNDDj0TMJcW9DozxyD2mAZKSw0dslNBejKUlpygRVq8eb2yZ
         gvOlIiKxx8Ck7sBXuuSzXyv+0mm72EIsTGXx3pzq/G/B9vlEpE39saQ6vIJ2VTuXL7O4
         FQYq0UZhKaCDjFGvsRqM3mr4rHqRjCSbvg54skBzGP99lk4IBy3/YM8eReqrrIMjPP9G
         Gwa3/UIiX80qJh6bQhVwRK8pTuZGTAyED7wGghph6GljlLGezKNPFhP6acSS+G5/P2Gu
         In4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5nZg8KheWIS8ObVaNA2RcCFchGpMXgRR/HHGM1BHBw=;
        b=G6pP/mFwb/OIl+7kojUHVM99gUBPgUVzlAM8bvJf+uE/lkgJgKD9FgXsa5XwZmybDS
         MsJOmM5aRged1DNJkljE0pxhjOaqAO7cI3FZn0E+SjXednb0IezjWEGHhD6ofyeILnkF
         AOTD/DBSo9eEx0CDjd4m9DrEodj0ESCUpbpugV7l2Y0Opk0WK1BxIjIAwHPPZk8xjtbZ
         f8TnEJtsAJAPvuy3d1EyHGKbZDlB6WQb/3AiR9ZptxBPRLKOPbweooRQaM26nYULLais
         P9qv8fzVeE93KipZk4XIr28ne3rgZAVulQC5IsBcMlGEsRCqcQdkhhMeHw12D39Mxn7D
         Lrmg==
X-Gm-Message-State: AOAM533VteOkDMig96Sh2xCmlI/Ult0KWW2dnK/vFz38pH4g66pKxwWy
        2Co9qC+Dmr5BBYU6u/fAAFI=
X-Google-Smtp-Source: ABdhPJzz2QrldO4fIrKUkRTl1Oo3K4hLblhuGYsUcIPU2pKjUY2pOSrmJezS/COh7b4iOpC4OH5OZw==
X-Received: by 2002:a2e:974e:: with SMTP id f14mr13305849ljj.102.1591709354999;
        Tue, 09 Jun 2020 06:29:14 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id s8sm5069821lfc.83.2020.06.09.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:29:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] drm/tegra: output: Support DRM bridges
Date:   Tue,  9 Jun 2020 16:28:53 +0300
Message-Id: <20200609132855.20975-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609132855.20975-1-digetx@gmail.com>
References: <20200609132855.20975-1-digetx@gmail.com>
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

