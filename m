Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E489F20672
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOTatsuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgFYAIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbgFYAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:08:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27519C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 17:08:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so1919146ply.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDQmr4M7f0b4vct3QfFl9IqKo/J7WcBaHfYFiG0iFP4=;
        b=jOTatsuvSAFGuC1zfOvuK87RmUepW0cCS/gKGHr6z7GtyB/DNCfzkpjiv0eSlqkgL7
         4W0gMsAciQDh2x2Q/um5d43SuKEDH5Ob15/3R7ktlgpz4GsoUjf32Cv3X6u2JHbwHrPn
         jJ8YOn8/Bsk/1M+Z7fDSUlWLidg9db+SwOZaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDQmr4M7f0b4vct3QfFl9IqKo/J7WcBaHfYFiG0iFP4=;
        b=V2dfsvwNL+MUdvkUVbC19XAgw9r7yqggGo96+KK47f281qzl77MQX+rocZ2AT5Av5M
         vpRD4ErvjKwPQQ60nkV3ZDh8GIzWb2OXS5I7DsMQVCAW/wOyFaAokzvAdFhcJIFIHb0y
         wGlMVdWiw5xlJnlsKq2/DTJirDUDG58nW+snpc/py8wrjhtLhqL6oYKKrxprvDXUfKTJ
         GGCaZ0qllZCsAgqHMBctsqJXL9jrAFMGG1kcIA3zY4VyTKnbGsF0NGdJB06IOApKeQ65
         0XMU4HJcqMU1uJN/0G0MupdSS7DdrrfWVlKGzht29vT2SWGWUfx1sCS6AmRjmMeB05ff
         MCrg==
X-Gm-Message-State: AOAM5332hx2wR3bWCLh/G+/tMjRGDDcnkn47ORMavAEN1lqyipmxFOyX
        yTNOKdY1W5dnD6WB2/7f4b8juQ==
X-Google-Smtp-Source: ABdhPJwmmHgiFaWnjRljKgSdj7Q1Wrf7FJQbi5FMZjnUD3Vm8dho6daBPalirc/2BVyVB2AViDwBZA==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr30625569pld.301.1593043693448;
        Wed, 24 Jun 2020 17:08:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id dw17sm5905866pjb.40.2020.06.24.17.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 17:08:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sc7180: Switch SPI to use GPIO for CS
Date:   Wed, 24 Jun 2020 17:08:04 -0700
Message-Id: <20200624170746.1.I997a428f58ef9d48b37a27a028360f34e66c00ec@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni SPI protocol appears to have been designed without taking
Linux needs into account.  In all the normal flows it takes care of
setting chip select itself.  However, Linux likes to manage the chip
select so it can do fancy things.

Back when we first landed the geni SPI driver we worked around this
by:
- Always setting the FRAGMENTATION bit in transfers, which (I believe)
  tells the SPI controller not to mess with the chip select during
  transfers.
- Controlling the chip select manually by sending the SPI controller
  commands to assert or deassert the chip select.

Our workaround was fine and it's been working OK, but it's really
quite inefficient.  A normal SPI transaction now needs to do:
1. Start a command to set the chip select.
2. Wait for an interrupt from controller saying chip select done.
3. Do a transfer.
4. Start a command to unset the chip select.
5. Wait for an interrupt from controller saying chip select done.

Things are made a bit worse because the Linux GPIO framework assumes
that setting a chip select is quick.  Thus the SPI core can be seen to
tell us to set our chip select even when it's already in the right
state and we were dutifully kicking off commands and waiting for
interrupts.  While we could optimize that particular case, we'd still
be left with the slowness when we actually needed to toggle the chip
select.

All the chip select lines can actually be muxed to be GPIOs and
there's really no downside in doing so.  Now Linux can assert and
deassert the chip select at will with a simple MMIO write.

The SPI driver will still have the ability to set the chip select, but
not we just won't use it.

With this change I tested reading the firmware off the EC connected to
a ChromeOS device (flashrom -p ec -r ...).  I saw about a 25% speedup
in total runtime of the command and a 30% reduction in interrupts
generated (measured by /proc/interrupts).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 57 ++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 3a8076c8bdbf..74c8503b560e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sc7180.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7180.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,sc7180.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
@@ -570,6 +571,7 @@ spi0: spi@880000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -607,6 +609,7 @@ spi1: spi@884000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -668,6 +671,7 @@ spi3: spi@88c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 41 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -729,6 +733,7 @@ spi5: spi@894000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 28 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -779,6 +784,7 @@ spi6: spi@a80000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi6_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -840,6 +846,7 @@ spi8: spi@a88000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi8_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 45 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -901,6 +908,7 @@ spi10: spi@a90000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi10_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -938,6 +946,7 @@ spi11: spi@a94000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi11_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				cs-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1204,65 +1213,97 @@ pinmux {
 			qup_spi0_default: qup-spi0-default {
 				pinmux {
 					pins = "gpio34", "gpio35",
-					       "gpio36", "gpio37";
+					       "gpio36";
 					function = "qup00";
 				};
+				pinmux-cs {
+					pins = "gpio37";
+					function = "gpio";
+				};
 			};
 
 			qup_spi1_default: qup-spi1-default {
 				pinmux {
 					pins = "gpio0", "gpio1",
-					       "gpio2", "gpio3";
+					       "gpio2";
 					function = "qup01";
 				};
+				pinmux-cs {
+					pins = "gpio3";
+					function = "gpio";
+				};
 			};
 
 			qup_spi3_default: qup-spi3-default {
 				pinmux {
 					pins = "gpio38", "gpio39",
-					       "gpio40", "gpio41";
+					       "gpio40";
 					function = "qup03";
 				};
+				pinmux-cs {
+					pins = "gpio41";
+					function = "gpio";
+				};
 			};
 
 			qup_spi5_default: qup-spi5-default {
 				pinmux {
 					pins = "gpio25", "gpio26",
-					       "gpio27", "gpio28";
+					       "gpio27";
 					function = "qup05";
 				};
+				pinmux-cs {
+					pins = "gpio28";
+					function = "gpio";
+				};
 			};
 
 			qup_spi6_default: qup-spi6-default {
 				pinmux {
 					pins = "gpio59", "gpio60",
-					       "gpio61", "gpio62";
+					       "gpio61";
 					function = "qup10";
 				};
+				pinmux-cs {
+					pins = "gpio62";
+					function = "gpio";
+				};
 			};
 
 			qup_spi8_default: qup-spi8-default {
 				pinmux {
 					pins = "gpio42", "gpio43",
-					       "gpio44", "gpio45";
+					       "gpio44";
 					function = "qup12";
 				};
+				pinmux-cs {
+					pins = "gpio45";
+					function = "gpio";
+				};
 			};
 
 			qup_spi10_default: qup-spi10-default {
 				pinmux {
 					pins = "gpio86", "gpio87",
-					       "gpio88", "gpio89";
+					       "gpio88";
 					function = "qup14";
 				};
+				pinmux-cs {
+					pins = "gpio89";
+					function = "gpio";
+				};
 			};
 
 			qup_spi11_default: qup-spi11-default {
 				pinmux {
 					pins = "gpio53", "gpio54",
-					       "gpio55", "gpio56";
+					       "gpio55";
 					function = "qup15";
 				};
+				pinmux-cs {
+					pins = "gpio56";
+					function = "gpio";
+				};
 			};
 
 			qup_uart0_default: qup-uart0-default {
-- 
2.27.0.212.ge8ba1cc988-goog

