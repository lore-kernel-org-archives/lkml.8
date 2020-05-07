Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD49C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A8F2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgEGP5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:57:18 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:9779 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEGP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:57:15 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 56F95240005;
        Thu,  7 May 2020 15:57:12 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: usb: atmel: Mark EP child node as deprecated
Date:   Thu,  7 May 2020 17:56:50 +0200
Message-Id: <20200507155651.1094142-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507155651.1094142-1-gregory.clement@bootlin.com>
References: <20200507155651.1094142-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to describe the end point in the deice tree. These
properties won't be use anymore, so mark them as deprecated to keep
the old device tree documented.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/usb/atmel-usb.txt     | 56 +------------------
 1 file changed, 3 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 44e80153b148..423b99a8fd97 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -88,13 +88,15 @@ Required properties:
  - clock-names: Should contain two strings
 		"pclk" for the peripheral clock
 		"hclk" for the host clock
+
+Deprecated property:
  - ep childnode: To specify the number of endpoints and their properties.
 
 Optional properties:
  - atmel,vbus-gpio: If present, specifies a gpio that allows to detect whether
    vbus is present (USB is connected).
 
-Required child node properties:
+Deprecated child node properties:
  - name: Name of the endpoint.
  - reg: Num of the endpoint.
  - atmel,fifo-size: Size of the fifo.
@@ -112,56 +114,4 @@ usb2: gadget@fff78000 {
 	clocks = <&utmi>, <&udphs_clk>;
 	clock-names = "hclk", "pclk";
 	atmel,vbus-gpio = <&pioB 19 0>;
-
-	ep@0 {
-		reg = <0>;
-		atmel,fifo-size = <64>;
-		atmel,nb-banks = <1>;
-	};
-
-	ep@1 {
-		reg = <1>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <2>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
-
-	ep@2 {
-		reg = <2>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <2>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
-
-	ep@3 {
-		reg = <3>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-	};
-
-	ep@4 {
-		reg = <4>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-	};
-
-	ep@5 {
-		reg = <5>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
-
-	ep@6 {
-		reg = <6>;
-		atmel,fifo-size = <1024>;
-		atmel,nb-banks = <3>;
-		atmel,can-dma;
-		atmel,can-isoc;
-	};
 };
-- 
2.26.2

