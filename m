Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B36C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3122522BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OrN32bn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgGTLCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgGTLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:02:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F812C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:02:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so10140890pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nE2C5G9azmjt7+W5WypzQU7MH/oEmdhAcqvQRmdBylE=;
        b=OrN32bn1NLV16DqlcAg6lzQE2YeAojK5jFDLALPUOg2KRPpv/YIV7iQ0c//+WbvOxy
         E2dSu40efbgjfG8KMFeADvWMwgu83b+SVTErIsqYw0qckAAuE6LIhb9pc4cJLdwYRhuJ
         DeCh+/uQLtRMQ13kbNIGis2fG1nUBijMGZg+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nE2C5G9azmjt7+W5WypzQU7MH/oEmdhAcqvQRmdBylE=;
        b=jdaAr9di4v5IWxwj+IvH8A5uzM0c9Asx/uYdrjjzrlZxKFgZPzNWFk40xJQLHd3DWF
         6SLhPbMCj8/LbjyBsNPykO6iWM9nRXSbEAIt3yCl9elj2841wOr1Qv6X7ugsKng0vwDq
         a34heR630Ie4FtArJoenrwa81rXfXgBblUeOqu8lMpm94FNN9pjeWHjdx6os48T6lal2
         WBLae3PeX4HKuOGdv2GDLR8epupdqYtvtML0hYcWzVRWMcJJ+hfPIBuAFmssKf1tjyzo
         dZ9cSrdAcWBRFrXpA4ALUjke1lJ2+u9yG1KF9KUxwyeZgPwHJWmuIP/mWxYe+c9tY/Dn
         C4sA==
X-Gm-Message-State: AOAM530fOoeGVXP4BY78w2F30NHn7KbYuu4YLQ4uUE2rOX/DLmm5LjH9
        epIqK7GSf6DD1Nv89tu5TLXhaA==
X-Google-Smtp-Source: ABdhPJzfZGwcRqJ/2TJ7XK9B7mq5al4xcTrrQMO1xpDhX5tStOastAhCSymLPYlFkDb/+SJbR5N7wA==
X-Received: by 2002:a63:757:: with SMTP id 84mr18562219pgh.275.1595242973437;
        Mon, 20 Jul 2020 04:02:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8c21:db7b:4558:fba3])
        by smtp.gmail.com with ESMTPSA id o10sm11445876pjs.27.2020.07.20.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 04:02:52 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/3] ARM: dts: rockchip: Add USB for RockPI N8/N10
Date:   Mon, 20 Jul 2020 16:32:28 +0530
Message-Id: <20200720110230.367985-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa dalang carrier board has 2x USB 2.0 and 1x USB 3.0
ports.

This patch adds support to enable all these USB ports for
N10 and N8 combinations SBCs.

Note that the USB 3.0 port on RockPI N8 combination works
as USB 2.0 OTG since it is driven from RK3288.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
- depends on https://lkml.org/lkml/2020/7/20/446

 arch/arm/boot/dts/rk3288-vmarc-som.dtsi       | 42 ++++++++++
 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 18 +++++
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 78 +++++++++++++++++++
 3 files changed, 138 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
index 0bcb9f067d66..abe3c01d13aa 100644
--- a/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-vmarc-som.dtsi
@@ -267,4 +267,46 @@ sdmmc_cmd: sdmmc-cmd {
 			rockchip,pins = <6 RK_PC5 1 &pcfg_pull_up_drv_8ma>;
 		};
 	};
+
+	vbus_host {
+		usb1_en_oc: usb1-en-oc {
+			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	vbus_typec {
+		usb0_en_oc: usb0-en-oc {
+			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&usbphy {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1 {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
+
+&vbus_host {
+	enable-active-high;
+	gpio = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>; /* USB1_EN_OC# */
+};
+
+&vbus_typec {
+	enable-active-high;
+	gpio = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>; /* USB0_EN_OC# */
 };
diff --git a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
index 450e5bb5af0b..d2b6ead148a2 100644
--- a/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -33,6 +33,24 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc12v_dcin>;
 	};
+
+	vbus_host: vbus-host {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb1_en_oc>;
+		regulator-name = "vbus_host"; /* HOST-5V */
+		regulator-always-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vbus_typec: vbus-typec {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb0_en_oc>;
+		regulator-name = "vbus_typec";
+		regulator-always-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &gmac {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 37ed95d5f7e9..111d6cf9a4e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -304,6 +304,18 @@ pmic_int_l: pmic-int-l {
 			rockchip,pins = <1 RK_PC2 0 &pcfg_pull_up>;
 		};
 	};
+
+	vbus_host {
+		usb1_en_oc: usb1-en-oc {
+			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	vbus_typec {
+		usb0_en_oc: usb0-en-oc {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
 };
 
 &pmu_io_domains {
@@ -324,8 +336,74 @@ &sdmmc {
 	max-frequency = <150000000>;
 };
 
+&tcphy0 {
+	status = "okay";
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <1>;
 	rockchip,hw-tshut-polarity = <1>;
 	status = "okay";
 };
+
+&u2phy0 {
+	status = "okay";
+
+	u2phy0_otg: otg-port {
+		phy-supply = <&vbus_typec>;
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		phy-supply = <&vbus_host>;
+		status = "okay";
+	};
+};
+
+
+&u2phy1 {
+	status = "okay";
+
+	u2phy1_host: host-port {
+		phy-supply = <&vbus_host>;
+		status = "okay";
+	};
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+};
+
+&vbus_host {
+	enable-active-high;
+	gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>; /* USB1_EN_OC# */
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_en_oc>;
+};
+
+&vbus_typec {
+	enable-active-high;
+	gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>; /* USB0_EN_OC# */
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_en_oc>;
+};
-- 
2.25.1

