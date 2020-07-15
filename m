Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0DDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3E720657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utmLJ4zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgGONSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbgGONSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:18:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB8C061755;
        Wed, 15 Jul 2020 06:18:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f7so2712848wrw.1;
        Wed, 15 Jul 2020 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wUKqVm7HhQHZHAh1aRb0McOhWAmEoANXqccX8LExZo=;
        b=utmLJ4zmY0PQAjRcRmdyXqqm7JV0/D4AtNpknZMH8a4O2nkUqEQJPVOFwI5uMMbybl
         dVzzcT6Nfl6MqCeI0jZXWsK/+Lkl6CLDrSQy/TCq/toSINLHUwqzds0Uxkn0jqwtPp06
         TpnGkBAWwwkbLxQFf4i93kFc0fCpy1pBtZe5z32aKArMsg6mmRH5VUD6A9RRbKzDGRRv
         NfEALf6mjmslL06Ben09Kvdwq1k+OdYXO6GSqxfsxNV+HN8Dxt4Fw77oDpN10Khc+DH3
         tkYVkuV5vPoCL9VcQAeH6KrculhWGbwIC5ETcy5jowi9lipdI1PgLKgkLzk5dRcWMdI/
         aqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wUKqVm7HhQHZHAh1aRb0McOhWAmEoANXqccX8LExZo=;
        b=q5U15fPY+7KYSLHAMsELgaXyjfRYJ+pQ5xDm3fquHHJ4p9HkcIxA8C7Ab3tYkjkIps
         3VBuyyL/Lj/NZaybnGFCHywSykrZcEZTyF6MwqmvcjEzc1qNzLDi+e+uCBNzxvGf639J
         44epY6QpBS3os7gGi+ucN490XG2HGZ2mn5qjZq+LrsnE6AuPp02zwNjiX/Ck+RZJtkcr
         JIlKW3uaryTKVs0VQyMQFSrts2erdgE0/YsIB/QFVQjuWJKb5VsaY7QYbqY+Tc6vxPba
         arF81GCuWdjh5yGc6LruXoALpfDEjsnz6XpQ9yGriSNoeFovLgpDBclVWlu2etPZ4+Le
         EX3Q==
X-Gm-Message-State: AOAM532yrnt5CS/pEF85ewCyzxeA2eCgzVUfRv4xl9EYgvQZJ0yveyLo
        saQxRhy9YD+qsF9miOwbYoI=
X-Google-Smtp-Source: ABdhPJzuNfTmNCzMaQWGKJcwu5iWLHPmtSKCSaXxIF3taRgYn9oCulQ2qiEm34R6bSNp3lvYB/5a2w==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr11065541wrt.309.1594819087777;
        Wed, 15 Jul 2020 06:18:07 -0700 (PDT)
Received: from skynet.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id j145sm3623650wmj.7.2020.07.15.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:18:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     simon@arlott.org, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Wed, 15 Jul 2020 15:18:02 +0200
Message-Id: <20200715131803.1762064-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715131803.1762064-1-noltari@gmail.com>
References: <20200715131803.1762064-1-noltari@gmail.com>
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
 v6: introduce changes suggested by Rob:
  - Add another if case to device tree binding for SoCs with just 1 clock.
  - Ignored "additionalProperties: false" suggestion since it triggers a
    warning. This has been reported, but I haven't received any answer yet.
 v5: no changes.
 v4: conditionally require 1/2 clocks and fix clock/reset values.
 v3: no changes.
 v2: phy-cells changed to 1.

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
new file mode 100644
index 000000000000..8ab0ab3154ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
@@ -0,0 +1,97 @@
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
+  resets:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - resets
+  - "#phy-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - brcm,bcm6328-usbh-phy
+            - brcm,bcm6358-usbh-phy
+            - brcm,bcm6362-usbh-phy
+            - brcm,bcm6368-usbh-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: usbh
+      required:
+        - clocks
+        - clock-names
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
+      required:
+        - clocks
+        - clock-names
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

