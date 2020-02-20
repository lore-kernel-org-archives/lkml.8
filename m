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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17749C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E222C2467D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2FtSKFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgBTIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:35:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46008 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:35:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1558506pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWD5EoDnyMEVvpGTdgYdYgLmYJyVRNy3T597G1z67yk=;
        b=u2FtSKFX4CacAKc8xWvJmhxD5qhhvbDyLNtsCKVsbW1YAKLuZBig5n/p3kq7e8EU11
         A2acQdgTcIYY9/kwND534EI9ZMMShoCdkmAQpIPWxLnz962zv2gfqDQq/4K6ylaR9Jbo
         SyrMJL+10pzYzYGLSs/1D1e0s6OEJazqdlzokcnEWs7xeO1Ss6ibEz9huIEXImHUxqtM
         Ej1JkK/PfA1iy+ho3uFebNt8Xh+0xOR8p/omxgOGvMiXm7Vj42KJnX4CsdB651XJjT1g
         /kyf+TQlbPI6znulHlYcWYzg6BnCPDZY0DiAujkZHHj8DM9QToA0H/ofmXjyMrjpL3DE
         sU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWD5EoDnyMEVvpGTdgYdYgLmYJyVRNy3T597G1z67yk=;
        b=BYyyH37JgRi8E3uoHHc4XSZWtsAMPlmn4pd16udcCYqYrbbNdGMrldVVvIPKSNGVaq
         8+h8Kca/wBTksvnOLfG3++Hyacg/bTduqiXRgWTsb82lIDzz4KAf4hDEiO/1gbApJPnK
         kZMoyEYygXsRYY5XdMtojTl4IB8Ejmho9TQ5jjJQLD6Wlr0k6CftYceBZzi+GTEcTEst
         wORw9P5adoj3Kjuoy5Q/dFKBB7M1+VxpR/SHoB8t8irpjZnBDT6MDRe2kK13Ybg0skak
         t66KA1Q+/pBMylYXJ0xvxNui4YEPvRz9Z1wS+1pFm/t2JpMpqt8VcIWPTt90MizYo67V
         8zpw==
X-Gm-Message-State: APjAAAWf6uYfD5oKGvgHmN8ctdqnaEoX5ldFrqCNsEXcGcvyvvMaf6oT
        uXm/kNrhbYa6tt76r3YiQmE=
X-Google-Smtp-Source: APXvYqzs7/Gqt1xQfGHj7U15rIDiPo8TglS71njYt+orbfTk1syKkenp7pbBfokhD2s4o1o8orXINg==
X-Received: by 2002:a63:2c50:: with SMTP id s77mr13673718pgs.182.1582187754273;
        Thu, 20 Feb 2020 00:35:54 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id l13sm2319038pjq.23.2020.02.20.00.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:35:53 -0800 (PST)
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
Subject: [PATCH 1/6] drm/bridge: anx6345: Fix getting anx6345 regulators
Date:   Thu, 20 Feb 2020 00:35:03 -0800
Message-Id: <20200220083508.792071-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220083508.792071-1-anarsoul@gmail.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

We don't need to pass '-supply' suffix to devm_get_regulator()

Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 56f55c53abfd..0d8d083b0207 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -712,14 +712,14 @@ static int anx6345_i2c_probe(struct i2c_client *client,
 		DRM_DEBUG("No panel found\n");
 
 	/* 1.2V digital core power regulator  */
-	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12-supply");
+	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
 	if (IS_ERR(anx6345->dvdd12)) {
 		DRM_ERROR("dvdd12-supply not found\n");
 		return PTR_ERR(anx6345->dvdd12);
 	}
 
 	/* 2.5V digital core power regulator  */
-	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25-supply");
+	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
 	if (IS_ERR(anx6345->dvdd25)) {
 		DRM_ERROR("dvdd25-supply not found\n");
 		return PTR_ERR(anx6345->dvdd25);
-- 
2.25.0

