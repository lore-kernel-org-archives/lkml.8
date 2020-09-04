Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44286C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBEB206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ub8eFJOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIDTTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgIDTSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:18:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F5C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:18:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so4800565pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+o1kTnhnkf8evW6DjpPlTqc5IbDQ2l+8IQNKfObPRcg=;
        b=Ub8eFJOcHhnkBjBNAVs7WoqcLH2R/3NwLdwwS0gTm/e8FHPJTcm9PdMr4xtQq687OW
         1kMyPGFLWm3aht89kYBy3SpWUepnRBWyzL84ZpVd2XD3P6ypNmxOLfHd32/Fz8mI2q18
         sFram9TXrekM5y0v7M3eFwJtFfjsjd6QIYsVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+o1kTnhnkf8evW6DjpPlTqc5IbDQ2l+8IQNKfObPRcg=;
        b=mmeeZZsw+Oei0cqCcDixqzVGQAhpAhb+wRZZcyeLdoRkvQNIo1HT5e6jCA8lose/SF
         +ybniFvr1PaJZSVI0T/pcZYq+4pTLMSmLmf/kA/ftVE8D3QUEIRQ39+psK0N+F7aGYxX
         dj2VOcWk2NmrHVwKoRFWcDAkD3Hggdwm5GxcvgwEljQ+josnoZ5Z3n6VOHRB0exdhKJQ
         HYv5WTm1CbjIB2oVnn4f0UF9Iu0TdARx48RTTwcUQ8Lbr7VvU0eNFxIFsrSN/xJ4zcVE
         +tFU8umDpgZr1FBA2HiupjnojyLntQRtMRV4rjhAUmwthbKMaskbyCnSzkrl6wwKl0AI
         oYeQ==
X-Gm-Message-State: AOAM533a6ttJWJKmawbpZ4caZ66q8UBxjEf5jxCZsuza8QsMNj8H/VCo
        rs++fRgqGl7kDZi5fuQMZnz4Aw==
X-Google-Smtp-Source: ABdhPJxeupP/Y8O6Ovq4KCzOQMOefBkJ1+gUf8zE0vGCTLY0jHVuKQCOd0weoS9P60yGUbzIS2mn/w==
X-Received: by 2002:a62:406:: with SMTP id 6mr10016207pfe.193.1599247132975;
        Fri, 04 Sep 2020 12:18:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b9ea:24bf:6b2b:1eee])
        by smtp.gmail.com with ESMTPSA id t4sm5986001pje.56.2020.09.04.12.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 12:18:52 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Tom Cubie <tom@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/3] dt-bindings: extcon: Document Type-C Virtual PD driver
Date:   Sat,  5 Sep 2020 00:48:28 +0530
Message-Id: <20200904191830.387296-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904191830.387296-1-jagan@amarulasolutions.com>
References: <20200904191830.387296-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Type-C protocol supports various modes of operations
includes PD, USB3, and Altmode. If the platform design
supports a Type-C connector then configuring these modes
can be done via enumeration.

However, there are some platforms that design these modes
of operations as separate protocol connectors like design
Display Port from on-chip USB3 controller. So accessing
Type-C Altmode Display Port via onboard Display Port
connector instead of a Type-C connector.

These kinds of platforms require an explicit extcon driver
in order to handle Power Delivery and Port Detection.

Document dt-bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../extcon/extcon-usbc-virtual-pd.yaml        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-virtual-pd.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-virtual-pd.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-virtual-pd.yaml
new file mode 100644
index 000000000000..8110fbe2ddc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-virtual-pd.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/extcon-usbc-virtual-pd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Type-C Virtual PD extcon
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+description: |
+  USB Type-C protocol supports various modes of operations includes PD,
+  USB3, and Altmode. If the platform design supports a Type-C connector
+  then configuring these modes can be done via enumeration.
+
+  However, there are some platforms that design these modes as separate
+  protocol connectors like design Display Port from on-chip USB3 controller.
+  So we can access Type-C Altmode Display Port via onboard Display Port
+  connector instead of a Type-C connector. These kinds of platforms require
+  an explicit extcon driver in order to handle Power Delivery and
+  Port Detection.
+
+properties:
+  compatible:
+    const: linux,extcon-usbc-virtual-pd
+
+  det-gpios:
+    description: Detect GPIO pin. Pin can be Display Port Detect or USB ID.
+    maxItems: 1
+
+  vpd-polarity:
+    description: USB Type-C Polarity. false for Normal and true for Flip.
+    type: boolean
+
+  vpd-super-speed:
+    description: USB Super Speed. false for USB2 and true for USB3.
+    type: boolean
+
+  vpd-data-role:
+    description: USB Data roles for Virtual Type-C.
+    $ref: /schemas/types.yaml#definitions/string
+
+    enum:
+      - host
+      - device
+      - display-port
+
+required:
+  - compatible
+  - det-gpios
+  - vpd-data-role
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+
+    virtual_pd: virtual-pd {
+        compatible = "linux,extcon-usbc-virtual-pd";
+        det-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_LOW>;
+        vpd-data-role = "display-port";
+        vpd-super-speed;
+    };
-- 
2.25.1

