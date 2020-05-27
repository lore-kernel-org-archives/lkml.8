Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34919C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6BF20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h6RPvmMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgE0QuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:50:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41468 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgE0Qt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:49:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04RGnp3a070390;
        Wed, 27 May 2020 11:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590598191;
        bh=h35Gn9fogWy8wFBKtHA2ZrBUEohvkANKQUX2eEmDuJo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h6RPvmMeHr26HjndE788lh5lk0qrcK+lfc3/JtMRy6q7QcT5uDUGlrgzwErzXhL1U
         yppNwXavwHjxy/qmyUlXVtYNgM3sE56yad+xOiGjKUXPJZZIOa7qx5FADeUfJKNcpf
         BwTC10jdRJgrJ7x2R/WkWKuVJp05dFvDP0W8ZuKg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04RGnpjc005981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 11:49:51 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 11:49:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 11:49:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04RGnoJx071529;
        Wed, 27 May 2020 11:49:50 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v4 3/4] dt-bindings: net: Add RGMII internal delay for DP83869
Date:   Wed, 27 May 2020 11:49:33 -0500
Message-ID: <20200527164934.28651-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527164934.28651-1-dmurphy@ti.com>
References: <20200527164934.28651-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the internal delay values into the header and update the binding
with the internal delay properties.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/net/ti,dp83869.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83869.yaml b/Documentation/devicetree/bindings/net/ti,dp83869.yaml
index 5b69ef03bbf7..2971dd3fc039 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83869.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83869.yaml
@@ -64,6 +64,20 @@ properties:
        Operational mode for the PHY.  If this is not set then the operational
        mode is set by the straps. see dt-bindings/net/ti-dp83869.h for values
 
+  rx-internal-delay-ps:
+    $ref: "#/properties/rx-internal-delay-ps"
+    description: Delay is in pico seconds
+    enum: [ 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000,
+            3250, 3500, 3750, 4000 ]
+    default: 2000
+
+  tx-internal-delay-ps:
+    $ref: "#/properties/tx-internal-delay-ps"
+    description: Delay is in pico seconds
+    enum: [ 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000,
+            3250, 3500, 3750, 4000 ]
+    default: 2000
+
 required:
   - reg
 
@@ -80,5 +94,7 @@ examples:
         ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
         ti,max-output-impedance = "true";
         ti,clk-output-sel = <DP83869_CLK_O_SEL_CHN_A_RCLK>;
+        rx-internal-delay-ps = <2000>;
+        tx-internal-delay-ps = <2000>;
       };
     };
-- 
2.26.2

