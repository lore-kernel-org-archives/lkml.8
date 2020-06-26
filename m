Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A0CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C868207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hrA8eI/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFZKB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:01:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40665 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFZKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:01:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200626100111euoutp025225cb5f157cddc03d1c8432b7d1a9ac~cD7zPGxIU2358023580euoutp028
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:01:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200626100111euoutp025225cb5f157cddc03d1c8432b7d1a9ac~cD7zPGxIU2358023580euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593165671;
        bh=FHCuuaIM6iYHipda4rakjqMi4ghKc6Dm3/I5/j2IFWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrA8eI/OFM5nK6TDghuwcmWoCGT/BoU1SJ4hBfWBsHjVjRBWj4RE1ZAfxKmV/NXpN
         uwj4M3LGoqD2Z3yAf6zb49VIWFBUf30r6F16Ma4ToC58IN7dqvocmW2sbxgsaxr0BF
         vYquaA3aXNq5P5fLRV3PZqKhivS9yic0Azj7ATjA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200626100111eucas1p2a3fc77556f77587970444e08c7bfbd29~cD7y4vQM40241702417eucas1p2q;
        Fri, 26 Jun 2020 10:01:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.EB.06456.767C5FE5; Fri, 26
        Jun 2020 11:01:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200626100110eucas1p24327c924dada0c2e86ecf0ab5b5af571~cD7yfZReH0240902409eucas1p2-;
        Fri, 26 Jun 2020 10:01:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200626100110eusmtrp2e1590d0784faf930f3ae366b4abbe2c5~cD7yeyj9e1303213032eusmtrp2U;
        Fri, 26 Jun 2020 10:01:10 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-37-5ef5c7679853
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.86.06017.667C5FE5; Fri, 26
        Jun 2020 11:01:10 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200626100110eusmtip10e216f4cb07c1f1d10a5fb2c27eddda1~cD7xo50po2131121311eusmtip1A;
        Fri, 26 Jun 2020 10:01:10 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [PATCH v6 3/4] drm/bridge/sii8620: fix resource acquisition error
 handling
Date:   Fri, 26 Jun 2020 12:01:02 +0200
Message-Id: <20200626100103.18879-4-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626100103.18879-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUyMcRzf757X0rXHyfqNlG5rw0YS28/LvLb2mI0wfyguR49q1ZV7VNio
        RF2ld72IJtTkQlx1uVrrXK3TUnqXI0fILrVGhVqi6wn/fb6fz/fz+X6/v/1oTNJGLKGDFac5
        pUIeKiVtcW3T5IvVgcYJ2druAQkyPWwjkCWjAaDH+eUEynn/kUS/tZkY6p4YJVH8nXIS9fyw
        YKh5uAdHSZnFFNJ86CVQV80NEhly6gB60NhPIUOaHyocz8G2M2xXbwfGjvZdpti670U4qyvo
        p9jrqmsEq1EnkeyzjE4RW194n2LNKUYRW1Ecw6ZVqgGrT83G2TGNs4/Y13ZLABcaHMUp3bce
        sw2qyu8gIobtz7Tfdo4FuXbJwIaGzHo4rTKJkoEtLWFKAXz7+SolFOMAfu1WA6EYA3A6O3VW
        oecsD5pkAn8XwC91Q+Cf4+d0HGXNJZmV8FfFK9KKHRhPmN5aMBeLMVM47ElMIKzCIuYQfN47
        KLJinHGDvTkZcwYxg+BkQyEuLOgCyx7pMSu2YTbCPFMqYQ2CzAgFR9PTCKHJC9am3Zo3LIJD
        xkpKwE7wt+6mSMAx0Fx6CRPMKgCrHukwQdgM37RNkdbbsNm1y2vcBXoHLMxLFQkn28O+kYVW
        GpuFWdo8TKDFUJUgEbpdobm1aj7QEZa0T5ACZuFrzSVSeKArALboG8kM4FLwf1gRAGrgyEXy
        YYEc76Hgotfw8jA+UhG45kR4mAbM/rKWGeO3J2Ci87gBMDSQ2on1meMyCSGP4s+GGQCkMamD
        eGdri0wiDpCfPccpw/2VkaEcbwBLaVzqKPa8bTkqYQLlp7kQjovglH9VEW2zJBaovUbGq/u7
        g+vjQRnbcfD1Uk1Wk+mU/7tdjzldyOH0Yt+6aVnnhZexxjHtgUnX3G0bZmr38CWfJtf15y4L
        9a5MyUrea9mdvvxk87uL/kRsiN/DIie3p+b66CMD0FkRFO+qM/lo73ir5EGJi2fiqpPz7jWW
        ZEYNLji/Yv8m+3197pVSnA+Se6zClLz8D/GU1O5hAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7ppx7/GGax7b25xa905VouXEw4z
        WmycsZ7VYurDJ2wW/7dNZLa48vU9m0Xz4vVsFle/v2S2OPnmKotF58Ql7BabHl9jtbi8aw6b
        xaGpexkt1h65y25xqC/aYu6XqcwOAh6Xr11k9nh/o5XdY++3BSweO2fdZfeY3TGT1WPTqk42
        jxMTLjF57J+7ht3jfvdxJo/NS+o9+rasYvQ40DuZxePzJrkA3ig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jK0zLrIWvOGruLBIroFxGk8XIweH
        hICJxNpjcV2MXBxCAksZJXb+XczWxcgJFBeX2D3/LTOELSzx51oXG0TRJ0aJhc2zmUASbAKa
        En833wRrEBEwlug/O4sdpIhZoI1VYu75J+wgG4QFgiXWnRUFqWERUJW4NnUCWD2vgIXEz8Nz
        WSAWyEus3nAAbBmngKXE9Fu9rCCtQkA1nUsiJzDyLWBkWMUoklpanJueW2ykV5yYW1yal66X
        nJ+7iREYVduO/dyyg7HrXfAhRgEORiUe3gMTv8QJsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGy
        KrUoP76oNCe1+BCjKdBNE5mlRJPzgRGfVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBcc2rTZ+6/d2uSLewHij6tDV1qtDLXSu5eiI2/esKXVV14kh/ifucVd1L
        ZLdWeYeyGM9hq95oWmLSF9iTLnd3TtCapPN2l15dnh/BnGnqHP0y4zEbV5xVg6Vw9nylu/YP
        Cvdcytdpv3u803na0dOq5ZpyG6YkTFxvfPTiqaAZEx9MZTCoXmcSocRSnJFoqMVcVJwIAAI3
        g3bAAgAA
