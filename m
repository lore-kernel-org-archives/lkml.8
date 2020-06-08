Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87243C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C90206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W4Z+8xah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgFHRs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbgFHRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:48:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566AC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 10:48:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bg4so6947514plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYz+Xl/FEuDPplFOt9XJcftofUYzSfEPkgENfM7upRY=;
        b=W4Z+8xahUegQR5m34xKJyXKb95xGcM4nDB/HcR8qyKD7HD1yTyy8nTggMScCzWXhRR
         yNF5f0v2m1kwdsvoEs29JXCFlfzARbkRKV2BXVLgFlbq66XhIcfokxUz9LFPg2S+ocH7
         m2bSZxdNaIP6rF27XkOKysscJo47pXXpMITQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYz+Xl/FEuDPplFOt9XJcftofUYzSfEPkgENfM7upRY=;
        b=V+c8h2CGz6GZaLhXfRbg8XGV/4SLXFa13aZEyw2t0TW4F33oWx3vosEWPgW+YQYQjR
         sjD+PQR71MWCtChCfxgzLrSiYRkU0rmnpxP6SKr5nhThWG+m87PIH+oq68tlAtoONS2x
         TLr1mDBkHwKUkJvyiyKgFcKV/nWrhKxUWmH3ZVADfPN1T3HdCSEu7DDDQRWDLxDZ2oyB
         R3atAY4970mL8YNP+TnBiCDOceQm/P16YsApSJOkGc1O08Ui+uEf/NWBpXvDIXpij20b
         m7NXo6Hrhdj3nYo7go3G62NVTUyK1rbVMZqrQMactJJxNhv6c9O74RaPZwANSIwCddJF
         DWFg==
X-Gm-Message-State: AOAM531lbCo+rmihrfV8cbkBI9iNPPYW+nATgWic9kULWEWV3II/NP/y
        BRyUjMDlhjOVgo5tLU8JqcRrxw==
X-Google-Smtp-Source: ABdhPJzUQ/95idKfShP8Nh5BuMq/OjblF/QTB/uWi6Bvcc8cxblw6O5yxEJRwy2WRXEJxwvbl9d5jw==
X-Received: by 2002:a17:902:c40c:: with SMTP id k12mr22052765plk.105.1591638536526;
        Mon, 08 Jun 2020 10:48:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n7sm162682pjq.22.2020.06.08.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:48:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com, sam@ravnborg.org
Cc:     robdclark@chromium.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, spanda@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Don't compile GPIO bits if not CONFIG_OF_GPIO
Date:   Mon,  8 Jun 2020 10:48:32 -0700
Message-Id: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot noted that if "OF" is defined (which is needed
to select DRM_TI_SN65DSI86 at all) but not OF_GPIO that we'd get
compile failures because some of the members that we access in "struct
gpio_chip" are only defined "#if defined(CONFIG_OF_GPIO)".

All the GPIO bits in the driver are all nicely separated out.  We'll
guard them with the same "#if defined" that the header has and add a
little stub function if OF_GPIO is not defined.

Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 2240e9973178..6fa7e10b31af 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -151,8 +151,10 @@ struct ti_sn_bridge {
 	u8				ln_assign;
 	u8				ln_polrs;
 
+#if defined(CONFIG_OF_GPIO)
 	struct gpio_chip		gchip;
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
+#endif
 };
 
 static const struct regmap_range ti_sn_bridge_volatile_ranges[] = {
@@ -925,6 +927,8 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn_bridge *pdata)
 	return 0;
 }
 
+#if defined(CONFIG_OF_GPIO)
+
 static int tn_sn_bridge_of_xlate(struct gpio_chip *chip,
 				 const struct of_phandle_args *gpiospec,
 				 u32 *flags)
@@ -1092,6 +1096,15 @@ static int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
 	return ret;
 }
 
+#else
+
+static inline int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
+{
+	return 0;
+}
+
+#endif
+
 static void ti_sn_bridge_parse_lanes(struct ti_sn_bridge *pdata,
 				     struct device_node *np)
 {
-- 
2.27.0.278.ge193c7cf3a9-goog

