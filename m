Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E1D2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qD+EYJuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHXUbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:31:16 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:5554 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHXUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598301073; x=1629837073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wVH0kRlx4+fs0+IVfameIICQ+MQssp95e6xvIysueho=;
  b=qD+EYJuAlL1qUB6EhAy51JNZYA28INLqKeMlOKoHWF3qj3Zbq+HDqW42
   Sx8MDFoHzo/mtxAIA8NGra3tV1E1iYl2conBck4tmF4uzKfi1zntsfVBn
   bntqmmP14q+4a961Y9KP3xAcW/58QHh94bT5KfTy0k0opRP/XY4CC33cY
   Q2dIXQ6MQlvzLOzBGWv+JOFjg8YZU0ujmyeeX6NMeFJhElAjAPLM/aiTz
   F+Jl6S54y46ZV1Z4KffqfVN4DsiWHHrp16WAQCUV0ur9GOlxNTbdZswuY
   QNuob078BDh0q5ARCBd94GBIUU8Pu6t2NfLBnL/+XWS//NutuRFGPuhhq
   Q==;
IronPort-SDR: 5kvEKzPe9/bfgt+f89bgv7aJToAGWDNpFQ4V2N5hr0wUCpPfWUOHnCSnK9SmofW8T6o31X41tY
 uUYrC3vUYOA2aG+Hw6B5r39F4Jr9WjGksirf63fkfchM+DbGYKGyQRpB0kHWdkKmwDSCz0TTty
 ob7hlLmoWK0GpzfiMrxQ8m7jGX/DYCMops8dlcArZX/KnGpdYqQ1XCkHRChRdwXHyCJFIfc6zO
 LDb0Gs0CnuecC/Oteehq7aeMoELusWG4+hncyK8yVNoGaprx7o7oxe0eFHa8kZybgspZxbIpXD
 r+I=
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="24066872"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 13:31:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 13:31:13 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 13:30:33 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v5 4/6] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus rx-sample-delay-ns property
Date:   Mon, 24 Aug 2020 22:30:08 +0200
Message-ID: <20200824203010.2033-5-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200824203010.2033-1-lars.povlsen@microchip.com>
References: <20200824203010.2033-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has the following changes for the snps,dw-apb-ss DT bindings:

- Add "microchip,sparx5-spi" as the compatible for the Sparx5 SoC
  controller

- Add the property "rx-sample-delay-ns"

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index c62cbe79f00d..c79c8a167c46 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -36,6 +36,8 @@ properties:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
           - const: snps,dw-apb-ssi
+      - description: Microchip Sparx5 SoC SPI Controller
+        const: microchip,sparx5-spi
       - description: Amazon Alpine SPI Controller
         const: amazon,alpine-dw-apb-ssi
       - description: Renesas RZ/N1 SPI Controller
@@ -93,6 +95,12 @@ properties:
       - const: tx
       - const: rx
 
+  rx-sample-delay-ns:
+    default: 0
+    description: Default value of the rx-sample-delay-ns property.
+      This value will be used if the property is not explicitly defined
+      for a SPI slave device. See below.
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
@@ -107,6 +115,13 @@ patternProperties:
       spi-tx-bus-width:
         const: 1
 
+      rx-sample-delay-ns:
+        description: SPI Rx sample delay offset, unit is nanoseconds.
+          The delay from the default sample time before the actual
+          sample of the rxd input signal occurs. The "rx_sample_delay"
+          is an optional feature of the designware controller, and the
+          upper limit is also subject to controller configuration.
+
 unevaluatedProperties: false
 
 required:
@@ -129,5 +144,11 @@ examples:
       num-cs = <2>;
       cs-gpios = <&gpio0 13 0>,
                  <&gpio0 14 0>;
+      rx-sample-delay-ns = <3>;
+      spi-flash@1 {
+        compatible = "spi-nand";
+        reg = <1>;
+        rx-sample-delay-ns = <7>;
+      };
     };
 ...
-- 
2.27.0

