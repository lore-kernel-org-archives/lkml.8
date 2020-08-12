Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4687E20656
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghoiSEhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHLUUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:20:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDAC061383;
        Wed, 12 Aug 2020 13:20:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so1596915plz.10;
        Wed, 12 Aug 2020 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8xWeiFcuqMpOpznRWNhlTz5KRrSm7Nj77jg3nbd+YY=;
        b=ghoiSEhjlNenhfjUiqEhtHT9xEiKodA/KyVdxYA+q1jzK5Kq2PalXgpwTQTOSGhr/D
         yPthOpYAbqrYOdERbK5IGo5vahuJujvMHQGTAtAI+ANScrfvbjZVsB/R17oxaxT/R+R3
         MAQDmzDLCko8fqww5DbIOW8Le0egNGZ3hIv5vq7V2VLXYXReBUXFviOcVpC4gNCpnGKk
         MHl7MY0Hk2gAKtqfprMa1ic+A+JCCNdB6J8aK3i/Agi2gsK4QNIg//RMKBpZ9Xs8nfUz
         VKqIgW5ECgpge+5NQbe8cc7yiAS1srqRlDjeqESk9+V+Azuo4Lc6WlxFXR5Hw+DuX5FG
         jXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o8xWeiFcuqMpOpznRWNhlTz5KRrSm7Nj77jg3nbd+YY=;
        b=H8CdRSSB4dth7D0nw5VMJa9wFobezIip3DgWi3ZWOoQR7m3lmouYaYd0eLJv9e9smW
         UTfuGBi61VlSL5L9wWvWPxaOubbVAndXMKCaWyZLKEqzDCJz+QgmGFxC7pbD/bv/wzJx
         sAMjTe4aI+EgQkFWKkxuIUDQVP2/1LFO84XYj1RKlWvmhcEKNDXOU1eDbmGZ5E3BBDQs
         DXujYNsA7CsHk11IUwnN1irbExVcYCCLtz3lMi4FPiEP7nDvffhWYouLRTQui7dOOB+G
         SLEuyzxYD2B8krYZLLYoTYm7J8uysrD3KNwmrrYYs4+9yLLtn2sqIG+joE8lqKAn964D
         wM+A==
X-Gm-Message-State: AOAM530VzMVabWeLhlXDyPmeRjmPvsdVcLTA0fhr6e0IhyV0g9TpjibL
        RwBKe1elIxvnJOS5IRlVHlcbKAkK
X-Google-Smtp-Source: ABdhPJwqF3Ok8rRvsRYSx70jxMSy7K7/99FFjbKgtm+2NO2ANq7B770iVO9Ft0oaXXCmzTfNn8pAww==
X-Received: by 2002:a17:90a:3aa6:: with SMTP id b35mr1699627pjc.69.1597263648730;
        Wed, 12 Aug 2020 13:20:48 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 75sm3292999pfx.187.2020.08.12.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:20:48 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: Add support for Broadcom USB pin map driver
Date:   Wed, 12 Aug 2020 16:20:16 -0400
Message-Id: <20200812202018.49046-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812202018.49046-1-alcooperx@gmail.com>
References: <20200812202018.49046-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the Broadcom USB pin map driver. This driver allows
some USB input and output signals to be mapped to any GPIO instead
of the normal dedicated pins to/from the XHCI controller.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/usb/brcm,usb-pinmap.yaml         | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml

diff --git a/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
new file mode 100644
index 000000000000..19cf6ad36373
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/brcm,usb-pinmap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom USB pin map Controller Device Tree Bindings
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+
+properties:
+  compatible:
+      items:
+          - const: brcm,usb-pinmap
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Must be defined if any out-gpios are specified.
+
+  in-gpios:
+    description: Array of one or more GPIO pins used for input signals.
+
+  in-names:
+    description: Array of input signal names, one per gpio in in-gpios.
+
+  in-masks:
+    description: Array of enable and mask pairs, one per gpio in-gpios.
+
+  out-gpios:
+    description: Array of one or more GPIO pins used for output signals.
+
+  out-names:
+    description: Array of output signal names, one per gpio in out-gpios.
+
+  out-masks:
+    description: Array of enable, value, changed and clear masks, one
+      per gpio in out-gpios.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    usb_pinmap: usb-pinmap@22000d0 {
+        compatible = "brcm,usb-pinmap";
+        reg = <0x22000d0 0x4>;
+        in-gpios = <&gpio 18 0>, <&gpio 19 0>;
+        in-names = "VBUS", "PWRFLT";
+        in-masks = <0x8000 0x40000 0x10000 0x80000>;
+        out-gpios = <&gpio 20 0>;
+        out-names = "PWRON";
+        out-masks = <0x20000 0x800000 0x400000 0x200000>;
+        interrupts = <0x0 0xb2 0x4>;
+    };
+
+...
-- 
2.17.1

