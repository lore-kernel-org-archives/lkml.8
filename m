Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48754C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F172082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Zvf3Xjxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbgGAQa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:30:29 -0400
Received: from vps.xff.cz ([195.181.215.36]:52084 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbgGAQ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593620972; bh=Oj0dUcmJMqbWWnEM4fT6FFb2wi7F4yzS6GdUL1tM2bs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Zvf3XjxawvPDIwJHmE0HLoyYa6PArOwnOXK6FGyw6noHShQ8FaPC0ApzZpMoi9g8L
         PJn5dvreXQ4/Dt1qmolJPnxGaJOFd+eJxLq8pzqwbAeKp6Uec5z6GZcq3BBRYSPD7C
         rIzQygxsr4R0wjnE+fL4Jc2NdwOlC3OVccu9l1S8=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v7 03/13] dt-bindings: panel: Add compatible for Xingbangda XBD599 panel
Date:   Wed,  1 Jul 2020 18:29:18 +0200
Message-Id: <20200701162928.1638874-4-megous@megous.com>
In-Reply-To: <20200701162928.1638874-1-megous@megous.com>
References: <20200701162928.1638874-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel. It is based on
Sitronix ST7703 LCD controller just like rocktech,jh057n00900. It is
used in PinePhone.

Add a compatible for it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../bindings/display/panel/rocktech,jh057n00900.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index 928ba42e7f8d..a6985cd947fb 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -18,7 +18,11 @@ allOf:
 
 properties:
   compatible:
-    const: rocktech,jh057n00900
+    enum:
+        # Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
+      - rocktech,jh057n00900
+        # Xingbangda XBD599 5.99" 720x1440 TFT LCD panel
+      - xingbangda,xbd599
 
   reg:
     maxItems: 1
-- 
2.27.0

