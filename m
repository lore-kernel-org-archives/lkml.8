Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F410CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7D720772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="MuA9Noi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGCLrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:47:24 -0400
Received: from vps.xff.cz ([195.181.215.36]:41236 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgGCLrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593776842; bh=Mror7EhaRxvkBeJPmtCPvGSBofo331RIQIKcoOFqy6Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MuA9Noi6uYlKU2CAFK1WTynrh42ZGRL7Tg8K7H1vyG8kWNPzuGLCruUbNWGfmOCU9
         OWZBGyUs4yf6qYpa19lLPTYLtYrfT0OfyF8lrONoflImJXKxOSmYDyUGBQyJ1Y/Ck1
         zUWj9XpA84Ujd+c37JTA/Q8748X7xbfwo9DPjvc8=
From:   Ondrej Jirman <megous@megous.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: Fix example in nwl-dsi.yaml
Date:   Fri,  3 Jul 2020 13:47:16 +0200
Message-Id: <20200703114717.2140832-2-megous@megous.com>
In-Reply-To: <20200703114717.2140832-1-megous@megous.com>
References: <20200703114717.2140832-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example is now validated against rocktech,jh057n00900 schema
that was ported to yaml, and didn't validate with:

- '#address-cells', '#size-cells', 'port@0' do not match any of
  the regexes: 'pinctrl-[0-9]+'
- 'vcc-supply' is a required property
- 'iovcc-supply' is a required property
- 'reset-gpios' is a required property

Fix it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../devicetree/bindings/display/bridge/nwl-dsi.yaml      | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
index 8aff2d68fc33..2c4c34e3bc29 100644
--- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
@@ -165,6 +165,7 @@ examples:
  - |
 
    #include <dt-bindings/clock/imx8mq-clock.h>
+   #include <dt-bindings/gpio/gpio.h>
    #include <dt-bindings/interrupt-controller/arm-gic.h>
    #include <dt-bindings/reset/imx8mq-reset.h>
 
@@ -191,12 +192,12 @@ examples:
               phy-names = "dphy";
 
               panel@0 {
-                      #address-cells = <1>;
-                      #size-cells = <0>;
                       compatible = "rocktech,jh057n00900";
                       reg = <0>;
-                      port@0 {
-                           reg = <0>;
+                      vcc-supply = <&reg_2v8_p>;
+                      iovcc-supply = <&reg_1v8_p>;
+                      reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+                      port {
                            panel_in: endpoint {
                                      remote-endpoint = <&mipi_dsi_out>;
                            };
-- 
2.27.0

