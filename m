Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B983C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691A020729
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7iU+nx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGTNMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgGTNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:12:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BD6C061794;
        Mon, 20 Jul 2020 06:12:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s10so17747829wrw.12;
        Mon, 20 Jul 2020 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqgEqWWYilY633bNavPrC0sTJz/E0BBmplyUh2qxTX4=;
        b=n7iU+nx6m2JaTjSyRZxLipY4+VOyK0z9FJ21EzSa1l5XRRGslLe9mKBhf5pQvZ03aR
         TlDF8hnaC3qlu+UA8RWScCa/vJk13mTt158+VQjuwdm0JGuU3oR8aoUOQGY8ZIcTn2ua
         aQTArKxf9SCVDlglKr4SzoMheyhz11IfhIHXRnxHGAIu1qT+4BcQFQIreajbf8OtaOCp
         SeRfvskHeCuaetVAHQPPpRGdTpr4nfW6k6QsRR+tvTFifbsKgGfPtkxOPf7wNSShsf7D
         gRG2p9k653EAmS6Jwxj8ZK7avc6xBYJe/p/Pqru6BkJkS0MbuCXWO1S7/LeJtkHtl2tZ
         xdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqgEqWWYilY633bNavPrC0sTJz/E0BBmplyUh2qxTX4=;
        b=mKDwchPdy4EDAe5VbkmwrYBMEzwi/O416BlHL2jpgoTISellpBEYBwTRqZN522947l
         NmcR35zgFxhgcek+HvArK3HhVR0+zOhUG8bwsnwcdebvZ1/xDUhg4+gfzMm6skV6U77J
         gC/758ghtu+O5qxavdfSUCRgxGpy6Yxe0VyYjG3iQ/uONWmcgP7ezDqszO6hbFYBvjQo
         KCoPMsJxn0CL6ikLWZkx84CobE2FlvN68vmJRrVw4/aWP/ejsSNmQp2owbxNS9zzRcBB
         zd45oD8cP/CdZP1p/5PM/WSajorMNeDIl6o1UI+4pQL0shUv6dPR2ZVnkhyKcQoVtWaA
         /Oew==
X-Gm-Message-State: AOAM533NF2WCIW2ma1RtDvvmhl4BBVVDgfIlsxGNO1Cxd5gbhiAbR8jr
        u61QhIn3Mcp/eTtalJMH3oI=
X-Google-Smtp-Source: ABdhPJyNfds8vvKHsKQWyUI/6Vmg4+HcKyFdg4KO5sHFaK7JF2p7cBVPf6R9Z3ajU88I6EHSu9NZaw==
X-Received: by 2002:a5d:6386:: with SMTP id p6mr21968326wru.417.1595250737763;
        Mon, 20 Jul 2020 06:12:17 -0700 (PDT)
Received: from skynet.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id j24sm2725293wrb.49.2020.07.20.06.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:12:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Mon, 20 Jul 2020 15:12:08 +0200
Message-Id: <20200720131209.1236590-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720131209.1236590-1-noltari@gmail.com>
References: <20200720131209.1236590-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document BCM63xx USBH PHY bindings.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v8: no changes.
 v7: introduce changes suggested by Rob:
  - Move clock conditions to the main section.
  - Set missing additionalProperties to false.
 v6: introduce changes suggested by Rob:
  - Add another if case to device tree binding for SoCs with just 1 clock.
  - Ignored "additionalProperties: false" suggestion since it triggers a
    warning. This has been reported, but I haven't received any answer yet.
 v5: no changes.
 v4: conditionally require 1/2 clocks and fix clock/reset values.
 v3: no changes.
 v2: phy-cells changed to 1.

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
new file mode 100644
index 000000000000..9a2e779e6d38
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: BCM63xx USBH PHY
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm6318-usbh-phy
+      - brcm,bcm6328-usbh-phy
+      - brcm,bcm6358-usbh-phy
+      - brcm,bcm6362-usbh-phy
+      - brcm,bcm6368-usbh-phy
+      - brcm,bcm63268-usbh-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: usbh
+      - const: usb_ref
+
+  resets:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - "#phy-cells"
+
+if:
+  properties:
+    compatible:
+      enum:
+        - brcm,bcm6318-usbh-phy
+        - brcm,bcm6328-usbh-phy
+        - brcm,bcm6362-usbh-phy
+        - brcm,bcm63268-usbh-phy
+then:
+  properties:
+    power-domains:
+      maxItems: 1
+  required:
+    - power-domains
+else:
+  properties:
+    power-domains: false
+
+examples:
+  - |
+    usbh: usb-phy@10001700 {
+      compatible = "brcm,bcm6368-usbh-phy";
+      reg = <0x10001700 0x38>;
+      clocks = <&periph_clk 15>;
+      clock-names = "usbh";
+      resets = <&periph_rst 12>;
+      #phy-cells = <1>;
+    };
-- 
2.27.0

