Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E092081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="YWTnNiSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgFZA4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:56:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:45010 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgFZA4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593132965; bh=Xs3DGK4g22Xz2ldtB+A5ZCMGYmWkqwG6E538OdVkcGc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YWTnNiSbvFXnMqnLTaqbz42pAY4AZNqWmp+1Mb0kxc3kYgLnDDskDCPYE24jqRMPB
         cannFblFO36FQe0sovyYEkB/KNKf3zpd8+9gPGGB1Bbe4chnjssNwSfsydQ/BfXByH
         y9LtueWwsRbjTn3eQE9LK/48vFFy3yQ8mKRxcSO4=
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
Subject: [PATCH v5 03/13] dt-bindings: panel: Add compatible for Xingbangda XBD599 panel
Date:   Fri, 26 Jun 2020 02:55:51 +0200
Message-Id: <20200626005601.241022-4-megous@megous.com>
In-Reply-To: <20200626005601.241022-1-megous@megous.com>
References: <20200626005601.241022-1-megous@megous.com>
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
index f97c48550741..4d43a1b36d7c 100644
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

