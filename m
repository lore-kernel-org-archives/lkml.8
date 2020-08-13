Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC42A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0O3VVSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgHMV4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHMV4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:56:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D3C061757;
        Thu, 13 Aug 2020 14:56:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b11so3812034lfe.10;
        Thu, 13 Aug 2020 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTkK39BlZkedB5Vph2dghueoQAO2WsRm0+GwhySEKyY=;
        b=l0O3VVSf0dYKebIDxndlR/t/F2RLrn/zKRoOGjnGLxMx8bnX2hwymf1eZQsqys6tsD
         AsqopKdS0kfkrtQsAu82vdMzBGR7Cv0BTspPLjqarhzMSjriKXQoCPn9Hojsj+ytQ3jR
         iyAadB948zlIFHN0on94OvcSNqH4IWuy/TTGVrSqFfpKiDgvaib5VeB6jlEpnBuKP9o/
         KnLLArRk61U3HdFvPqziKxw2auZnkr5X6uFnZ64CT6gIDUGmg/i6YePcFCKJm47YecUs
         d/d2pOtRMdxHjlnZ/39/byJJz8bpiOjzw+YNWkB9KO44utPF6KV1sr5UHMz9z9phIVuI
         wyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTkK39BlZkedB5Vph2dghueoQAO2WsRm0+GwhySEKyY=;
        b=GWFS0V83VaAKrAhW/ztTUL5x6u+b+ZNctBlWs+QV9+KEtwLgZgG/LoKIGnrZd4VotS
         6kKHXQxHz0NIbChW/jJYHk18B46+wEno8cZKnY0fGt5OGazQb9seFYwXBggMmDlM/909
         j8g1YL4hKopPygYDPxpEi4emlBkox0tiHJfKYOoTwEGjBPx7l7luoNgMkXwWT7yH5hGQ
         e9sXnHoQGDJQ3h+VBG2mf6g9B8tooFCFE4B6WaVXfssSAeLBZ/1cVCWnu10ymswUyKF4
         45mOEfLYxcspMN0eGIROnJm/Je0lkHaQSejbPIqFYyxQqcHFsLIXEUMjS31seXauLUql
         vCTA==
X-Gm-Message-State: AOAM5302cX1hqpdEnzNcgbIo8zg9geavmXYAK0xdH1leRIWjKmn4iyBO
        o07zkWSHae/Kq/MyFneMRd4=
X-Google-Smtp-Source: ABdhPJwpXkbGHsxGhgR7mAcufwuWAY7AnTmGU57eUQgfeST1zhEUCzFswSyjx17Cd53DZIZBQEiSTg==
X-Received: by 2002:a19:418a:: with SMTP id o132mr3214359lfa.63.1597355794110;
        Thu, 13 Aug 2020 14:56:34 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1349977ljk.97.2020.08.13.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:56:33 -0700 (PDT)
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
Subject: [PATCH RESEND v12 4/4] drm/panel-simple: Read panel orientation
Date:   Fri, 14 Aug 2020 00:56:09 +0300
Message-Id: <20200813215609.28643-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813215609.28643-1-digetx@gmail.com>
References: <20200813215609.28643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel orientation needs to parsed from a device-tree and assigned to
the panel's connector in order to make orientation property available to
userspace. That's what this patch does for the panel-simple driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cb6550d37e85..6e3e99a30d85 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -112,6 +112,8 @@ struct panel_simple {
 	struct gpio_desc *hpd_gpio;
 
 	struct drm_display_mode override_mode;
+
+	enum drm_panel_orientation orientation;
 };
 
 static inline struct panel_simple *to_panel_simple(struct drm_panel *panel)
@@ -371,6 +373,9 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	/* add hard-coded panel modes */
 	num += panel_simple_get_non_edid_modes(p, connector);
 
+	/* set up connector's "panel orientation" property */
+	drm_connector_set_panel_orientation(connector, p->orientation);
+
 	return num;
 }
 
@@ -530,6 +535,12 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 		return err;
 	}
 
+	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	if (err) {
+		dev_err(dev, "failed to parse rotation property: %d\n", err);
+		return err;
+	}
+
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
 		panel->ddc = of_find_i2c_adapter_by_node(ddc);
-- 
2.27.0

