Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74727C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2A520786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKNxEDg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgFPIeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFPIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:34:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948BC05BD43;
        Tue, 16 Jun 2020 01:34:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j10so19795507wrw.8;
        Tue, 16 Jun 2020 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvcpsuXcW9VNFl6uXhkfn7k7tErP7EAuCbtAVgP08DY=;
        b=eKNxEDg4kFcaZQIYB8OMYabj3dRfW6ebgoM3CIL/XF9nUW5TgSHDgSSNMKY3UYwtyW
         u19vQezA0aFVWemjhnnRihJhcoZ53OGOnoXXp9DoKXYkZCtIlP6nAnTW1bXM+9B0CC0b
         wCyZmQl9nKG8euyfbniidTkwAxW6HgUyrCYzJb8DX2BIJ+6QIWOD4nRcn9bxrzF+i6Gy
         Oxkicviin5NZDDJcMR8V8/f7WGQcOcP18TW/5aNoTjpbeKN8Cr1nnWf1Y8k8zXaaQGX2
         3JmdeeIFqonNdJW0s2nHKdNmEaX4wJYfOqwEA1QD89e4Ua+H+cExAr1jpHUBrwusvrif
         XPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvcpsuXcW9VNFl6uXhkfn7k7tErP7EAuCbtAVgP08DY=;
        b=VRRK9gfY48gxI5sFygSUsVUmxwyv1cK+ddGXdM7Y6KnI0+FXYRMYd+7TPmUSKl5Swi
         NvxWL1heUMFSL+ZsoZMh1Lm2vSFhMG+ox3OSpXyl6nTXvnz6+OqADtMgj2KDPlcuPxO9
         TTbvXMyXEPR/3FBWAylWx5LELMUHLU/xYFu9TAlTK3huCOMJ3ht08xreFIje6IVDHmAy
         mbT3SEmuouf17P50Q1fqg6UyjPSh2Gdaf9acryzpYwCAFL17TnoOfQIPcsO0HHClBYet
         tj6CJlZxtC9oLpJ1fL2jbj6Qt0Mq8jCrBD+dmHOm6DS8bwhdHHOrrp+gsUJX9qEtXZfv
         gyNQ==
X-Gm-Message-State: AOAM532+SDHg/rm85IKbnKQVmIcv9e9/Xda5kggKpMyF1snFjExyBfuO
        /2WWFWpKOahtBvCGGgwU6i0=
X-Google-Smtp-Source: ABdhPJzWWDrEko1QQTOj8SM9Ke8qvJ2AFwZtBqEQ+p2O66nPN+vKJld3AeRTdCZlU6A1pC8h2pDAMQ==
X-Received: by 2002:adf:f8cc:: with SMTP id f12mr1770425wrq.418.1592296451480;
        Tue, 16 Jun 2020 01:34:11 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id s18sm34318981wra.85.2020.06.16.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:34:11 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Date:   Tue, 16 Jun 2020 10:34:07 +0200
Message-Id: <20200616083408.3426435-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616083408.3426435-1-noltari@gmail.com>
References: <20200616083408.3426435-1-noltari@gmail.com>
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
 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
new file mode 100644
index 000000000000..3e7c97799b91
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
+    const: 0
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
+      #phy-cells = <0>;
+    };
-- 
2.27.0

