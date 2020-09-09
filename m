Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD27C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248CF2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VwOSKziV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgIIQxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbgIIQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:04:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CAC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:04:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so2827520wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiyqCx4YnZ+Or6eOmMKNfQ0j9dSdplwdoBw+wNl6q58=;
        b=VwOSKziV6KxZBIx/wGbNdqd2Y86noYBluv4unymCGwu3te8jbuKa3ccpWYMnch++2a
         7z+xHoRGaFu8JgUBYDtf8zxYfS3iUNGtflX4ZqSZ7xTJGZbR+E8PjtrDZvfN/JL060fc
         mNaVnsam1wEaLDJyP/xodQ6M17rSwtotUeNLEjVZ6FL7ww+0ZolDJ3MrafIRHvZqUTue
         fKMsHIzQdcuASojK+c/frFsDrH2uyxSoQZtb7hmfbw+gKH+uQBVx6UZAlZwGUJtEtIen
         x0Gm785684liWBPGC3wrTWHJJYu1HTuEdpWXl3w5Z43oHdPMvCDyPMYA5pjhmy56RQ//
         FKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiyqCx4YnZ+Or6eOmMKNfQ0j9dSdplwdoBw+wNl6q58=;
        b=c0ym5E0Ycl833BrU/pf0y2IoLab8HK//SLqjpwO+hJo20Ymk9LRLiIAEKasY3QvXu5
         7lX/819rDV8+WfTsxTsi4L8+TpKdggZBs8x9k2EAJZbOYlZsB5IAE3kio9SODc0X8r7q
         B3AJLYFuIOn1N0+jEU2DUOprB3zwT79Eds94OEhd1poA7rOxYTdivf8jMew8LuJ/+WVK
         D7Gv2Ezc3im/S0xlCql2hqkDT5wwb7verQ6nUCz32rvp0a6G8bP83y0y1r+lJsDWO97p
         Jym/YAX7FsaNRbBkhzZUtLkoqTv4WwxnVtg3Y8b291Vr7B0lezoALMxOdHaeYbpF/QKi
         N2jg==
X-Gm-Message-State: AOAM533yeFgMs2V7nZD4NGkSN8/0bEr+nruiyyuTniG6/V3M5iFBHis3
        P1VU0DxhSggFSG0h7prtZsiazQ==
X-Google-Smtp-Source: ABdhPJxA0NvRTmioXzuZmiTka9YmzVYgx59EJqwb30lAKBiKzxc9Xiv5IR6ANym/gnZ6+pjLTpazaw==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr4148448wme.179.1599667457194;
        Wed, 09 Sep 2020 09:04:17 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id y6sm4850700wrn.41.2020.09.09.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:04:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, kishon@ti.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/5] phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode
Date:   Wed,  9 Sep 2020 18:04:05 +0200
Message-Id: <20200909160409.8678-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200909160409.8678-1-narmstrong@baylibre.com>
References: <20200909160409.8678-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep OTG ID detection even when in Host mode, the ID line of
the PHY (if the current phy is an OTG one) pull-up should be kept
enable in both modes.

This fixes OTG switch on GXL, GXM & AXG platforms, otherwise once switched
to Host, the ID detection doesn't work anymore to switch back to Device.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 43ec9bf24abf..6e862ea60d8f 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -158,7 +158,8 @@ static int phy_meson_gxl_usb2_set_mode(struct phy *phy,
 				   U2P_R0_DM_PULLDOWN);
 		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
 				   U2P_R0_DP_PULLDOWN);
-		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP, 0);
+		regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP,
+				   U2P_R0_ID_PULLUP);
 		break;
 
 	case PHY_MODE_USB_DEVICE:
-- 
2.22.0

