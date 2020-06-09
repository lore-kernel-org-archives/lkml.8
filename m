Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7227D20823
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG/UsiXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgFIKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgFIKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:18:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96D8C03E97C;
        Tue,  9 Jun 2020 03:18:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so9880826pfg.2;
        Tue, 09 Jun 2020 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0d16ZSjZXDVB9XnoF7g8/C8LhZpWELESeA2tbYD7eQ=;
        b=AG/UsiXYoOJYlHtPerABlcHwszE5UoF6nbuNIqAJuXbLtI546Ko7bh9KoLmTyGYjSr
         tUWIgn1RMafwryN11ejY/TV7c8AX2NUCKaxRRjc57gcUjWf9bBi1WmE0vurTemfnsPas
         RZcBLC8PDd+sYXmjfuJ/0l/X4tsmNI/3f1U6jst0F/rUg+1dYxaHwem9J1Ik8tTi7CI6
         fKMrt5lmS7hEVGIdEBwT4i27WGg5sBKfey9EeYkOy4HsMjolaZ+eKmtFFMkYy4E9Ffoc
         DThy8oQFum0fYYwxYy4WIaqdo20RLLLE2hl3OUyhFYWlL81LTO0YfRq0+v0bvylmIaSi
         DrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0d16ZSjZXDVB9XnoF7g8/C8LhZpWELESeA2tbYD7eQ=;
        b=WHB3rl8eYUED5Zf5fSJf8kpOcuTA1sjTYtg7R1asY3Coq92QEPzSDRdWfpHvw5NvZJ
         huxGdAFSVh2H3Zde3/xkY0NHDwg8YTHrxDfWQ8bLzKUSbKknddSzl+yrb+g0kzKAX4yt
         gK41xMNmAlSR3XwRIrKT9pSS2pwd+bE1705m39Z4590aLYYc+MPUM+8V8pGbKNN8HFuG
         zeoJmf3aRA7LcM7pxKMmw0dDBNc1Qc59FPodkHFOmZVNvBvXku07P7JMBb1FkksAnTiV
         WivFVGY3N0XNgzXI++9Ra4QJS9hX71PWcrOeNCeoJLV0vIKQ3/ywVPANspAfYmLzIQJO
         buww==
X-Gm-Message-State: AOAM531vtROp1hPmE3aF83ZTXyifAe8PLr+iLY42BDB6UMjjzpyi4xXt
        ztgFpGiGPMtPSEf+eEUW6BQ=
X-Google-Smtp-Source: ABdhPJxXx5Nq3IGHo7wWKQw5zUcrDvnpBG2qlLfjMRL4bSyiW6rcHZW18FEGdq1l+goPWwa1qW1StA==
X-Received: by 2002:a63:af02:: with SMTP id w2mr23067058pge.116.1591697903285;
        Tue, 09 Jun 2020 03:18:23 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.18.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:18:22 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
Date:   Tue,  9 Jun 2020 15:47:10 +0530
Message-Id: <1591697830-16311-11-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds uSD support for Cubieboard7 board based on Actions Semi
S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
added yet, fixed regulator has been used as a regulator node.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v3:
	* No change.
Changes since v2:
        * No change.
Changes since v1:
        * No change.
Changes since RFC:
        * No change.
---
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 41 ++++++++++++++++++++++++
 arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index 63e375cd9eb4..ec117eb12f3a 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -13,6 +13,7 @@
 
 	aliases {
 		serial3 = &uart3;
+		mmc0 = &mmc0;
 	};
 
 	chosen {
@@ -28,6 +29,23 @@
 		device_type = "memory";
 		reg = <0x1 0xe0000000 0x0 0x0>;
 	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	vcc_3v1: vcc-3v1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+	};
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
@@ -81,6 +99,14 @@
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
@@ -90,3 +116,18 @@
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

