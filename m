Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A061C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D3F20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+07F/U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEHVUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEHVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:20:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F1C061A0C;
        Fri,  8 May 2020 14:20:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h9so3566459wrt.0;
        Fri, 08 May 2020 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RS2ptxmKb3ffwIAhZDMnM3dCIs8tmDEdZCAAPTqFzQ8=;
        b=A+07F/U3f0MrRotSRljdPjGnVKFx9RMOeIhdLwxoO/kDHdIrz1s0HHehh9pWGlFQe/
         rSyrZqgik4cHbB14XfYyDbRNKcnZDZ8AiFrtbSlXFmT1rMv7DTvX3mC15EDt2b/cbWZu
         LzjBzrNsIP7aWHpDS57OAsbj0ziTvxhl1lf6uX58nKOXijH4q2pYAo+a66T0EtCvdiRC
         mHBsVaParRRKAMb/NBxkCEKKzs90pMABIjUGs+K/kRckc95U8udBbmo5OvACBYhY4rNK
         jyQKbL+JLlgN2aCDAhY8OG6ZpiSGz0tHAc2/Vv7P6WJ2A6RXm8miqaOMunX/1IG8EThn
         Br+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RS2ptxmKb3ffwIAhZDMnM3dCIs8tmDEdZCAAPTqFzQ8=;
        b=aGayFm4iTmXY+CNdNJNif8zNoTrj2dt4jUv4EaMxt5IBizVkRUURYl6GhzPD/dUekT
         le6iQ4LzWJGpStcPZCOqIOpIigVvWFgNs2LxTH56PZVkSndIYsS/rc3KPDRIZO0IbQ0/
         1BBIQq47lQjKuHRiK8xzapRAWNGrpcgcma9sMPPYg6+SMlR71VdDceQpg8Jat73nST20
         Ks7EEee1BOluF1WW4sJ/2R7KpqCldBejvCA0O0GUUJUxrQ47suJmKovb0qL5TUXA7mBt
         /5DruVIVuO2AUOpW6gs/n+fKlAwvwPKfn02Fw4x74Ny1GSG2k36OUQFZr058FLRjVUs7
         VhWA==
X-Gm-Message-State: AGi0PuY6VsYnalcbx/YiGhP4ywQxQyw5dxTr00yMWaVLPdV502o7CYq1
        kdt6dwsim5N1+M+aM1EPsenbiYyNskU=
X-Google-Smtp-Source: APiQypKODx2brOOBHWWSAOsBJfBScus9jb75m1v6WcD/ETNO75Cy4XAvkUe8LuDT7u4hjuSvbJN+SQ==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr4759217wrn.190.1588972801877;
        Fri, 08 May 2020 14:20:01 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n9sm4669705wrv.43.2020.05.08.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:20:01 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v8 2/5] dt-bindings: Add Broadcom STB USB support
Date:   Fri,  8 May 2020 17:19:26 -0400
Message-Id: <20200508211929.39020-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508211929.39020-1-alcooperx@gmail.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.

NOTE: The OHCI driver is not included because it uses the generic
      platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/usb/brcm,bcm7445-ehci.yaml       | 59 +++++++++++++++++++
 .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
new file mode 100644
index 000000000000..2a9acf2b5a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
@@ -0,0 +1,59 @@
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
+    const: brcm,bcm7445-ehci
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

