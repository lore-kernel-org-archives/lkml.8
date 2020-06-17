Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90BB20884
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWp4V8jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgFQXUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFQXUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:20:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D1C061755;
        Wed, 17 Jun 2020 16:20:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i3so4994486ljg.3;
        Wed, 17 Jun 2020 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpCBAuxLIibpWTrEfnZ4pOnO24Bo4VASqlc3TYxbEqA=;
        b=YWp4V8jl4qNCfkH09ImPEg/X26d+XB7NXB0OmvxCehmOoqyI+rVejTY8WifV7InUUq
         QkgGFYEemD4osjkVU1bByc0u2A+3nUiZzY0JNph9iVtYoY92hpcAPVVJpVGXckxJ5oPa
         1W9A4T6fctWq1rjEuBd53ew0n9zGPf2uWnkIvRWu1SWd7+Afck1GfhPsJJCXLqDL9Pqs
         m+DJ1EqPiZvF8bD7mvze+DNK9Kgi4kUfzCYY7YQ10cIAbie5wFyzDd/ptBRaXpXcVgxU
         uLEIU7TqsCNKYdLJapIfLKge5eh3KX80nQ5oJ/Jen/YM0INukDi8k9KV7F+R3AtVHcqS
         glzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpCBAuxLIibpWTrEfnZ4pOnO24Bo4VASqlc3TYxbEqA=;
        b=aSG+STANQjl5XvIwMQomxkm727JgJE67Osjp833jx9H4+gII3iKPvWulTX1HiKZqwz
         PMZqqspH3iayxispqcIPIZ34SahdWqtA3MUdQJDn9VJsKAYIwun0K0Me/pfUK1/CMNLq
         OEySB2mtyhCaavU2CYkfO/ziykX/tSQbsqxp6wR72Vwv7v6R5BNWJv7A724jDsWVKqlC
         f+P9Pl9m1PVDejAtTBKNzzTFjMGp5p+/IqcujR0XIlE36o+K0IPiDPDKcM5Fgl2msk2E
         Bdec1jXRJTyXB4vheBK7ZyhddccWVJo9Z62PB9yDPt2XaXsbkW9JBIojJAfu1qY9EvlL
         xOyA==
X-Gm-Message-State: AOAM532MxxKQw17KyJZTXtBFaQcyM3icGmQenuGvBFV7qtTzG1UwhRBX
        GUUjpwzlMjloJqitsIaSgBo=
X-Google-Smtp-Source: ABdhPJw86GF1deCwvykUE9oiRjzFg8hcTUyO2I001jtlm7SREpb4mqoGvWD8uzGQ/IAZGl+tkwwkFg==
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr830817ljc.272.1592436017044;
        Wed, 17 Jun 2020 16:20:17 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id x3sm235100ljc.82.2020.06.17.16.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:20:16 -0700 (PDT)
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
Subject: [PATCH v11 3/4] drm/panel: lvds: Read panel orientation
Date:   Thu, 18 Jun 2020 02:18:41 +0300
Message-Id: <20200617231842.30671-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617231842.30671-1-digetx@gmail.com>
References: <20200617231842.30671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel orientation needs to parsed from a device-tree and assigned to
the panel's connector in order to make orientation property available to
userspace. That's what this patch does for the generic LVDS panel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-lvds.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 5ce3f4a2b7a1..f62227059090 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -37,6 +37,8 @@ struct panel_lvds {
 
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *reset_gpio;
+
+	enum drm_panel_orientation orientation;
 };
 
 static inline struct panel_lvds *to_panel_lvds(struct drm_panel *panel)
@@ -99,6 +101,7 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = lvds->data_mirror
 					  ? DRM_BUS_FLAG_DATA_LSB_TO_MSB
 					  : DRM_BUS_FLAG_DATA_MSB_TO_LSB;
+	drm_connector_set_panel_orientation(connector, lvds->orientation);
 
 	return 1;
 }
@@ -116,6 +119,13 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	const char *mapping;
 	int ret;
 
+	ret = of_drm_get_panel_orientation(np, &lvds->orientation);
+	if (ret < 0) {
+		dev_err(lvds->dev, "%pOF: problems parsing rotation (%d)\n",
+			np, ret);
+		return ret;
+	}
+
 	ret = of_get_display_timing(np, "panel-timing", &timing);
 	if (ret < 0) {
 		dev_err(lvds->dev, "%pOF: problems parsing panel-timing (%d)\n",
-- 
2.26.0

