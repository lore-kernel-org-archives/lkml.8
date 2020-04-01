Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49DC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31D92074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV3t/LzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbgDAF5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 01:57:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42422 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAF5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:57:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id 22so11580861pfa.9;
        Tue, 31 Mar 2020 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CSFvkX7wQ3c9tYicTf3/Zvg/fptqpEYTtcmz4lzBSkg=;
        b=CV3t/LzO6vc9SkPTJw3qn7tmuadRXV2zhUZwmg/FBKEIZUZRaXKqxpKc8tQSliXiyD
         QAU0JCn/wv77f5muFD3KFKi1K41d7vLoj2d/2OSL6hw8v1CEAy81ZYGNUk5uQjFu+RRQ
         9xxh8FSUCeShOQjP1L3yExiY1YFPkp2k+eB8Soj8KNxT28EqBSmhR7XO63Uybkc1GMcG
         9jmrbGgY0JUfT9gGxcuTJJg4Fit3oyWiO6u2aoL87HvdZncj9lDdDoKabJi58wgRVqlY
         jCbmxYgE7pjSSTya5wy0sIZiM72QwBXi6gVAz5GBH0rkWgIMwvMBMYsRBM77jiwb2Xac
         JXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CSFvkX7wQ3c9tYicTf3/Zvg/fptqpEYTtcmz4lzBSkg=;
        b=pWyO8hzT5EdprIVTdUp4P3GLlxOLBDMnMGUMVtTSWXthubEBZkSudH3d6lPTc6DsKL
         1B5X6z8QcV8/C2ghgUmolBwqmES8sAi2G4au8KvjXKmusjiEqkmB1vKT4lZVNsyxoZTK
         cMEUKcahrC8bCyVndliyI25QwSK7ZOGd1ebE/XLY8FJWlmFa/Dax68FsrKeri1oSMK2G
         HiZZ0tGfkKfPynXKfSwjSUJOB4zC1dFu4DPWid5Yvk0VhpzJ7B9liIlX1SseiY5s5zH1
         t80vGUwJr6VVaUssiy0birUpEQVUVTxtsZckHMRXV5pWqs5jTkUPzadkjj7Hr4XocItB
         vpmw==
X-Gm-Message-State: ANhLgQ3Xle3KbujdcpNbxn/2EhHzGd4m0Nr8v7erQOA0xfMQ7UxdFk3U
        jRhexMCyyS1Odjmzf0ALc8GC+S1S
X-Google-Smtp-Source: ADFU+vuYNQb2S4BDEaYHcMxTCAKjtTAEOSU3bvws6/VI5IVwGb3Yx4pgUfMEOmHNQRb6f4kvVxQMmQ==
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr21417274pgk.269.1585720668796;
        Tue, 31 Mar 2020 22:57:48 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 5sm715956pfw.98.2020.03.31.22.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Mar 2020 22:57:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
Date:   Wed,  1 Apr 2020 13:57:37 +0800
Message-Id: <49020c8b96410f023707777750125cfd680c904d.1585720483.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
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
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
new file mode 100644
index 0000000..0f7451b
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
1.9.1

