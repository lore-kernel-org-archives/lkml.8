Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA71C352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B8D21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ewZ0X+0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBFTSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:18:50 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42264 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgBFTSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:46 -0500
Received: by mail-wr1-f47.google.com with SMTP id k11so8548812wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3qTczoW82L1nczYwcOGhiZ1KM1HmNc7LgyXt8NRxHA=;
        b=ewZ0X+0oLLxN96enhnKX1bzkTGICZq+WMiKedc8D88EQ5Cg8fGH+rFRiPsbyciYrSi
         4L5lbf9D/AnFkiCqqms7LGApV0le6xaa5D9nc/FWyV4Nrscl+iIUNJLY6tvD/DRLlN5H
         /mhXhtuMBGpJVJQsALFqJKMvNqvOZwUP2C3OwUPtheMnLsM0ggfKz+t44ilu7Xv+DbbB
         IEnLyg5bT36ZqcJ04Nnd3L7wLM90k3rqndg3wIP9psa57RcVJaj9WzLXOPq/sCtK3FGc
         2agblq0bI8LHvcfnz0aHOGpjEqg8FleqC8scoDhHsKNbuOzo/VV4bH9syqSfSsaju+y+
         uvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3qTczoW82L1nczYwcOGhiZ1KM1HmNc7LgyXt8NRxHA=;
        b=Z5+XD17Sao+yeLX3fYCKF+/pnvNzfGciVs/qav6soBpPLHMRCwBtW1Qf4nwpc/244A
         ZPYa9Q3l/OlXLD0JAyfn0vfLtIp2ec8BShJaXRGnWQPwmOTbPlj7mqil9Gyhc3QqwYup
         fgT8IAeyRlI+hfvpqovcBspsJ40C08M1i0IBnmrJ3WMfoSr84jXqYuyz/pqg/jh7xnu7
         LRMFiBXGn0+bcd2TyWgxCaUFxrRgk1nx4XSg352oMpasoOE4OAh6EXaA05v6imTk5g8J
         y0hr1fmbffDQMkYtI5rm0tnoU0mMkIp8b0o1PPWbsLkwqatUwUvOEhT7MyNTnN/4zxy7
         2BmA==
X-Gm-Message-State: APjAAAUzqsnr9HEA3LbcyVCbxYl1y7QzlMGXS+wom4bMnFw4X/UBXaNl
        UAS0IyIfcebo3UKqPIvH5WbSug==
X-Google-Smtp-Source: APXvYqwIOTKJnzwY5IhgDVKhEwIYcVqUnwAuTSERF3IoD/aDj3BwVe9eZ9tmY2zQ2QKNOq15gkDtZQ==
X-Received: by 2002:adf:a453:: with SMTP id e19mr5132981wra.305.1581016724045;
        Thu, 06 Feb 2020 11:18:44 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:43 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] drm/bridge: synopsys: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Thu,  6 Feb 2020 20:18:28 +0100
Message-Id: <20200206191834.6125-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200206191834.6125-1-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
for these modes in the connector if the platform supports them.
We limit these modes to DW-HDMI IP version >= 0x200a which
are designed to support HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 15048ad694bc..4b35ea1427df 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3231,6 +3231,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.of_node = pdev->dev.of_node;
 #endif
 
+	if (hdmi->version >= 0x200a)
+		hdmi->connector.ycbcr_420_allowed =
+			hdmi->plat_data->ycbcr_420_allowed;
+	else
+		hdmi->connector.ycbcr_420_allowed = false;
+
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
 	pdevinfo.id = PLATFORM_DEVID_AUTO;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 9d4d5cc47969..0b34a12c4a1c 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -129,6 +129,7 @@ struct dw_hdmi_plat_data {
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
 	bool use_drm_infoframe;
+	bool ycbcr_420_allowed;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.22.0

