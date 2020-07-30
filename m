Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A1520842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="DzRfY/Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgG3NCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgG3NCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:02:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22272C0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:02:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w19so1063282plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQXDaPRMT2Knve/W75mxDsq7AYy8/2i6BlEqeNHe2LA=;
        b=DzRfY/PlB7jme2woTtQhljw2ldEn1o/2IjXE5fMPsbTKe7eIqBcP+rsvpAa6K4VxBq
         r56S3C7ATRX4fbhGk4K/fQbHxnI0+hgie25kv8UUvoHn5vKlnZ7+WTsfaet6GKZKtaND
         px2tQDZnBza8iHqPatpOyKFRK78pKCil2r4/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQXDaPRMT2Knve/W75mxDsq7AYy8/2i6BlEqeNHe2LA=;
        b=l/ERlsNp12Xl6AMExluX05Scz7nHBCe07rFcLUBr+KgyxXo+5zSUxH+jJcAMzjfldi
         DzOeQksgmUxeLQpwz8svj9CL3EJAfKsvFDH3y59Pbvu7s7Lr75mP8b//ZhQLTlgxDXxE
         noy9fz+RVuLuADvTiHANdLl/LJIfIbWCJewiPa/GIIAieGl76DyYzSby6jMETlP9UdNy
         GMT9EVwxbmmak8m2JtKF8olfeJ4tgBO4D9l5bnROk3bo79JEuB7i6xR82nWBzV7TdBrc
         SPBlDlG2JWwJ9Wl2THScdKjse/bTZKRQ6FnTgU7hYGesfuyEVFVGPKbX022/59Ag7XUJ
         dSMA==
X-Gm-Message-State: AOAM532nu0ukNXxGGXtOgwqO7e2pE2FpUvdr/eqPvMa12mPFtXcBswci
        YOvZsd/XovIyqvL+x2mPclS2Fw==
X-Google-Smtp-Source: ABdhPJyIpTrjirSM42AIRDjJTRvxM3JjBUd4U2OivfIkORi7zAWcv+nifY2e81XEdhi+AaHs+hjAgg==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr33492092plz.9.1596114154322;
        Thu, 30 Jul 2020 06:02:34 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id b13sm6758704pgd.36.2020.07.30.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 06:02:33 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@armlinux.org.uk, w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH 1/3] dt: bindings: interrupt-controller: Add binding description for msc313-intc
Date:   Thu, 30 Jul 2020 22:00:42 +0900
Message-Id: <20200730130044.2037509-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730130044.2037509-1-daniel@0x0f.com>
References: <20200730130044.2037509-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a YAML description of the binding for the msc313-intc.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Tested-by: Willy Tarreau <w@1wt.eu>
---
 .../mstar,msc313-intc.yaml                    | 79 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
new file mode 100644
index 000000000000..e87c72d452c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 thingy.jp.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/mstar,msc313-intc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MStar/SigmaStar ARMv7 SoC Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 2
+
+  compatible:
+    enum:
+      - mstar,msc313-intc-irq
+      - mstar,msc313-intc-fiq
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  mstar,gic-offset:
+    description:
+      Offset added to the intc irq number to get the parent GIC irq.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 255
+
+  mstar,nr-interrupts:
+    description:
+      Number of interrupt lines this intc has.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 255
+
+required:
+  - "#interrupt-cells"
+  - compatible
+  - reg
+  - interrupt-controller
+  - mstar,gic-offset
+  - mstar,nr-interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    intc_fiq: intc@201310 {
+        compatible = "mstar,msc313-intc-fiq";
+        interrupt-controller;
+        reg = <0x201310 0x40>;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&gic>;
+        mstar,gic-offset = <96>;
+        mstar,nr-interrupts = <32>;
+    };
+
+  - |
+    intc_irq: intc@201350 {
+        compatible = "mstar,msc313-intc-irq";
+        interrupt-controller;
+        reg = <0x201350 0x40>;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&gic>;
+        mstar,gic-offset = <32>;
+        mstar,nr-interrupts = <64>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9b35edac7ef7..cf64b4b90222 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2140,6 +2140,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar/*
+F:	Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
 F:	arch/arm/boot/dts/infinity*.dtsi
 F:	arch/arm/boot/dts/mercury*.dtsi
 F:	arch/arm/boot/dts/mstar-v7.dtsi
-- 
2.27.0

