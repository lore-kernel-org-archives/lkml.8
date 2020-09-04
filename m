Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1624520722
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231282;
	bh=/p3lMAEm/yGooAnCxTN8zhpzzWRbuLPyimxMLeewvXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nx0HoiT6OCF+7g1vm3JNhh4iKwOaklf28yJ+OxAEOsTxwzjOfmJ2QGiF653Klxhtd
	 oIQ4fRkwrr28Ojy8v4donusViSUh/CljQOAAXYaiApdlZjcCdAcU1JrKnvxewBi/Bd
	 0iyiMn3XkC+iVtm04q8apEsVSFIf0v32Go4sSXkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbgIDOyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbgIDOyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:54:03 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C3F20722;
        Fri,  4 Sep 2020 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231243;
        bh=/p3lMAEm/yGooAnCxTN8zhpzzWRbuLPyimxMLeewvXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eh/pmg9gbfINlAKynchtq8oPsuY68uof0c1Le45d3qIU3ZAXhrQ13COJjJapvYDEh
         sOgVZVoYKqCOKI7U1ngUPzuWII8+aHlcYgZBCTUv6HLSeKEu5gixxtxtjmQgkA3fsl
         w5aM3yqOCW49ZMyf9kU0jcdLiWp2+Nj3jju5ds/c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 07/13] dt-bindings: mfd: rohm,bd71847-pmic: Add common clock-names
Date:   Fri,  4 Sep 2020 16:53:06 +0200
Message-Id: <20200904145312.10960-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common 'clock-names' property which might appear in DTSes.  This
makes it consistent with rohm,bd71837-pmic dtschema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index 5d531051a153..6328163fc32a 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -35,6 +35,9 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    maxItems: 1
+
   "#clock-cells":
     const: 0
 
-- 
2.17.1

