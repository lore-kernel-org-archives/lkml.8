Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48231C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2058424653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgRS/obe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBZIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:10:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36187 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgBZIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so1064769pfv.3;
        Wed, 26 Feb 2020 00:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4KM0r5uD7rljHPdtJuNxVsZCmDnwVuLvCzxfAh27Klw=;
        b=dgRS/obec3aOByr8PTKvXVfLFPdY1OXcSqqEUuyzPCu3aykdzkVOJ72/vImDdDvwYy
         u6HGV4iMY1+UU+6DDHioTxtUmpb4PL1lZF9mvbpeFOT35Mv2rS6loQXlTy5PFr/ULB4B
         lWV4RthTKBuPwRIoUJkcrsrmXJSZo5zuYr9Oo1NFcrbFmqPY68uGSvIhMKxSZsO769hX
         ujP/inLHS1BnYoTZvXdKpMKWCie+TcW+f6ic+DwM5gEVUlvh2oZnE/KN+Mq3UuB1youB
         dUl46XZqucP07YZ37nkUhsXFZn5UiopzPt1a6mWynNd4vdD+LEgxQgd3WURCof44zIb4
         ifRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KM0r5uD7rljHPdtJuNxVsZCmDnwVuLvCzxfAh27Klw=;
        b=TTo93bzGDVAvr5cr3kpM2Sx3qBBwK7G4pEbZt/KKZMetlWRXebqp/Vh979yMtHgO5q
         wBRdUhpP//gCTCO0mNELe4SvYko4k2FfKRvKDUkQJaPWs11zzOvfd9Rhx6uc9B/1vQED
         R0TsxlMq9CNRhB8xQOkPQgLNsatdqN+ssSCaraXLzo9knCrV5LRcTCSk+H6M2PIaOvQ/
         5XCVM6ZqvPKHNE6M0w3TnJbmKOHxWmPMTR3WOSQZrH/MSVao+jnoujqnuTlekHbqyEuH
         MzGxJ4K/T2HJ0ZolvhfiVfjJQXuUM9vJ+zIXf3b3k6Uu4k+XSkvvqItBWwG0pN2zX7vQ
         gt3A==
X-Gm-Message-State: APjAAAUJbH5qla/djmEfL6aJ7QERYfLpJWwrl5wLFB/lfwI3CzO8vlDD
        xExlbOHw5gWD0NGej9vCEq0=
X-Google-Smtp-Source: APXvYqyQjLc15uh0MUo/Upb22dso+icknd9LfH39mfhW5X2d4U/9EURWB7pcI9luJw0/E5sOA2wZ5Q==
X-Received: by 2002:a62:3304:: with SMTP id z4mr2893899pfz.79.1582704643017;
        Wed, 26 Feb 2020 00:10:43 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v7sm1679230pfn.61.2020.02.26.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:10:42 -0800 (PST)
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
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 1/6] drm/bridge: anx6345: Fix getting anx6345 regulators
Date:   Wed, 26 Feb 2020 00:10:06 -0800
Message-Id: <20200226081011.1347245-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226081011.1347245-1-anarsoul@gmail.com>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

We don't need to pass '-supply' suffix to devm_regulator_get()

Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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

