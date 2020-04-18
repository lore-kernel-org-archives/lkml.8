Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA57C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3ED3221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3DnJSRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgDRRH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgDRRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:07:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBEC061A0C;
        Sat, 18 Apr 2020 10:07:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k28so4394038lfe.10;
        Sat, 18 Apr 2020 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzHxFhcgWD/fZsCe3fmC7U0LkboW0qpnWF3suCBMKYk=;
        b=T3DnJSRYxNDt1AYmdsFRorYQ4sIbtNy/6+H3c+6NJY7aaU79vwN+SYTDidg4TKuA98
         uo4I5ZY60m++jXGywzj3RODdSlR+iDtP8z2XXjco1sz7bRQyRnlzp5IsvyBTyX0H4rmR
         xehROXC4fNe+sL0U221SX/K7W7RbscCMft2bMFgvZd6TjLh72jCMy4F5TniArQO+IBOO
         D93gu3+bXptqcq0F7L3j6319aoKk78KvxJrkdiGljpKuXescvmutAqEd7WzY5VB2FSBd
         JKf1bU4Erlmlx/BQ/ZDXIY6YIZxrKHT2LSSg1jmE1OQpBIXiC1JC7VJgXMQwBJNA5B9S
         pMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzHxFhcgWD/fZsCe3fmC7U0LkboW0qpnWF3suCBMKYk=;
        b=el54Mo1O8J6zVTJc8nHzavnG56s9JA1bVv2Z/YQVjqiUtnPpkf4TVaI6e8/ZRswuON
         U9VT/66nkIUsflPZjtiK3UYu9yDpwGnoyUC+TertsPcXMziPS3epDMjt81d2eWxOmY4F
         UnoAENQlYMpUVgp382RRQV9kqua1o74AyXwkh5h8rOiB3RqOdCVTAA6wXnmeCLaauwIC
         rMVGUk7wor1Nb2RPxodQtVNrLsFljZCGVuvFjhIogL6o/x5OCWvVSZNW9d/lgPw+dQ0x
         k9oj4Kfxk6751BdAkltWi3lgN6vL4K4FBR5oVUnMGqD7CYlyOAbGdWqiNIVd3s0cYBwZ
         1C7A==
X-Gm-Message-State: AGi0PuZxyXWmpr9UcxmxuLx3L+Cp8RICBY4bX1u85NaqL45BIzQRBFwV
        p/lNd+TSKSd11nYN4uBd30o=
X-Google-Smtp-Source: APiQypJOiKhEF7D0gxeLQ/r3Rd9nuz90wAPm/Ps9vRcN1st7U3WZUnpoxcnAew3oAkwi1D7S5rp4Dw==
X-Received: by 2002:ac2:58ee:: with SMTP id v14mr5017916lfo.25.1587229641823;
        Sat, 18 Apr 2020 10:07:21 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id e15sm8768909ljb.25.2020.04.18.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:07:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] drm/tegra: output: Support DRM bridges
Date:   Sat, 18 Apr 2020 20:07:01 +0300
Message-Id: <20200418170703.1583-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418170703.1583-1-digetx@gmail.com>
References: <20200418170703.1583-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Tegra device-trees will specify a video output graph which involves
a bridge. This patch adds initial support for the DRM bridges to the Tegra
DRM output.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/drm.h    |  2 ++
 drivers/gpu/drm/tegra/output.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 804869799305..cccd368b6752 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -12,6 +12,7 @@
 #include <linux/of_gpio.h>
 
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

