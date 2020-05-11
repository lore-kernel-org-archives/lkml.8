Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722ACC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5659420720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f55WxTes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgEKThN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731515AbgEKThI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:37:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC43C061A0C;
        Mon, 11 May 2020 12:37:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so12435295wrp.12;
        Mon, 11 May 2020 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+pB3oMe25IMIw8jJ+MHFKICt1gmdUo4L1q7+Hkox1M=;
        b=f55WxTesSj+bfKKc8i71FmJVjwL3YRlb+ELkkSdM6L4FPD+UL08kWc4ajLyqDlA+9l
         YXtLi08023b40i5I6n7gNowgVTT2RI/gT/Ez2J7m6oS5kCACgxyClk56HTf+Qz6mzLz1
         dh2xNOqY9lM/97+EAhIN36REB122l2nUhNJfi1NXrYHDHFgV7yB+DbXGsCZd9DG3unvX
         dr8/DC9NGjb5eSzsqXDFFntjqdUqtHqgrs4ed76gGKW4t0toqYrf4xKOF7vCDT8lZFWk
         1BPDuxb/6Z05ulGgZZ5mQ4OefP27hOE4tMvEyUTPx0z50lJZfTJHO2YfUKrKvXhrb096
         IwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+pB3oMe25IMIw8jJ+MHFKICt1gmdUo4L1q7+Hkox1M=;
        b=EjWZndItJgnGBQFm5qfWw4TL1eNHVn4OwzN7uWlrWN0eZPR/huGiUheWItrbK8tqpC
         9NjtN+FfCH5ojqNZlnHyBJfmNViIrGcZ//RPFp8cfpA97vC6HmV1i7qBEA/Ub3gWFxRR
         FpK+NxKpKx14rCuAO9eet/0aoyoc9zculrirGLvu+RetsIDtBtwkIQpGaeXNaKgj68Mk
         oA0L4lt2LrycoLytkRJsVqWizTs62dgSz92GPavBZnPUSWDD8jqnCIwX/a248Wvbem14
         RhbpkMvYG+TX5+eKW+FXQUnP8wufuVZoa2M7tXMGt1MSM8EMs97zmRDf/xEts9WeYm5f
         kwJw==
X-Gm-Message-State: AGi0PuY3nf73NIeMrlQZChqVucS+dYracXTflnPU19Qx2ni7l/X1IraI
        Q7WCMTXFUeVA7Fsj1OYEeCnRitqMLsI=
X-Google-Smtp-Source: APiQypIr4p1YXRpkmy6nIepPvSMiLmv+h9BwVQPUgO7zS+VoEHxqtpW+7nPxoLsw4MPyAX1EUQRA9A==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr8816343wrx.133.1589225826789;
        Mon, 11 May 2020 12:37:06 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o203sm11529030wme.12.2020.05.11.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:37:06 -0700 (PDT)
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
Subject: [PATCH v9 2/5] dt-bindings: Add Broadcom STB USB support
Date:   Mon, 11 May 2020 15:36:40 -0400
Message-Id: <20200511193643.30926-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511193643.30926-1-alcooperx@gmail.com>
References: <20200511193643.30926-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.

NOTE: The OHCI driver is not included because it uses the generic
      platform driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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

