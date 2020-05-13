Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E31C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6546120673
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ThRcLeZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbgEMNHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:07:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54104 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgEMNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:07:20 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7IPT043989;
        Wed, 13 May 2020 08:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589375238;
        bh=C9IeA+VMqNp11foyocZyx6XO16F5Fon6CjEx0Vpeqlw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ThRcLeZHPxW5EQF4qTKczrAeOQFd3XVkHRAUvYvS3F9qIx9S72bPROkFO5VwdoxZJ
         +nwnpe6UnYif6zfdadSyRHl1R4sBZuBsCJ5ocHjmSfTj/u8M+B6rxR1HCu8V7vQ1dD
         ho4MHM3e9+lsazOECfrON+I4DCN3WFznH2AeT5Pg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DD7I90010782
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 08:07:18 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 08:07:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 08:07:18 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7B2S074071;
        Wed, 13 May 2020 08:07:16 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/3] dt-bindings: usb: ti,keystone-dwc3.yaml: Add USB3.0 PHY property
Date:   Wed, 13 May 2020 16:07:08 +0300
Message-ID: <20200513130709.10239-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513130709.10239-1-rogerq@ti.com>
References: <20200513130709.10239-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 SoC requires USB3.0 PHY to be turned on before the USB controller.
For this SoC, the 'phys' property is used to provide the USB3.0
reference.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../bindings/usb/ti,keystone-dwc3.yaml        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
index 14d2fe329b93..51c0ab01b0bc 100644
--- a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
@@ -34,6 +34,16 @@ properties:
       value. This property is as per the binding,
       Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 
+  phys:
+    description:
+      PHY specifier for the USB3.0 PHY. Some SoCs need the USB3.0 PHY
+      to be turned on before the controller.
+      Documentation/devicetree/bindings/phy/phy-bindings.txt
+
+  phy-names:
+    items:
+      - const: "usb3-phy"
+
   dwc3:
     description: This is the node representing the DWC3 controller instance
       Documentation/devicetree/bindings/usb/dwc3.txt
@@ -44,6 +54,17 @@ required:
   - interrupts
   - clocks
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: "ti,am654-dwc3"
+
+then:
+  required:
+    - phys
+    - phy-names
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

