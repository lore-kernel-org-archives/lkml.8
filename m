Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA6C433F7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626E72065D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pgsehobR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbgGVTK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732575AbgGVTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:10:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9406C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:10:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 207so1787589pfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGX6YRrhbrO/m3jF24wl30NH0VjikDWGykW4dnyjN5I=;
        b=pgsehobREQgn6u5WcHh/7eTlKykOcK81M2/05t7HGsP9hOXTJGrKaJwO16XrH9fF26
         S3BgqJAolBaPwfmQ/Hi+kejEwXk4w7t0tR2r5cfvPWKpKpwHk6XrBw3Fp1b3eLQDPmTh
         k263E0Pf/TJiEHskLC+dy/Kza3yobqQc4NrGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGX6YRrhbrO/m3jF24wl30NH0VjikDWGykW4dnyjN5I=;
        b=n6BZ3bKEOoF14U6uIiKBFUBguf666Hc4dR3qCX4hNAoWAlsOYpfxFX2RixtvknQQ3z
         an+lQhzT43NOMmnlxdNZVeTeYXlZZFQ/rsFm7jrEe92SLppVRxQa9NBAIOAYjOHah+eN
         50bmTlG8J0uvMVj3Zo2a1NkeKWyuaJ9ZB7BY64lV2PpXGZLtX3OgKQQCVxX0Qqz95zCQ
         iPt+BY3khXHBXFA9E0cpXFuFuQh69O34TDfk+pAUAJ40tPaGGEF8IFaVocUulrk3ZIdi
         8JXczwdC+QOMPV/TYCBC3JBWrpoLav43dwHPkQUnIgxWGOCP6PVA1VJp2UQB+vy8M2ym
         tVcA==
X-Gm-Message-State: AOAM532+WAHCQK4Q+HX3jPYP6aslImgWYHQJme/w9dM8jP6OApoyqHqG
        nOfEDDdtg3LhmOQWlv19ThQTZQ==
X-Google-Smtp-Source: ABdhPJx5OuUvBmtXjQwfIsNwKD4N/ljc6cUbAVeb337f+qYrbzgGFk5fTQQbiDBQuvH2JFjHmSxnyQ==
X-Received: by 2002:a63:db57:: with SMTP id x23mr1121154pgi.178.1595445024421;
        Wed, 22 Jul 2020 12:10:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:fda7:aaf8:9d1a:6749])
        by smtp.gmail.com with ESMTPSA id n137sm342398pfd.194.2020.07.22.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:10:23 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 6/6] arm64: dts: rockchip: Add Radxa ROCK Pi 4C support
Date:   Thu, 23 Jul 2020 00:39:49 +0530
Message-Id: <20200722190949.215656-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722190949.215656-1-jagan@amarulasolutions.com>
References: <20200722190949.215656-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock PI 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
GPIO pin change compared to 4B, 4C.

So, add or enable difference nodes/properties in 4C dts
by including common dtsi.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- add radxa,rockpi4c

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4c.dts   | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index e7b11e8fd9b6..48cc045e6928 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
new file mode 100644
index 000000000000..4c7ebb1c5d2d
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2019 Radxa Limited
+ * Copyright (c) 2019 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi 4C";
+	compatible = "radxa,rockpi4c", "radxa,rockpi4", "rockchip,rk3399";
+};
+
+&sdio0 {
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+	};
+};
+
+&vcc5v0_host {
+	gpio = <&gpio3 RK_PD6 GPIO_ACTIVE_HIGH>;
+};
+
+&vcc5v0_host_en {
+	rockchip,pins = <3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+};
-- 
2.25.1

