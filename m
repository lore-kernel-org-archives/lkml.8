Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEC8C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D0B20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="jWuvWWHI";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="jWuvWWHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgEFTYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:24:08 -0400
Received: from node.akkea.ca ([192.155.83.177]:50628 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgEFTYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:24:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 65B5E4E200C;
        Wed,  6 May 2020 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588792706; bh=LHoulxi1vTiKQKmc4GVw+S12/3VEaL+Jud01OzrChlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jWuvWWHIIGzaT0qvMjH/2HdacRQlCU0aGAG3XWwW4cC60lZxoTlmwGxrn0ZDYwV2f
         rS2MsrMBebv8GOjo/h4OSTiZiQXut5VIQPQWWeWxiiUrOmc/XsQUlxlrFSl5K2pGya
         awNKgKrogmqhKocm7IvPTKvvbJfxeKqdOnW9b0I8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 410gAoNv7bRR; Wed,  6 May 2020 19:18:26 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id BFB5E4E2003;
        Wed,  6 May 2020 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588792706; bh=LHoulxi1vTiKQKmc4GVw+S12/3VEaL+Jud01OzrChlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jWuvWWHIIGzaT0qvMjH/2HdacRQlCU0aGAG3XWwW4cC60lZxoTlmwGxrn0ZDYwV2f
         rS2MsrMBebv8GOjo/h4OSTiZiQXut5VIQPQWWeWxiiUrOmc/XsQUlxlrFSl5K2pGya
         awNKgKrogmqhKocm7IvPTKvvbJfxeKqdOnW9b0I8=
From:   Angus Ainslie <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: usb: ti,tps6598x: add dt binding doc
Date:   Wed,  6 May 2020 12:17:18 -0700
Message-Id: <20200506191718.2144752-3-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200506191718.2144752-1-angus@akkea.ca>
References: <20200506191718.2144752-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the tps6598x driver

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 .../devicetree/bindings/usb/ti,tps6598x.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
new file mode 100644
index 000000000000..925db38aaf84
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,tps6598x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI tps6598x driver
+
+maintainers:
+  -
+
+properties:
+  $nodename:
+    pattern: '^usb-pd@.*'
+
+  compatible:
+    oneOf:
+      - enum:
+        - ti,tps6598x
+      - items:
+        - const: ti,tps6598x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    typec_pd: usb-pd@3f {
+      compatible = "ti,tps6598x";
+      reg = <0x3f>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_typec>, <&pinctrl_tcpc>;
+      interrupt-parent = <&gpio1>;
+      interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+
+      connector {
+        compatible = "usb-c-connector";
+        label = "USB-C";
+        data-role = "dual";
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            usb_con_hs: endpoint {
+              remote-endpoint = <&typec_hs>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            usb_con_ss: endpoint {
+              remote-endpoint = <&typec_ss>;
+            };
+          };
+        };
+      };
+    };
-- 
2.25.1

