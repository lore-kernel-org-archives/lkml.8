Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4BFC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986F020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nuTjaVVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBFTSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:18:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45368 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id a6so8534298wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfwwSgZBSRjQLTS6nz0OrfuIbfyqmaLe46Sq7iiWS8c=;
        b=nuTjaVVr5wcwTnZqfAsI/wPKCTvbOASiVjKWSq+spZCIb/y/vJbnCq+XxMnO94worw
         qTVv8ItgHInBYZxkuBb/xU0IMMKcCjbTWGgOGj6R2Swso7EiJ62AnQ8kd0txkrFL5Xza
         4lC4yHORnPNZAidzUdIjUxguEKhwQpHvzNqvL1EY5tZutgTyuQYoSWnRyK128d3SVFcN
         vGNAPcxUtj4bX4NPnB3omZAAd6OF3VAD2MhGdSSGRwU6Xdt9h8aCV4G8X8XcZKAKaBhG
         X2HyyUfCnjXm6cwzLGYZDjwDTmevBIGsDOHRckrHSdSYDuFdMIyeHYZ1kCzOnHPhgTCW
         giLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfwwSgZBSRjQLTS6nz0OrfuIbfyqmaLe46Sq7iiWS8c=;
        b=f39GPYgoEVGgVNIuHPmSDJ2hmVxwbq/Mfizzdj6ufMzaKP+uJ9euU7nv0m9A/Tsc90
         /s7D1CT/PMJG62n6J/Z5LBFDNsm86foPHFeV1sGfAOqfcUWTdkIPjIH0nZjEbeox+QBD
         1ko2UM998laNKXIIrPZsIVuuBVZdLAGRq5x9/06a0FKwtjfwUVoQbAmd3B8mek5EUv4e
         vu6t5M6zvv+CXU92LJDT08WaVLkgPGP94xMIS7hC1px8O84jjBdE07cjFH9khIp7qyjY
         q28lL1kVgDZXcgjar8397B7ktkf9iZbOf2pPFZNVlthMsd688+e5b4wbUlMr+lwhEDBM
         /0CA==
X-Gm-Message-State: APjAAAXChCNsxOuIVB1ABDUxz8p6y6AJL7TQJ1xszeRvJo53YbxdSjT4
        97PvdjV10Gw0UJ+cRrpJYHMSrw==
X-Google-Smtp-Source: APXvYqwVZMBEfqGjN2j0fB5MXvXxRI+9+Sp2L8ylMlDIx4Zc4gEKynwt2gn9sTqQNabIC4jgkHTQmw==
X-Received: by 2002:adf:e906:: with SMTP id f6mr5259501wrm.258.1581016720052;
        Thu, 06 Feb 2020 11:18:40 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:39 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 02/11] drm/bridge: dw-hdmi: add max bpc connector property
Date:   Thu,  6 Feb 2020 20:18:25 +0100
Message-Id: <20200206191834.6125-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200206191834.6125-1-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
MIME-Version: 1.0
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
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 9e0927d22db6..051001f77dd4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2406,6 +2406,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 				    DRM_MODE_CONNECTOR_HDMIA,
 				    hdmi->ddc);
 
+	drm_atomic_helper_connector_reset(connector);
+
+	drm_connector_attach_max_bpc_property(connector, 8, 16);
+
 	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
 		drm_object_attach_property(&connector->base,
 			connector->dev->mode_config.hdr_output_metadata_property, 0);
-- 
2.22.0

