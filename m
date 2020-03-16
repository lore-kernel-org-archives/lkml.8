Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12327C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E5F2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWG2bc+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgCPOd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:33:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35308 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgCPOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:33:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id 5so7148346lfr.2;
        Mon, 16 Mar 2020 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZDDZumFM4GKkqmise65KcQNrnejQ1Q6C9mhu8+xXRqI=;
        b=AWG2bc+5Ee9obty+kw+QqJmaHXD0x6LGBAzcB3LeMs18u7WkxgnQW7Y4GrtHYDcNM0
         sefnHSJFaVkgZCWU85q+68eOtFB62Jd/P0u99x41+Fje0fVG8/8EBwEhfFEGkLHddt9n
         AGYTx1Zr5Oj5gYTX9I7DNlH/Wj4A3mD9qq2XkH8jtLsJwZ29gRfgS2Q+cpTM/WgFaT82
         FLkO32mTGfRVq7nrfG1zcOeV9REmaD5g+6SlBu5a+/LRxUW/ZVPjMOrr1bE5g2SA7uA1
         ym1ihLtMN+YsU28hNyTDzbewt5pJXlFkoIbSEVEUSYqvD768nslMn4YjNEGzRwqnvpWf
         NwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZDDZumFM4GKkqmise65KcQNrnejQ1Q6C9mhu8+xXRqI=;
        b=eDeGrBTLv6wLTRZdqCXdsqHYMKPz9zg0goNDAh31x1HAS/Osd4hBkWlMsmzB4r41fq
         v+xVCc1Ux4UMB8FLtIjZmm5FWcT0SOW0cnt3rzP2f3dDZrsX/1UR2SNDpYt+RIBlN5vm
         LdvjyIeZg89H1LZ1l1ihIQyw/03X25HhQLhkvuhg3r0xC6BbhaVVZfxrKY927hA7h01m
         uzoY36ZZ7vJkmLorLdzEkqHyq+mkIJGNPddV7wg75qCjMXX8Li0E+e/G+KdIq/Zhyzw9
         hKL/O2QaY5kUlLZHIz7AhPOVf4AkENOgRR062fTLWMOAbHts+nuKJK5/79dzHAFCdnyX
         F4oQ==
X-Gm-Message-State: ANhLgQ06T322PWAQYwzkzKhOUBX5EdDErBvdMzotPDb90cQjsWuOfBAx
        XwyXUtZqUdRUaWAVrCV7798=
X-Google-Smtp-Source: ADFU+vtEH3/gPLBV77T2Pvsxla+YknqaQV9OQHTagfl/9rf11cs5Qj8lXizAXfYMF8h9Iem5++ETMA==
X-Received: by 2002:a19:4350:: with SMTP id m16mr9059395lfj.67.1584369233381;
        Mon, 16 Mar 2020 07:33:53 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id k14sm16045lfg.96.2020.03.16.07.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 07:33:52 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] ARM: dts: colibri: introduce device trees with UHS-I support
Date:   Mon, 16 Mar 2020 16:33:45 +0200
Message-Id: <20200316143345.30823-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316143345.30823-1-igor.opaniuk@gmail.com>
References: <20200316143345.30823-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

1. Introduce dtsi with overlay configuration for enabling UHS-I
for Colibri iMX6S/DL V1.1x re-design.
2. Introduce new dts for the Colibri iMX6S/DL V1.1x
on Colibri Evaluation Carrier Board V3.x. However, disable 1.8V for
the Colibri Evaluation Board since this carrier board has 3.3V pull-ups on.
3. Provide proper configuration for VGEN3, which allows that rail to
be automatically switched to 1.8 volts for proper UHS-I operation mode.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

v5:
- Fix copyright/licensing [Shawn Guo]
- Don't enable 1.8V by default, as some carrier boards have 3.3V pull-ups,
  which leads to [  164.058099] mmc0: error -110 whilst initialising SD
  card errors. [Marcel Ziswiler]
- Change hierarchy: move SD-card properties to the module level device
  tree include (to explicitly state that these properties relate to module,
  not carrier board) + people can easily include it in their custom
  carrier board device trees.

v4:
- Document Colibri iMX6S/DL V1.1x re-design devicetree binding [Shawn Guo]
- wakeup-source property fix [Shawn Guo]

v3:
- change hierarchy according to Marco's suggestions [Marco Felsch]
- adjust compatible string adding v1.1 [Stefan Agner]

v2:
- rework hierarchy of dts files, and a separate dtsi for Colibri
  iMX6S/DL V1.1x re-design, where UHS-I was added [Marcel Ziswiler]
- add comments about vgen3 power rail [Marcel Ziswiler]
- fix other minor issues, addressing Marcel's comments. [Marcel Ziswiler]

 arch/arm/boot/dts/Makefile                    |  1 +
 .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  | 31 +++++++++++++
 .../boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi    | 44 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 11 ++++-
 4 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d6546d2676b9..97da51be1de6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -412,6 +412,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-aristainetos2_4.dtb \
 	imx6dl-aristainetos2_7.dtb \
 	imx6dl-colibri-eval-v3.dtb \
+	imx6dl-colibri-v1_1-eval-v3.dtb \
 	imx6dl-cubox-i.dtb \
 	imx6dl-cubox-i-emmc-som-v15.dtb \
 	imx6dl-cubox-i-som-v15.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
new file mode 100644
index 000000000000..223275f028f1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright 2020 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6dl-colibri-eval-v3.dts"
+#include "imx6qdl-colibri-v1_1-uhs.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6DL/S V1.1 on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri_imx6dl-v1_1-eval-v3",
+		     "toradex,colibri_imx6dl-v1_1",
+		     "toradex,colibri_imx6dl-eval-v3",
+		     "toradex,colibri_imx6dl",
+		     "fsl,imx6dl";
+};
+
+/* Colibri MMC */
+&usdhc1 {
+	status = "okay";
+	/*
+	 * Please make sure your carrier board does not pull-up any of
+	 * the MMC/SD signals to 3.3 volt before attempting to activate
+	 * UHS-I support.
+	 * To let signaling voltage be changed to 1.8V, please
+	 * delete no-1-8-v property (example below):
+	 * /delete-property/no-1-8-v;
+	 */
+};
diff --git a/arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi b/arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi
new file mode 100644
index 000000000000..7672fbfc29be
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright 2020 Toradex
+ */
+
+&iomuxc {
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170b1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170b1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170b1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170b1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170f1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170f1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170f1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170f1
+		>;
+	};
+};
+
+/* Colibri MMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
+	vmmc-supply = <&reg_module_3v3>;
+	vqmmc-supply = <&vgen3_reg>;
+	wakeup-source;
+	keep-power-in-suspend;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index d03dff23863d..e85a41e84fd4 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -229,7 +229,16 @@
 				regulator-always-on;
 			};
 
-			/* vgen3: unused */
+			/*
+			 * +V3.3_1.8_SD1 coming off VGEN3 and supplying
+			 * the i.MX 6 NVCC_SD1.
+			 */
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
 
 			vgen4_reg: vgen4 {
 				regulator-min-microvolt = <1800000>;
-- 
2.17.1

