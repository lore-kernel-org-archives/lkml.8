Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19235C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4469208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="qkebOUzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgBWDQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:16:19 -0500
Received: from vps.xff.cz ([195.181.215.36]:36896 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgBWDQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582427777; bh=cBWlfj++s2/S0YKuROSJoDR9+u4sdEc4wNQ7e2Fs0jY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qkebOUzMI3/k2FfAPeGVxwK3frmTSAeccUBgAEAh8GHxNjg84YQylgMLeVYA+cxsF
         LfM2f4DBfi/SBolGyZTChppIGnxvDGfYn8Tl+QrnPjfUxBqWyoxafME4YCoFmBKPVE
         LyWYDtb1x1vddjK0Ple3VBmEdv/MvSvR//ljZ31Y=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sunil Mohan Adapa <sunil@medhas.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: sunxi: Add PocketBook Touch Lux 3
Date:   Sun, 23 Feb 2020 04:16:13 +0100
Message-Id: <20200223031614.515563-3-megous@megous.com>
In-Reply-To: <20200223031614.515563-1-megous@megous.com>
References: <20200223031614.515563-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new board name.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 327ce67308237..7c4be977be37f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -647,6 +647,11 @@ properties:
           - const: pineriver,mini-xplus
           - const: allwinner,sun4i-a10
 
+      - description: PocketBook Touch Lux 3
+        items:
+          - const: pocketbook,touch-lux-3
+          - const: allwinner,sun5i-a13
+
       - description: Point of View Protab2-IPS9
         items:
           - const: pov,protab2-ips9
-- 
2.25.1

