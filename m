Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4214C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA85C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDv5Z/iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgFPSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFPSpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:45:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10871C061573;
        Tue, 16 Jun 2020 11:45:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t194so4154847wmt.4;
        Tue, 16 Jun 2020 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMgA4YJ/qbECneRtetKCJmuDx4PxuOukQg7g/2crGKA=;
        b=XDv5Z/iYeTJ6vRnmkeD73r2vASjq0XQ/6aeW2+c0/m/WzbCOV+S8g5ya9ksurkHCOf
         umKx4XwA/E7X5+6KsaHSkP7cBcuEX+lt1nyPjIXpxcJ/QzKscKXzV86IBf3bQqnwMG/t
         2RDMj+XIREq17ukVHhccGr41OGFquevUfoJuP3JnGtM0VHFoTyOny3Md8Wr8at8/NEDV
         tkvKryTUGBIAtt0vpUSB2Pb2t9EDDSnd54YgWrAZ0qh1RT+CgLR3sXHZAlevSAJqsH/R
         eCSGwaozu0d6o1zphS2Bs6rrNa6QZ/kjYYzKx9tU/3kLy1E4E2mAYmWw2Lg3u4ngL4Pr
         afEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMgA4YJ/qbECneRtetKCJmuDx4PxuOukQg7g/2crGKA=;
        b=lC10olBWS8LEt/A+jlJfCAqQf9+PRU+yVZt9KjfX+pboZTiDieQdt625LlGpUXH9lN
         hekhqv36tfaDFOxaEDkXQ62ZDGWz1pqBLuaGxV9Z/GvEdZdDxTagQ6aNT6FV03WxzTTy
         0HOVe0Am+532LaUQtdyLQrJ8dSPQrIjO6Zx1ZPSqZZ2DYIbAG8UI1FEGPKMD9iJ3u/Sm
         sAVyyqZmePnS9NmNUW0i3Vj/Yi6UJ6CpArvMWlMV0EQaILlG2hPQNinMrS+PTpleChHu
         0fJy6cJgXc2FNVLUmR3qmGo+7eHmH9QfZolPerwfyfM84ORFLUR9xDObviW0rKH9ccXz
         5+Mw==
X-Gm-Message-State: AOAM531FTfq4rgdruA6nyCIDNI40XgaNUwLFaV/3GKc6LJYdovks8jm8
        6qMW3ROseYVyTbZL9zPh3kg=
X-Google-Smtp-Source: ABdhPJyyzLEab3tlZohjF60/d333MbM6aVxfC5uG4JauZWjsw2Da5X6n3CGsGR33Txl0YsoWhijvvA==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr4858240wme.13.1592333145726;
        Tue, 16 Jun 2020 11:45:45 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id q11sm30528707wrv.67.2020.06.16.11.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:45:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Tue, 16 Jun 2020 20:45:41 +0200
Message-Id: <20200616184542.3504965-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616184542.3504965-1-noltari@gmail.com>
References: <20200616184542.3504965-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document BCM63xx USBH PHY bindings.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: no changes
 v2: phy-cells changed to 1.

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
new file mode 100644
index 000000000000..9ef2c1f8aa00
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
@@ -0,0 +1,72 @@
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
+    maxItems: 2
+
+  clock-names:
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
+
+then:
+  properties:
+    power-domains:
+      maxItems: 1
+  required:
+    - power-domains
+
+examples:
+  - |
+    usbh: usb-phy@10001700 {
+      compatible = "brcm,bcm6368-usbh-phy";
+      reg = <0x10001700 0x38>;
+      clocks = <&periph_clk BCM6368_CLK_USBH>;
+      clock-names = "usbh";
+      resets = <&periph_rst BCM6368_RST_USBH>;
+      #phy-cells = <1>;
+    };
-- 
2.27.0

