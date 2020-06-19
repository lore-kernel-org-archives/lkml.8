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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84775C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C0720739
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq58WWEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbgFSKBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgFSKAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:00:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C530C0613EE;
        Fri, 19 Jun 2020 03:00:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q11so9097915wrp.3;
        Fri, 19 Jun 2020 03:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fc/ZRtpBM3g53RRJYB71TtlpBDGsdj4dTHpptXk9V+E=;
        b=Pq58WWExXZ9otcKxJf1zB/dM1leVY7SSbgW/LVaQOi3gk6exFI6lF16yZOgX+hYg5J
         XMLQjUVd2TXMggZWtEzjcETMJu6Lbs2Mts6o2T/qQzgcaipzYgJxKz8Mw81YVnf5EeSH
         BWcaKmoVslFTXJJ6JDxDb1WswUFU0B4e6HMhDGswZP5MrXGlmSPS6yuK9ZNrg5HVo2fp
         CWeamv+3M3aQ7zSorupx/AlqdBCD7x3zlJmLVOmI9L7CQg96c2Vc9AHxuE07+LYdjun9
         AMlufbf1AdLEgRvxVmK4n/DlhfjcJ127jqs3Hv/UQq0jvYrLl4gy5Q9LM0a2OvvSjN5v
         CtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fc/ZRtpBM3g53RRJYB71TtlpBDGsdj4dTHpptXk9V+E=;
        b=gUVwmCmoaTKCUlAAtPq02GnrVaLT6lyOQlt6z1hTFiBjUcVqhrcnYIIs/0Uxd7sa+q
         89i+W4ca9XHEDjlHx863KtQUovalBtXrZIwqJOhTCRjsGI3YXii8EOC1+AoV+/mCDSwg
         vNwtTHdIpMs1Rht5lAl8VpBkrbTGfbtsRgbH8uO/8xyYyi0Yipc4WRQI7tGF3llLJ/Cw
         krmTHiyao8wYSJptdvKhOVVHRd6EzRSrEcH0iTZMW0/XTqYPEId65//3xC7aQcgu9JrK
         OMdCgGKo4bKPp5nr5LoeelsSxxYB09qc2E1binoBt8FHC7K01hN4XHYYvY1jdBQwJ0VL
         l3qw==
X-Gm-Message-State: AOAM532LPLT8VOtFN8nBp4tM4kR83zweVpNu/FcNjj0Tdv/QuBBxvg11
        V/iora4YcEq8WUQIfr9g3EM=
X-Google-Smtp-Source: ABdhPJwL6UxyAGf0Q7nuXdxO5omCn5QIADzsqmyfpcHKpjTIb8EsA90+xXivTVn0wF2IqQO/fHcZnA==
X-Received: by 2002:adf:f446:: with SMTP id f6mr3213092wrp.59.1592560839559;
        Fri, 19 Jun 2020 03:00:39 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id v6sm7164961wrf.61.2020.06.19.03.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 03:00:39 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Fri, 19 Jun 2020 12:00:34 +0200
Message-Id: <20200619100035.4032596-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619100035.4032596-1-noltari@gmail.com>
References: <20200619100035.4032596-1-noltari@gmail.com>
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
 v5: no changes.
 v4: conditionally require 1/2 clocks and fix clock/reset values.
 v3: no changes.
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

