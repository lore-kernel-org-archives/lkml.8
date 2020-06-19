Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E46C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A845C214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk2Jvxye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgFSIvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFSIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:51:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FEC0613EE;
        Fri, 19 Jun 2020 01:51:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t194so8357684wmt.4;
        Fri, 19 Jun 2020 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lYDT1B7WUmMqVaT2wEKNALKzv72VR3G8K7qQi7KpNc=;
        b=bk2JvxyenU4aqD+qkVUo1kyOnr4HZYghoi/oZwkhdA1oHIyoZESvA2LVi+7xdBglgJ
         m42rvCdivK25aY3PApEVHAf5iWBf8wudN99ciDen9GpDPu/6/+812uVftiOLKh1h+8gb
         zmMsYjZOh8l+jk1p+kl5G9ebet3lPF7bjlcgmyKjnpFplPQXFIW0MzP9PllONzi1iByc
         ChNlfVbpkl1XbRAexbzZOkpgoY00odPjTi8RsUOmJPQ1rJunvM0mxlbFHEXUhpdYxubj
         GgM4ptHd74XJl6ipgiRp0Go1vd6stu0h+B90SEkxlzVoog24WYRgME+5iHiyH6f+e/qY
         wTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lYDT1B7WUmMqVaT2wEKNALKzv72VR3G8K7qQi7KpNc=;
        b=BuDw7pyq3gxL7p0YOh4h6weMHkG8k1EYAKawCugS4+rT98oN1hNXE7bygvVxpgON+M
         GZKgtfOhLnCNYwl6m9GrT8FUptTEQxr9FP8PZKeGZz3hfcZh6U54MVe1qoK0eskCT3Ks
         k7Ql23YPf5rGAAj8E5YicUUZByvGpwVb507Vm2+RX/vqz9WWLp+iiA2VLqyY4jaZLgod
         gjSc133rKkrSxB1Vb1BI+VIaCtVoznlB8Cu5hCrdN/Ov+7kXv524Lyt2P2xzvuVpy7yZ
         xR+SIGnRTsCPtDP5OUxZeiqijWOlvd5/AhoEp2ubUumV+L+P2YCVpX3vXFWBA/oDcM/x
         Ahhw==
X-Gm-Message-State: AOAM5305mnk59OBK3jNZ6futKXuS2KXq1P6Q67G82iqdptzfIWtpCBmR
        3u4NYRcqfOyiPSho4514e2E=
X-Google-Smtp-Source: ABdhPJzKu4g2eBDhQtkA5czepSMMz6BLGgq2khE3gPGgX1q6t+nmren5zX6ZtXSQWmUUXG7HorRxCg==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr2684984wmb.116.1592556688888;
        Fri, 19 Jun 2020 01:51:28 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id l1sm6674331wrb.31.2020.06.19.01.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:51:28 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Fri, 19 Jun 2020 10:51:23 +0200
Message-Id: <20200619085124.4029400-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619085124.4029400-1-noltari@gmail.com>
References: <20200619085124.4029400-1-noltari@gmail.com>
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
 v4: conditionally require 1/2 clocks and fix clock/reset values
 v3: no changes
 v2: phy-cells changed to 1.

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
new file mode 100644
index 000000000000..f267da6193a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
@@ -0,0 +1,84 @@
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
+    maxItems: 1
+
+  clock-names:
+    const: usbh
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - brcm,bcm6318-usbh-phy
+            - brcm,bcm63268-usbh-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: usbh
+            - const: usb_ref
+  - if:
+      properties:
+        compatible:
+          enum:
+            - brcm,bcm6318-usbh-phy
+            - brcm,bcm6328-usbh-phy
+            - brcm,bcm6362-usbh-phy
+            - brcm,bcm63268-usbh-phy
+    then:
+      properties:
+        power-domains:
+          maxItems: 1
+      required:
+        - power-domains
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

