Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F74C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D8220707
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HGBNFfvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgH2P74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgH2P6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:58:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC7BC06123D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g6so912457pjl.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxwHm2VuekYt0XLlgyTrwGM7XhV6Ku6W16NQioEm9rE=;
        b=HGBNFfvyMj8caxJEkMJIH+GwBZwuc1YGxYnJDZg72pKvag+ZXcPerRI1ZfqsUqbNFV
         UA8Qw+ucvmwZXAS/GwB/c5PwyslGZ2Pqwyxw+wQYAgoeY3lpgaZuFiuKrEv+1sXyko9y
         L4KcLYJkntDkdfdN47yYDBJP0UieAFTndfERE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxwHm2VuekYt0XLlgyTrwGM7XhV6Ku6W16NQioEm9rE=;
        b=DOjlW23LJeZtkHCV8I1q887js2IeR9DRgIA3539nsn1zeq6N0NOgnAKg2Kw0jki3RU
         PJG/9EjeUKtjfKN+mHgp84tYBhGsY1WG5HETAXv2j9LiDFLvDANRTOrHi+RB+vnWcP82
         gXENISYSq1ZkbQBoXt2ifPNTRY4hm6iV8XocO8zSrBBz3bWE7DwlVmPBDl1K+vvNTWOT
         elOKfBHel9tvMD1C9f6HiXK80Yyq489+9aQPqLAabOkabuGq12F0WTe2+wOecq+odOcb
         G3p7AN94tckoxxAuc19NbCX3WeK8UlQkcSTtF/AFyeDVe3YhEMEHpMApJO+5tYCJT+Kx
         YOdQ==
X-Gm-Message-State: AOAM532VJ2RL1rBKOYGvnOpYjSNyqH5hnK2SPsg1u9xHfjqH3Ty/4SyM
        EVygjegzhmq69SYOQjri9XbJew==
X-Google-Smtp-Source: ABdhPJzce9I/TRSbam4Qr9dItMOQaXfYbhUChv8CxER+mpC8zi9SawY3xte4Hpdg7etGhAQzjPSnow==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr3474554pjb.39.1598716722795;
        Sat, 29 Aug 2020 08:58:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:58:42 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/7] arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
Date:   Sat, 29 Aug 2020 21:28:18 +0530
Message-Id: <20200829155823.247360-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829155823.247360-1-jagan@amarulasolutions.com>
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board.

Genaral features:
- LCD 7" C.Touch
- microSD slot
- Ethernet 1Gb
- Wifi/BT
- 2x LVDS Full HD interfaces
- 3x USB 2.0
- 1x USB 3.0
- HDMI Out
- Mini PCIe
- MIPI CSI
- 2x CAN
- Audio Out

SOM's like PX30.Core needs to mount on top of this Evaluation board
for creating complete PX30.Core EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- move carrier enablement nodes in carrier dtsi

 .../dts/rockchip/px30-engicam-common.dtsi     | 39 +++++++++++++++++++
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |  7 ++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
new file mode 100644
index 000000000000..4e85c1a690e5
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/ {
+	vcc5v0_sys: vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_sys";	/* +5V */
+	};
+};
+
+&gmac {
+	clock_in_out = "output";
+	phy-supply = <&vcc_3v3>;	/* +3V3_SOM */
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 50000 50000>;
+	snps,reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&sdmmc {
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <800>;
+	vqmmc-supply = <&vcc_3v3>;
+	vmmc-supply = <&vcc_3v3>;	/* +3V3_SOM */
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m1_xfer>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
new file mode 100644
index 000000000000..cb00988953e9
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+#include "px30-engicam-common.dtsi"
-- 
2.25.1

