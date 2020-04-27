Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AB8C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22472072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBXMK6iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD0HUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgD0HUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:20:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3537C061A0F;
        Mon, 27 Apr 2020 00:20:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so7351509pfv.8;
        Mon, 27 Apr 2020 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ugGlujtn3dDnrGju7ZgAZz03fv8HLSylSAJy626CBik=;
        b=XBXMK6iZjcUJGelQ+1gU7U8NX3t0KuA8q5IEcDIUmMvXtC2PayfuYu0UZWFst9dGfW
         JNZD5sPkgldMYKg14pO1ZpCcjBBLSkcXhPkWqxA0Dg9SKqAS1i7QUmrDSr474iySdAXl
         dIgvFOZUvYfHbwOsVowwVp7cxo79EsinrYQXxdZQhXF93somUnEPWAKnXvUDM+F18t9k
         K22Wtq5Kr3scNgH8d3jSySwOu99iaYN7A0wKn8QjZ9TIPC0f9pC6KI0X8MDWDP4ObFtI
         +4UH88JeC7AKL8L0pKf/eh9Yp2Ai1kktqihfgVMQcTnNGkNAMCuLGViKGkBqEsYDzFRU
         bGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ugGlujtn3dDnrGju7ZgAZz03fv8HLSylSAJy626CBik=;
        b=HA1xpxhVxSUIMbVMUgMJkXu5uMrjBjzDIc7s4kxlZIqeRkeKd+0ZXNWMW3U1EIqLaX
         IQCgSkjyaOWVRGKu9oQkG6KkyBRE0dI5JF39DDJqeeEzgFkduB1wh8iwBcLLGREl9r9j
         yKj+gnwM8a1qVQGv2ZiZ54AF0IHtMCvJfCFScLBuW0emnTNECy+Hcn2WEa12rUo36vkc
         ghkuV3DbKCkUjoiiV4L14pt0imKPrbW4J49tFeyLBE+k4eV7Yf6rX9cORRVtT5VZrhcQ
         zn2HtnRdkgiIthX2/udTjwHlq4QzdpxOYZnD4khAnVj57Qk/XLecQiSpi4lVxDWhfE6a
         SN6A==
X-Gm-Message-State: AGi0PuZ0xUuZEtQwOvsgI1lCSw8awdxT06wpXVW5c+vmsjFKigzfkoz2
        nOZSMIvISDlQbpq4RExEnpU=
X-Google-Smtp-Source: APiQypICK0qD8gD3HCpdOLGz52VlUUkN3av4Bne20ulEaJhg/t5QpoC7vtTTRxf3lF8W6MAe+tiWhA==
X-Received: by 2002:a63:4383:: with SMTP id q125mr20393732pga.27.1587972009508;
        Mon, 27 Apr 2020 00:20:09 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id o21sm10104124pgk.16.2020.04.27.00.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:20:08 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     robh+dt@kernel.org, jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
Date:   Mon, 27 Apr 2020 15:19:53 +0800
Message-Id: <8d29eba045ef18c5489e122b3668afc20431f15d.1587894279.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@unisoc.com>

Add the Spreadtrum mailbox documentation.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v2:
 - Add reviewed tag from Rob.
 - Remove redundant 'minItems'.

Changes from v1:
 - Add 'additionalProperties'.
 - Split description for each entry.
---
 .../bindings/mailbox/sprd-mailbox.yaml        | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
new file mode 100644
index 000000000000..0f7451b42d7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -0,0 +1,60 @@
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
+
+  interrupts:
+    items:
+      - description: inbox interrupt
+      - description: outbox interrupt
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
2.17.1

