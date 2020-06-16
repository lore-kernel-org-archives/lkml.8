Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADBAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB425208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwb3A+Az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgFPSSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFPSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:18:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C5C061573;
        Tue, 16 Jun 2020 11:18:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l10so21742277wrr.10;
        Tue, 16 Jun 2020 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8b9w5Bl2hRduQlm5Ms5q2rrQhAAPM6If/ziLRYU2pNA=;
        b=gwb3A+Az/M8/mSOMrobEndzEbDF9O6nZjaLrtPnL9ccc1tEDKZ4zoR/xI915JKDohZ
         nREap0BDMicV5GOHBYJQlC1KOgibyM+7Jo0dGStow2l0leuYM8Xx/oOeEh2rXw6eDgpa
         JiatzvrM/nSq6+J/+nSISzW0MPTsk0UjIJOQiufJNWojjwGW8+sMdzguhjSGX12TV+hA
         UGt5b9CG88h6eTxy4mzTGCspeESYLxq+J5MpSdVEaBu/PP6sQRs3sncrvd3BVmYroBri
         d4egmK76kwdzXQmypBXv0fPjzY8LUSkY+1iBU23PIoCl3zKAs893GOEyCycaju4d5Sn0
         SNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8b9w5Bl2hRduQlm5Ms5q2rrQhAAPM6If/ziLRYU2pNA=;
        b=Rf8ZOkBx8qXCwHFGhe+jN8j5hEJGdZnfPACpMKUaxIrT4GApipS2LER690so37fHGg
         yrQnEUm/pmhlYoIB/XchmYS1Lm9pW1fRLH/qLKlOE3XnSn5+bi3BmNVjlZfxyXwA6/HI
         OVnoWLaRVAm4wi8pqQMn5Kxc4fhvIUoYMbyK+YpXDNXyfqwUneZCPEB5ueKORS+nxLth
         fwf3e8UeOdvTVBSeYxbeKYAlGo/cxpmgle2JbcexxoRbLBQWBhETuqwZj5l5yzsH4P9K
         FRKYeiaOx0ziAlxhFtM63cD9Z1m0K/dIY36UBrDlPGJZOlKtyxxxdc5nx7g9ZNOPC/w/
         smtg==
X-Gm-Message-State: AOAM531hjXEVxp6gDH6dqDgQ75y2cQKnC2iLrAoCKrIS+JMpo1dLDJGL
        85o03dMAjuJRJEj/snhmOM/hHDQd4rU=
X-Google-Smtp-Source: ABdhPJwbPkYjXMpg9rPLEmw8iujy82MzJeuXEayutCiKGTao6xvPSkg9H39yipRMGNeONYVpnZC5IA==
X-Received: by 2002:adf:f2c2:: with SMTP id d2mr4204754wrp.424.1592331486195;
        Tue, 16 Jun 2020 11:18:06 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id u3sm28651091wrw.89.2020.06.16.11.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:18:05 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Tue, 16 Jun 2020 20:18:01 +0200
Message-Id: <20200616181802.3498745-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616181802.3498745-1-noltari@gmail.com>
References: <20200616181802.3498745-1-noltari@gmail.com>
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

