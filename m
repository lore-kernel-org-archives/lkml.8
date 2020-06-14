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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C56AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B6420739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqy6XNyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgFNRXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFNRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:23:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB6C08C5C2;
        Sun, 14 Jun 2020 10:23:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so16427469lji.2;
        Sun, 14 Jun 2020 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5nZg8KheWIS8ObVaNA2RcCFchGpMXgRR/HHGM1BHBw=;
        b=Dqy6XNyLSpGzRAK8Mx2BZJwy8mQMfw9cJ4gG2HCuEejoyhoX1igZul80ku4k+6hGxl
         8UF0ySu37m0omKHX5t0FvsIIflDE1n/SKPlGJyePW22HIzv4iRDLOJPyFfvXBKyjvujP
         k25eoAezusd38q28urO4RjKuVQX4Rrq0O2LTvI1w/y2EqQ6lXH/S4fguB998BNVhV7Gn
         dNaOJLhcTmc02Yd91VMo+aIWNUCE6lZ/2duOTdyDWNcS0/HTHIwTcSs+44upBtVIsGOh
         J37RR8mTcgyTZwF4xdNgqOPk7TPmxB1VvDskyB7acYlPP/eU9hvDbylanZbqTO3PQX/K
         vQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5nZg8KheWIS8ObVaNA2RcCFchGpMXgRR/HHGM1BHBw=;
        b=ope10otpJzB5y1MUcIMzyUyQj53f5ZBWyr/5G7laivYvGLZ8BDLTSX3TGK4kwjU/Zr
         RkJGlgHew3nYfX/eJcoKsUi8BbouklZnb8KRYioLJkOei+5Lx1MpCQOfGbyLnMeAKyib
         J4mBBSf8vFLgCU8Ss6+/xteDjCcN8a2eohB5MR7iL/8WoZExkubWgn+yQiZb7D2cYSED
         RyQq/9XRNu7ftu5PnPp4OKvS8ArgXcPot8i3obD6B7BFaFMfOztCrvEJVyvT+bXNYWx+
         KvRx84V7WlVlF+k7l9gQmzjU0iySCKi7QuL5jbgNTMWQ1h8DyDHiNeQ/mOP+o2ydcv1Z
         7t1A==
X-Gm-Message-State: AOAM533BBdQL9WC36OWtpSFiSnF6oc2tF2IosOM9wzVc/uFH54rLG32R
        XAQx+1CBEJW0rH05YNzidLw=
X-Google-Smtp-Source: ABdhPJwSz84D2Xlury2MH6eG3RCGtfat5pMgNh5ZeZ8BdFrpPl/5TrBUHqMqWjoU3cTBnLJPEyUmcw==
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr11057370ljp.266.1592155402510;
        Sun, 14 Jun 2020 10:23:22 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id m14sm55144lfp.18.2020.06.14.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 10:23:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/6] drm/tegra: output: Support DRM bridges
Date:   Sun, 14 Jun 2020 20:22:32 +0300
Message-Id: <20200614172234.8856-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614172234.8856-1-digetx@gmail.com>
References: <20200614172234.8856-1-digetx@gmail.com>
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

