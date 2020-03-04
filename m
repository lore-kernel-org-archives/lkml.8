Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15CC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E835F2072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wg0RvIDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbgCDKlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42630 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgCDKlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id z11so1744326wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajIJB0wcFTIisjxYEYMgxm+dr9nVY4WUtZ38KJr42sk=;
        b=wg0RvIDCGd3OKaS+UQvVbeeMEYBWJF8GOY/PfMOKdQVJ+TjqChEm4pHTM69HwAbcCX
         Ex/7xSAM1S2h4CuGEj33aykuH0PKks9E44VM31QfhpCHDz63upJK9OFMlqxsgAtBq2Nz
         aN1DBI3qRWbUl0moYu2dCezZbRxsydcMItxVLT3946v2JgZpCBKkwEclmbG9OteF4vci
         32xslYPrUrGOKImGpSpFBKB4SuS0OGuno5LIq8urHrqEzvL5aNSSgbmYr1oUm1FP6/Ln
         y0yoUQauN9eyXCMnuoly6kqtiuuwxtgKyUKLEJcJn8Qw2Qn4nLN1ZflEdpIB3NwBwMOC
         lJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajIJB0wcFTIisjxYEYMgxm+dr9nVY4WUtZ38KJr42sk=;
        b=TIDZ2RWzkUf2lRE+bWVldcUU4zw9NwmCMeMnyWMWWwNOYXSnnMkL2F9CaHYILR2lZp
         jaim17ptrQIcKJ4+oLWlDHWen65r2nME9uj57P81LyjMVK/GmyJp6wuIrTwDvAW7FZQi
         N0Ar/54MdhnfnP8+cmOdgKFvCt/XvQ7etuVgVdC7HOFBDFgTeoMI640EcsJI8SOvXQRq
         rzBWS33Nsfs2HgmCOLg0zXuqUAd0ovG3bMd+YL1Its+4SWA9cWwvdKP6nrkZZJehUpUU
         hoGXrxkQmQPhfPZ/67XuwpVjNMCR4NOLnH5E6Jmm0+zUQOaTZ3OZ1jXrOM1uDgjmDYX+
         2Gww==
X-Gm-Message-State: ANhLgQ3jilSfU2WiG30zvMolIVH+9sf6VggJM4nVV9qlwNBrt1Bgj1HT
        +9IQMVP/vLGEOLT1i6hzGnNZDQ==
X-Google-Smtp-Source: ADFU+vsX44bMGYYDWTVYLN4XIHqigFLMlCLDbsBmS7tp2HMpAhPRQ9ZynsXeUOg29HcIDJKwo4OQ4w==
X-Received: by 2002:adf:9282:: with SMTP id 2mr3674245wrn.124.1583318460121;
        Wed, 04 Mar 2020 02:41:00 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:40:59 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de, heiko@sntech.de, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, boris.brezillon@collabora.com
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 02/11] drm/bridge: dw-hdmi: add max bpc connector property
Date:   Wed,  4 Mar 2020 11:40:43 +0100
Message-Id: <20200304104052.17196-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200304104052.17196-1-narmstrong@baylibre.com>
References: <20200304104052.17196-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Add the max_bpc property to the dw-hdmi connector to prepare support
for 10, 12 & 16bit output support.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 10f98c9ee77e..e097f60e6431 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2414,6 +2414,14 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge,
 				    DRM_MODE_CONNECTOR_HDMIA,
 				    hdmi->ddc);
 
+	/*
+	 * drm_connector_attach_max_bpc_property() requires the
+	 * connector to have a state.
+	 */
+	drm_atomic_helper_connector_reset(connector);
+
+	drm_connector_attach_max_bpc_property(connector, 8, 16);
+
 	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
 		drm_object_attach_property(&connector->base,
 			connector->dev->mode_config.hdr_output_metadata_property, 0);
-- 
2.22.0

