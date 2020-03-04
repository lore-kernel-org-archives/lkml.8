Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA192C3F2E6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8474A21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QstsY6nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbgCDKlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42649 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387897AbgCDKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id z11so1744835wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZYaVAxRnaObr28BZLmmHgNx+5g0OhRS2ehQYDVzjXU=;
        b=QstsY6ncnufuZrETjDUNyPb+E0wCE7nPglDBEz1h4hDqKKBYSN0Omz187XucsKMQbL
         01m4i6n+B0zVhRg1d37E89qC92HcBhsaTLziRCSe7L2gQb1we30DBKZ9+cHKN3iM7dxp
         kIgDy/FF4fM5cUfwfmkY94oFmnXIKaSH05RZqXeDutS5aFdqasW7OxamJe3Drnuuwe4f
         /enVSrulADQSWwGzJwkZdkxx7/B8GdPAZhIccEbKlxjTPd3EPrhan1WZmg06ZZ3RImXj
         IEIU6twNIO48k2iKCVUt+4J61AbHYJmlaEqeBcmb4jnr9yzYZInJ5uLzOgPyIHGw3haG
         M9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZYaVAxRnaObr28BZLmmHgNx+5g0OhRS2ehQYDVzjXU=;
        b=EoUEK+EF5qcvAuoLb2XvecqWifrt13tgUxwXmWjkd992M18YKquxzfxFjYsI/n4TD8
         YcVlorquxNUixoBPxhVfKWNR8/+Ee+Azrgkq6VpVzqjkiQxomIsAOpaAlWNlqe300YZh
         RKE67doUTLaUnY2ahpoDDyAXWE9SRKhgGZKmDj35flUoWnk1Fz6HUCGK1zr0kgWcH16T
         jdnkXIV4zimkBYpjXnci5gDhGHVx64e8e+L6PaK4p/ACRtMwFhBa5/IncpOUPgdGkf9G
         6kTBvDltWTRsGPSsWmPgy1HEL6b3nJT2tjrBq/yq1Ti+ckzClptnD95L9g+lwcDZp29r
         B6Mg==
X-Gm-Message-State: ANhLgQ0y25n0c5MmXtAd8L8jlBaPOF8eeCRxN7gC03BEKLcC1X258aVV
        INaJK13tAxPLLwYjPYnBGKF7sg==
X-Google-Smtp-Source: ADFU+vtUN4p11cLYhabM5zjrKYxA3Sbq1hcwONdJ7Xn7ZgQfAJmrBHXJV1buXqvWexI/+vikKZuKOw==
X-Received: by 2002:a05:6000:12cc:: with SMTP id l12mr3490390wrx.304.1583318467351;
        Wed, 04 Mar 2020 02:41:07 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:06 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/11] drm/meson: dw-hdmi: stop enforcing input_bus_format
Date:   Wed,  4 Mar 2020 11:40:49 +0100
Message-Id: <20200304104052.17196-9-narmstrong@baylibre.com>
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

To allow using formats from negotiation, stop enforcing input_bus_format
in the private dw-plat-data struct.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 8f51d032262c..72c118142eaf 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -1014,7 +1014,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->phy_ops = &meson_dw_hdmi_phy_ops;
 	dw_plat_data->phy_name = "meson_dw_hdmi_phy";
 	dw_plat_data->phy_data = meson_dw_hdmi;
-	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
 	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-- 
2.22.0

