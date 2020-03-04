Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99884C3F2E0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCDC21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mx3iwudl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbgCDKlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41786 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbgCDKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id v4so1751112wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBV+Mcykh4jSy5LpMQRzAqt2z+ZaR095g4MjbXShAoU=;
        b=mx3iwudlVrvCSNzwqeOyAiR9iitVlgrIa99spLuUe7EBWEDzGsbfPJwUu/KChoErXv
         h+x7mYH4pOYQK/gcuqO2/KiRhpkfhw4SqJ+ijRydXIHTihh3jCfnuwVFvE7/bBsRpjSo
         YBHe8jApAPWuwbuR3E6ulkOBVLLeYNlIb8z2sfscv+9NWVBDWb1jw1FEGVbfaZdb3S2G
         SqE3edSCmjs3PY4oDy47OO6WbgnP7lbPYdcRzSmj6RbirUvScmGhMBpnIZh++HUN1Igk
         AQmQx91AAzSSK13TZy1OAfbzdS5FaHA0ymybCPHhkIPN9URKH7R/mvUd1wqOfe8t2Fs2
         GFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBV+Mcykh4jSy5LpMQRzAqt2z+ZaR095g4MjbXShAoU=;
        b=aIAvAM3L6eYIT3x1XoyKGc3v01RiDA5dFDoBLP9WD9hjApH1+sU7CLTD5wxf/9ZJhe
         i8vHfMeLR4pzcOVKPVkkz+/gkcUxKAbWNOGHp2goLiD+NiMiXr0qnWf29a7ZlDJydXyw
         3By+5xZ9tW5Vb8trs/QriW/ygcU8MWo2pJRGtEBUvejCMsoTQgtU4S5U1z0ppYbeUlZI
         JLJsO0itTAKxADA1F7ullo1qesZnRfqEJPbd3kouSLkZ8Cz0iEK/1bCBnPg3wJ3//dUe
         PXZ3XeQCo8YkDRq5nV+UyXS+tqz1NSfoZGA+lXLBwZXtlLW7wg1T0hyHtpwJPwV9U9v5
         vz6g==
X-Gm-Message-State: ANhLgQ29GWr3rVnFMh0hpdTInSDkBce6pJbLjuJirI09LiHJ+x4YvnFE
        iaKnARBF60BDzbw24ryRDO3eKGCFd4ReOw==
X-Google-Smtp-Source: ADFU+vsAiBhy5hUXNqkS6IUhDPu3/5igsqNw0fPqWtjcAmSwSaZaQwxoNYwzPB6lgmNIuSlWEmlnGA==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr3643854wrn.128.1583318464154;
        Wed, 04 Mar 2020 02:41:04 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:03 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de, heiko@sntech.de, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 05/11] drm/bridge: synopsys: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Wed,  4 Mar 2020 11:40:46 +0100
Message-Id: <20200304104052.17196-6-narmstrong@baylibre.com>
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

Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
for these modes in the connector if the platform supports them.
We limit these modes to DW-HDMI IP version >= 0x200a which
are designed to support HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index de19e8993e1d..f85c15ad8486 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3252,6 +3252,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
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

