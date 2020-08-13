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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FBA204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqNUb2U4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHMV4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHMV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:56:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEDDC061757;
        Thu, 13 Aug 2020 14:56:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 140so3815108lfi.5;
        Thu, 13 Aug 2020 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mD1tbRihw0/dSqZZEiPFcDugxOmEjVbt/2mN2YLwJu0=;
        b=gqNUb2U4Cjk6cKs9FX/HC8gOpEBKd0eI8FZomqWS834t6EEJJEqIGRo4mj7GtWHOxa
         J/XJq5dqiszoDLkonRZ2A/kjeSB5We/fz7uQX5oYcDWwvcPZJRFNqAAKY6WFyQHwUIMg
         C9u74Usn6XA1P5dRoBvMWAakW3XumhuDsvxFgYX0+8yBm75FVXjuCoXUOe0wSl42XVZy
         tzyMcWrkDssGLxvjr/g5WgtbnYl3ZbpeEx6AwwlIUpB01uEQMNlecodINpe1ftHg0bzL
         VHttyyYbglzaHyPWNPEui2RxLZZpRLrzf5C8Kl35yr5a/E9iSROnwprUbDmdqGtUCXD5
         h8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mD1tbRihw0/dSqZZEiPFcDugxOmEjVbt/2mN2YLwJu0=;
        b=OkeK3MaocDccUzuKa2b6AApDRHRePMt8yMj7CqJHz576RWbraz2erpHMKNEK9YXNBY
         M/9pf6PtmzcE1ragXPXulDFhiMkKRRdflPmvQR16zi22J+FECtwOa8xXjDURF4wkcXO1
         QydGqct9Xv3bzJw3MZc0lqW9k2Oy0s/i7wfymnfo2fwEZALXIxIc4uBdxLSZaQAgMiOe
         PBiKrBN4EFCakK1IkVU91KSaxgzQYmE3Vtgcw5nsTjZ3l1kw2Jv88dUZfbMYaBC3/i8t
         Zk6DM5Hj3TXbHqbbsG2JmyWu7L1NdHmb0WTmcs2lUsOeUYKypSl7BAnM0lCNE0AU0eWR
         3cWQ==
X-Gm-Message-State: AOAM532ocJW0nitgnv1noadFnhJKddDIRbb9fRu1LG/34RasFcFr5u/c
        PmeJqNJF6z4OQMNZiPvMWcA=
X-Google-Smtp-Source: ABdhPJxXJ9rih0Dt3yP8eoAOGHV6bcCBCyfCb2U266j6QPsBxHM2lQQLP+giJn7kGx36Kmk7Mtk3uw==
X-Received: by 2002:a19:830a:: with SMTP id f10mr3172796lfd.28.1597355792965;
        Thu, 13 Aug 2020 14:56:32 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1349977ljk.97.2020.08.13.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:56:32 -0700 (PDT)
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
Subject: [PATCH RESEND v12 3/4] drm/panel: lvds: Read panel orientation
Date:   Fri, 14 Aug 2020 00:56:08 +0300
Message-Id: <20200813215609.28643-4-digetx@gmail.com>
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
2.27.0

