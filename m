Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BCDC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A912137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oQM9HI5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgEBLsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgEBLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:48:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA0C061A0C;
        Sat,  2 May 2020 04:48:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so9853801wra.7;
        Sat, 02 May 2020 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98yd6/MjdfkYVYK6lpue8l8KyVR5I9cjkaTH2AGGuE8=;
        b=oQM9HI5YKF9AIc22557RWgfMXw189lprQTDWh3/TkJNwafueJi6rEJ+MLbh1sCtDEu
         fwTxkLF9lABWq8K74S8CepWTreXt46oNYy0lTL7yxXCTGXvQeZFZVWjij+rD6uIJ1yt1
         qcnY8JljC4/tTbDqXNVA9riGb0b40m9NuuwinG9pk+cekjW5lXzAg6MQUX0o7oD9qTGz
         Y0nTLoAPSST6/0pYZWxMBxUnz1ORSlyPx72hZEI6IF/XfzvYNbPBwyt02yA++1YkZ1VE
         J2/UECV/BR0GA/ONA/s2yZfDSK4dQRqYkipAgYEwiPhFk98jVs1uZmzFapjZaSnIhJWi
         5plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98yd6/MjdfkYVYK6lpue8l8KyVR5I9cjkaTH2AGGuE8=;
        b=Jz23tzss6as1jbkf122iPgrSUKwOI7r8dIDOy0b+bV/UKk56qt4qm2I4x16ulpcZbn
         pG1aalFzCBMJ4Vuei/NS8wmOUcvDTCZqnUUNZGaTcJqkYWVsnaXU8455Mg47Mtb2lg3n
         JgF9XFSQNCt31d7rico1BvjBsZ9+4evj32Z/5xKEfCSiRYy2sE6ucV0YeK6PBnsP4iJ3
         IhKUc5q8kZceHxfZiNKeGYCwur3LGDr47NIvTd1edVMx712chNCRYh14W7xwxbcq25TS
         2tzUaIuKGmXddUCDLxSHH7/3YBkG4biI0CbwqAhXNN5r+KXEvkLoBjQtYMze+472W+0F
         PAnA==
X-Gm-Message-State: AGi0PuYbKm1cZ70MzcXrKiROYfEcpi+r+KXLFISBQCfcq+6v1QmQjzuj
        2rcd0DrfKUgxK9FhWI20oZ0Eqq6puYM=
X-Google-Smtp-Source: APiQypJ3RKI2IzGlwLZ8NrXLuXmn30ZOcihVHHIUbuZVhRB7GmZNx7D/xwkixVXqUaM0DMb0w2/3FQ==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr8668993wrw.309.1588420108230;
        Sat, 02 May 2020 04:48:28 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s17sm3801599wmc.48.2020.05.02.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:48:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/6] dt-bindings: phy: meson8b-usb2: Convert to json-schema
Date:   Sat,  2 May 2020 13:47:47 +0200
Message-Id: <20200502114752.1048500-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the DT validation in place, let's convert the device
tree bindings for the Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2
PHY over to a YAML schema.

While here, also add the fallback compatible string
"amlogic,meson-gxbb-usb2-phy" which is already used in
arch/arm/boot/dts/meson{,8,8b}.dtsi.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../phy/amlogic,meson8b-usb2-phy.yaml         | 61 +++++++++++++++++++
 .../bindings/phy/meson8b-usb2-phy.txt         | 28 ---------
 2 files changed, 61 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
new file mode 100644
index 000000000000..c2fe8c08d99e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+            - amlogic,meson8-usb2-phy
+            - amlogic,meson8b-usb2-phy
+          - const: amlogic,meson-mx-usb2-phy
+      - const: amlogic,meson-gxbb-usb2-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: usb_general
+      - const: usb
+
+  resets:
+    minItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  phy-supply:
+     description:
+       Phandle to a regulator that provides power to the PHY. This
+       regulator will be managed during the PHY power on/off sequence.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+examples:
+  - |
+    usb-phy@c0000000 {
+      compatible = "amlogic,meson-gxbb-usb2-phy";
+      reg = <0xc0000000 0x20>;
+      resets = <&reset_usb_phy>;
+      clocks = <&clk_usb_general>, <&reset_usb>;
+      clock-names = "usb_general", "usb";
+      phy-supply = <&usb_vbus>;
+      #phy-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
deleted file mode 100644
index d81d73aea608..000000000000
--- a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Amlogic Meson8, Meson8b and GXBB USB2 PHY
-
-Required properties:
-- compatible:	Depending on the platform this should be one of:
-	"amlogic,meson8-usb2-phy"
-	"amlogic,meson8b-usb2-phy"
-	"amlogic,meson-gxbb-usb2-phy"
-- reg:		The base address and length of the registers
-- #phys-cells:	should be 0 (see phy-bindings.txt in this directory)
-- clocks:	phandle and clock identifier for the phy clocks
-- clock-names:	"usb_general" and "usb"
-
-Optional properties:
-- resets:	reference to the reset controller
-- phy-supply:	see phy-bindings.txt in this directory
-
-
-Example:
-
-usb0_phy: usb-phy@c0000000 {
-	compatible = "amlogic,meson-gxbb-usb2-phy";
-	#phy-cells = <0>;
-	reg = <0x0 0xc0000000 0x0 0x20>;
-	resets = <&reset RESET_USB_OTG>;
-	clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB0>;
-	clock-names = "usb_general", "usb";
-	phy-supply = <&usb_vbus>;
-};
-- 
2.26.2

