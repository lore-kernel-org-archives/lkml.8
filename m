Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604A7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DDF8208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGmDqbcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgD2Rbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Rbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:31:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D39C03C1AE;
        Wed, 29 Apr 2020 10:31:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so3527957wrb.8;
        Wed, 29 Apr 2020 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQqyiz3VgaSkn1orBkc5cYQMmcAyasI8rZi9b6SsAs4=;
        b=iGmDqbcCdUM4/oWQteb7EnZKNc4+48gf8xUxyYVGo3TnmH2aD0JS4wqeYNBziFwmwz
         GS5HInIahI7uiczakMz9KITiJdoGCRjSbUXSGqxWKOcFYhkHJAtytjDrMoS0OeF1YrKE
         A/WHmSmYNt6mPfO+tVxTO3GyCbYed9RJ+6quGhTNegERcyMzmfbmX3tbshkusTJY9mXB
         1P7K2bIllGcy1fBzG5RRPKVf1pSlhtWSgSvXwnuzE/t1QOruMG2KDphEexc+EmnberTR
         FQF0JqY1iD069jekWxSp5jiXGCJjz85Pj5O0urydo/5ot8JWbAirQWvqYAgDJGaqzcea
         +fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQqyiz3VgaSkn1orBkc5cYQMmcAyasI8rZi9b6SsAs4=;
        b=Atyl8noxp6jWPhQbTJ5RX54VHEoTAMe2KTd7yW8W5KPjg3Uq3+e1SJlfE7aeBcbBta
         5lZ1oXKuX/Sfz9SQyuY12k+/DBOKfcL45PwZ72b8Zgz6cNHqasOF1V98nW7RLH5eKD0x
         NYcTylyCqkoLMarDh1b2VXSVhJzGjnmjGa/+nr6I7+mDFbli9xCg9SPg5sOn2S8oV80K
         i81eczm/WurTEl5cnLDO/sTxy1GdJVlnvjWBjkCMN3IWmM1L4DV9xwL1vUSSwHH12nfe
         Ine7mfan63lieYgRL71ICX2X7f7270ORnWOuS93vNSszEaLzYCVSSqXBkfM+49X3pF0F
         tSiA==
X-Gm-Message-State: AGi0PuaIZBWjJEeI1tL1bGGzyVqtmm5evNUHguMXeSFSmcKdtN1XyT6m
        mHiGwodh/SKccwYCtlyKYkG7XJoxrs8=
X-Google-Smtp-Source: APiQypLAksD45L/G/YUyVOhmOPxjz9zEhRrYXc0wmfc6UxxJMMdmNiSfKO7B8XCmZAcz3kNCXV8dGQ==
X-Received: by 2002:adf:f58e:: with SMTP id f14mr39298005wro.79.1588181494446;
        Wed, 29 Apr 2020 10:31:34 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j11sm31177182wrr.62.2020.04.29.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:31:33 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/4] dt-bindings: Add Broadcom STB USB support
Date:   Wed, 29 Apr 2020 13:31:09 -0400
Message-Id: <20200429173112.38366-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429173112.38366-1-alcooperx@gmail.com>
References: <20200429173112.38366-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.

NOTE: The OHCI driver is not included because it uses the generic
      platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/usb/brcm,bcm7445-ehci.yaml       | 60 +++++++++++++++++++
 .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
new file mode 100644
index 000000000000..7c67f7dd7a67
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/brcm,bcm7445-ehci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom STB USB EHCI Controller Device Tree Bindings
+
+allOf:
+  - $ref: "usb-hcd.yaml"
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+
+properties:
+  compatible:
+    contains:
+      const: brcm,bcm7445-ehci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: Clock specifier for the EHCI clock
+
+  clock-names:
+    const: sw_usb
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usbphy
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - phys
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    usb@f0b00300 {
+        compatible = "brcm,bcm7445-ehci";
+        reg = <0xf0b00300 0xa8>;
+        interrupts = <0x0 0x5a 0x0>;
+        phys = <&usbphy_0 0x0>;
+        phy-names = "usbphy";
+        clocks = <&usb20>;
+        clock-names = "sw_usb";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index dc025f126d71..23e89d798b1b 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -24,6 +24,7 @@ Required properties:
       device
     - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 or RZ/G2 compatible
       device
+    - "brcm,bcm7445-xhci" for Broadcom STB SoCs with XHCI
     - "xhci-platform" (deprecated)
 
     When compatible with the generic version, nodes must list the
-- 
2.17.1

