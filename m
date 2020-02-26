Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB75C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FF720732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt6GKp40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBZJEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:04:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42055 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBZJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:04:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id 83so1361936lfh.9;
        Wed, 26 Feb 2020 01:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eHZsWhf/jI0CQUdI3eAEsrWZ3jvP1O0Z9niC9Xk7qU=;
        b=Bt6GKp40/528dIego2DNE20IvNRKTqPzT65q2zEeWe8bApszPZNzCNzQHavKUIlb18
         s+1muF3PFfBeFE+MaReQimvdA9Fv2waQG910ug5Ho5cAGCDy6s1muuOhbXZIEsqopIxo
         ROAfEOa8ZKwhQtZuT4CQ4w+SaaefQl0ksiptXkiuVhdBcl1WSiZ1xoZCMn0cdLsJwXuU
         SvNlaweTXadrtLfbr8GB0l4xqRRjhEhZ8u3KpWUPzj+Zv6ye1Un1ys9FbsGUgVVAs0UZ
         aLf+tSIZfeTqGSun8S+4tCeQ+vZ9RZJfVXWOutLfH1ZgMsg6gIvldFORNJfo00O05Ibv
         vFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9eHZsWhf/jI0CQUdI3eAEsrWZ3jvP1O0Z9niC9Xk7qU=;
        b=X1rKIS1khBrmy3bPxcwr6MFdtByKc0QFd2g3nf4yO74feBlBPySDkKNoe9qH5Z1/9S
         J4pJtXkNwTU+ammGHir9olTi+nK8HW0mlOYKFXatapkI14htlrYftV1h8ZIirXG+illC
         nQTUykdNoELnh7J9EWCZgQt4DP4Mwzg1y+veZfHayL437ZGOqAt9sRM8yiYNtadUKqvQ
         N+9pTZkF3D8xLyE9F4//GM9oJkxe46cYZebdVVkdIuWaHIF4O/zEQ86wl1e0Aa9U7G1o
         E+1UOeOkXGi6SiFdVlq2LyYhnRvfHOkHQg8Suif3BzvpEEaNZnbKqBEC4MX+IHexECIx
         NTeA==
X-Gm-Message-State: APjAAAV1v3ioq4iGfrF5jKcppAK8tSproH3XdCAKyMvawHYgR7ofsBjQ
        hLymLezEEnYU2c+f9kc/OnA=
X-Google-Smtp-Source: APXvYqwrbSOXZUu09UI9/5ecj+GU4pY2j83Euw++/lMlFFAzDz7ZkhK3fSH2SPIK4olLQspKKPsbDQ==
X-Received: by 2002:a05:6512:3e5:: with SMTP id n5mr1887701lfq.55.1582707845096;
        Wed, 26 Feb 2020 01:04:05 -0800 (PST)
Received: from localhost.localdomain (dsl-trebng21-b048b1-221.dhcp.inet.fi. [176.72.177.221])
        by smtp.googlemail.com with ESMTPSA id k1sm777927lji.43.2020.02.26.01.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 01:04:04 -0800 (PST)
From:   =?UTF-8?q?Joni=20Lepist=C3=B6?= <joni.m.lepisto@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com
Cc:     =?UTF-8?q?Joni=20Lepist=C3=B6?= <joni.m.lepisto@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: zynq: Add support for Z-turn Lite board
Date:   Wed, 26 Feb 2020 11:03:36 +0200
Message-Id: <20200226090337.16065-1-joni.m.lepisto@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dts for MYIR Z-turn Lite and respective target in Makefile
based on the existing Z-turn dts which is compatible except for
memory size.

Signed-off-by: Joni Lepistö <joni.m.lepisto@gmail.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/zynq-zturn-lite.dts | 115 ++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-zturn-lite.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d6546d2676b9..56b1bce92744 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1241,6 +1241,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zc770-xm013.dtb \
 	zynq-zed.dtb \
 	zynq-zturn.dtb \
+	zynq-zturn-lite.dtb \
 	zynq-zybo.dtb \
 	zynq-zybo-z7.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
diff --git a/arch/arm/boot/dts/zynq-zturn-lite.dts b/arch/arm/boot/dts/zynq-zturn-lite.dts
new file mode 100644
index 000000000000..96c0babe8267
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zturn-lite.dts
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2015 Andrea Merello <adnrea.merello@gmail.com>
+ *  Copyright (C) 2017 Alexander Graf <agraf@suse.de>
+ *  Copyright (C) 2020 Joni Lepistö <joni.m.lepisto@gmail.com>
+ *
+ *  Based on zynq-zed.dts which is:
+ *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2012 National Instruments Corp.
+ *
+ */
+
+/dts-v1/;
+/include/ "zynq-7000.dtsi"
+
+/ {
+	model = "Zynq Z-Turn Lite MYIR Board";
+	compatible = "myir,zynq-zturn-lite", "xlnx,zynq-7000";
+
+	aliases {
+		ethernet0 = &gem0;
+		serial0 = &uart1;
+		serial1 = &uart0;
+		mmc0 = &sdhci0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x20000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		usr-led1 {
+			label = "usr-led1";
+			gpios = <&gpio0 0x0 0x1>;
+			default-state = "off";
+		};
+
+		usr-led2 {
+			label = "usr-led2";
+			gpios = <&gpio0 0x9 0x1>;
+			default-state = "off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		K1 {
+			label = "K1";
+			gpios = <&gpio0 0x32 0x1>;
+			linux,code = <0x66>;
+			wakeup-source;
+			autorepeat;
+		};
+	};
+};
+
+&clkc {
+	ps-clk-frequency = <33333333>;
+};
+
+&gem0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy@0 {
+		reg = <0x0>;
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&can0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	stlm75@49 {
+		status = "okay";
+		compatible = "lm75";
+		reg = <0x49>;
+	};
+
+	accelerometer@53 {
+		compatible = "adi,adxl345", "adxl345", "adi,adxl34x", "adxl34x";
+		reg = <0x53>;
+		interrupt-parent = <&intc>;
+		interrupts = <0x0 0x1e 0x4>;
+	};
+};
-- 
2.20.1

