Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E316C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B34320734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="eBHYdxR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgFJJJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgFJJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:09:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9BC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:09:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so720694pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rOPH/PbuLqa2Cv7xwtOA9u/UUbRhuHyuujsYiUr6F0=;
        b=eBHYdxR1Xa52Fqd6sKtA6Rq9srTsGJmyYGxwbZSYDhJs6eswpgfL+p9qNHFYDV7KsI
         ea0S7VZZel+/Np8snAXVZxKW3KU7rulyRGs1hilXxkMK4Au7hYZWzXz9YV1FisLONDxq
         3C5cCG9B7w6VuXyD5NLkLc9pSlNglhlDmqEDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rOPH/PbuLqa2Cv7xwtOA9u/UUbRhuHyuujsYiUr6F0=;
        b=H6rW2Fum+J173pLQmgkIfFA4YB+i8eHuUf4cFDgAtfwHTgZHpdgzEYGkUi2DUyuwOS
         VrGukUpVykQht9kiGetr2n92tBpDMmKD0BaM5r54NyblQuT+6pBVSJYMkeAjOsl49UWG
         AR6lRNEYy5JHHbhxDS5GJKwp+k18Kt2/IV+WEVNa4HmRTAYDWVNkjQu9KF7kGfhWY7dY
         V8hPa6icv9fWIh5lJSHrUFPYzBsq5ALOd1Xup1u5jMRVAfA2HiRYxyvlS4q6xf2BnOfb
         Xooq8qYZoBu0/JM557M8hSoA9dtQG/xKTHWZfTHwYBecDTjqlE0+7VGpS2vrjhl/ExJ8
         lt0w==
X-Gm-Message-State: AOAM530jDhIOsbkgZqnLwMnPcpMQgAn2GxxKuPBz/4PCIc7mYcsR6iCl
        /TYUFwvgmbr6VmRZ3EQqLzpYYw==
X-Google-Smtp-Source: ABdhPJww724krgp0BaN7nCeOkrtyuYDvte4q30IE/QoN+f33C/Hjei4IWQ+/yy2VykQxBXRYOfRA7Q==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr2104726plp.331.1591780189664;
        Wed, 10 Jun 2020 02:09:49 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id nl8sm5191620pjb.13.2020.06.10.02.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 02:09:49 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, daniel@0x0f.com,
        devicetree@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] ARM: mstar: Add dts for 70mai midrive d08
Date:   Wed, 10 Jun 2020 18:04:03 +0900
Message-Id: <20200610090421.3428945-6-daniel@0x0f.com>
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

Adds inital support for the 70mai midrive d08 dash camera.

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
index 000000000000..4ee50ecf6ab1
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mercury5-ssc8336n.dtsi"
+
+/ {
+	model = "midrive d08";
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

