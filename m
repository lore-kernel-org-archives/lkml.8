Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C894C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F820C09
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgArmsFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFQIdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFQIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:32:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4EC061573;
        Wed, 17 Jun 2020 01:32:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y20so1049340wmi.2;
        Wed, 17 Jun 2020 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AADm8+jPwopqGrKKxP/w78VBLg3nPZe95QFE0auj6m8=;
        b=FgArmsFLy2nwlgisGeTAt4/owTGITkMYo10qO995gaqHhpJoOYRm9zKi43zJ4x1r/A
         LqC0vBgrLAHE6zmWLa90Vi05nyI5fx39/8hXlYJ3I724KN8Y3oChsib5o5uNC1Z7XNe9
         gTbzZtfUNN+vyP9K5gdu3H4ATy6BBr4MwtCGIa0nvRlYBdCIrItZXtyPZfWeQVaIR83j
         Lcx0ZafGVfOfy7HZluNgjtAzQZVgInhaUPgHhXRJlJt27HaVyAnDMEX+KOXMg1vcOOhW
         BJ2QP0cLr7VOklWGo0ZNlnJYAmoVM2ruoxbaJ5MvNVqrq8RzLuwM4UkqroJdteYH13cv
         888w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AADm8+jPwopqGrKKxP/w78VBLg3nPZe95QFE0auj6m8=;
        b=W89ZgVRwxnG5J+oWF1wYSzp9m6j+BaVnpajj1NQOkZdO3xPAHnU2kc6fnLMTfrDCHW
         JBlCukdwKPXIrGB5iOyRBQpO8ZoJdueio6vPrhal4VBY7IeGBJ8GzhuVPiap0E/fZ84+
         icXe8iNd7X1EkEVmh4iZyaE/8VP0srUx3t5gfpdGPPwe7309pIKcW9urzvpmwENg2fzb
         tWbj9vHPgDAwZxMXSZWc3WKl5mSbkDPzveB0KQExlClFuOeWivaiYibFXMIqI57SVwLl
         Gt/Yir/qrItOOh6ek6kUa6S1gli0Ep4I/PqadbAA+x1bx+N8Wi0xTPVPE6popoQcZ0kK
         tjpQ==
X-Gm-Message-State: AOAM532B3qRR/vi33ZFBKobArfzjiMzrafdUxsIh+7VBfmf9HgsF9Dze
        M4ql6h+kOfgZy+9G5i0m91JyWfGcKj4=
X-Google-Smtp-Source: ABdhPJxA0V/6Xv5T0EzwZ4XUEOAnWfimiqZnv4hazxN7qFsbsCrEH+t8EbYtB/FXfU4RlsTxUFCplg==
X-Received: by 2002:a1c:9d96:: with SMTP id g144mr7073223wme.126.1592382757987;
        Wed, 17 Jun 2020 01:32:37 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a16sm32596863wrx.8.2020.06.17.01.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:32:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v6 2/9] dt-bindings: reset: add BCM6345 reset controller bindings
Date:   Wed, 17 Jun 2020 10:32:24 +0200
Message-Id: <20200617083231.3699090-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617083231.3699090-1-noltari@gmail.com>
References: <20200617083231.3699090-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for BCM6345 reset controller.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v6: no changes
 v5: no changes
 v4: change license and fix maxItems.
 v3: no changes
 v2: no changes

 .../bindings/reset/brcm,bcm6345-reset.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
new file mode 100644
index 000000000000..560cf6522cb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/brcm,bcm6345-reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: BCM6345 reset controller
+
+description: This document describes the BCM6345 reset controller.
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm6345-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@10000010 {
+      compatible = "brcm,bcm6345-reset";
+      reg = <0x10000010 0x4>;
+      #reset-cells = <1>;
+    };
-- 
2.27.0

