Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32650C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA7C2100A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="dfEVMnUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgFPMSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgFPMRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE3C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h10so5414223pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxsELow/CoU16NBO8fCV4XFh+Vs58ACm8fFgodBIGbU=;
        b=dfEVMnUOrlm75Do55n4EG4lq64bKU2DQd+yiAm7EqgMZnWfzogsUGdaZ3JQNKhvGrw
         kMoVWalScvTdrtqoYErdYGAlf8KnvS4wxiJit4MvXqHSWlmPJtH6Vue+aGITPr2WPKOj
         9Dho9XGRtAqJJvPAN+V1aCmsFQfMmzGKaSkx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxsELow/CoU16NBO8fCV4XFh+Vs58ACm8fFgodBIGbU=;
        b=EP4R32BSI7gcN9XZT4ZzFc0a72Z8UWZKm5+hAhACFRhQXn5phFDc3VCVgSprpo7jmJ
         +bzBREw30ivi6q52zyg3ewMZPtvLwdojl+DLGTebyPoPv+vyKNFpSQYIwJMzsMNkZnWM
         pHlMD267hlALEgeLsEM9dKDxNA93un/Tlaci0M1BRuP6NrF0v94AQlrJPIMaLRHxN2ag
         VbCOLBcMniVPyuOra8hV5yGKatWwqxQ5jx602tUEXv/mlNS3FsoNJnkgH4l22yQwuKR7
         bNcLqHQc+s4zdOPsXVk1A9vL6BXzGbk4b9z2ihOo3nThz0k+ghJ/IHPYA/Isrh+r/ogp
         tZ9w==
X-Gm-Message-State: AOAM5327C9Cov1Z9cwx5aQqxq3TNKHdp3FB/smyxw0e9QMM1XMmZqoBa
        RVzbdLB15UeY7/AjHNXiK+e9b6sZU2M=
X-Google-Smtp-Source: ABdhPJy7+4BLo/r62dntrZVKD/KOvs2UH8dORLxn2x3U2IpNvJ4/z16AtjIUt660N4rdTvTpBdsHfg==
X-Received: by 2002:a63:6d86:: with SMTP id i128mr1811101pgc.432.1592309854515;
        Tue, 16 Jun 2020 05:17:34 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:33 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 11/12] ARM: mstar: Add dts for msc313(e) based BreadBee boards
Date:   Tue, 16 Jun 2020 21:15:24 +0900
Message-Id: <20200616121525.1409790-12-daniel@0x0f.com>
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

BreadBee is an opensource development board based on the
MStar msc313(e) SoC.

Hardware details, schematics and so on can be found at:
https://github.com/breadbee/breadbee

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile                    |  3 +++
 .../dts/infinity-msc313-breadbee_crust.dts    | 25 +++++++++++++++++++
 .../boot/dts/infinity3-msc313e-breadbee.dts   | 25 +++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e-breadbee.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6a1cac0bfc7..4a5f8075a4f6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1342,6 +1342,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
+dtb-$(CONFIG_ARCH_MSTARV7) += \
+	infinity-msc313-breadbee_crust.dtb \
+	infinity3-msc313e-breadbee.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
diff --git a/arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts b/arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
new file mode 100644
index 000000000000..f24c5580d3e4
--- /dev/null
+++ b/arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "infinity-msc313.dtsi"
+
+/ {
+	model = "BreadBee Crust";
+	compatible = "thingyjp,breadbee-crust", "mstar,infinity";
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
diff --git a/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts b/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
new file mode 100644
index 000000000000..1f93401c8530
--- /dev/null
+++ b/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "infinity3-msc313e.dtsi"
+
+/ {
+	model = "BreadBee";
+	compatible = "thingyjp,breadbee", "mstar,infinity3";
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

