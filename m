Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB7C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE7521741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rci9PqEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBFTSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:18:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40818 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgBFTSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so8560397wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mFlT0Omv41nAtEpTgYWO4Xf2iU3uM7fX834ml+D12E=;
        b=rci9PqEx4hby5MvW1khg7iEKwuy1bfbD4iaH4uETQBur1Za15XCzVjeFY1VfdBhtw4
         Sgm+lIqBzDWUcXws81WyInQc4DgofK0ajNixco/KiwkevvAVCOdtY5ZeQ6xfN/Ef6rVb
         GayBIdYOso2YrWls5jJXiF/U+8TKQSpE/sJZNy5HxzOqmim+LVfpuTuYr/kwh/7kYfdW
         Y3awX+mVUGcHmrjyQdCGHxtp6dtxRCX/efFt9Twi9ODg1shreYkTyHnQOaQ/ER9EN8Ut
         ptxJLeh9r0Gvc7WMEkLdB6fdxT1wUa0xnxOwgm+0Q4KtNxTa3y6OHyult0N4gOrTG7WX
         OpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mFlT0Omv41nAtEpTgYWO4Xf2iU3uM7fX834ml+D12E=;
        b=UiZrDc2onvn6RXZbJVDO83HGGrkaJUUqL/1laiN0j5ZKpEah0tJJvyPqCZLq1m7O+l
         yPaN3qQf6G3DySdf4SrOyT9Zc/BRa9+oCALLLx6JA36IiAVr+130J2ACiEMmq2M6iz6d
         nmZSqmYcXgmEimIdERTQmvgG2i6EEFyhdEpG8zx/81rn/uzkNx0TR+VcPSWtLrvuFy+B
         zd4Py4JvzWWIgeGgheCPndqfLnLizHPzHJdxK3DQwOFggcqANulvmxV1vcVvFDruw/3Q
         vtdPl5At8OWVyGa2lRt8za4+gymCyTP7Av/qlhQ7RQoCMmOwI/yyXGhDk/TXVZ3KGZlS
         hH3A==
X-Gm-Message-State: APjAAAUTLc6IyHpIkJXVY4AiYNHgt6YtWOU/ctEeWxLRoIUuIMp1DBrc
        lSOicYkf5+zaOCwzG8smjarbRQ==
X-Google-Smtp-Source: APXvYqyowlhqCLlPiC8LwlQGO8ZeahyUMuyPS6kHuCVL6/61Z4rWlDzBpMhGfN5LPnPhHBF2WM35Pw==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr5375779wrh.121.1581016718863;
        Thu, 06 Feb 2020 11:18:38 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:38 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 01/11] drm/bridge: dw-hdmi: set mtmdsclock for deep color
Date:   Thu,  6 Feb 2020 20:18:24 +0100
Message-Id: <20200206191834.6125-2-narmstrong@baylibre.com>
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

Configure the correct mtmdsclock for deep colors to prepare support
for 10, 12 & 16bit output.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 67fca439bbfb..9e0927d22db6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1818,9 +1818,26 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
+	if (!hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format)) {
+		switch (hdmi_bus_fmt_color_depth(
+				hdmi->hdmi_data.enc_out_bus_format)) {
+		case 16:
+			vmode->mtmdsclock = (u64)vmode->mpixelclock * 2;
+			break;
+		case 12:
+			vmode->mtmdsclock = (u64)vmode->mpixelclock * 3 / 2;
+			break;
+		case 10:
+			vmode->mtmdsclock = (u64)vmode->mpixelclock * 5 / 4;
+			break;
+		}
+	}
+
 	if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
 		vmode->mtmdsclock /= 2;
 
+	dev_dbg(hdmi->dev, "final tmdsclk = %d\n", vmode->mtmdsclock);
+
 	/* Set up HDMI_FC_INVIDCONF */
 	inv_val = (hdmi->hdmi_data.hdcp_enable ||
 		   (dw_hdmi_support_scdc(hdmi) &&
-- 
2.22.0

