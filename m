Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCDC3F2D9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D0A21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p5N/NFyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgCDKlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35891 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDKlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so1774059wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlZFtTmligcUGV2ilGv6/Rl0JPmMhZmteeBqaEsq6sg=;
        b=p5N/NFyAuT8ukGGq70FLD7EFyzryrkzlSFGA0gCXfZFxRI8hmOfyqv+c0JPYRinVno
         dz8FZYsj9MLsdY9duoUA8YcA57relbWXeZqDOfcpFC9E9WrKALLhb1YqtDVkAkOPm+HH
         b7F10S1+LdUuN/riOdvhrf24aTAN9k6pHqqx6LxNrIcARf3cBWWkXNbfHTfyE77gyMbS
         rDXZf5n2/1yHQydhOv/LdgTKcEXvCXAPMk6cPoCRKIqn008fhy+K9XjrWGHNEgFj2IVQ
         BzyiT+1yUoQMgUY/G5xZJZIBkoFRi3JrVlzV1vARxcxSjZh8DoP3aplkTIc1Iftgw7tu
         Lhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlZFtTmligcUGV2ilGv6/Rl0JPmMhZmteeBqaEsq6sg=;
        b=oqz5lr0k7Fdy6F3XNwDPuweeNw6Bkwqj96WN8j/Vz3aAg2o3Ph9RGrqGtjwL8E1HvQ
         6Jp0mzg9jCqlcUAGOYlW86mNOF0W/Nin/A/xkS3PlbELJTWS3UA4shWM+SI7lv96k7Fi
         E0kRGc8AuYBPc8lZVN3g6Bz7haryavie2PhPD95r8FPzb0SejQtmsemN33dMzIVU6qPG
         wUMhSoByXe22NAYqpA9iHjk8omS4lpk9wscwRvEaTwCFL/m4zu2teT0dKQ69gi9otCJe
         9ne2F6JrW2HeBxqvS6o04ZwrJcbRr+/PTg2J+bFIlTkxDguPgm5PIparpFhAL9wZfJbl
         5B3g==
X-Gm-Message-State: ANhLgQ1WMeBbBR0jgIG1hCjwTEgfq+wOZjJRcsl7d4ZzN7UWUpTA1DYh
        1+S3HgW6Q3u4RgOHY8pafDRLAQ==
X-Google-Smtp-Source: ADFU+vs3gnEE2UIP5b+mmLx2vKVo2Uouk57cGecRqzNjEhKymPdorJNJJ26O032WTJZcTMZagGHwXw==
X-Received: by 2002:adf:fa07:: with SMTP id m7mr3439222wrr.384.1583318459144;
        Wed, 04 Mar 2020 02:40:59 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:40:58 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de, heiko@sntech.de, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, boris.brezillon@collabora.com
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v5 01/11] drm/bridge: dw-hdmi: set mtmdsclock for deep color
Date:   Wed,  4 Mar 2020 11:40:42 +0100
Message-Id: <20200304104052.17196-2-narmstrong@baylibre.com>
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

Configure the correct mtmdsclock for deep colors to prepare support
for 10, 12 & 16bit output.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 9bad194cfd0a..10f98c9ee77e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1814,13 +1814,32 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
 	unsigned int vdisplay, hdisplay;
 
-	vmode->mtmdsclock = vmode->mpixelclock = mode->clock * 1000;
+	vmode->mpixelclock = mode->clock * 1000;
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
+	vmode->mtmdsclock = vmode->mpixelclock;
+
+	if (!hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format)) {
+		switch (hdmi_bus_fmt_color_depth(
+				hdmi->hdmi_data.enc_out_bus_format)) {
+		case 16:
+			vmode->mtmdsclock = vmode->mpixelclock * 2;
+			break;
+		case 12:
+			vmode->mtmdsclock = vmode->mpixelclock * 3 / 2;
+			break;
+		case 10:
+			vmode->mtmdsclock = vmode->mpixelclock * 5 / 4;
+			break;
+		}
+	}
+
 	if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
 		vmode->mtmdsclock /= 2;
 
+	dev_dbg(hdmi->dev, "final tmdsclock = %d\n", vmode->mtmdsclock);
+
 	/* Set up HDMI_FC_INVIDCONF */
 	inv_val = (hdmi->hdmi_data.hdcp_enable ||
 		   (dw_hdmi_support_scdc(hdmi) &&
-- 
2.22.0

