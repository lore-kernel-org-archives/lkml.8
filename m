Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10D220724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHUMWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:22:00 -0400
Received: from comms.puri.sm ([159.203.221.185]:51444 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgHUMSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:18:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A94BDDF578;
        Fri, 21 Aug 2020 05:18:30 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FZOmtKxIOhcp; Fri, 21 Aug 2020 05:18:29 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 3/3] dt-bindings: arm: fsl: Add the librem 5 phone
Date:   Fri, 21 Aug 2020 14:17:55 +0200
Message-Id: <20200821121755.24599-3-martin.kepplinger@puri.sm>
In-Reply-To: <20200821121755.24599-1-martin.kepplinger@puri.sm>
References: <20200821121755.24599-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for the imx8mq based Librem 5 phone. The "Birch" and
"Chestnut" hardware revisions are supported by r2. The "Dogwood"
revision by r3.
See https://puri.sm/products/librem-5/ and https://developer.puri.sm/Librem5/
for the schematics and more information.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6da9d734cdb7..25b4abd2c564 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -368,6 +368,8 @@ properties:
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - google,imx8mq-phanbell    # Google Coral Edge TPU
               - purism,librem5-devkit     # Purism Librem5 devkit
+              - purism,librem5r2          # Purism Librem5 phone "Chestnut"
+              - purism,librem5r3          # Purism Librem5 phone "Dogwood"
               - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
           - const: fsl,imx8mq
-- 
2.20.1

