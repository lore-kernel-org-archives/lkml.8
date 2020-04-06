Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E313C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354622054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="YUu1PJW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgDFKQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:16:07 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:56818 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbgDFKQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:16:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A5CAB412DE;
        Mon,  6 Apr 2020 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1586168163; x=
        1587982564; bh=ec2Uu6MO0dI09ztGzWgEko0AxDftNtbrvg5in+Wl9is=; b=Y
        Uu1PJW1/Fu8B1YJwjCrcANL8Y8Bfgl+NpCBjzavSEjmWR3l06MJ4EyxZ1q8perJz
        B/fl6YxkMkvz6KBGH/vaOIKGctUiOFAlN38WxB3hZNfsdhb1PqQJ5hZ3OBSib+uX
        QQy80+u685Qt4HGsEJCSBXlmzCl2drY+TbAGJvff+Y=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ocj7AW-wOcmT; Mon,  6 Apr 2020 13:16:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0237A41287;
        Mon,  6 Apr 2020 13:16:03 +0300 (MSK)
Received: from bbwork.com (172.17.14.122) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 6 Apr
 2020 13:16:03 +0300
From:   Alexander Filippov <a.filippov@yadro.com>
To:     <linux-aspeed@lists.ozlabs.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Filippov <a.filippov@yadro.com>
Subject: [PATCH] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Date:   Mon, 6 Apr 2020 13:15:53 +0300
Message-ID: <20200406101553.28958-1-a.filippov@yadro.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.14.122]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
by YADRO.

Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts | 284 ++++++++++++++++++++
 2 files changed, 285 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e8dd99201397..6f9fe0f959f2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1347,6 +1347,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mihawk.dtb \
+	aspeed-bmc-opp-nicole.dtb \
 	aspeed-bmc-opp-palmetto.dtb \
 	aspeed-bmc-opp-romulus.dtb \
 	aspeed-bmc-opp-swift.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
new file mode 100644
index 000000000000..0c8a9e7838ff
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2019 YADRO
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Nicole BMC";
+	compatible = "yadro,nicole-bmc", "aspeed,ast2500";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer@9f000000 {
+			no-map;
+			reg = <0x9f000000 0x01000000>; /* 16M */
+		};
+
+		flash_memory: region@98000000 {
+			no-map;
+			reg = <0x98000000 0x04000000>; /* 64M */
+		};
+
+		coldfire_memory: codefire_memory@9ef00000 {
+			reg = <0x9ef00000 0x00100000>;
+			no-map;
+		};
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power {
+			gpios = <&gpio ASPEED_GPIO(AA, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(AA, 7) GPIO_ACTIVE_HIGH>;
+		};
+
+		alarm_red {
+			gpios = <&gpio ASPEED_GPIO(AA, 3) GPIO_ACTIVE_HIGH>;
+		};
+
+		alarm_yellow {
+			gpios = <&gpio ASPEED_GPIO(AA, 1) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	fsi: gpio-fsi {
+		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
+		#address-cells = <2>;
+		#size-cells = <0>;
+		no-gpio-delays;
+
+		memory-region = <&coldfire_memory>;
+		aspeed,sram = <&sram>;
+		aspeed,cvic = <&cvic>;
+
+		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
+		data-gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
+		mux-gpios = <&gpio ASPEED_GPIO(A, 6) GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
+		trans-gpios = <&gpio ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		checkstop {
+			label = "checkstop";
+			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(J, 2)>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <100000000>;
+	};
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+	flash = <&spi1>;
+};
+
+&uart1 {
+	/* Rear RS-232 connector */
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+			&pinctrl_rxd1_default
+			&pinctrl_nrts1_default
+			&pinctrl_ndtr1_default
+			&pinctrl_ndsr1_default
+			&pinctrl_ncts1_default
+			&pinctrl_ndcd1_default
+			&pinctrl_nri1_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	use-ncsi;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+
+	rtc@32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&gpio {
+	nic_func_mode0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "nic_func_mode0";
+	};
+	nic_func_mode1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "nic_func_mode1";
+	};
+	seq_cont {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "seq_cont";
+	};
+	ncsi_cfg {
+		gpio-hog;
+		input;
+		gpios = <ASPEED_GPIO(E, 1) GPIO_ACTIVE_HIGH>;
+		line-name = "ncsi_cfg";
+	};
+};
+
+&vuart {
+	status = "okay";
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+&ibt {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+#include "ibm-power9-dual.dtsi"
-- 
2.21.1

