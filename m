Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0177C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFB5206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NIDiBIFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgEVMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:25:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46604 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgEVMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:25:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MCPbUu069719;
        Fri, 22 May 2020 07:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590150337;
        bh=qxfanaIpfydm+Sb/ZPt2hCD9Nf64PH/IoXNJmmM5pE4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NIDiBIFZiy3wOp96ycC8tKxpeVh726Qxvl6vuoa+4NbWcRqTrqGe9G5dYq+ZPeBeg
         uipaPBUUIUBQ75H1XxjFCSA/PL8dvOMt7QAhKacjLQeMcvuOEQn8PZu+q6eRyA+wXw
         vhxOXF4EHuLhMeKUWEg8I99U8H1RiYIKcFOqhB+M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MCPbeK096431;
        Fri, 22 May 2020 07:25:37 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 07:25:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 07:25:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MCParu007992;
        Fri, 22 May 2020 07:25:37 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v2 1/4] dt-bindings: net: Add tx and rx internal delays
Date:   Fri, 22 May 2020 07:25:31 -0500
Message-ID: <20200522122534.3353-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522122534.3353-1-dmurphy@ti.com>
References: <20200522122534.3353-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tx-internal-delays and rx-internal-delays are a common setting for RGMII
capable devices.

These properties are used when the phy-mode or phy-controller is set to
rgmii-id, rgmii-rxid or rgmii-txid.  These modes indicate to the
controller that the PHY will add the internal delay for the connection.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - updated to add -ps

 .../bindings/net/ethernet-controller.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index ac471b60ed6a..70702a4ef5e8 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -143,6 +143,20 @@ properties:
       Specifies the PHY management type. If auto is set and fixed-link
       is not specified, it uses MDIO for management.
 
+  rx-internal-delay-ps:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: |
+      RGMII Receive PHY Clock Delay defined in pico seconds.  This is used for
+      PHY's that have configurable RX internal delays.  This property is only
+      used when the phy-mode or phy-connection-type is rgmii-id or rgmii-rxid.
+
+  tx-internal-delay-ps:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: |
+      RGMII Transmit PHY Clock Delay defined in pico seconds.  This is used for
+      PHY's that have configurable TX internal delays.  This property is only
+      used when the phy-mode or phy-connection-type is rgmii-id or rgmii-txid.
+
   fixed-link:
     allOf:
       - if:
-- 
2.26.2

