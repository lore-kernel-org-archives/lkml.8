Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D54C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE8320776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuhFyzqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgH1NyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgH1Nx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:53:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE381C061233;
        Fri, 28 Aug 2020 06:53:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so1251637eds.3;
        Fri, 28 Aug 2020 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6g/eS7zH2f40jz0ItECktwz0CHPb0AoI4mWHFv+EIfw=;
        b=CuhFyzqyuILD6dB+zn4B9tLjpTTD7G4nRMcS6CZwmWimN+SlsLtkdVHxcmXIMql6DH
         68rUP6QozsvF1BMt+W/GNyqKUzPHGyuDU8dzNyABC9aSPsG81U5HMym/8c+hXmPGXeYS
         K+pzuZ67XuNzUnyIwF3/9Ge8d9ACFL76sCy48KUwep2pRKUNm47j8qh6OwIalU2tCjN7
         Y7pg2mErMu5V2IRnbWDVGaXfvlkGfd8yYFjD6geNJKkGROT1tXH+hxb6+eWFNkAHfLx2
         sRyNg1seM7QioWZcc6AnDfMsIG67xiTORuIeSjUlT/QKk6l1/NvsvmRD2mBuTIKYvXuj
         t1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6g/eS7zH2f40jz0ItECktwz0CHPb0AoI4mWHFv+EIfw=;
        b=FRNC0y4/FatH0oKu85+jhMVW9UhL0YcqW+KJtAelh2G0fd+RCGjp2Nx9iuSZsR3dkD
         G+TZ3aLam2Zn2UKCM9GUeYc68Y2PefR6PnHaBG/nDjCJLEG6o3vNcGmGf64zialPGo5q
         kjsJG2KSFSO046FxKPWY0fU78VYdbHqDNKY73Uv7iAz3t6j9rkbHlOdIPUBbN61HHKpV
         QJ3bOD5UjPmm6H+l2TT83fD3afKlo2rPXisoPDZVbdrR6Ln2pkhunbh288pOsMyDQShJ
         Z45W8EfQyq4NFLh7l19ugxA04OVKWJBdlUlr/KGYCRzhyIBrZCEiLgUq1qSbtiBJGiT+
         Fx5Q==
X-Gm-Message-State: AOAM531clxToZ7KuOeh9MbzaPOxbUmgW2AAeZ03KNHpfxbdSmxkvxvP1
        1PU94UB5rB4YD9waG9aPMys=
X-Google-Smtp-Source: ABdhPJwYAk7TS5DA6wHvo2isqsN1Ef95e87YOO59YD+5VkSL7LiQoj74U1ANr2tqYVoDwUpUO44oNg==
X-Received: by 2002:a50:b946:: with SMTP id m64mr2042615ede.92.1598622807602;
        Fri, 28 Aug 2020 06:53:27 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f20sm981624ejq.60.2020.08.28.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 06:53:27 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH v2 4/4] arm: dts: owl-s500: Add RoseapplePi
Date:   Fri, 28 Aug 2020 16:53:20 +0300
Message-Id: <5a6fc55341b346439ba32b5a3e14087edbaa6226.1598621459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Device Tree for the RoseapplePi SBC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 47 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-roseapplepi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..bff9ef996fbb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -868,6 +868,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 dtb-$(CONFIG_ARCH_ACTIONS) += \
 	owl-s500-cubieboard6.dtb \
 	owl-s500-guitar-bb-rev-b.dtb \
+	owl-s500-roseapplepi.dtb \
 	owl-s500-sparky.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
new file mode 100644
index 000000000000..a2087e617cb2
--- /dev/null
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Roseapple Pi
+ *
+ * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
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
2.28.0

