Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BCC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1FD206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjuaeUYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD1DKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1DKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:10:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FCC03C1A9;
        Mon, 27 Apr 2020 20:10:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so589822pjz.1;
        Mon, 27 Apr 2020 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S8BLmOCzp5cb3zshGg37K/qejni/rzN5lSqjOw94NTw=;
        b=LjuaeUYhJh5HMH6QO14HlQpJegTqGRXWTj+tTtMQ2r1L2sBSDGqHUzvZWpZfSkG0Mf
         AoGfhPM4s3oc95484hGw67pn+F5NCYjnUf6LQEnaL0UCOXAw5C7mJXee47Hbqfl8eHkZ
         ID0quAsw67vydiEmHrtIqkRjOflnXJLodBZyhOdC9lkS9EFpyB8BoPY1fPyKIDQsVlUA
         j12SRZt0Eo5SZZApGTdsbujOmNZVdUVxWOpyS69pksy36NZLmu4y0fgpCdVjBalJdSaF
         i9FpdHGUnGlQXREQzrif5HS0gVDy5c451ta8Lxfa6qRVpYo9JBfIJW6G+LlTiZ/zO1Dk
         VFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S8BLmOCzp5cb3zshGg37K/qejni/rzN5lSqjOw94NTw=;
        b=TJMI9gto6XHao62YqZ9vrKpEG58amN84hnGjVmCx2dmnQO8MZZy5kSX+FCO8B4VcK9
         r1eR7s1vT8Yv+qnnBGcBPNoG32NiH9ZmK9VugrcJeLGVDUv/xaaWXoqVe/5HUMOXHVXB
         w2q1BJ7W81YGojeGNQde3Ncxyb6gNrN6eLgHvko9tl7w+sCjWm++s8OT19FEr0224Bei
         tp/zD6y0Na0cu5OLTifoxiueXqD6A9kpr87zM12Cpajih7w5lBmp9CH8BFz2lY/1a2qV
         GTodlmK7wOse8JlRMQHd/+sBAGIFCv8Obha4ppq6bmOrbTqMcANXnAmf+6ispaG56P4I
         qY3w==
X-Gm-Message-State: AGi0PuaDz9Qbb/H5vjGFDXguIT5J7uvO2uOQeN2kdI81/6ou1TB7xDub
        Gn1WnRmtnhnoMec65mSMyGw=
X-Google-Smtp-Source: APiQypKR2PL66w366wGallvfa5RIqn4VojMwNKbRkmJt4I7HUv2W/8dKRP2iH/CThqQfAZoN4ut7Jg==
X-Received: by 2002:a17:902:a603:: with SMTP id u3mr26829342plq.105.1588043416481;
        Mon, 27 Apr 2020 20:10:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id 30sm6298643pgp.38.2020.04.27.20.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 20:10:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     robh+dt@kernel.org, jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
Date:   Tue, 28 Apr 2020 11:10:00 +0800
Message-Id: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
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
Changes from v3:
 - None.

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

