Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E3C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0983D20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYxzKsPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgDHSOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:14:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34060 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgDHSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:14:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id c195so599741wme.1;
        Wed, 08 Apr 2020 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0e196N9NUbdplitpkQkJfpaeN0+6myfhv6YB2DCo4aQ=;
        b=RYxzKsPQI0RrSAlJMp+GdU5mQkQ515lCzrbilXZebOZZ81KBIP+RPpHEwvmpQN1j02
         9QwON2l829ZghxUN4/8UZupk/XnJSQk+wwVpvqqObWNEJEFjxI62PYlHbLr5FMLKcM6Y
         NfZQ4+N9fk9oFDXeiQbJ8y1whumB/twb6A53Hes8WImrtek57vrkUaeUJ5PABEoHJZPQ
         UecRhJCEgM/Ny2KVRstNF9P49VV9g6ogA5pVFr3Ure2TIpqh4H1D34oKSh1BHViUlAyj
         1KldDhDtAzf/dbV7O3kGl/6RcCJe77SE14kgnhQGCJ3MGTpobV1AYt1DG8P3zXY3L13X
         4ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0e196N9NUbdplitpkQkJfpaeN0+6myfhv6YB2DCo4aQ=;
        b=gr74rZ1Udm0DoNwFnyzLdB+Fx7wOX/2FVZ8yafqGyt46UfZAzh5Vy8h0S814A9Ri98
         V9OW912w4C5PA+rNfXurThLd8FFl2y7xGEjJeNuoXbub0y6C1/0YLYtjctCzyvFGCa3i
         wFU5N2EF0m7tMNfCDVgW1nSiOKfyfzjFKTZhToVSmDsQCgvQiVCqSZdNAVbNCjh3duIW
         +fh+r4drznaPQH2vUexUuiW2vyZoFm+dNgyWhQhy9v05jIyt3tBw2ee9/aBsFnoGWgvo
         HHKDd+H2eGnCAzpWhA6DiBiyTpHLV2kkIHgvzpoHSDU2zWDJM5eEVGWsXYjMUObJTvUR
         OKcQ==
X-Gm-Message-State: AGi0PuYvUaHc+HK6PmPwHJCQx4AWxRO79BvxLtFtGNhfvEW0AYXJ2rNM
        ahb+86qVpJWBalCwuRMxsVKuXa7I0P0=
X-Google-Smtp-Source: APiQypKBQwVsS3bbac+5OD6W9QbH392+bZKgqRHQHXfHvlbW1SBXLgYLVv355wcVgm+pbDQ34mSuAw==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr5718681wma.24.1586369683082;
        Wed, 08 Apr 2020 11:14:43 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n124sm441700wma.11.2020.04.08.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:14:42 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/4] dt-bindings: Add Broadcom STB USB support
Date:   Wed,  8 Apr 2020 14:14:03 -0400
Message-Id: <20200408181406.40389-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408181406.40389-1-alcooperx@gmail.com>
References: <20200408181406.40389-1-alcooperx@gmail.com>
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
index 000000000000..d41710574b5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    description: PHY specifier for the USB PHY
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
index 3f378951d624..aafc316b5a8e 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -23,6 +23,7 @@ Required properties:
       device
     - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 or RZ/G2 compatible
       device
+    - "brcm,bcm7445-xhci" for Broadcom STB SoCs with XHCI
     - "xhci-platform" (deprecated)
 
     When compatible with the generic version, nodes must list the
-- 
2.17.1

