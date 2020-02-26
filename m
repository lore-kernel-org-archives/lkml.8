Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709DAC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4813A20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0cii6N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBZILI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:11:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32927 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBZIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so998179plb.0;
        Wed, 26 Feb 2020 00:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bV3ZvEYwFOIunmpWLGzAgCdGTlK6S+EV6uVEHB+FGxY=;
        b=Q0cii6N45xFi8jvZk47bAoc1Nxu6hFKn2R/6gr1ZfjKbVoDJZ64PKB8Z3UWgfpC96z
         m858biDFlV7/4mo1LjVTUmbbBHm1yKrJnJ3uLVZBlEdyOFSDznZRxrzu6B/mSXoBfdGU
         mlGpBVLSLPU/z8ykPcedU1XFyCgTRivYgIcpSqG+QITc7/eIRdzyugFFz9Yzl27ql70w
         8AlOefrAt/HgAlO+4L6JoXtZp+YN7BobPP6qXr0OfqH/1PLZecbnI0vC7uItRmmZkPfN
         j7AsPd8mIOV8s5KgCaaK+xwtreytUn7QQZvq+Frfrl0pLWndKlgav8D5uWnV85pooXdR
         SCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bV3ZvEYwFOIunmpWLGzAgCdGTlK6S+EV6uVEHB+FGxY=;
        b=UQ0vly5+p5p/CtZZNJNPlOQp0h5KWCGnkr6InfWVzCoVUavCO7uPVgYeAuNKxzqBz2
         x6JX99GOENLOe2jV14TTOurmSsalEyOCO4p3Ocd+1ebigUsTuU9Amh4cHPUrBdqYKJTl
         JNoNRSlxp+JQe83eH1OBbXUnVWQNOO+ekRLd2OLg6DTEiYtwTrKrewPPluMG0pJkYI6D
         kpZ+VA3IK/9JpeAALPgmxEjbMSAy4ICiOApGMTugah+U7YyTas9wjwDTlyl5yee6w5EX
         TbPNAVqZHa78VAG5/LSQ73kZplyDrg9SQ2cKxVnLqSWDPaGKkMARxjL+oKnlNHayklpc
         PXXA==
X-Gm-Message-State: APjAAAWWafXaVCqsgcXdVroOf90ghNGa+lKmrwn7PrLs7ZeW/Mklo+R2
        2Z7WIAYBqXNeA8C68ruDN6U=
X-Google-Smtp-Source: APXvYqwzmN2dNDKDPwprqjYoy3wHRxeIo1QTGdy8Nrs8WKG2CT6K8e2fuBfcpdmu4anfHjvkmdpjJQ==
X-Received: by 2002:a17:902:6184:: with SMTP id u4mr2301682plj.216.1582704644297;
        Wed, 26 Feb 2020 00:10:44 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v7sm1679230pfn.61.2020.02.26.00.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:10:43 -0800 (PST)
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
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 2/6] drm/bridge: anx6345: don't print error message if regulator is not ready
Date:   Wed, 26 Feb 2020 00:10:07 -0800
Message-Id: <20200226081011.1347245-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226081011.1347245-1-anarsoul@gmail.com>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to print scary message if devm_regulator_get() returns
-EPROBE_DEFER

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 0d8d083b0207..0bf81b9b5faa 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -714,14 +714,18 @@ static int anx6345_i2c_probe(struct i2c_client *client,
 	/* 1.2V digital core power regulator  */
 	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
 	if (IS_ERR(anx6345->dvdd12)) {
-		DRM_ERROR("dvdd12-supply not found\n");
+		if (PTR_ERR(anx6345->dvdd12) != -EPROBE_DEFER)
+			DRM_ERROR("Failed to get dvdd12 supply (%ld)\n",
+				  PTR_ERR(anx6345->dvdd12));
 		return PTR_ERR(anx6345->dvdd12);
 	}
 
 	/* 2.5V digital core power regulator  */
 	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
 	if (IS_ERR(anx6345->dvdd25)) {
-		DRM_ERROR("dvdd25-supply not found\n");
+		if (PTR_ERR(anx6345->dvdd25) != -EPROBE_DEFER)
+			DRM_ERROR("Failed to get dvdd25 supply (%ld)\n",
+				  PTR_ERR(anx6345->dvdd25));
 		return PTR_ERR(anx6345->dvdd25);
 	}
 
-- 
2.25.0

