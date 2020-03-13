Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD9FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A76B2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ehu6PcgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCMJHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:07:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCMJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:07:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so11052381wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noym7N9HZ+0j3iemfyMolfTdAyqS68kNioWo1cBTRwM=;
        b=ehu6PcgPt850KQjzoV4GQagTdcUkLwYwh710xe+NU9v3iKlSKlhiukznVO0+fscCuX
         ScMV50BTelVKnRfFRKF9i6Vqn+RkQNHi1mN91q7nY0c0GYa9PXXbs+WXKLhWFVuew+vu
         BmmzNXNA8BPF9/bpDsmnAjsV7wcjvbQe5l9Gn8oVQYrxWIoI8fouyIhVJLhMr7iH4ubA
         FoLE1KQn+dGzWQPq0mepHbGk8DAZRmrZ9xpg3G8PiOnY/eZAr2u2NVRRzFhETaB8BqA8
         ZK4NEQXE18nuIuTn8tuluoTFL3TfuMX8qP3OUMCxsUjq9/wZWXwGqY5VofbKyzUZ2v8U
         nmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noym7N9HZ+0j3iemfyMolfTdAyqS68kNioWo1cBTRwM=;
        b=PuXmMgVHxvMmD5MAzbhNHTv3YI9m+ekeYN3NToDGE0TulhKoNOMNt2uPmM5pS36liT
         Qo/DeMZKaRsz0ai4QcKUTZ9yTml/EZzDwAO2ABJJLJMIxW+D4Cb1GXNBrqBv6VrtrSYQ
         /AS3EWvDb0U1aDJs5eFttst0vNAs2YAp23hgcYqVB569/bSRFFDCAfcjHSU+7yOnCMc+
         IwzIOgOQkwTqit4qH86EUDyJ393zy+O/S8QCEPG/wlF+YmUugj10B942IoyB/BDhdlJ0
         73zyEx0T4GwvGc62f5Go+hdZtL0pZefh5UGaza4IVMlawZ/7DmqX18YtByBRCK01Vl5z
         HoNA==
X-Gm-Message-State: ANhLgQ10R+gAl28/Q2EXx8GQMf+3zaK5RR8gGuwnUFImiYiSsaIlRqzC
        ncSb/fI8a1LNHxxf4wQucZmITw==
X-Google-Smtp-Source: ADFU+vvGEUqKOHAbXHeHU9sk0wLV/5ZlhtBmNDC8otoQy0IjrRf1k/8Ec6KWw0KmFvH2+W0feRZgzA==
X-Received: by 2002:adf:c40e:: with SMTP id v14mr16353044wrf.408.1584090438334;
        Fri, 13 Mar 2020 02:07:18 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id i1sm61872399wrs.18.2020.03.13.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:07:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] arm64: dts: meson-g12: split emmc pins to select 4 or 8 bus width
Date:   Fri, 13 Mar 2020 10:07:10 +0100
Message-Id: <20200313090713.15147-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200313090713.15147-1-narmstrong@baylibre.com>
References: <20200313090713.15147-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas VIM3 shares the eMMC pins 4 to 7 with the SPI NOR, in order
to enable the eMMC and the SPI NOR interface, we need to omit the
4 last pins from the eMMC pinctrl.

As it was done for the Khadas VIM2, split the eMMC pinctrls in ctrl, data
and ds pins with either 4bits data or 8bits data, and update the current
board accordingly.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 40 ++++++++++++++-----
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  2 +-
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  2 +-
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  2 +-
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts |  2 +-
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  2 +-
 .../boot/dts/amlogic/meson-sm1-sei610.dts     |  2 +-
 8 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 87b9a47a51b9..d09efb86ec33 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -295,17 +295,9 @@
 						};
 					};
 
-					emmc_pins: emmc {
+					emmc_ctrl_pins: emmc-ctrl {
 						mux-0 {
-							groups = "emmc_nand_d0",
-								 "emmc_nand_d1",
-								 "emmc_nand_d2",
-								 "emmc_nand_d3",
-								 "emmc_nand_d4",
-								 "emmc_nand_d5",
-								 "emmc_nand_d6",
-								 "emmc_nand_d7",
-								 "emmc_cmd";
+							groups = "emmc_cmd";
 							function = "emmc";
 							bias-pull-up;
 							drive-strength-microamp = <4000>;
@@ -319,6 +311,34 @@
 						};
 					};
 
+					emmc_data_4b_pins: emmc-data-4b {
+						mux-0 {
+							groups = "emmc_nand_d0",
+								 "emmc_nand_d1",
+								 "emmc_nand_d2",
+								 "emmc_nand_d3";
+							function = "emmc";
+							bias-pull-up;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					emmc_data_8b_pins: emmc-data-8b {
+						mux-0 {
+							groups = "emmc_nand_d0",
+								 "emmc_nand_d1",
+								 "emmc_nand_d2",
+								 "emmc_nand_d3",
+								 "emmc_nand_d4",
+								 "emmc_nand_d5",
+								 "emmc_nand_d6",
+								 "emmc_nand_d7";
+							function = "emmc";
+							bias-pull-up;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
 					emmc_ds_pins: emmc-ds {
 						mux {
 							groups = "emmc_nand_ds";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 168f460e11fa..b00d0468c753 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -472,7 +472,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 2a324f0136e3..a26bfe72550f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -271,7 +271,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 4f2596d82989..1b07c8c06eac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -443,7 +443,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 8830d3844885..b59ae1a297f2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -435,7 +435,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index ccd0bced01e8..325e448eb09c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -485,7 +485,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 90815fa25ec6..b6f22a0bd318 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -312,7 +312,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index a8bb3fa9fec9..71cc730a4913 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -518,7 +518,7 @@
 /* eMMC */
 &sd_emmc_c {
 	status = "okay";
-	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
-- 
2.22.0

