Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C67C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0E524654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+fgwF/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBTIgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:36:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36716 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgBTIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:35:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so1280932plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYQONlA9lvcFld0G+NwhV5rBbyIu6fNUKkg/bhapB14=;
        b=N+fgwF/6e6JTKFlrJgQIRnbOLpsKCtZYnIYWWcKNnfKNY9CCUMr6V9Gw9TGF6pjJIB
         EHSAyjOJyfeCwqQkmI4hUnJOnoferabWuW52Jemsyz3ozxX45q3P64AnHJpigGKXMWzg
         wBZNL9EgTQWFnkbTSNbeoeGpldgIni5ogrZfMmarImqShr+dejWNmNW96uI2OQSM/DiG
         TbWyOd6OuhzcE+KwC0rYa/X8GMZFSoOWT0/63ZQIGG5D9x0EvG1IvBxr9J8jYpAcdO0a
         4Za6FD12Z2xqA0PCoc8lNH2bo+yCBkGwRyZmRXN6uApIHstunbaeA/WX/yObPRwoUFUG
         f+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYQONlA9lvcFld0G+NwhV5rBbyIu6fNUKkg/bhapB14=;
        b=jnFT6diFITU+b5gHGaIu7Dk2ppvu7UIeP3+k3evXq8Z3+iPTvqfvK6rq45a9G6u/0A
         8cQwc6PSofVkmz1uuwk6nlQyTm/a3tCRzGV/53n2ekEaMoVez7IJ1itrCAVh0pY9sk8j
         Q9r7msR0suJNt2NKwvwbxvJlfO4ZLjv7BQ2OwK83lLoomcTghaMyQBE6as3Im09dgcCS
         AaRPMeUqV2RA/bnXfNCT8fM/3HBnTaymiAKx8RDZlty+yrsR6BvS1FRBXtoY7BeKQHcT
         EvGAol7uWO1DdBCYBxNG6Y++AXP64JwkK2f5JIaHeQs+UHVk/nrUoL9lWVnasqeRplnv
         D7Dw==
X-Gm-Message-State: APjAAAVL3ixtTod76Pm7EmOlz1Nh23HUE7R5mb+sAshFTbVg2jKpcfDi
        5Noz5/lQ7WsJlxaCqEUF1NI=
X-Google-Smtp-Source: APXvYqwAMzlg3ox1kckOd8OArhVChc+fFh1B8FYzsDIg77886p2/0Fs+/up3ECkbKsMtzNNlm8jUUQ==
X-Received: by 2002:a17:90a:c216:: with SMTP id e22mr2300961pjt.134.1582187755353;
        Thu, 20 Feb 2020 00:35:55 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id l13sm2319038pjq.23.2020.02.20.00.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:35:54 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/6] drm/bridge: anx6345: Clean up error handling in probe()
Date:   Thu, 20 Feb 2020 00:35:04 -0800
Message-Id: <20200220083508.792071-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220083508.792071-1-anarsoul@gmail.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regulator_get() returns either a dummy regulator or -EPROBE_DEFER,
we don't need to print scary message in either case.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 0d8d083b0207..0204bbe4f0a0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -713,17 +713,13 @@ static int anx6345_i2c_probe(struct i2c_client *client,
 
 	/* 1.2V digital core power regulator  */
 	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
-	if (IS_ERR(anx6345->dvdd12)) {
-		DRM_ERROR("dvdd12-supply not found\n");
+	if (IS_ERR(anx6345->dvdd12))
 		return PTR_ERR(anx6345->dvdd12);
-	}
 
 	/* 2.5V digital core power regulator  */
 	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
-	if (IS_ERR(anx6345->dvdd25)) {
-		DRM_ERROR("dvdd25-supply not found\n");
+	if (IS_ERR(anx6345->dvdd25))
 		return PTR_ERR(anx6345->dvdd25);
-	}
 
 	/* GPIO for chip reset */
 	anx6345->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
-- 
2.25.0

