Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F35C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7093206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ4LcDQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCLSv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:51:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42191 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCLSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:51:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so7685709ljp.9;
        Thu, 12 Mar 2020 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=13R22XMmnPBFa+XmLMhxZD9IQtiRWvB+ZAw8frnViw0=;
        b=aJ4LcDQXRf5MxDhImbvLsLuy+sb0rdgQyk162IKS9yk4AXXr0WsxVekRzqN5/8tfYv
         vGaMMMgNlcoYshhJLimAUKBTy+EbL31KxKkM/qYDzwGuhC+75w7NPT+FM398fchnJSqm
         KCah2EGT57BhFPHWAskt2OlJBayaYwy5zW4pUikp5yzE6j4N70ommkMHvckWWL4NVs0N
         ACIHuVVhNxeFB93tFiLCGK6DRjYTrqaD/4WurbmcOudsXggvZrFkCEVVliukSHhWFZna
         r+fqwuw7ubQ3brPRFf+72lAWEG+5Hj98yqT3w8H6vG2Uq8p0OG88P0F7lpKnkPKr9zPS
         BcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=13R22XMmnPBFa+XmLMhxZD9IQtiRWvB+ZAw8frnViw0=;
        b=TWHRdRym3R2FzYk/vOmXVzJxrmAfBvIEfBLFbryP6vlWv7ovKxUQJtid70B+9rxKZu
         vdYCCxKlLwceSeKNBqPnRdKe+LCwQ3fAV3BxbDE9QHNWCpO20EfLD/RFzQArwcTUH2i1
         NATka2wHwj6J0KjKtYZp0LAv2smy0zSvx4MhXKkMZgD4HVDBp9ZZ4rQNHe2+amuFCwwj
         lM8JR+5j4trLRVyTlu9+f48yBbotyeEP984YGN/FR8O5UV+sw6OLWRAU+dq7wFF3lA1F
         NKXyoIuQFC3WFZ+MirOVpGOYNs/ITZgJ5HamdqFbGQhBX45hb/zamT7TekEjRZqVy2Fx
         Ko2A==
X-Gm-Message-State: ANhLgQ1r0my8STG4gPa44GQoFYXHATg/fjbVCfN+wy0dPzmWx0LXhrIF
        u1hsRe60B977FoKzuosimSA=
X-Google-Smtp-Source: ADFU+vvJDdtdslvLrUQYWZOsOPYcn6i7Mb55d50MfAnEAC8qjdT0/2mBVDsAMNmUYQN7OvDpHCg2QQ==
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr5813851ljn.5.1584039084278;
        Thu, 12 Mar 2020 11:51:24 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id h6sm5281346lji.39.2020.03.12.11.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 11:51:23 -0700 (PDT)
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
Subject: [PATCH v4 2/2] ARM: dts: colibri: introduce dts with UHS-I support enabled
Date:   Thu, 12 Mar 2020 20:51:13 +0200
Message-Id: <20200312185113.2504-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312185113.2504-1-igor.opaniuk@gmail.com>
References: <20200312185113.2504-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Introduce DTS for Colibri iMX6S/DL V1.1x re-design, where UHS-I support was
added. Provide proper configuration for VGEN3, which allows that rail to
be automatically switched to 1.8 volts for proper UHS-I operation mode.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

---

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
 .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  | 59 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 11 +++-
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts

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
index 000000000000..fced7d99f5d5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+/*
+ * Copyright 2019 Toradex AG
+ */
+
+/dts-v1/;
+
+#include "imx6dl-colibri-eval-v3.dts"
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
+	status = "okay";
+	/delete-property/no-1-8-v;
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

