Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDEC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C47520731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr4itP/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgD2UIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:08:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE23AC03C1AE;
        Wed, 29 Apr 2020 13:08:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so1196880pjb.5;
        Wed, 29 Apr 2020 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQqyiz3VgaSkn1orBkc5cYQMmcAyasI8rZi9b6SsAs4=;
        b=nr4itP/RuFdoWCo2GTledzuUie+48IZRsx7pRVqJHfsFlVrNYgDAzdBAUJbT+jwhju
         Ods1yOLO/2gl4yQiV9f+mcj3D+r6Jmy9GhvHnTbd3uXqnivZJwqSysKAE6FlxVTD2r1B
         OBH9qGnjg0x+qKgp0vPbBG27yTcwfpXtHm1hzLEwtJuS2t3tR7J/GgCx9JJitE8UkhQZ
         6OEPm/Q8Sl042l4dWEnftUuiUnM19pIvQdLvEfVJtzX1WOGH8CKFNK3GAnJyc4cLNcX4
         lG2EPpkIqrQETxis8DwZBDioYM02FfRPMer/Q1sh1yzrd11Js0y7Rp3mBxavPPKJZWKD
         U9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQqyiz3VgaSkn1orBkc5cYQMmcAyasI8rZi9b6SsAs4=;
        b=Ng3AOigYeMY1QUC6iTxkVI2q31gAovwxNV5V1o6j4l3pjH4or5X6og7KU0H1faDcaL
         wSuRAY5hI29c2WBHHwOAp+Bb5ftOy7hDkiVPLsGDSnorxALD3DrlFEYi97KDs2RlkSFH
         qdOnHc2us07PhZ596qDRPKO8ipYU6Kgn6meM2WG8SGrWHReSfE16FnuCRzCo0krxjKEU
         r9Wmj60SpFEPvwf9/EUwGCSh+1+UEYyyFMuLFPUKLi8KEpDnE/VU9zEVDw/vbQvO+bLz
         PILHsHAiQwF1XxN3dwC2U9V3Zciu1V2DPWf0DoeBYmpnueXi/G6QLuTmmHOBBCL5FTkU
         RDdg==
X-Gm-Message-State: AGi0Pubn+5ZLqVhuDG+zeYTeuSBsY7anlAdsrj1CqC2a1Goq7bjKwG9E
        GwsA3OHUyIL0vdtTSvEEzgNUROBz3Qc=
X-Google-Smtp-Source: APiQypIUeeXRQbzu7qxMvdvwRfG0GMUmBGNrQJ5JcE+D4siPjAHQC+8aQkMTP7h0ZOGLjyvc7ddytw==
X-Received: by 2002:a17:902:464:: with SMTP id 91mr40290ple.261.1588190922171;
        Wed, 29 Apr 2020 13:08:42 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z23sm1638957pfr.136.2020.04.29.13.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:08:41 -0700 (PDT)
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
Subject: [PATCH v5 1/4] dt-bindings: Add Broadcom STB USB support
Date:   Wed, 29 Apr 2020 16:08:23 -0400
Message-Id: <20200429200826.20177-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429200826.20177-1-alcooperx@gmail.com>
References: <20200429200826.20177-1-alcooperx@gmail.com>
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

