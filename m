Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D11DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A539208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Si5mpSVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGCTs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:48:57 -0400
Received: from vps.xff.cz ([195.181.215.36]:47728 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgGCTsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593805724; bh=2pQ5r99yANU9+lW3Rp2PJtmKfbBgvKfHKIjpZpQp7bo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Si5mpSVuna+Wtbxsl8XgTRDs8F511V3vsbkEsJ2b9J7ijNwfzqDWef/8vSx0UH/yk
         fB2mtL/YWp1clNN8tfNlIPQBpdgVK8HlPgJN9geJjvoh3V/8klk/Er++S2DBvWtQjt
         B5efjFrZXioj+xffywuTZo482YM5F2Ex0HktjqH4=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: arm: sunxi: Add PinePhone 1.2 bindings
Date:   Fri,  3 Jul 2020 21:48:40 +0200
Message-Id: <20200703194842.111845-2-megous@megous.com>
In-Reply-To: <20200703194842.111845-1-megous@megous.com>
References: <20200703194842.111845-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Pine64 PinePhone 1.2.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 87817ff0cd35..efc9118233b4 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -657,6 +657,11 @@ properties:
           - const: pine64,pinephone-1.1
           - const: allwinner,sun50i-a64
 
+      - description: Pine64 PinePhone (1.2)
+        items:
+          - const: pine64,pinephone-1.2
+          - const: allwinner,sun50i-a64
+
       - description: Pine64 PineTab
         items:
           - const: pine64,pinetab
-- 
2.27.0

