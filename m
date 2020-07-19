Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EDBC433F7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2876921744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzNVcvKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGSRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:43:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FC8C0619D2;
        Sun, 19 Jul 2020 10:43:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so7633581plr.8;
        Sun, 19 Jul 2020 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xERbi9bOr6P1N81bLEIUaoSvz0k8bcyvEw3AL2LaphU=;
        b=VzNVcvKHYgWdbdxQuuyqQMzUyuUuUU2Phb1huMF/OBfv7MQlICLcPyGjuOd6VlU6EQ
         aNVVxiCJgUSsqy0qIt5x7UosITnGj0D7Q8XOdi00pwJnzMpnzK9KkkXSMp1z9BgAIYgm
         kQ4GWWQKmsduJjBEU+ZnA3cjmZdkBTImdzrg7ZEumA42RIevTDMC1/7zsX4uMGpMOA1F
         GDusz0n96S3sHkFSa0TP9WWb/z61eC/arMp2FVf5v+svRQz0vWclprRKlmCYwFex63GJ
         L47i+gqamRoP1QLAUIG0cr51ux80rqGE/Al2PnRVhz4FECnytKWrwgRX0s7mPMJGTSYo
         MFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xERbi9bOr6P1N81bLEIUaoSvz0k8bcyvEw3AL2LaphU=;
        b=fPr4pgeI7gE2rDsdLLJ/2xyr7NClf94eUJ4JV/YCx1vmwtC+Ey/7IPAtxHT91g4Dc0
         2YEQFLjcXG65+Sy9GlwjxNs1OhCqu+W7PsPfgNFNOXGBPtf7sWFW7HOIP6MM1Ng3QKFV
         nUrFf5KF+o10vglXNb90QKF3i0jW7TyaDpNewil22i/Rzu4Jy5VW8KKUm7+Ep1DY4HAt
         4CNJhpLD9cBw8bEktievmHXBdS72M130/dwLX8+QGBII7sKHinj/H7MjpxMJs01xKQSw
         NrKdSDKmQpxy+nTon0Mi7x+o5GLoxjea2mqmCp9REm/bsTdnOYlAdY42MNRdidmOaAhk
         A6Iw==
X-Gm-Message-State: AOAM530z93lV8ZIlKcOUnWT81KMG+/z+nw/QqQWnXD+e2W7J0T8Y+1OU
        jobDz8glmszY34IAi0pOLvM=
X-Google-Smtp-Source: ABdhPJzFjy5Re5wHrfnnLOEDXJwqhY4zyTlQNcb5gvH/weedfkGoPOAqpkcFiObqh3Tbzqalfy2kcQ==
X-Received: by 2002:a17:90a:21c6:: with SMTP id q64mr20803329pjc.172.1595180600915;
        Sun, 19 Jul 2020 10:43:20 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:43:20 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
Date:   Sun, 19 Jul 2020 23:12:07 +0530
Message-Id: <1595180527-11320-11-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds uSD support for Cubieboard7 board based on Actions Semi
S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
added yet, fixed regulator has been used as a regulator node.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* Brought back the uSD fixed regulator.
Changes since v5:
        * Removed the Fixed regulators as these are
          not needed.
Changes since v4:
        * No change.
Changes since v3:
        * No change.
Changes since v2:
        * No change.
Changes since v1:
        * No change.
Changes since RFC:
        * No change.
---
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 33 ++++++++++++++++++++++++
 arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index 63e375cd9eb4..f81d63261ba2 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -13,6 +13,7 @@
 
 	aliases {
 		serial3 = &uart3;
+		mmc0 = &mmc0;
 	};
 
 	chosen {
@@ -28,6 +29,15 @@
 		device_type = "memory";
 		reg = <0x1 0xe0000000 0x0 0x0>;
 	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	sd_vcc: sd-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
 };
 
 &i2c0 {
@@ -81,6 +91,14 @@
 			bias-pull-up;
 		};
 	};
+
+	mmc0_default: mmc0_default {
+		pinmux {
+			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
+				 "sd0_cmd_mfp", "sd0_clk_mfp";
+			function = "sd0";
+		};
+	};
 };
 
 &timer {
@@ -90,3 +108,18 @@
 &uart3 {
 	status = "okay";
 };
+
+/* uSD */
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_default>;
+	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	bus-width = <4>;
+	vmmc-supply = <&sd_vcc>;
+	vqmmc-supply = <&sd_vcc>;
+};
+
diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 9ed88aafc2da..ba498cf9217d 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s700-powergate.h>
 #include <dt-bindings/reset/actions,s700-reset.h>
-- 
2.7.4

