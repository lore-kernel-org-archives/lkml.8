Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A703CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883DD204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgHSNpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgHSNoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:44:21 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB677C061350
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:44:00 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id HRjl2300G4C55Sk01RjlxW; Wed, 19 Aug 2020 15:43:56 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8ONV-0003Dn-Cb; Wed, 19 Aug 2020 15:43:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8ONV-0007FT-Ai; Wed, 19 Aug 2020 15:43:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/7] dt-bindings: net: ethernet-controller: Add internal delay properties
Date:   Wed, 19 Aug 2020 15:43:38 +0200
Message-Id: <20200819134344.27813-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819134344.27813-1-geert+renesas@glider.be>
References: <20200819134344.27813-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal Receive and Transmit Clock Delays are a common setting for
RGMII capable devices.

While these delays are typically applied by the PHY, some MACs support
configuring internal clock delay settings, too.  Hence add standardized
properties to configure this.

This is the MAC counterpart of commit 9150069bf5fc0e86 ("dt-bindings:
net: Add tx and rx internal delays"), which applies to the PHY.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v3:
  - Add Reviewed-by,

v2:
  - New.
---
 .../bindings/net/ethernet-controller.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 1c4474036d46a9dc..e9bb386066540676 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -119,6 +119,13 @@ properties:
       and is useful for determining certain configuration settings
       such as flow control thresholds.
 
+  rx-internal-delay-ps:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RGMII Receive Clock Delay defined in pico seconds.
+      This is used for controllers that have configurable RX internal delays.
+      If this property is present then the MAC applies the RX delay.
+
   sfp:
     $ref: /schemas/types.yaml#definitions/phandle
     description:
@@ -130,6 +137,13 @@ properties:
       The size of the controller\'s transmit fifo in bytes. This
       is used for components that can have configurable fifo sizes.
 
+  tx-internal-delay-ps:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RGMII Transmit Clock Delay defined in pico seconds.
+      This is used for controllers that have configurable TX internal delays.
+      If this property is present then the MAC applies the TX delay.
+
   managed:
     description:
       Specifies the PHY management type. If auto is set and fixed-link
-- 
2.17.1

