Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318E3C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC5C246B0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF9Ne9LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgB0SPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:15:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34007 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbgB0SO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:14:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so89981otl.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKHUWz0Uha+CDG15YVmtHwxSiy2XT+hJxNbxwEkR868=;
        b=uF9Ne9LOzTJajpv69uldX3AlwwCsOG21dTH6WDxjIygZq8IYdQaVrWnpoRAHUbl9pc
         2Wi8RK01BtA2wDp7AEz+f6DLqMim+kBabrziprkHt9My6ifj58ykYGyRyHk0f9es3E21
         g0u14rY2qTDrLve2najzfjzWsQnswHdAi8/0gGRta6WRcXc5z61ckYfEbRHgDfNA+rau
         5KZTIcCWvEgU0UV5SnrOTKQaCVJ55kx24ykG2YMVnJq/iCN8OfLz1tN4luydERR7G6vT
         wJ/b89Ko0vmX8rUk4Hdg6pvjREuHMOkTE94hzyi/KIvGBF2ITAjvStgSoZnt+yD130XP
         QgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKHUWz0Uha+CDG15YVmtHwxSiy2XT+hJxNbxwEkR868=;
        b=twm+wVGlpQdLneODF3cFC8+/xwr6NrCRu65db1E1Ad+EUzmstLY5wbba/ExUUVO7nd
         oSbyp6adhgRK29pVo1IZlPNArOhtjnZM5PL3GtUa7A84trMzmmlXhJ75CA5pYSVxtXMy
         Rh5HDe31ukNasvljrtuQ6CqRyvUiKrGY6WtqnKlx9jcViV8EtyGXb3hf1YyqRQ0NllHx
         MnMxFGqCo5ok/heRvkKEMMxlbg7hrACD4C2qI60/ncVN5yENnoWqCbWhua0MIt7kKk+U
         TNQo6gthF53sKn95Zgho70LSOgukD6XSOc2GY16GZxF+Bl+m9+DfdUM9wxkH5C41Fg1W
         YOmA==
X-Gm-Message-State: APjAAAXzF8UBdW2bWZFXWY7FYN+Xq1cRIVdN89wmVz1o0QYBP+Q2XhaM
        YOU6+byaP0wOh3RsJdwsom8=
X-Google-Smtp-Source: APXvYqwKPwyDY58hJwakzgtIbOYkNTqQx8h99is5DUCIYu4mGGT47ZNUD2O+KGlJWl3KeKXMNTBy8w==
X-Received: by 2002:a9d:7f98:: with SMTP id t24mr156313otp.338.1582827298541;
        Thu, 27 Feb 2020 10:14:58 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id t203sm2205534oig.39.2020.02.27.10.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:14:58 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] musb: sunxi: add support for the suniv MUSB controller
Date:   Thu, 27 Feb 2020 12:14:50 -0600
Message-Id: <20200227181452.31558-4-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227181452.31558-1-thirtythreeforty@gmail.com>
References: <20200227181452.31558-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv SoC has a MUSB controller like the one in A33, but with a SRAM
region to be claimed.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/usb/musb/sunxi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index f3f76f2ac63f..76806b781844 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -714,14 +714,17 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	INIT_WORK(&glue->work, sunxi_musb_work);
 	glue->host_nb.notifier_call = sunxi_musb_host_notifier;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb"))
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags);
+	}
 
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-musb"))
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 
 	if (of_device_is_compatible(np, "allwinner,sun8i-a33-musb") ||
-	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb")) {
+	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 		set_bit(SUNXI_MUSB_FL_NO_CONFIGDATA, &glue->flags);
 	}
@@ -814,6 +817,7 @@ static int sunxi_musb_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sunxi_musb_match[] = {
+	{ .compatible = "allwinner,suniv-f1c100s-musb", },
 	{ .compatible = "allwinner,sun4i-a10-musb", },
 	{ .compatible = "allwinner,sun6i-a31-musb", },
 	{ .compatible = "allwinner,sun8i-a33-musb", },
-- 
2.25.0

