Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D941FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CD120B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="ESIgPO/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgFPMRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgFPMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C579C08C5C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s10so9161442pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDQC1q/6pTc2BSyh05jjBKpJepT+dwpazrZGsFLJpVo=;
        b=ESIgPO/yFoN1yMwOvDNrlQaYh8bbunv9VbR9IKFnZbYX6dpCTDGH+c6VH2SDIdfESr
         vkcjchgJk6GtVFwTNIHnN8OZeh0eizMagRZB+bTDD0IE1qBG1X8AdLbFDrBj6qZfvGOw
         jXleuZz+UEUBvMbo8Remr4eW4uLhYb2tLHhlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDQC1q/6pTc2BSyh05jjBKpJepT+dwpazrZGsFLJpVo=;
        b=nN6P11NA4PpHqKDXYn0b8OU9jYhEDhMIe8bDGZt+b1ZjW5np1gT1X1N6VDgvG2qod3
         /c/Id2yPhal30q6VvpR6ptA3tpN/kyLYzWEypFvC9Kv0UZrPPdVapAKiTcsfmyeq93lA
         Vvrtsm64vcGdrWCLhdPsxVuKTbSj7NRObs7GNt5FXgXthnQHqUwksL8/ZAmWbW1QbC78
         pRL3+T0lFd7Ss5qswPOAjkwO44MMboGhuwCAjl/pAIkLCIsgOWdroFqh8JVdjA6ALanH
         6o+m85I+kgZmMddeZvVhqxR+A464dXixrq2qmhW9wk4kHazEZipKcgL9XESGplCazUSp
         ozeQ==
X-Gm-Message-State: AOAM533x+OqrMJEhnjK+5Rlx56JBCZ+AhIU1QXG5W/VFKzOAzvqFOU/N
        dvhfe+7/4yGVXVbibfQidsW34Q==
X-Google-Smtp-Source: ABdhPJyWmAquQyVAsMd+xi0kijqsxvUQQiX6VNMiN1pZ1XkqqyV013WG62jyzVMUsqdx145PjJ2Rmw==
X-Received: by 2002:a63:c204:: with SMTP id b4mr1819831pgd.67.1592309841318;
        Tue, 16 Jun 2020 05:17:21 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:20 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 05/12] dt-bindings: arm: Add mstar YAML schema
Date:   Tue, 16 Jun 2020 21:15:18 +0900
Message-Id: <20200616121525.1409790-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200616121525.1409790-1-daniel@0x0f.com>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some intial boards for Armv7 based mstar platforms.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../devicetree/bindings/arm/mstar.yaml        | 34 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml

diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar.yaml
new file mode 100644
index 000000000000..7bb91a546b5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mstar.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mstar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar platforms device tree bindings
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+        # infinity boards
+        - items:
+          - enum:
+              - thingyjp,breadbee-crust # thingy.jp BreadBee Crust
+              - thingyjp,breadbee-crustx # thingy.jp BreadBee Crustx
+          - const: mstar,infinity
+
+        # infinity3 boards
+        - items:
+          - enum:
+              - thingyjp,breadbee # thingy.jp BreadBee
+          - const: mstar,infinity3
+
+        # mercury5 boards
+        - items:
+          - enum:
+              - 70mai,midrived08 # 70mai midrive d08
+          - const: mstar,mercury5
diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..a8640c1c50cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2117,6 +2117,13 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/mioa701.c
 
+ARM/MStar/Sigmastar Armv7 SoC support
+M:	Daniel Palmer <daniel@thingy.jp>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+W:	http://linux-chenxing.org/
+F:	Documentation/devicetree/bindings/arm/mstar.yaml
+
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
-- 
2.27.0.rc0

