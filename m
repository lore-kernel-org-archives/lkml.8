Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE30C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D921206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9u62OK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgFBRik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:38:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1987C05BD1E;
        Tue,  2 Jun 2020 10:38:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so5367261pfg.8;
        Tue, 02 Jun 2020 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HAbgr6zzu7r3PzTp5xRYYLgURACWC5IB5Lo9NqHN5fo=;
        b=u9u62OK0Uz5k1NzgozSXxo36T3wV9tU3tuP7QiUTICd5Z10I5tWt/FC90JijoDefoB
         hv2LAGTV3gI99dRYnbE/XPwDsJnXFEG+gx2NdICxSiBzqA+oaklooUtdmwuP+J9kpbFf
         oK+arfayMtiRluo0rXam4pMeEa8F3yKXQAoDGLYbyDWBkkLRnQRRyOTAjv1l9alSPrm8
         lzguxtttntllPT5yCJ7gcV7nzz8G19UOeseFAlA3TzpNfcIAov+O23C2W2EqtUkTfmsS
         o3ZYmU700zdrxhni6MLHxrAea767urY6Ti3b9v+aUjL1IT1XPa3QU+IYYKzyrsFMp+Z4
         0Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HAbgr6zzu7r3PzTp5xRYYLgURACWC5IB5Lo9NqHN5fo=;
        b=D0vgDrVbw6TZFExSsR/J08Vz5bVHIRULo3pXuRIkBkJVqQex9fGrga8fUImaYFgogt
         5ovH6ukDtVnCAXcmV1UfF+vrl0Iydb/MDOkXnIRcmhUn6HnvonqvutnrFOizQ1BBqwsK
         D9a/OAPuE/9Nc6HENHcv/7Z1RPA9yjc68hf24OixF788Y/5KGOppncvZCUhhxBNy+tPq
         HQguBWGD4ojbqVZDojKuPuCqBPct/VGo3Ihwur6iTSEER6KILlVtn/Mz9s8Qm/kfCUm5
         A6ve6xc0ovQlIIlzxXBuBWEoALamoy2cD2XOjXwpJo5KwR+hCN4/emeJfO0Wq+CFYSgf
         mGLA==
X-Gm-Message-State: AOAM530YIOZPV6e9EA1LoIp9w2J4ow7aKwzG0jzUkyYitSmDAa7TIM+C
        oKXwk1hke93NQ9DW5GQ09r4=
X-Google-Smtp-Source: ABdhPJxAbqcmXVF8wyXKbHqP1xkJnZ4nuq6VrQpjX+86dyaNozOCQsWXCGFL4FJIV2YghvUde/YaSA==
X-Received: by 2002:a63:658:: with SMTP id 85mr24337043pgg.181.1591119518467;
        Tue, 02 Jun 2020 10:38:38 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.38.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:38:37 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
Date:   Tue,  2 Jun 2020 23:03:12 +0530
Message-Id: <1591119192-18538-11-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds uSD support for Cubieboard7 board based on Actions Semi
S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
added yet, fixed regulator has been used as a regulator node.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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
index b1a34f95d44c..2bb29bc683ef 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/actions,s700-reset.h>
 #include <dt-bindings/power/owl-s700-powergate.h>
-- 
2.7.4

