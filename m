Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9CEC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FBB20767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TwL3aLwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgHaI3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgHaI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:29:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC208C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 17so193707pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuanP6HW9kvPEQuI6DTNe4sSDhIR8cAsGo+XK6KWMec=;
        b=TwL3aLwk9UyIY3oVxI5Frm2N0sssZOnvZC5t+4MfsSi9w/+jHe5IdUO3KVjzwM6IRA
         2ZdmfRZaIaZ79h7DxjXgd1P+5qbjgt47EWf+MTjuxDI84KzbrFLrB0pnQFpLNW9sVzYo
         KrcYLJoJoJhaQhdgqZ3UcOFkbowqERT9NPq4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuanP6HW9kvPEQuI6DTNe4sSDhIR8cAsGo+XK6KWMec=;
        b=Vuaq0dNqxoHP1sRF8WFrjaA8xurSIJFyyBarc4TB8BlGWyAhlGy844JBpkfJrTMfzd
         ZbwzKCsCXobBz99O2+agrqCU30Iq1qtJF24Y/pFEp0E53CJpTZc8klD1JT6NEjdYQ6wm
         t0ij6Tp+x+WguFVuoNa2uLTxZYJhlVBd1KyvckEKHcQBGVxrTUo7UCQPGiuuicUhhBQ6
         cv5z5IyYAoFcGKJM5JKRefHILjwFUP0X8rch2B3rVx/Wq1E22iWvRDxCHFHnCyLvX9Gy
         qW2ifeBry5sKm0jimw1LPNtjpj1XK1pOEPYtMJznQpnPh7c2bLQjeccw8KuRJX3CV0g/
         dEmA==
X-Gm-Message-State: AOAM532zErxnsgqXowQ6o7OOVc2NgfhSPg5CpdpRh8STO3YuKYlhiz9y
        ydPJxGLnCxN1GkOc1mP/IF0ATA==
X-Google-Smtp-Source: ABdhPJxHp9KzFC/inaCHGtGKRVkZ0zDxgxUVa6URm880rJytbeIXXLL8OQrDFq5OGfUSVdfQR+xK8w==
X-Received: by 2002:a65:614a:: with SMTP id o10mr412010pgv.411.1598862578373;
        Mon, 31 Aug 2020 01:29:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d50:45fe:aaf3:66ee])
        by smtp.gmail.com with ESMTPSA id b5sm6411335pgi.83.2020.08.31.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 01:29:37 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/7] arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
Date:   Mon, 31 Aug 2020 13:59:12 +0530
Message-Id: <20200831082917.17117-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831082917.17117-1-jagan@amarulasolutions.com>
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
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
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes for v3:
- sort regulator nodes properties
- drop cap-mmc-highspeed property
- add Amarula Solutions copyright
Changes for v2:
- move carrier enablement nodes in carrier dtsi

 .../dts/rockchip/px30-engicam-common.dtsi     | 39 +++++++++++++++++++
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |  7 ++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
new file mode 100644
index 000000000000..bd5bde989e8d
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/ {
+	vcc5v0_sys: vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";	/* +5V */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
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
+	cap-sd-highspeed;
+	card-detect-delay = <800>;
+	vmmc-supply = <&vcc_3v3>;	/* +3V3_SOM */
+	vqmmc-supply = <&vcc_3v3>;
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

