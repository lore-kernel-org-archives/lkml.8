Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CF120792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="pHwPz3/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFLNIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgFLNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:08:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AA4C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:08:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r18so4101779pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExlPimcyN0C9gUcFWFhuq3PS7O7BfX3eTiw73uF+8IY=;
        b=pHwPz3/9RUHfJOkjaN4ZBtOX77d1HkgRg9ClL/XLVcIxT5g60o2UJif+VTLnzuS10o
         7nGu22bg/6MP+m1eeXCr0SKFssLMgjIQSVGQnPmKk54vQ/WKLXtg9CozLWd7et4JrPFQ
         eFsCUNLCyvoiyJ/Skke4EnDDedbjJ4gEc4OIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExlPimcyN0C9gUcFWFhuq3PS7O7BfX3eTiw73uF+8IY=;
        b=bImH6Kpxp4i/4uoORbfz92Ph4oyi1VBUcwlG+13WwKBClMiaYKK8z4Q287G9EE1xW7
         vMthn8ThzhxODL/wr6B3JghAqEy4rGb2D17vLftTvC9CKOOdSYsrBKJQtoW0+HaYk9u2
         4GibLjabT/2qIdwUUMLtKiGCpg5tAf+VCEzMqCBrQoQBkq5VPL4AGpOhTV+mnMo48P9Q
         lAAYAjfDEFuGLnC8kQ/1lpRe+mNMNhl3x/YvcKDkgP/Dmq0lHUR5hDxN1zIEAT7KiBnj
         snW+/VxBxNca+LtRmhyLoQCt/Usyh9Iz2vjIOFZ9wKOfm6VHMt/PePtWhXBSMGY7OS9J
         4TUg==
X-Gm-Message-State: AOAM5334VfxqUgmTC7rzvAwCgParoXKkQhAWcb7zd+QclH2j+koueBjM
        a+YfFHSYXqGczLOFOWL5aVlrp3YEpDn3CQ==
X-Google-Smtp-Source: ABdhPJwJXtJsLrwe8ViCdFf8oX0Frz8tkL/HtZbRHPnq2TZTirgUsoynj7/bVtsGLckljhnBSmRYSw==
X-Received: by 2002:aa7:9f10:: with SMTP id g16mr11859002pfr.47.1591967292064;
        Fri, 12 Jun 2020 06:08:12 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:08:11 -0700 (PDT)
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
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 12/12] ARM: mstar: Add dts for 70mai midrive d08
Date:   Fri, 12 Jun 2020 22:00:12 +0900
Message-Id: <20200612130032.3905240-13-daniel@0x0f.com>
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

Adds initial support for the 70mai midrive d08 dash camera.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile                    |  3 ++-
 .../boot/dts/mercury5-ssc8336n-midrive08.dts  | 25 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4a5f8075a4f6..35c7ecc52c60 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1344,7 +1344,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	infinity-msc313-breadbee_crust.dtb \
-	infinity3-msc313e-breadbee.dtb
+	infinity3-msc313e-breadbee.dtb \
+	mercury5-ssc8336n-midrive08.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
diff --git a/arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts b/arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
new file mode 100644
index 000000000000..f24bd8cb8e60
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mercury5-ssc8336n.dtsi"
+
+/ {
+	model = "70mai Midrive D08";
+	compatible = "70mai,midrived08", "mstar,mercury5";
+
+	aliases {
+		serial0 = &pm_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
-- 
2.27.0.rc0

