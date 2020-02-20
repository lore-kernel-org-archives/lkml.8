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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC25C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FE824654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3u9Ja07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgBTIgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:36:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43747 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgBTIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:35:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id p11so1264104plq.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijTyB6ZR5pfL9IN/EaJ22u7Sp0djdDBIhKNgT7JvipY=;
        b=b3u9Ja078tSmcCLcfoMQJDexdgyH/UZUnFYqU4ZxbLy6czS/yTF/tJ2B8Yy102S8sN
         U35/QiLltRKbOx17qqhB/GkFDaJejvf4ImYkPJ25DMx7AXr1DiGNp1qeccXsGpTmPjUP
         L6keUCh/INygIGP1TJB5/Vo/Z7pz9epIu2+IHkFdNt/rgqueYxtm0/ZTVnAUYhoJH5Ha
         TOH7wvgMIqCYUNxrwLgoS2ReFdCSfBx6ddtW3rxgGGCW7Yyz+sfheNQqlsYX0SgdP2Ud
         3/xrhFyrS6DTh24Z7fd2eRhzaA2g/EzfPLcCqvIVOr3owpGad3Hza66L98rZlOmnSkND
         k14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijTyB6ZR5pfL9IN/EaJ22u7Sp0djdDBIhKNgT7JvipY=;
        b=JWAvyJ5xOUxwOWeRiJq4yV2cpRD5WPpde3aEu/gfI1614axbH6YCVu/ZtX1AMzGY7X
         Ny09+69+6htNQFCaPSwHSnolhezTkaMMSqvxtrh5C8T8HF1Cbvkc7YGA///xyJV8oLzw
         eOXc1M3qnMqk8+AeUgMxDdAxpHNsVBQtye78JGDB4fwtPZY2gcktJSqwf1m6p5r5aTt1
         DQglrNzKjZvgWnc6CVmYoUTpgeuyWJ5dvvzYTQqjbCyAaXXebW3iNByk2d1bs4D7wDPm
         Ujjapx8xaqnAWB6hT876K5bsUbV8jbBAzEe2OHzBu7PuOsE7QuxjiUZV2dMKhlXEpLxT
         gVMw==
X-Gm-Message-State: APjAAAWi2I+1BLXwUvXwh/3VWi9jm4/EZBSuhVYLzON1ypm9TT7MUjDj
        ljA+nUMdmhUp7kw0gThIIBM=
X-Google-Smtp-Source: APXvYqx+XcOfE7rl34bx8Kj5W10tYHXxB9gA64KZqWfc1a/TzGmCwogwaY6RZV8h7YFo8hBwokFMIQ==
X-Received: by 2002:a17:90a:b381:: with SMTP id e1mr2289733pjr.38.1582187757461;
        Thu, 20 Feb 2020 00:35:57 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id l13sm2319038pjq.23.2020.02.20.00.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:35:57 -0800 (PST)
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
Subject: [PATCH 4/6] dt-bindings: display: simple: Add NewEast Optoelectronics WJFH116008A compatible
Date:   Thu, 20 Feb 2020 00:35:06 -0800
Message-Id: <20200220083508.792071-5-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220083508.792071-1-anarsoul@gmail.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds compatible for NewEast Optoelectronics WJFH116008A panel
to panel-simple binding

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 8fe60ee2531c..721de94cc80a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -43,6 +43,8 @@ properties:
       - satoz,sat050at40h12r2
         # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
       - sharp,ls020b1dd01d
+        # NewEast Optoelectronics CO., LTD WJFH116008A eDP TFT LCD panel
+      - neweast,wjfh116008a
 
   backlight: true
   enable-gpios: true
-- 
2.25.0

