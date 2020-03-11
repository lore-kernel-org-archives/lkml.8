Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5377C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A542146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NgewE5pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgCKMvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:51:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgCKMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:51:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so1981670wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voK4xVRATAJ1dlqqOLPJfEhvH/b2NcYPolGiaZ4ZDGY=;
        b=NgewE5pH2ubf6Xep9BPlnsu71Iiy5y6GiXL0m0Hyh+MRd2DG+R95m9E/YLe6mRzs4v
         3ht5N1r5cyzSzQze56KVTUWSn83NEy4YF3v4JdIkJJQ1OAqukdcwdYPH9l4bg808BYqf
         yWerZvk40Vg6b14GYcoD3M6apTJLfOKjaRAS+waH+xnv9jJ9N42fKeS3Mm/+ekoYDvJo
         mSkmmN37/H30f9kGrQ2HwqLke5C5xy01uQYE8Yz6rvX35y7RCTz17MqZVgltJ+zSvHpF
         Iiz0uOi0myzwYoF/ZaSXWxfk0VCS8HkBnt0ae4hqgmJtxxI5DbEmpSYMCIZwWAciXEW4
         vWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voK4xVRATAJ1dlqqOLPJfEhvH/b2NcYPolGiaZ4ZDGY=;
        b=OXT34gD3CfYOaSwVYszK7DBVKuT9F/9whMRxVt/V30amYXTxgDf2kTSQqlc0fTkfdK
         RAvUw7LChdXE4EK6/X6+Xc/bxPNK4hV7aPXZYWFH6oh9spIjB9O18v8lNmh/u2Xsz44/
         ujd845AelXeEgLU3+qZ48pgdDNbxA4S3qWsJpat4tHcOe0uEG4BJYNcoV9EOPNq8FJJX
         /eOUEZEvQ3V2z5WQaZJGtNGC/fYibd9st3UYvIAmzX7qS7F5UwQs2M9p4uj6wD+pxB3O
         d0KdF5NMzzq+CcA7VB63K6iwIgU79QUgTP65gKF4wQ2af0SCL1dlCB9pDOJXRWU2AcP/
         xPTw==
X-Gm-Message-State: ANhLgQ10kXpwCgIX9Agp7USD8eHaTg5YgzogTVpCduIfR4/xSy5hzvIo
        B3WndPNDbAXo5X0wimQPfPWnOQ==
X-Google-Smtp-Source: ADFU+vuHzJoBWiuWXa93nVX3LEtEiiiQt1WnKL1tKPhNI2IxSKL3y13zZbv1e/00FBK/USQMhVXp2Q==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr3619222wmk.159.1583931104929;
        Wed, 11 Mar 2020 05:51:44 -0700 (PDT)
Received: from robin.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm8843538wme.36.2020.03.11.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:51:44 -0700 (PDT)
From:   Phong LE <ple@baylibre.com>
To:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, a.hajda@samsung.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, sam@ravnborg.org, mripard@kernel.org,
        heiko.stuebner@theobroma-systems.com, linus.walleij@linaro.org,
        stephan@gerhold.net, icenowy@aosc.io, broonie@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: display: bridge: add it66121 bindings
Date:   Wed, 11 Mar 2020 13:51:33 +0100
Message-Id: <20200311125135.30832-3-ple@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311125135.30832-1-ple@baylibre.com>
References: <20200311125135.30832-1-ple@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ITE bridge HDMI it66121 bindings.

Signed-off-by: Phong LE <ple@baylibre.com>
---
 .../bindings/display/bridge/ite,it66121.yaml  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
new file mode 100644
index 000000000000..1717e880d130
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ite,it66121.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ITE it66121 HDMI bridge Device Tree Bindings
+
+maintainers:
+  - Phong LE <ple@baylibre.com>
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  The IT66121 is a high-performance and low-power single channel HDMI
+  transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward compatible
+  to DVI 1.0 specifications.
+
+properties:
+  compatible:
+    const: ite,it66121
+
+  reg:
+    maxItems: 1
+    description: base I2C address of the device
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to active low reset
+
+  vrf12-supply:
+    maxItems: 1
+    description: Regulator for 1.2V analog core power.
+
+  vcn33-supply:
+    maxItems: 1
+    description: Regulator for 3.3V digital core power.
+
+  vcn18-supply:
+    maxItems: 1
+    description: Regulator for 1.8V IO core power.
+
+  interrupts:
+    maxItems: 1
+
+  pclk-dual-edge:
+    maxItems: 1
+    description: enable pclk dual edge mode.
+
+  port:
+    type: object
+
+    properties:
+      endpoint:
+        type: object
+        description: |
+          Input endpoints of the bridge.
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vrf12-supply
+  - vcn33-supply
+  - vcn18-supply
+  - interrupts
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c6 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      it66121hdmitx: it66121hdmitx@4c {
+        compatible = "ite,it66121";
+        pinctrl-names = "default";
+        pinctrl-0 = <&ite_pins_default>;
+        vcn33-supply = <&mt6358_vcn33_wifi_reg>;
+        vcn18-supply = <&mt6358_vcn18_reg>;
+        vrf12-supply = <&mt6358_vrf12_reg>;
+        reset-gpios = <&pio 160 1 /* GPIO_ACTIVE_LOW */>;
+        interrupt-parent = <&pio>;
+        interrupts = <4 8 /* IRQ_TYPE_LEVEL_LOW */>;
+        reg = <0x4c>;
+        pclk-dual-edge;
+
+        port {
+          it66121_in: endpoint {
+            remote-endpoint = <&display_out>;
+          };
+        };
+      };
+    };
-- 
2.17.1

