Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1581E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMNNMnFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgFOATU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgFOATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:19:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F35AC05BD43;
        Sun, 14 Jun 2020 17:19:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id k11so15515971ejr.9;
        Sun, 14 Jun 2020 17:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMTnpuFTK9jMtHgfDYfsLFnZ16e3Qp2YKWz6Fg/OOQQ=;
        b=TMNNMnFOmmen27sobkCbO/xSOzIoROxVXssX4s+9qM9gKFKpBNvv4poHe354kO8kXM
         x+NT1ijS7ZTZkGoMohxBwyFdzGESdLYqQ58GeUuuOR2pXScfC6b58wpDHY0H+2QZ814d
         +u104JG+82FO24SGOu/jkVTmg2FMv0LHg4orVIE4qK971JwvT5QzI31rSa/JDj5AK/d5
         USVTLKwKjIhxH7HUdYc9o8e4SbuTMhwy5J3rt10eSd8q6LhjSSyYYDfJ0wbld9QdvUvH
         3/Z4s7gCKFlIWv82r6BxlZMGM9A+lXAexHsyxJet1K8NTtU8VoyNhGfWs7LnTRqG6cSl
         BM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMTnpuFTK9jMtHgfDYfsLFnZ16e3Qp2YKWz6Fg/OOQQ=;
        b=ps8eBED30/ywDXubfwVkxr971piXOurDkZ2L6by6Qt417JnI4QqhDk6wWzeN4Jsxkz
         OUw0tyY9yGwkVCjioyv0gro9BMX38iHaf1j+1hFFOT5oGt/92+Zg4GjQldS6wjdkA9yf
         o+9tV+VC9Mq22SdANrq78bnggHy4yxGqFUhB/lzEbLNt5hXC0LTGxW2uj5QfDqOscf6x
         QaPZz1CIhUimmlMDrihEOvEKDZB2io3jY4jAF/NgnIB/tr+JSsarUA1l0853yxSIFHU2
         t9o34Q0ctvJeYlPh16jQLlqzrWXogMcvrGoDHpqg9EwukCL95ABYralyU/Ipm40+YnNT
         5nIw==
X-Gm-Message-State: AOAM531v7gHotoDAvm4v6WTHRp7YgSaiMxkOLLwf4wdQjWb//PB9qjmT
        JPlxAhHJeL+U8HKlj2vwa7B2sCVU
X-Google-Smtp-Source: ABdhPJynU7JATluvS5IkONOy2HvGg1e/Xs2GAOvxN6KxiJXIZWmcUHYO6vytc6SvZDhpg+KBsFxMHw==
X-Received: by 2002:a17:906:4f87:: with SMTP id o7mr3547346eju.233.1592180357346;
        Sun, 14 Jun 2020 17:19:17 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id m30sm7450666eda.16.2020.06.14.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 17:19:17 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] arm: dts: owl-s500: Add RoseapplePi
Date:   Mon, 15 Jun 2020 03:19:11 +0300
Message-Id: <2d12521d196e2c08a30aacd0ab20d93593f94707.1592123160.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Device Tree for the RoseapplePi SBC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 47 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-roseapplepi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e8dd99201397..d0712e7275da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -856,6 +856,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 dtb-$(CONFIG_ARCH_ACTIONS) += \
 	owl-s500-cubieboard6.dtb \
 	owl-s500-guitar-bb-rev-b.dtb \
+	owl-s500-roseapplepi.dtb \
 	owl-s500-sparky.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
new file mode 100644
index 000000000000..c61fbaa3821e
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Roseapple Pi
+ *
+ * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "owl-s500.dtsi"
+
+/ {
+	compatible = "roseapplepi,roseapplepi", "actions,s500";
+	model = "Roseapple Pi";
+
+	aliases {
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>; /* 2GB */
+	};
+
+	uart2_clk: uart2-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
+};
+
+&twd_timer {
+	status = "okay";
+};
+
+&timer {
+	clocks = <&hosc>;
+};
+
+&uart2 {
+	status = "okay";
+	clocks = <&uart2_clk>;
+};
-- 
2.27.0

