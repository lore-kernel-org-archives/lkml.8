Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7E6C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F0521927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ha2GwyAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBFTTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:19:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36306 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgBFTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so8601448wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkuWKP+kehiiAt4mXS862G4zA31oHWX/RYq3ofBu8tk=;
        b=ha2GwyAkKH+wQTq5xCi9nQNnmfGBBVIce9Y5Sg12TGCZrAzeP+RGf65fuetUKjjMUJ
         2Fg+RguaV/wmAUU1N6DHR5r+++SACqqlDMoLAE8U9fL5nWfYQWo25ZdJyBHqD2itLHi3
         ObuvjedL3QFRydd28qghCwSDyR5QN9Lx5ciWCUwqhht9quMK1VCGSdmoXikjZysE2PCL
         OTticgeSt5OfFjuEsgfGW3ZXyKZT4Zz/wH7Loq13OyICgYHKx7XB5ng1xghlx21xXb+g
         8zel5aicZvw0VfH2W7bbfrV5O1VVnPaJGu9BjqULuDEGqJShtxMfcbmp5M4DgmlR3n+M
         ExRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkuWKP+kehiiAt4mXS862G4zA31oHWX/RYq3ofBu8tk=;
        b=D0gohcBukKSVWQFLOqZAmNkj7saYHf6cZc0wmFXPaNhUgd9YgYfSCK+ffNJpQaArPS
         EQi7rCf46qkY60sQ7r81jYoED7zWhiWfsfOJMtjFVlmsxAfZfBrzgbaosKsfE7epTmaq
         NzBVLXBW5xFPXW/RVJlyqAWK+zUfRNkIMKQXaMjWDcHQt+uYXmuAEuvaRLojdLIbZ3MO
         tb1rMxZHK5TLt+SCHV57Q5+3vljYeXRloUc147xkte837qubJ6N6SCWSVgUMtTLf5Aa4
         uIm/PNV1G0BiQp/FX17n69IP+4aU19NqD280cDUSfJpbKX7+DghLzOuNjGkpr24taD6A
         j/Sw==
X-Gm-Message-State: APjAAAWIHYGafSmeut2E6WOIe8v5Rb7GYSzUz0GgIYdeJunau5HCXWoS
        gTVdLPiDiwJBPQWV4iLIHuxzFQ==
X-Google-Smtp-Source: APXvYqzEj013w06qtPlR99peGGjw52cz7evogyeuvqZ4vvfjeTP98U7JJ7Cs6Dto9PL2/CzyoLFsww==
X-Received: by 2002:adf:a285:: with SMTP id s5mr5600926wra.118.1581016727891;
        Thu, 06 Feb 2020 11:18:47 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:47 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] drm/meson: dw-hdmi: stop enforcing input_bus_format
Date:   Thu,  6 Feb 2020 20:18:31 +0100
Message-Id: <20200206191834.6125-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200206191834.6125-1-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow using formats from negotiation, stop enforcing input_bus_format
in the private dw-plat-data struct.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 4b3809626f7e..686c47106a18 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -1035,7 +1035,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->phy_ops = &meson_dw_hdmi_phy_ops;
 	dw_plat_data->phy_name = "meson_dw_hdmi_phy";
 	dw_plat_data->phy_data = meson_dw_hdmi;
-	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
 
 	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-- 
2.22.0

