Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444ACC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25302206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DspHGxQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgE2SGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2SGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:06:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAE8C03E969;
        Fri, 29 May 2020 11:06:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u13so4518107wml.1;
        Fri, 29 May 2020 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upQJf5klT3BJhtYCik8Xt8ZFwpOd8Ec+MHPem0ZBw8c=;
        b=DspHGxQfaOC5kX6RIxvC1n0CE1qXRgsL4blUue2WedwR0X4NsElEG3XCCag9mBzcQl
         SoDHlqHZQhspzDo2d39Tk8dusf7LAbUo2KjrJmovrmVwFR0zVdMp+mPfJ4uN6KNOoqCq
         RlF4tIZ2BjAg8cVTd871wAQoep+io91MgCroMR7R03/Bbh1m0bmhDcsNtSCXPlkMEroT
         9rsOHe/mfn+oieHO8JQ52AzRCk02VeLf96AkXC6H87KqMhteuJw/6cFM89V5xstClfv4
         e67/ytujHYHO8XkBTNYkMKN36PBwQTDSsZENgnT6pft3mm5PbQyjIIwn0KQqJxc95uap
         qVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upQJf5klT3BJhtYCik8Xt8ZFwpOd8Ec+MHPem0ZBw8c=;
        b=BUEv85iIC5DbB5tW7ST5ULv77qZOLwkUE7JxTeSQ5MK9fQ/urpmpTJUlY2HT5doQur
         zeXhtLqdte3YDybs13cj87ZNOsuuZk+tfyKCyAcEXN4gpGa/zj1nvUYDd6o+y+FWO2Bj
         M++bUBrbr1EkhAw0kzPgDsbYOP6FB9+alz+2PCWeZDAwpd25RaGjbp5s93L8NF8Ns3+n
         ThUVVmzMOFdVx6MQIB+WYzuv/lNSHiijqtPHMOr8n3s9extNnmFTz8hcsuNZMBKpg8hH
         XD/Ap8jsNqMV2S21L2Bh35DAB6jMVpj8bLa9Shf1OVCxce2q8pbUJhoX8fLIso0IVLVi
         pf9g==
X-Gm-Message-State: AOAM5333HASH9Yz85YzAZeTqvAMbSkzyzvmIziqv3LOveJQQw/DsouV8
        pTS4xZ/flTSmlOO8m3r18Sg=
X-Google-Smtp-Source: ABdhPJxECAbSxRGc7r2e70SdPbZdEqtqwn8on6WG0NbbGyW+QD1yZ66KVZEWblueeLh61ipr8/Nl1Q==
X-Received: by 2002:a1c:a905:: with SMTP id s5mr9433945wme.120.1590775593019;
        Fri, 29 May 2020 11:06:33 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id t185sm299618wmt.28.2020.05.29.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 11:06:32 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Merge gpio-usb-b-connector with usb-connector
Date:   Fri, 29 May 2020 20:06:31 +0200
Message-Id: <20200529180631.3200680-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The binding for usb-connector is a superset of gpio-usb-b-connector. One
major difference is that gpio-usb-b-connector requires at least one of
the vbus-gpios and id-gpios properties to be specified. Merge the two
bindings by adding the compatible string combination for the GPIO USB-B
variant and an extra conditional for the required properties list to the
usb-connector.yaml file.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/connector/usb-connector.yaml     | 39 +++++++++++++++++--
 .../devicetree/bindings/usb/usb-conn-gpio.txt | 30 --------------
 2 files changed, 35 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 03b92b6f35fa..9bd52e63c935 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -15,10 +15,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - usb-a-connector
-      - usb-b-connector
-      - usb-c-connector
+    oneOf:
+      - enum:
+          - usb-a-connector
+          - usb-b-connector
+          - usb-c-connector
+
+      - items:
+          - const: gpio-usb-b-connector
+          - const: usb-b-connector
 
   label:
     description: Symbolic name for the connector.
@@ -140,6 +145,19 @@ properties:
 required:
   - compatible
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: gpio-usb-b-connector
+    then:
+      anyOf:
+        - required:
+            - vbus-gpios
+        - required:
+            - id-gpios
+
 examples:
   # Micro-USB connector with HS lines routed via controller (MUIC).
   - |
@@ -202,3 +220,16 @@ examples:
         op-sink-microwatt = <10000000>;
       };
     };
+
+  # USB connector with GPIO control lines
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+      connector {
+        compatible = "gpio-usb-b-connector", "usb-b-connector";
+        type = "micro";
+        id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
+        vbus-supply = <&usb_p0_vbus>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
deleted file mode 100644
index ec80641208a5..000000000000
--- a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-USB GPIO Based Connection Detection
-
-This is typically used to switch dual role mode from the USB ID pin connected
-to an input GPIO, and also used to enable/disable device mode from the USB
-Vbus pin connected to an input GPIO.
-
-Required properties:
-- compatible : should include "gpio-usb-b-connector" and "usb-b-connector".
-- id-gpios, vbus-gpios : input gpios, either one of them must be present,
-	and both can be present as well.
-	see connector/usb-connector.yaml
-
-Optional properties:
-- vbus-supply : can be present if needed when supports dual role mode.
-	see connector/usb-connector.yaml
-
-- Sub-nodes:
-	- port : can be present.
-		see graph.txt
-
-Example:
-
-&mtu3 {
-	connector {
-		compatible = "gpio-usb-b-connector", "usb-b-connector";
-		type = "micro";
-		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
-		vbus-supply = <&usb_p0_vbus>;
-	};
-};
-- 
2.24.1

