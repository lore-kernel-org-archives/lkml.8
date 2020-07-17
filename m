Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47EEC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8100A2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOYb1JFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGQJsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:48:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D030C061755;
        Fri, 17 Jul 2020 02:48:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f139so16198239wmf.5;
        Fri, 17 Jul 2020 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJHS8T5ZP2Us9EXEt6XxFRJxlnk3VVbmaR5Q3Oo60x8=;
        b=aOYb1JFd2yogObdkyXUchErAXi5VB9NnpQuQ2rtLzbN1wzP2VhlKzTKZbp331X6bJj
         WP2sOpJEn09pIgeRa3CyfvgVRrN8L5HJdr4/A4B43GoLoNp8S58ml802ulaBhEnSRB2E
         9gEz2h/j3alhsm/HFKwCi1KJ4Vg5FPUbwFT5gwSEo77rmygzxyqGftkGbHOKH5lvrm+3
         t4dRYhAnNwcjffT44PvfxGUQwNcPnjZP/LvoZpy2KjcBIkk4LEukLPvwDdEJwB7zPzcX
         SVnVawifeQIvcqTjT5ugx29DGCkUROyXe6C7vycWtvj10QONvl26/RoQ7atit5OFvZ55
         v8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJHS8T5ZP2Us9EXEt6XxFRJxlnk3VVbmaR5Q3Oo60x8=;
        b=gxmSZkW9J5XVvwBTcQH5TfzBaMMyQN47/6C9ngqr5u95utwDlGQrlvRZYRdmvPivSx
         08QN/+BLlclYW/3gvJexLDvhDB6Xv473PxlkyoPriQyd7NfJZhnNYUYD1B01O62c3LEK
         l/I0EjWGtCbzlf2wKv5L18/qFj14EC6wtBiXVcoju8+2p05yzOr47jusZxqUo7B3Y9o5
         eMTKxC4G4yVdRXq2gDNYftsNDI+I5KRQglYWlRWcf87fehSuddzZi8RJLPdXT20v+VcC
         +Qd85Lm/WhWj9LBi7/yWC4qhYE5xyiPe0RFVsFapx3o7qRJJguRuAGSMxEIQJlpJOGni
         TnGA==
X-Gm-Message-State: AOAM530xotOUCz1jDbRLWg0h8VTGgLJ/663YINN/8c99pF+hsNTxbM7y
        CS/8/TvZo6iaTdyOED48ap0=
X-Google-Smtp-Source: ABdhPJym9dnBeZJ3gArJttolSms+B15ZRoROE1ouB/8XsgJFUM/HjsNQvyEFdHz4ynLV7eDyhjMJ3A==
X-Received: by 2002:a1c:80c8:: with SMTP id b191mr8012978wmd.37.1594979288689;
        Fri, 17 Jul 2020 02:48:08 -0700 (PDT)
Received: from skynet.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id u84sm12816587wmg.7.2020.07.17.02.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 02:48:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     simon@octiron.net, simon@arlott.org, jonas.gorski@gmail.com,
        kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        p.zabel@pengutronix.de, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v7 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Fri, 17 Jul 2020 11:47:55 +0200
Message-Id: <20200717094756.9951-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717094756.9951-1-noltari@gmail.com>
References: <20200717094756.9951-1-noltari@gmail.com>
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

