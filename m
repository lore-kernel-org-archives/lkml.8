Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30567C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C032074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231242;
	bh=ASiZ0rB9LNwgfTE9ttuElktd19XeAlJ3o/IpyKudDPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TjZkiI8YeEoxSPtYzuLra7D+lyjEZe5PV7uVIl5FUxZ+IhBd0fN0H9HZfBnbcbm3y
	 ppOi8jQDrV1y3ne2Lqm1YdciDlwIeCVYV3SuFZrztfYJk0mosizhcuY7m02mKedsZt
	 xw7s3F/4mD+ico8Zc5DYYmhJZgB0irE0K9+pFp4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgIDOyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbgIDOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:53:40 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231322074D;
        Fri,  4 Sep 2020 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231219;
        bh=ASiZ0rB9LNwgfTE9ttuElktd19XeAlJ3o/IpyKudDPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aR2RVbgZWjLaYqLsuAvDRAoxLGCQRm9KsDGoMMp/gGpODc1XE/ZpmzOUF1GTJldsI
         soD3XHAySHDgl59TNt7eXiWKS8uTSEJuDhusDjecYWQRjptUw3qSwxrPyPR2i8i9rV
         t6oKaiifMgz4rkD9iMzTPAs30EIopKu4CUaPFcTo=
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
Subject: [PATCH 03/13] dt-bindings: arm: fsl: Fix matching Purism Librem5 phones
Date:   Fri,  4 Sep 2020 16:53:02 +0200
Message-Id: <20200904145312.10960-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Purism Librem5 phones have three compatibles so they need their own
entry to fix dbts_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
    compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is not valid under any of the given schemas

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml: /:
    compatible: ['purism,librem5r2', 'purism,librem5', 'fsl,imx8mq'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 37cef8653541..edef7a9f4e36 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -377,12 +377,18 @@ properties:
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - google,imx8mq-phanbell    # Google Coral Edge TPU
               - purism,librem5-devkit     # Purism Librem5 devkit
-              - purism,librem5r2          # Purism Librem5 phone "Chestnut"
-              - purism,librem5r3          # Purism Librem5 phone "Dogwood"
               - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
           - const: fsl,imx8mq
 
+      - description: Purism Librem5 phones
+        items:
+          - enum:
+              - purism,librem5r2          # Purism Librem5 phone "Chestnut"
+              - purism,librem5r3          # Purism Librem5 phone "Dogwood"
+          - const: purism,librem5
+          - const: fsl,imx8mq
+
       - description: Zodiac Inflight Innovations Ultra Boards
         items:
           - enum:
-- 
2.17.1

