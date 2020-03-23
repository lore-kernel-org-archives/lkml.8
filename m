Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88265C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDCD206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb+zKKAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCWGN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:13:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40813 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCWGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:13:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id l184so7007830pfl.7;
        Sun, 22 Mar 2020 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6RunR6reW/rdha4XOFLo/23SuT6oFo6osITud1hxX5Y=;
        b=nb+zKKADfvG58zZQgBqsCUfbzB974vH7CsHBQk/LeoCSEFdn0+Nnbs75pJ8xLEyUxN
         JLZfC6JTVuBWoZkcvtaeI2WUSUjSYonkMFK3HP5LKsOKWciYXmCIRQ/K4O8esW7W9wlq
         5c1PmZe7i5qw7N5C7bbrRIU1j5VqECEn5F/2VgW/km437hskRZRBWbmcUNzp5ZS3xjDX
         Q3x/TiKFyWzJJuhyI81XWMN5oVkgHuR0sX6BTrVelNobWglhgJhkDVVN2hIQVJJAiDIL
         A2mstRgUlJHTt4xYtAePm2OVqfoeMd3xjyvpHb8EyoDSKJm8v+pP2oAU9h/TCDVmTzq4
         HZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6RunR6reW/rdha4XOFLo/23SuT6oFo6osITud1hxX5Y=;
        b=PVE2d5LeGMYMY8isIrUWsEpdSaXXbQM7lRuRZq0/p3Jv8kp1oUQcKS4l9/wsCzxP3/
         41tzE7NX2lQrhbfgENnoGX2zpHu1pfSYwuy91hJlnfK6jdrNWFAtCKoO6XHQfaoV4uzF
         y0gGDSh+L2g0GDFShT5L3AihOsodrWOSCkP6rlwgDxrT5HB+YNoUwgeQXz2Jcpy309f9
         CW+v2IfNzyYavD76xTM8qiLOguXLT2z+7w7V7FbnF5hplJwP5Lla4lDKffmV7KR08+sj
         sRLC7EB2KB3/P47yOudvzNuk5xKMddWb1hCRdioqP0B4c/9v1MzZpzytw5ghB7Ewcgb8
         Efdg==
X-Gm-Message-State: ANhLgQ1b0R9by4YlALlnfbPG9bGsnzHYT+X4pDXf1n6Sx1JBpD+WZpal
        vj87MW4EWitYVq83rJ85F3Q=
X-Google-Smtp-Source: ADFU+vvgKLpr2Zg/O4HQWAHsJwfSiSdJMSKiaGomL4mu93OT8Ti7hK3cSqVzKOAVvhz6L/iHCCaG0Q==
X-Received: by 2002:a65:5905:: with SMTP id f5mr19326629pgu.87.1584944036066;
        Sun, 22 Mar 2020 23:13:56 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l1sm11458625pje.9.2020.03.22.23.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 23:13:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
Date:   Mon, 23 Mar 2020 14:13:46 +0800
Message-Id: <600e0b027a4e62a4aea8900e5a1e95e3e14b10f0.1584943873.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@unisoc.com>

Add the Spreadtrum mailbox documentation.

Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v1:
 - Add 'additionalProperties'.
 - Split description for each entry.
---
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
new file mode 100644
index 0000000..0848b18
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Spreadtrum mailbox controller bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-mailbox
+
+  reg:
+    items:
+      - description: inbox registers' base address
+      - description: outbox registers' base address
+    minItems: 2
+
+  interrupts:
+    items:
+      - description: inbox interrupt
+      - description: outbox interrupt
+    minItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: enable
+
+  "#mbox-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mailbox: mailbox@400a0000 {
+      compatible = "sprd,sc9860-mailbox";
+      reg = <0 0x400a0000 0 0x8000>, <0 0x400a8000 0 0x8000>;
+      #mbox-cells = <1>;
+      clock-names = "enable";
+      clocks = <&aon_gate 53>;
+      interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
1.9.1

