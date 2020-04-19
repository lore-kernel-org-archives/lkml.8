Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E947C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF89122252
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLnuM0lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDSFxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:53:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69352C061A0C;
        Sat, 18 Apr 2020 22:53:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so6347250ljg.8;
        Sat, 18 Apr 2020 22:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xN3miRWZzdsMsxxSHU7bXZvm24cCusdBgj9dMFbMgFE=;
        b=LLnuM0lokDj6WShWfzAm7IQ3C2Ry/rP7akF1AWqIr1yEymcuF4s/lrT+i9l7w5Og4N
         +dCqigzJ3ypQAXiJOYS+hpg63f926bI2Y9dxSo/zZmYSdDD9wmywtQw+Q7tsvag63jXb
         V+VhY3w0Qsb4/2MqNWJvYbcfe+Gkao2oPUtIZG5jrxuWGUzA/xZVh0a49eaQ+qAeA5EC
         0RxNFbVHQMAblEuTv+OLK8R3Ulr6MnGBj35OCOv8eB6ixelH8Li717QcTVYKY9q6nVl/
         qYT/x2jZA2eZ9rm4j1y1tK+nObSOinZt9mDUvL2GGoBO5NgGJRPM8kVcqM+DJTOoy4xG
         Ceqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xN3miRWZzdsMsxxSHU7bXZvm24cCusdBgj9dMFbMgFE=;
        b=pkIK1wPExiCApO1okH3nddWdGaWrX+etTz6W1JEJGAo3r5Qj0IPh0uzwLPdN6v5OEE
         sdX7/24cmnGn96OcQG1vLkYLPYHnEydZ3wWoqcmutiSVeuYwj6znYcQ4WhEC42JbYeTx
         97KFgpnADPnfm3NGFqxOSPWVR3+GkpE6v6f8xVartqDe/HJ/NgGtfETP2nBT6tuCfADw
         24J0UT5i9+aoEPBQFrARmAr1AHkcgxFdqIoCmD9XrWsC3V0yFryqxDgJr16nVdvcGKC5
         zSZnUDzgoL+yY+63F+JEBy4IZyeoNQN2/q5pezZlB0AveT/XBYdvUkyVYAz9dtjzOSif
         8aaA==
X-Gm-Message-State: AGi0PuaxLmuTaftlHCaYa0vHcMMuyKi4oWd+ABN45sILiKE2bFqUZydq
        V3f/drov2zlAD6mgmFlzMpk=
X-Google-Smtp-Source: APiQypL9B78BpDHqzcdSxXcsbHU3s5I24MyU0cJ5Fjh+KgzcIB6iYgtHo9Bc5eUX8MkqBzw/Qqa6yA==
X-Received: by 2002:a2e:9456:: with SMTP id o22mr6510374ljh.94.1587275616923;
        Sat, 18 Apr 2020 22:53:36 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h7sm3366247ljg.37.2020.04.18.22.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:53:36 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 4/4] arm64: dts: meson-g12b-gtking-pro: add initial device-tree
Date:   Sun, 19 Apr 2020 05:53:22 +0000
Message-Id: <20200419055322.16138-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419055322.16138-1-christianshewitt@gmail.com>
References: <20200419055322.16138-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference
board with an S922X chip.

- 4GB LPDDR4 RAM
- 64GB eMMC storage
- 10/100/1000 Base-T Ethernet
- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
- HDMI 2.1 video
- Analogue audio output
- 1x RS232 port
- 2x USB 2.0 port
- 2x USB 3.0 ports
- IR receiver
- 1x full-size (not micro) SD card slot
- 1x Power on/off button

The rear RS232 port is not currently supported in the device-tree.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-g12b-gtking-pro.dts     | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 1fd28e84e808..0f377031cccb 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
new file mode 100644
index 000000000000..c2bc1ca5a136
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-w400.dtsi"
+#include "meson-g12-audio-hdmi.dtsi"
+
+/ {
+	compatible = "azw,gtking", "amlogic,g12b";
+	model = "Beelink GT-King Pro";
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		power-button {
+			label = "suspend";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		white {
+			label = "power:white";
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
-- 
2.17.1

