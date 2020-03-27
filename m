Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4947C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC12206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj858/00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgC0Urj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:47:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40367 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgC0Uri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:47:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so13121138wro.7;
        Fri, 27 Mar 2020 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mu7cNUO0odCnFqwLQLvjz/c2QxlWY0eOupuK6xxbEzc=;
        b=kj858/00LvpEwgsGkXZiBlqLBwRp3SKRyp6xt0Y5Bak5s6QahUk7IzrNmQ4wJpxZXq
         SN4UXOAnFfP92VtM46mKOw29pO+NbD+Y4kYrNZ54fXiwoIoz9/wHYGmBuZ1UlqJTie6Y
         0l0A6EhNoAfAmugWZ5A8MNKvVenn1fWNFDUcIdnY9HJYDG4lDvYR2dVuk70WaE5/4eMl
         zTTKUiRirfuimzrX+K0H8eyUekTrCCkEZMk7jIEOvNbNXpwwlDRQI3CUio/RgIeYMo6e
         h6Ve4/WTOJcyswFBpN+sNXZuqdEynilu5i6JbAgpb1A2ylUiMk4lf/ncxyG0YgfOnshD
         clVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mu7cNUO0odCnFqwLQLvjz/c2QxlWY0eOupuK6xxbEzc=;
        b=pImC6QFbQM7/PXNcOnnLy+SPX0CR/KD61C/eYgK5N0iIJ4vhMf8fCiQDyqv38lcvMA
         Xsjc+VLI5KZdctwWuh2Te5yMpJSaCX3iev4Xqnau6G1HExkXLhTMTL7erhaAHBCPsFXs
         duyNEn124INfUDB4GOmnIyyM0aOVu4x4kN5MIY8z71nZisDIKEuUJPHO5QejROLQESJJ
         gnT0Dc7d2Jm4nTFxfwBXYjXoSfh/n+m8VzxJYU4VVQFimLAOmYM/OCFQrDkdCNpg/+g6
         uiDsIp0E2cPQDR1drS8LbrHaCtkNBd+j3SyNFAr/Ec2119Jbh64HgB+0cqbzxlWkObcz
         648Q==
X-Gm-Message-State: ANhLgQ3/no8WQFWA7W7Jo9foU8GdF6yq7Ks3lURsf3Z5+qz2wLlon3Ni
        gOIN6N4wAgMmQEzFcXL9YEz3S9gnsK0=
X-Google-Smtp-Source: ADFU+vsR835CVDtze5uyJ/uO1J58tJ2qF5aBBZ2RrqWz33B0D+KEX1w/oKLFAUYF7gqoj+ifnPpyVA==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr1290873wrq.181.1585342056401;
        Fri, 27 Mar 2020 13:47:36 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z129sm9661450wmb.7.2020.03.27.13.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 13:47:35 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: Add Broadcom STB USB support
Date:   Fri, 27 Mar 2020 16:47:08 -0400
Message-Id: <20200327204711.10614-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327204711.10614-1-alcooperx@gmail.com>
References: <20200327204711.10614-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.

NOTE: The OHCI driver is not included because it uses the generic
      platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/usb/brcm,bcm7445-ehci.yaml       | 61 +++++++++++++++++++
 .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
new file mode 100644
index 000000000000..34b2f80296ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
@@ -0,0 +1,61 @@
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
+    ehci@f0b00300 {
+        compatible = "brcm,bcm7445-ehci";
+        reg = <0xf0b00300 0xa8>;
+        interrupts = <0x0 0x5a 0x0>;
+        interrupt-names = "usb0_ehci_0";
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

