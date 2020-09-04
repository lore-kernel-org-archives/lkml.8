Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069B0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B901720772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y056GuRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgIDQPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgIDQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:15:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D2C061246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:15:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z1so7333386wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ksfc1mO30cLXViBtYtZb85XN30sTC3Vit9JBymnzNwE=;
        b=Y056GuRHCxq6e0BBzqF948ztntuwIOz8bO5EXHZVceS8Jg0CfqOhBKqJlvVGpMwE4h
         iBh4LOB63DMx1RosXGJCf3erVS+BHoXJDPqtMJO7SIyyr05UVzhbEkh58RtK6t2KGkQq
         +Hy7UxD+sn6UhDGkxFCBUqtVQRBk48a+rzjkV6EVsnySbNQp2bAUVRuMQXxMJXA4J2cI
         L2hgvAP9NpXeUxdYoj7tslaf5AaEAl7u23kYEPbxTdtDBONu9Vi2bnZhz0KJQ3OZ+uAt
         vnu0Kqe0eMNoIac9xzecQ+BAnumczCrprQ4SqaeCKAcbcUtfAE+Lg5OeI0HaKwYzCfcA
         EYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ksfc1mO30cLXViBtYtZb85XN30sTC3Vit9JBymnzNwE=;
        b=W7BQBxfdo0eBO78umH76gieh9qroJ0kQZNpteb5wSubQ8Cg24WC9ER3vvfuJysBJUD
         FIvIUdKGRdsATVSoPoTHFkltdbQwF9olpX6y1bQWdPqZo8gdtL+1LJ38nY3nOJj/x8f0
         m25MvOLZuUM3WTApcRcTEjsGP3cdnErVBofdoTQPBzSAmJlXywSVU7+FHSD6uBhwob1/
         EblmAHPyTVRpAt3+G58eR4Ezb7MW24G8B0y1xk0SmR8mmmRRsxLPzpbVSWMeG6x4RYkL
         tIqCYk/GSOu6iVp8cWT3Z7OSGN9FJ6GSR5LLCQhWklQqjSGaHGmQQb+vwlvjaB3B2vUt
         GxXw==
X-Gm-Message-State: AOAM532tdbd8PipRFHBejqpnTu6APikuBOSLEY+G/MlI6afmEm4tzQxw
        u4dneG815tv2+newLuBlmm7Mtg==
X-Google-Smtp-Source: ABdhPJyny9jilxsNRKY1nnZVgili+ToZTQVRduxfJ01Z1nxjj81l/gIbx4yQO5JFHzDk5dUnx3wprg==
X-Received: by 2002:adf:f149:: with SMTP id y9mr8153667wro.93.1599236115028;
        Fri, 04 Sep 2020 09:15:15 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d18sm12238160wrm.10.2020.09.04.09.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:15:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: add TDO tl070wsh30 DSI panel bindings
Date:   Fri,  4 Sep 2020 18:15:03 +0200
Message-Id: <20200904161504.23915-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200904161504.23915-1-narmstrong@baylibre.com>
References: <20200904161504.23915-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the bindings for the 1024*600 tl070wsh30 DSI panel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../display/panel/tdo,tl070wsh30.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
new file mode 100644
index 000000000000..20f4fdedfcb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# Copyright 2020 BayLibre, SAS
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tdo,tl070wsh30.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TDO TL070WSH30 DSI panel
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+
+  compatible:
+    enum:
+      - tdo,tl070wsh30
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  backlight: true
+  reset-gpios: true
+  port: true
+  power-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - power-supply
+  - reset-gpios
+  - port
+  - reg
+
+examples:
+  - |
+    dsi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      panel@0 {
+        compatible = "tdo,tl070wsh30";
+        reg = <0>;
+        power-supply = <&vcc_lcd_reg>;
+        backlight = <&panel_backlight>;
+        reset-gpios = <&gpio_reset>;
+
+        port {
+          panel: endpoint {
+            remote-endpoint = <&mipi_dsi_out>;
+          };
+        };
+      };
+    };
-- 
2.22.0

