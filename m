Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F65AC5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D4B20752
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhJNuSGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCMOQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:16:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33615 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCMOQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:16:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so12323246wrd.0;
        Fri, 13 Mar 2020 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0geItnR1hP77wUFBV2Yc0AfuV9aOuFucx1z+d3zMZmA=;
        b=NhJNuSGh3aeUVHWb8I5+1v8F6hpJ820KgXzZRWXUkyFhdPaskoGMldtvlGR0Ob6qTS
         NEmrVMV+RYx8FFiLoE9i4n71jDeUefLr/d9RKqKQbJkRk12YoKmKRDsROv/BLWYq5ljM
         kMkvyhzm10Ll4muq6YKBIvVcNESK1s0aERipIKLGamoIMVPASeHQVO3/veCl3x+Xgm4e
         Np1/VL8EYmVQU3zX0sXV/wv7giAnNTYQYc8DKjDwIEMbewBfGDDDKdwd2J0kahRJLoDh
         j3AlELAXdArbY897E4d/cVqokpTLtNnA1fCCVhKMqI53MFEPVaTyYZw+UFUdmnJpBsKC
         H84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0geItnR1hP77wUFBV2Yc0AfuV9aOuFucx1z+d3zMZmA=;
        b=HQM/KGP4LlGjjGcWI2wSnDH+r+EdySouzyAtYwy3nGJfvJlw6tL/QHSRPRf4vm9s9h
         lG9yyEk88OgUYrNnKDAcSYUkL9lGGLeFvE/pzG+TUEW3GBzvBKuMiIflaTAfI2JpJmsP
         tywtAcgopmFipu/ZPuC6yvKfxUol4SxQhBl6RAoF94eXUcAHmToKfeXN/YgWFmDDVL4G
         55J0DAPa7ZWUg1aCD/YJQn4EdK5bFg2z1EaKJbtljA1KMkUU4d7s3Ux1r7kFkI9NjFn9
         WQBjdvqb5ykyyhj7rpXpow85K6AHPlXaFgy7FwUSfHPmfhK8P+IFWPygt3yipotY4dNd
         X1qQ==
X-Gm-Message-State: ANhLgQ3WEtLPmERWqkeaXAnp/lmZmWoZ2/K03PbFoQQNv2Wlt819FwwP
        hxTCOYXrUjkaLvxSmmhD4R0Q5idvPSc=
X-Google-Smtp-Source: ADFU+vttxcsLA1395SwhltsZMXRdZLBZdeW5S0lXEEqmoBV8/b61sqNbDZFP2BZQupHpawQhmENmMw==
X-Received: by 2002:a5d:4406:: with SMTP id z6mr18164979wrq.68.1584108983406;
        Fri, 13 Mar 2020 07:16:23 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id l83sm17561422wmf.43.2020.03.13.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:16:22 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/4] dt-bindings: Add Broadcom STB USB support
Date:   Fri, 13 Mar 2020 10:15:42 -0400
Message-Id: <20200313141545.31943-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313141545.31943-1-alcooperx@gmail.com>
References: <20200313141545.31943-1-alcooperx@gmail.com>
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
index 000000000000..ad570ca4ca6d
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
+    ehci@f0b00300 {
+        compatible = "brcm,bcm7445-ehci";
+        reg = <0xf0b00300 0xa8>;
+        interrupts = <0x0 0x5a 0x0>;
+        interrupt-names = "usb0_ehci_0";
+        phys = <&usbphy_0 0x0>;
+        phy-names = "usbphy"
+        clocks = <&usb20>;
+        clock-names = "sw_usb"
+    };
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

