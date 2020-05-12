Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A75C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DF02492E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DmFTUbcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbgELWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731626AbgELWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4743BC061A0C;
        Tue, 12 May 2020 15:24:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so10956031wmd.0;
        Tue, 12 May 2020 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82waVPteXNHi6dIMJjBHDsDaBtBSu7S6EIvE49VbcSw=;
        b=DmFTUbcvToPTVYCRVDW43Z7IyVVLKKuT1TGww9/gk5Wh5IroV3203wAuadVGzJaPr7
         JCtrqtORsykQi4ipexGAEWp6cNhLT8vVWOxuYDBec2u6ArFBZkl+QHR5CZPYtXffwjwt
         300YUx7oOEG/xNLsqihJxLtlu/IybZhOZ+oWGhN28/+Adj0D2sAHPzwmWW7jZ0YJ74bD
         n55xLzUU0xqvNj+0+JlQPJ96nKYRytPFCYxKP/AEOqgnav3R7n4MoCJd4WdJu6rwBv77
         ffQdUzMu41HGnMtNsaVvdll/6AcmdaY5AyEGEA63mZL5q7N/ScaGAedzRhK0TqDPTrrx
         7t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82waVPteXNHi6dIMJjBHDsDaBtBSu7S6EIvE49VbcSw=;
        b=A2l+ICy2rdfZHiNDVlIB1zFawHdzddyDNQCax9vDchTl5+IwKJvwAEhIqcqrH8/9t7
         YS5oC0/JhYmBjoA9o21tdk3vUGL7wq81w787GWJkrJ7MLTbohKwFA7wsPPRufYMXHR2g
         grIUeX72bWH989B3LhYhLB4K+SzHYVLkb+x1u7dsqM8DTMB9YV2naHc+ZOHDkXvMUItD
         jyo7Fkkzzzjfx2dtk5NCQIDZdBnqKNByAlikFSDBrssO6a7YAEGKzPafQJbHQq0wRa5N
         9cOrQvDIvMdHSFmAn3TnHn+RnzfrC2BDdXqicVoj23fj8LqMIglbKjC4ix0cC5UiNU4w
         aWvg==
X-Gm-Message-State: AGi0PuZ05HL6sgV/BEnqP7YhSNYNix1T75XfHg44AW+G9ZnYfS2hOv/0
        C2YsZm2q8rmLDcWBDXiCHmvlGCT9
X-Google-Smtp-Source: APiQypKIkp1CdypfQ0uEU9JOwaNCNbhKwWqoio9mMWBOIpnVePAlV/V6DFbSxBPtHQyPfeOIwuVXdg==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr37887601wmj.3.1589322274910;
        Tue, 12 May 2020 15:24:34 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b2sm21758758wrm.30.2020.05.12.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:34 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH v2 1/6] dt-bindings: phy: meson8b-usb2: Convert to json-schema
Date:   Wed, 13 May 2020 00:24:19 +0200
Message-Id: <20200512222424.549351-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
References: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
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

Tested-by: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../phy/amlogic,meson8b-usb2-phy.yaml         | 63 +++++++++++++++++++
 .../bindings/phy/meson8b-usb2-phy.txt         | 28 ---------
 2 files changed, 63 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
new file mode 100644
index 000000000000..0bd4ce39525a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
@@ -0,0 +1,63 @@
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
+              - amlogic,meson8-usb2-phy
+              - amlogic,meson8b-usb2-phy
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
+    description:
+      Phandle to a regulator that provides power to the PHY. This
+      regulator will be managed during the PHY power on/off sequence.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
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

