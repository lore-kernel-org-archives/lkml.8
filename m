Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E31C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0137D20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="phvykWEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgFJJII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgFJJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:08:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0DC08C5C3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so639739pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFLYpxHbY4xQl+GX5z/HGphuWdf5yeGEl+2VZh0NoD0=;
        b=phvykWEp5kakVa4//JISZ4izHq/iHRYHSRPk4+n5UPIHrxNLr5OvKN/4QA47cijVAz
         tJWbON0Khde6Uz/0hMlJhV9ChQM1A57r33xhvfeGRFdktL8NBLwzv0iglcWi7KeBHKjM
         fqoeWg2+cCArcb2TjMNqeoopb7lrmU3QNsxaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFLYpxHbY4xQl+GX5z/HGphuWdf5yeGEl+2VZh0NoD0=;
        b=LmU0pIM7BVpzguknoxtDVHc4GTF5bwN8qr7sFrjw2mlFtVJDLaBDnreLIvfObiLvhZ
         y/xC4eWYXLpeNh7W7Zw2ixTr/aiv1niiSBbsd+dJ7z6RnLIAUXWhz+CEwuwWV393JdxS
         oqLJkykK7ndhfIlSegglfEYzD2FJ3surfEIhvyIDwf2n5FZurB+bBsAZEGwIECAM3voZ
         djdLnsNI07x+j+3qS7HIsXCvUkDts3tcIi216M/mHRxdJEoqvxdSmVSZPLmCosCBgtxU
         tL2YBcfhDz9YhYRNwccOUwTNKg9avwn2e05B403bHxoJUdx7XV4gXKyjtTM+vpdzS5zy
         KoiQ==
X-Gm-Message-State: AOAM5337DbRW06zGA7o9Nh4UbZqnIWrxhsNFT0kNvzUNNjy+LDOIoQI+
        zFJvu02TswJtgASkMAWPZ7q9GQ==
X-Google-Smtp-Source: ABdhPJxVIc9uWyfdkUztrhVfVKHB1eV24/nijGoSa+KNsS2RjJ/nDtaKeu9V8C50Nvhf0lUkkgU7ug==
X-Received: by 2002:a17:90a:1544:: with SMTP id y4mr2072248pja.130.1591780081993;
        Wed, 10 Jun 2020 02:08:01 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id nl8sm5191620pjb.13.2020.06.10.02.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 02:08:01 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, daniel@0x0f.com,
        devicetree@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: arm: Initial MStar vendor prefixes and compatible strings
Date:   Wed, 10 Jun 2020 18:03:59 +0900
Message-Id: <20200610090421.3428945-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20191014061617.10296-2-daniel@0x0f.com>
References: <20191014061617.10296-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a prefixes for MStar, thingy.jp, 70mai and then defines compatible
strings for the first MStar based boards.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../devicetree/bindings/arm/mstar.yaml        | 30 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  6 ++++
 MAINTAINERS                                   |  6 ++++
 3 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml

diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar.yaml
new file mode 100644
index 000000000000..09e87cf6d6f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mstar.yaml
@@ -0,0 +1,30 @@
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
+      - description: thingy.jp BreadBee
+        items:
+          - const: thingyjp,breadbee
+          - const: mstar,infinity3
+
+      - description: thingy.jp BreadBee Crust
+        items:
+          - const: thingyjp,breadbee-crust
+          - const: mstar,infinity
+
+      - description: 70mai midrive d08
+        items:
+          - const: 70mai,midrived08
+          - const: mstar,mercury5
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ef6d75b9113a..1770fc794027 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -23,6 +23,8 @@ patternProperties:
   "^(simple-audio-card|simple-graph-card|st-plgpio|st-spics|ts),.*": true
 
   # Keep list in alphabetical order.
+  "^70mai,.*":
+    description: 70mai
   "^abilis,.*":
     description: Abilis Systems
   "^abracon,.*":
@@ -678,6 +680,8 @@ patternProperties:
     description: Microsemi Corporation
   "^msi,.*":
     description: Micro-Star International Co. Ltd.
+  "^mstar,.*":
+    description: MStar Semiconductor, Inc.
   "^mti,.*":
     description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
   "^multi-inno,.*":
@@ -1030,6 +1034,8 @@ patternProperties:
     description: Three Five Corp
   "^thine,.*":
     description: THine Electronics, Inc.
+  "^thingyjp,.*":
+    description: thingy.jp
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 77a3fa5e3edd..1ca77f97b8ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2110,6 +2110,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/mioa701.c
 
+ARM/MStar/Sigmastar ARMv7 SoC support
+M:	Daniel Palmer <daniel@thingy.jp>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/mstar.yaml
+
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
-- 
2.27.0.rc0