X-CMS-MailID: 20200626100110eucas1p24327c924dada0c2e86ecf0ab5b5af571
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200626100110eucas1p24327c924dada0c2e86ecf0ab5b5af571
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200626100110eucas1p24327c924dada0c2e86ecf0ab5b5af571
References: <20200626100103.18879-1-a.hajda@samsung.com>
        <CGME20200626100110eucas1p24327c924dada0c2e86ecf0ab5b5af571@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error during resource acquisition driver should print error
message only in case it is not deferred probe, using dev_err_probe helper
solves the issue. Moreover it records defer probe reason for debugging.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 92acd336aa89..389c1f029774 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2299,10 +2299,9 @@ static int sii8620_probe(struct i2c_client *client,
 	INIT_LIST_HEAD(&ctx->mt_queue);
 
 	ctx->clk_xtal = devm_clk_get(dev, "xtal");
-	if (IS_ERR(ctx->clk_xtal)) {
-		dev_err(dev, "failed to get xtal clock from DT\n");
-		return PTR_ERR(ctx->clk_xtal);
-	}
+	if (IS_ERR(ctx->clk_xtal))
+		return dev_err_probe(dev, PTR_ERR(ctx->clk_xtal),
+				     "failed to get xtal clock from DT\n");
 
 	if (!client->irq) {
 		dev_err(dev, "no irq provided\n");
@@ -2313,16 +2312,14 @@ static int sii8620_probe(struct i2c_client *client,
 					sii8620_irq_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"sii8620", ctx);
-	if (ret < 0) {
-		dev_err(dev, "failed to install IRQ handler\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to install IRQ handler\n");
 
 	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->gpio_reset)) {
-		dev_err(dev, "failed to get reset gpio from DT\n");
-		return PTR_ERR(ctx->gpio_reset);
-	}
+	if (IS_ERR(ctx->gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(ctx->gpio_reset),
+				     "failed to get reset gpio from DT\n");
 
 	ctx->supplies[0].supply = "cvcc10";
 	ctx->supplies[1].supply = "iovcc18";
-- 
2.17.1

