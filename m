Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8CEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A13206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEONM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:27 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53478 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgEONMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:12:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 76D87FB03;
        Fri, 15 May 2020 15:12:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g8I1dDNq2x7s; Fri, 15 May 2020 15:12:18 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 78087445AA; Fri, 15 May 2020 15:12:15 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 3/6] dt-bindings: display/bridge/nwl-dsi: Drop mux handling
Date:   Fri, 15 May 2020 15:12:12 +0200
Message-Id: <9884c56219e9bdbeec179c27ea2b734dbb5f1289.1589548223.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1589548223.git.agx@sigxcpu.org>
References: <cover.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to encode the SoC specifics in the bridge driver. For the
imx8mq we can use the mux-input-bridge.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../devicetree/bindings/display/bridge/nwl-dsi.yaml         | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
index 8aff2d68fc33..d2c2d4e19a25 100644
--- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
@@ -46,10 +46,6 @@ properties:
       - const: phy_ref
       - const: lcdif
 
-  mux-controls:
-    description:
-      mux controller node to use for operating the input mux
-
   phys:
     maxItems: 1
     description:
@@ -151,7 +147,6 @@ required:
   - clocks
   - compatible
   - interrupts
-  - mux-controls
   - phy-names
   - phys
   - ports
@@ -180,7 +175,6 @@ examples:
                        <&clk IMX8MQ_CLK_LCDIF_PIXEL>;
               clock-names = "core", "rx_esc", "tx_esc", "phy_ref", "lcdif";
               interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-              mux-controls = <&mux 0>;
               power-domains = <&pgc_mipi>;
               resets = <&src IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N>,
                        <&src IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N>,
-- 
2.26.1

