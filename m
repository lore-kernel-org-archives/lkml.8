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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB718C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B812A2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDyw/Z0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFNTEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgFNTEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:04:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D4AC08C5C2;
        Sun, 14 Jun 2020 12:04:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id o4so594707lfi.7;
        Sun, 14 Jun 2020 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofH5y+DsAUKO47Nkj6CHgyEmv07V+x06WqiTKtmxkz8=;
        b=tDyw/Z0NbyseYNFw0tmkDEmK0+rdlxT3B6Rx0ogIl0xtyfgXfz6h1CglbOficaxF7j
         opyTD6xXyzEhidGf0dAsVGJxGEJLW+5tIFSWwFwYrEUtVp4RkJQwNVuVPpfTsfi/xGRg
         lUvTrWWu5SISnnOknRogcrt75rMJBefk8sfOvpjnv1LtW5WIFo4NOx7jmgZESMgNxw0m
         NRa2NWMragB95iD4zcf3Z2hYf4HA+Tph53CfFfyTJPB0ELrZ8dR4ekL6nrFaB6DJ0fd1
         0HwkduwlYNPJdXHLlJHsa+VPG52wtU8H9fgC4wvWWAQQKdVLbiS8fWkw//BeawlVZBdF
         OZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofH5y+DsAUKO47Nkj6CHgyEmv07V+x06WqiTKtmxkz8=;
        b=Sfbj5AmgUsM8lhkPu/GXSR1yDM3OUu1iy7kCTnn4JIavHvXxHKpzmsZNk8xuz7Ux98
         y62cvC0yOkB+1CE5YJ6DhOh+WosDUZ+znEe0UTd+VENpcUhY7CqWNac9yJkrMpCUzIuF
         Owbpcm60OX7snfg9L0GFrPCi9mCcIqqwMVzfdekC53Zwee848OL4iJiPgViYiV0+t27V
         uu7RrFuOaTNN/7vTLp8bbcA0clbuT4TQ5+CymWvFNJnRim+akuaGaG1yg+KnZzD5dy4j
         xEAZGD2djGE7v1wVOgb5WBT1ObINxz+bE6vTn1sTQedFxIJCygJf6I5IM5z2HLFoncHI
         qUYg==
X-Gm-Message-State: AOAM5300aZrTLhRv7Bb8htUUhGTucdmbHRRFtvrqzQWEQ4aUS+HXCReX
        1+XWcLQb9ppZlooIg4nvcpg=
X-Google-Smtp-Source: ABdhPJwnG7yAfF3RYIYSWw/kDrX3Tt8hscqrxTuGTxm3j3w/fphxrbebeuo7y9inPvrpN1G6fHc9Ew==
X-Received: by 2002:a19:7612:: with SMTP id c18mr11900032lff.7.1592161446900;
        Sun, 14 Jun 2020 12:04:06 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id p15sm3410856ljn.53.2020.06.14.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 12:04:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] drm/panel: lvds: Set up panel orientation
Date:   Sun, 14 Jun 2020 22:03:45 +0300
Message-Id: <20200614190348.12193-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614190348.12193-1-digetx@gmail.com>
References: <20200614190348.12193-1-digetx@gmail.com>
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
 drivers/gpu/drm/panel/panel-lvds.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 5ce3f4a2b7a1..9421246ac80f 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -99,6 +99,7 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = lvds->data_mirror
 					  ? DRM_BUS_FLAG_DATA_LSB_TO_MSB
 					  : DRM_BUS_FLAG_DATA_MSB_TO_LSB;
+	drm_connector_set_panel_orientation(connector, lvds->panel.orientation);
 
 	return 1;
 }
@@ -223,6 +224,11 @@ static int panel_lvds_probe(struct platform_device *pdev)
 	drm_panel_init(&lvds->panel, lvds->dev, &panel_lvds_funcs,
 		       DRM_MODE_CONNECTOR_LVDS);
 
+	ret = of_drm_get_panel_orientation(lvds->dev->of_node,
+					   &lvds->panel.orientation);
+	if (ret)
+		return ret;
+
 	ret = drm_panel_of_backlight(&lvds->panel);
 	if (ret)
 		return ret;
-- 
2.26.0

