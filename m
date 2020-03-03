Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A971C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFBE20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gftyhLtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgCCGYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:24:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46273 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbgCCGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:23:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so831163pll.13;
        Mon, 02 Mar 2020 22:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tPHP3U0sPqM0DsBy+RwsfJsD5yoax7+mg4Fx4kOx2W4=;
        b=gftyhLtY6oe+dn0zlfQ7x0MmGSUQca0tvt55/8WA2xk/vxzdERSYbaaz8E7aT0Yzmc
         Adg+2vx9e5GRvHOpcYixr0DG0yNktt0MCMoVHyibSNWapnAe0mxYH212d3T36PRdmG04
         DKGN0o7KELYMVsglOonaLIMkNWl8dP+ASS+61GpSDm1sxGeS/whvaZB22vzRBodOMLP5
         YT7dZRH3xz+3VZa1OrXjnSdyWzhcxtBElsvXFLKQXVr4GL7YNc6tnUlM3w8vKEzLMXpm
         nKcpSxR/ccgRxRPcSwAQS00famorFheSDrWLOhTjCd/3FqA3fW8HqKuUnu7K10LABHWY
         IyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tPHP3U0sPqM0DsBy+RwsfJsD5yoax7+mg4Fx4kOx2W4=;
        b=C3hXgtqQomCjIwrVWQmEbrzmEdIBL+N2SFLkN4ZbMbG8kjDhCTtouti4tDAvM8jJlL
         XOry1iQZAzuMttYdM3v9r3iiK/w8seX/753SIwqafn+FG9qEP8edoR5T+UcxOXmqspdY
         pSrbtHH2oifSKHuuOX+QZhl9uk7Hx0qrS6uSUkai6H8NE/PgD6duEmczAb1q24GCE6Nn
         lXtDPWAfgzpHr34z1lcJBU9CxUxVNb0Z4ZYRBlv/gvZkfxv9aSZZRlDXRGWU3XucFQTK
         T9ejKdjv1rHqMdbyuZiREjf71MlahiCoGha3dQEMlU472VF1y3hliqhMCkD8O5ziypaX
         Y6GQ==
X-Gm-Message-State: ANhLgQ0JK3JYsGRWMYYSel1vpXpFQrQZiLxJCzLgxFd38kYQYTlV3kK1
        6qb/PRqUjjOp3E8PPteDygw=
X-Google-Smtp-Source: ADFU+vswS8WZqh3XC80WYcxue2Wxbx8TtqPDEj+caARAlRMTrLaMq4b71T3x6WkBwXt9L3CUtE3sYw==
X-Received: by 2002:a17:90a:9a89:: with SMTP id e9mr2411465pjp.116.1583216635621;
        Mon, 02 Mar 2020 22:23:55 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id k5sm7453526pfp.66.2020.03.02.22.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:23:55 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v7 7/7] dt-bindings: usb: add documentation for aspeed usb-vhub
Date:   Mon,  2 Mar 2020 22:23:36 -0800
Message-Id: <20200303062336.7361-8-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303062336.7361-1-rentao.bupt@gmail.com>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add device tree binding documentation for the Aspeed USB 2.0 Virtual HUb
Controller.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 Changes in v7:
   - updated to dual license.
   - removed description for "reg" and "clocks" properties.
   - Added constraints (minimum/maximum/default) for vendor specific
     properties.
 Changes in v6:
   - added 2 required properties into example and passed "make
     dt_binding_check".
 Changes in v5:
   - updated maintainer to Ben.
   - refined patch description per Joel's suggestion.
 No change in v2/v3/v4:
   - the patch is added to the patch series since v4.

 .../bindings/usb/aspeed,usb-vhub.yaml         | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml

diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
new file mode 100644
index 000000000000..06399ba0d9e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 Facebook Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/aspeed,usb-vhub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED USB 2.0 Virtual Hub Controller
+
+maintainers:
+  - Benjamin Herrenschmidt <benh@kernel.crashing.org>
+
+description: |+
+  The ASPEED USB 2.0 Virtual Hub Controller implements 1 set of USB Hub
+  register and several sets of Device and Endpoint registers to support
+  the Virtual Hub's downstream USB devices.
+
+  Supported number of devices and endpoints vary depending on hardware
+  revisions. AST2400 and AST2500 Virtual Hub supports 5 downstream devices
+  and 15 generic endpoints, while AST2600 Virtual Hub supports 7 downstream
+  devices and 21 generic endpoints.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-usb-vhub
+      - aspeed,ast2500-usb-vhub
+      - aspeed,ast2600-usb-vhub
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  aspeed,vhub-downstream-ports:
+    description: Number of downstream ports supported by the Virtual Hub
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 5
+        minimum: 1
+        maximum: 7
+
+  aspeed,vhub-generic-endpoints:
+    description: Number of generic endpoints supported by the Virtual Hub
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 15
+        minimum: 1
+        maximum: 21
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - aspeed,vhub-downstream-ports
+  - aspeed,vhub-generic-endpoints
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    vhub: usb-vhub@1e6a0000 {
+            compatible = "aspeed,ast2500-usb-vhub";
+            reg = <0x1e6a0000 0x300>;
+            interrupts = <5>;
+            clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+            aspeed,vhub-downstream-ports = <5>;
+            aspeed,vhub-generic-endpoints = <15>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_usb2ad_default>;
+    };
-- 
2.17.1

