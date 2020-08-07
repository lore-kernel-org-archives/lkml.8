Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15765C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E791F221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FnPFmg0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgHGJsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgHGJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:48:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF38C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:48:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so707085pfx.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qtqjn9bdXGvUfpcD1HWzU/py18DJffCjiF+w/RFjz2g=;
        b=FnPFmg0+YjpnOkedvmWUx/ChyDyzoLbOYxMCplO9uSXgjyi2P9moYPhApSPzIst4Q/
         FyVpEp9zRgs4lIOPwgA2WL+R4KAyqm6b1reDWc64DnQ+JNLRyC1CdS07wQVyYO0zSLug
         LO8Tgr/oTyUjlzGhqSXRbsCFJMaaBRVMzOWCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qtqjn9bdXGvUfpcD1HWzU/py18DJffCjiF+w/RFjz2g=;
        b=erLLTT2hQVoEa6HBrmLWDlOQUnYbGt9yQt9aJmM+t1GODDXqEOFr2nDxg2UZzpM3xs
         w7ykPb/xxtCKSS8Z0PdDg9Yb1ZGLL4R8Gzwrl+tF2r4Wu8n09P4FjK0lcFSFWJWp/1IQ
         KwRbr40I0nj9NGg08FDkJIbfhnYllzRVD3WLV+7BKzYI8J+CmNxdK2bGM6YCGEiEmMDa
         /gSY96MtDKGRwqSpydPOrqRX3I3VTddNFbs2TEFLNOlwE6KNP1BwffIvyk99LmjN+3YY
         asRm1DbU4edRvF1oDgOufefjWVe0MzOEGKTAENCVPzpNbwhSM1qfn+FlZQalfTq4ed3j
         JoHQ==
X-Gm-Message-State: AOAM532fiAQkHRs5ubqxVl2L4B7rtlsXIUYOqcgWVLetkf6lH+oFVAi2
        mpGlTGBzwmwW9UAEZdkr59uJ8g==
X-Google-Smtp-Source: ABdhPJzQ/zkmkBdBxmXc5ZdCVmyPR4dyh4piPTo+ebtaM8xlE4gOHHzep/PgunOz6/hEUBRNDtgpfg==
X-Received: by 2002:a62:7ac2:: with SMTP id v185mr12567409pfc.277.1596793733318;
        Fri, 07 Aug 2020 02:48:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:6097:2d32:26bb:64fe])
        by smtp.gmail.com with ESMTPSA id d65sm11412112pfc.97.2020.08.07.02.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:48:52 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 4/4] arm64: dts: rockchip: Add Radxa ROCK Pi 4C support
Date:   Fri,  7 Aug 2020 15:18:26 +0530
Message-Id: <20200807094826.12019-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807094826.12019-1-jagan@amarulasolutions.com>
References: <20200807094826.12019-1-jagan@amarulasolutions.com>
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
Changes for v4, v3:
- none
Changes for v2:
- update commit message
- add radxa,rockpi4c

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4c.dts   | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 8832d05c2571..02cdb3c4a6c1 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
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

