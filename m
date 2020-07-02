Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE14C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A1621707
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGBV3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:29:00 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49661 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgGBV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:28:58 -0400
Received: from [88.147.89.201] (port=34632 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jr6lL-000AXd-46; Thu, 02 Jul 2020 23:28:55 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 4/5] dt-bindings: clk: versaclock5: add output drive mode property
Date:   Thu,  2 Jul 2020 23:28:35 +0200
Message-Id: <20200702212837.10657-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702212837.10657-1-luca@lucaceresoli.net>
References: <20200702212837.10657-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node with properties for each output port, and a property inside it
to describe the output drive mode.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 .../bindings/clock/idt,versaclock5.yaml       | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index d8b8e35f16d2..f0ee612f573b 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -50,6 +50,35 @@ properties:
   '#clock-cells':
     const: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^out@[1-4]$":
+    type: object
+    description:
+      Description of one of the outputs (OUT1..OUT4).
+    properties:
+      idt,drive-mode:
+        description:
+          The output drive mode. See "Clock1 Output Configuration" in the
+          Versaclock 5/6/6E Family Register Description and Programming
+          Guide.
+          Allowed values are:-
+            * 0 = LVPECL
+            * 1 = CMOS
+            * 2 = HCSL33
+            * 3 = LVDS
+            * 4 = CMOS2
+            * 5 = CMOSD
+            * 6 = HCSL25
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 6
+
 required:
   - compatible
   - reg
@@ -107,6 +136,19 @@ examples:
             /* Connect XIN input to 25MHz reference */
             clocks = <&ref25m>;
             clock-names = "xin";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            out@1 {
+                reg = <1>; /* OUT1 */
+                idt,drive-mode = <5>; /* CMOSD */
+            };
+
+            out@4 {
+                reg = <4>; /* OUT4 */
+                idt,drive-mode = <3>; /* LVDS */
+            };
         };
     };
 
-- 
2.27.0

