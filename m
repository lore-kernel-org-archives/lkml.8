Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE362208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li/iRMGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgGBOyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgGBOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:54:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24DC08C5C1;
        Thu,  2 Jul 2020 07:54:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so3227192pjb.3;
        Thu, 02 Jul 2020 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2wOYN/0g0f5pbtH8g7BnJjydy7AU6qktq0S+o7E8FNM=;
        b=li/iRMGK1qmwA85z7TyIQB8rzEwcpW3lVJcAwYVcxGy4xXPWlYZow+e6hNmEH1nMaG
         caz3keLrkucWhYLsNYp8n+S3KIGktp5D2yilmH9iggZS3ktNjMmxscQm2cAETwAqCOr0
         uReKfSFCTZi0153Rr03CYwo0/xl6fhWtbqOIT0TU/WN5/2G2ykhCgwkq7hUyr+mVg0FT
         eZ+kOMoKaIONivxGMmrqfeyTb3a7RzDLpsvzwDwCQBOSORNGB8LVNRCgIPTiMzxjRawu
         CBflcAO7xFc/qbxsjUo5cFleKTk0qHiAwL/gRMM72HUtgzH+QpjER/jtDXxPD0j3wgUX
         3b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2wOYN/0g0f5pbtH8g7BnJjydy7AU6qktq0S+o7E8FNM=;
        b=GB/nnJv8IQvF0BVMyNHnzA+LEy61GiOVB/XWzWEk0+5331WLW6Z7HGYMFRLGWCHxBo
         9xCJC0pMwfxWiPV0wRu7BjLnyF6qaNxuaozu/QlgRjHjt7HzACxQfd800lCb7bXQnV33
         QHI20c4zBrpZgjX0PWhX5/jTFJSQI6i7zT2Qr+UP1UICNWn8y+3QdbG5yd+/xhshRkSh
         TMzdvgUJQR/Clw4YjZcUqeDAaPlQ49BlBfhCbQIHLb2EKKv5MLFXpSUxMRw4sAgkaqBz
         imMOU4AmVV0OAL47q4TAiBCygZD3vlX9LMnIWCSuYJSVIKzW8qioRE22JyZSf5FHni6o
         oKmA==
X-Gm-Message-State: AOAM533VKyd7lW7nZAr14MQemQHZ4GMhaPx8xqCQsKqP5LpWcSvPTEnA
        w4mehUl5mjmLAZetV1O7C7w=
X-Google-Smtp-Source: ABdhPJzteWrhGhXZLrpA2r7Wt2Dm1p8TiSi9Df05rcAtFbe3Dju+8vv5u638WNYUlvV80s05qtO+NA==
X-Received: by 2002:a17:90b:4c91:: with SMTP id my17mr30750529pjb.81.1593701643332;
        Thu, 02 Jul 2020 07:54:03 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:54:02 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
Date:   Thu,  2 Jul 2020 20:22:56 +0530
Message-Id: <1593701576-28580-11-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds uSD support for Cubieboard7 board based on Actions Semi
S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
added yet, fixed regulator has been used as a regulator node.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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

