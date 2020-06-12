Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA520792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="nUjvkzZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFLNF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgFLNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:05:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222EAC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:05:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s135so3437855pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPc9wn7ciRL1/w7YcmkKxstKF3mhNYu9SS7UDFpaIkA=;
        b=nUjvkzZrPNUxwZXt4rddj1k8k11Ut+O8vNlUvODyzPA5TRw+69KGcqYsPZ2G62F8Y+
         jzeH5qlPBMohmEll60co1xTFxhjueauzIrYC6s43YQZvhTZLQrKMj6I11sfQ294FeN7o
         1Cu8BgHXOYm6//LunIaFVzyeszvlCLlSWTqTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPc9wn7ciRL1/w7YcmkKxstKF3mhNYu9SS7UDFpaIkA=;
        b=ZBb1TZWKQ5AYzaRjzuEXaD7ACcBnk6+S5rQbrMEjNdUF5WYrqxPigF+5J/CMUUvn8x
         3mf8Tq5XwGOvEQcTWfFFAqco2qRBCinqSVQLxBC2NRmsyw2h0x9uW/WE8Wtq70U9KXmj
         VOF0qRQK73o6rxHEPP+8IQ7kHnfzD/7brKgL69dnmzrIK25uiINh2aJhgQjmHf6EovTG
         pZuWHLozXBThNAQsGphqldLdmVwoszvh999x0brixQjLomYIdYk8JQAG/1do9fBVGf8k
         3cQjU2WLr7jZ3mS1wvffhszNeCkadhBeoOMVVXjyEb9q/HgeTiRwpEVjfRTNG8fLyF38
         sQKQ==
X-Gm-Message-State: AOAM533zrylsKKo3uIB2W+9YjjL/7Mk8Wc5hSMEjn18v7LHexBk/jrxE
        fTrvy4L91wvRycZNqGSEX7oESLA5p3vaDQ==
X-Google-Smtp-Source: ABdhPJz1wFdIUTrlUYxHra18zo59hPt+Ljqw4iZ1xFCh8+Ip1RV9JHwrv4UOCHYaJcYh4KYJzR2RpA==
X-Received: by 2002:a63:a119:: with SMTP id b25mr10659528pgf.10.1591967156245;
        Fri, 12 Jun 2020 06:05:56 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:05:55 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel@0x0f.com, afaerber@suse.de, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 07/12] ARM: mstar: Add binding details for mstar,l3bridge
Date:   Fri, 12 Jun 2020 22:00:07 +0900
Message-Id: <20200612130032.3905240-8-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200612130032.3905240-1-daniel@0x0f.com>
References: <20200610090421.3428945-1-daniel@0x0f.com>
 <20200612130032.3905240-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a YAML description of the l3bridge node needed by the
platform code for the MStar/SigmaStar Armv7 SoCs.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../bindings/misc/mstar,l3bridge.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml

diff --git a/Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml b/Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml
new file mode 100644
index 000000000000..cb7fd1cdfb1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 thingy.jp.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/mstar,l3bridge.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MStar/SigmaStar Armv7 SoC l3bridge
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+description: |
+  MStar/SigmaStar's Armv7 SoCs have a pipeline in the interface
+  between the CPU and memory. This means that before DMA capable
+  devices are allowed to run the pipeline must be flushed to ensure
+  everything is in memory.
+
+  The l3bridge region contains registers that allow such a flush
+  to be triggered.
+
+  This node is used by the platform code to find where the registers
+  are and install a barrier that triggers the required pipeline flush.
+
+properties:
+  compatible:
+    items:
+      - const: mstar,l3bridge
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    l3bridge: l3bridge@1f204400 {
+        compatible = "mstar,l3bridge";
+        reg = <0x1f204400 0x200>;
+    };
-- 
2.27.0.rc0

