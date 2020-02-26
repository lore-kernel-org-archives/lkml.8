Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CFC4BA32
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DE124670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNQku0uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBZXES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:04:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39491 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgBZXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:04:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id j15so391940pgm.6;
        Wed, 26 Feb 2020 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tCAa6W32aZ6QEKpToe4fyzvDQPNVxEnlp17UdPCzM6s=;
        b=CNQku0uc3KAdlVn5+f/fITVzFDBSHYXMdo+LQ+8BVaz5Ht/O9aBWdkHEyNAVEACBKV
         uICQYcmmIle6na4NfMwdwB+RIKkkOVmrN7OkS11Bji2m331jj6F3aYPwDOvGGNUHye3I
         mGRlKp62czjkuztPiHmWW+KkfYVJlg1iQdnTVUk+C37gPgHC7ghJ58Xpj4KGjGKMqVYv
         gDLWHwfkFWFqP7TYdRDYPDqxSTkiqnFKRFSuIwghiWJyyWL1t4ZQ7lVfpEkYKXj91wIE
         fBqi7TVT7I9r0FamqmLRcL1Ff4vCvLqYAQGY1ns0Ka9X9xeIi/tO/w0jnj6l1bjC62wc
         9RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tCAa6W32aZ6QEKpToe4fyzvDQPNVxEnlp17UdPCzM6s=;
        b=SUeWJyiQm71Luifyu3a2obcMVacaPMmCnRnVkk+pWhsHq5vQ87lHrAwr73TaDo1H3O
         6qq159DUIKqQRhOf81d7hM+wuWOhdqmkpoq5uYpHEc1jPI2OLVKLR+HgTK3hWtlcr41/
         CjOkNxxzbyLMvpK7lKH7k2P89/arUgSIUJQvm0sJZm/CqEYUE7tkHD2906GzbTzgjK3Q
         ZwuBEEeR3tLWDg2KMLVFv9hcoO5xijucqCIuYCj3eR7M0F+hQEBqwZ9AF+mZRoogFIzs
         WR3/2XIH6neTfDDLk8fTvKvIIihIPKSYohEcAor/amnLEu88KzX6WyS7LGu6IVl5kmbM
         jL4Q==
X-Gm-Message-State: APjAAAV8PQvkraAGR9RN53MPml9GQv0L8Kzr+Dal27bcqX1Rd0/KV/28
        +bfeYdwJsZ5ZNmShV5InTCY=
X-Google-Smtp-Source: APXvYqxhOPuxfNONXmDQxDXVEgm8yFWi7DxNNyLfDQf3TB7RUJQjT+qTeMMjNtBejIG2YsmlSgqcvA==
X-Received: by 2002:aa7:9f90:: with SMTP id z16mr1025096pfr.161.1582758254295;
        Wed, 26 Feb 2020 15:04:14 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::7:5ebf])
        by smtp.gmail.com with ESMTPSA id 3sm3912621pjg.27.2020.02.26.15.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:04:12 -0800 (PST)
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
Subject: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed usb-vhub
Date:   Wed, 26 Feb 2020 15:03:46 -0800
Message-Id: <20200226230346.672-8-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226230346.672-1-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add device tree binding documentation for aspeed usb-vhub driver.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2/v3/v4:
   - the patch is added to the patch series since v4.

 .../bindings/usb/aspeed,usb-vhub.yaml         | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml

diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
new file mode 100644
index 000000000000..6ebae46641e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Facebook Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/aspeed,usb-vhub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED USB 2.0 Virtual Hub Controller
+
+maintainers:
+  - Felipe Balbi <balbi@kernel.org>
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
+    description: Common configuration registers
+
+  clocks:
+    maxItems: 1
+    description: The Virtual Hub Controller clock gate
+
+  interrupts:
+    maxItems: 1
+
+  aspeed,vhub-downstream-ports:
+    description: Number of downstream ports supported by the Virtual Hub
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  aspeed,vhub-generic-endpoints:
+    description: Number of generic endpoints supported by the Virtual Hub
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
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
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_usb2ad_default>;
+    };
-- 
2.17.1

