Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B05C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCB72072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgHVPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHVPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 11:11:17 -0400
Received: from mxout014.mail.hostpoint.ch (mxout014.mail.hostpoint.ch [IPv6:2a00:d70:0:e::314])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1196AC061573;
        Sat, 22 Aug 2020 08:11:16 -0700 (PDT)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k9VAZ-000HEL-DA; Sat, 22 Aug 2020 17:10:59 +0200
Received: from [2a02:168:6182:1:880e:adee:9ae9:610] (helo=ryzen2700.dss.husqvarnagroup.com)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k9VAZ-000K4J-AK; Sat, 22 Aug 2020 17:10:59 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
From:   Reto Schneider <code@reto-schneider.ch>
To:     linux-arm-kernel@lists.infradead.org, alexandre.belloni@bootlin.com
Cc:     Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] dt-bindings: arm: at91: Add GARDENA smart Gateway (Art. 19000) board
Date:   Sat, 22 Aug 2020 17:10:20 +0200
Message-Id: <20200822151023.31629-1-code@reto-schneider.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200810171921.8679-1-code@reto-schneider.ch>
References: <20200810171921.8679-1-code@reto-schneider.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reto Schneider <reto.schneider@husqvarnagroup.com>

Document devicetree's bindings for the GARDENA smart Gateway with
article number 19000, based on the SAM9G25 Atmel SoC.

Signed-off-by: Reto Schneider <reto.schneider@husqvarnagroup.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 31b0c54fa2cf..c0fa195698c8 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -41,6 +41,8 @@ properties:
               - overkiz,kizboxmini-mb   # Overkiz kizbox Mini Mother Board
               - overkiz,kizboxmini-rd   # Overkiz kizbox Mini RailDIN
               - overkiz,smartkiz        # Overkiz SmartKiz Board
+              - gardena,smart-gateway-at91sam # GARDENA smart Gateway (Article
+                                              # No. 19000)
           - const: atmel,at91sam9g25
           - const: atmel,at91sam9x5
           - const: atmel,at91sam9
-- 
2.27.0

