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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83818C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BE4206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itgve5ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgELPAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:00:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD5AC061A0C;
        Tue, 12 May 2020 08:00:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so5490903pls.8;
        Tue, 12 May 2020 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+pB3oMe25IMIw8jJ+MHFKICt1gmdUo4L1q7+Hkox1M=;
        b=itgve5ezxyPf3+uzliBLqYsH88+nQf5slgfOno9VLMm1zpNqP9ip7qJRO1tBi8jYb9
         7acpJyxXoBdsK25SM3C++Kf5Z5Cw9Hn8lSKBEg7nb8R9OrahI2fLeC4S7Cz1xeRX2Gt5
         ui/H6pI+rGTXzg/5eO9UbPRiRAFaF0cj84leoZistRurI9GXTRgi3viREoCStq6XKyCs
         uOQH/TdfzPR3W10nLK8vVf3Ah78okForIQivOTqlsZZUx9sFbgbLethvbyewOAVaQGye
         b9pvz8FC7g/1nYhX65HN4AtHchYvtMo/0rmA8U1sBvFbiD8Duyl1H6hqZi6BaSYc19Mq
         FeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+pB3oMe25IMIw8jJ+MHFKICt1gmdUo4L1q7+Hkox1M=;
        b=Rc36unXl2+mjDjs/eedJaQQbpN0i1np6c65pk+5ZIYkeI5ig7lm5XuSSlV7iraNN8G
         G/wjxLj80cQF3VnnEizyPrLvJiisVgLZ+BDxIEM/uZndaWBk4JXMzIjqBLUwR+kx6rh0
         wnm+okvQY0NrcVcCZ1kHUPxEcmvYh1wbZudSJaOMecTTyD+O4W+3mctDb9yhbyuiiFfr
         bG7UnxFI5wv0Hs3j4Xik+ZuISTW2Qn/McFUZ64vhvt4CQfrQAIo96O8LNvfqx1iMghG2
         5lG26xrBMdxG1jGYJipDkBVPJpULHHQKU7fZXbOA66cohGRTPTa1PJfjjZEtpWEgAAHO
         Ro0A==
X-Gm-Message-State: AGi0PubMF+zJDhRysIv2x4gDhT0xUGQwsq7Sz4spJQpATH6O0IsaNZzb
        hski65yZKInQ2J4RBPLhLqFAde8ZGic=
X-Google-Smtp-Source: APiQypJF1FFW4qiA92iDWOKPABM8OA836an6X7QEuseK4kD0KfrVhuEYx1bG0GZ4mCR/KqiZi2m+6w==
X-Received: by 2002:a17:90b:30cb:: with SMTP id hi11mr29133243pjb.103.1589295643608;
        Tue, 12 May 2020 08:00:43 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c2sm8359779pgj.93.2020.05.12.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:00:43 -0700 (PDT)
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
Subject: [PATCH v10 2/5] dt-bindings: Add Broadcom STB USB support
Date:   Tue, 12 May 2020 11:00:16 -0400
Message-Id: <20200512150019.25903-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512150019.25903-1-alcooperx@gmail.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
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

