Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E1C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9162080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inEtJl6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgAJOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:21:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgAJOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:21:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so2004029wrr.1;
        Fri, 10 Jan 2020 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QkqpNRwkXEHz49j2PunwFe7h2mlM4jVm/CGNg1v229A=;
        b=inEtJl6o63GPIno4sMCknRjQUtHCqDqQ2rVqdGl39A15ONvLjSveFoJZKq0KuAp8uh
         7jTxdKyb5QX0N8GlIczHpo6kE4aiQ1EJjf+zclxPcozEZ/SPIdEUWaaZkc+liDfkKTJT
         f57oFrnG+PA2o+tvcFZ9Zu7p5T4zatmHRREv53K+Kpi/HALZpo3jbxssQyaQ9zpXyYB3
         1O4Vdn/dU/95ezs7ngnYqwSuDpK+w8Et5Dy4fT9VETk1EAzw5h4wGGjPlRWG+f/v4d7O
         bNF38GbFVVXoCGzg0Sm4yJm6gc3WTDp4WMdGUXQ6M2pim5906SlsmSRH+xWkFKoDq+NC
         NsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QkqpNRwkXEHz49j2PunwFe7h2mlM4jVm/CGNg1v229A=;
        b=tqU/Vm1uCqRwCuIEVg/UaQGL7hvG4xy60hDiYxTTiqMd5YSDnrlhO2Ywz0i5btzFL4
         eL852wa1ykBuv9p2gtBXTo4mQiLRQa0XNCv8fVDpYNgxqZ/HXharaM3mqdCTwAnSm1Lu
         NI6TRBRfjd3hHSFdvzs6hR52w++cZbuwHNFKss81SUP3QCXvsKBkBBP/f+mLNpB0g5pM
         Tyk04aW0u8PbicU1ZaA2j/Abmz+0xe5wjLn81+V/hBl9MhhDDBwBYtqOeVz1SghE1sHK
         kqkNImBAzQ3xiBmuHIHjRY2GE4a5MTL8MpMRSxE6QmcBIhRw3TpzE5q3OWpPTfnpiDiI
         /Pkg==
X-Gm-Message-State: APjAAAW1SXY8vaf10UHrFe9R/VIWQSklWvyGdVYsNDZiZC5aGfmE5INd
        aK0Z8zKy7KZwEKqx8FJ1yAI=
X-Google-Smtp-Source: APXvYqxYWXbCZdBdnX3KYOwBOuGZD+qOcrwZQvIgjFefd82CDaIRhFVRhyi/m8FK/YH+aDHgE/O3oQ==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr3904876wrv.198.1578666095767;
        Fri, 10 Jan 2020 06:21:35 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a9sm2314148wmm.15.2020.01.10.06.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 06:21:35 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add reg property to brcmf sub node
Date:   Fri, 10 Jan 2020 15:21:28 +0100
Message-Id: <20200110142128.13522-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental test with the command below gives this error:
rk3399-firefly.dt.yaml: dwmmc@fe310000: wifi@1:
'reg' is a required property
rk3399-orangepi.dt.yaml: dwmmc@fe310000: wifi@1:
'reg' is a required property
rk3399-khadas-edge.dt.yaml: dwmmc@fe310000: wifi@1:
'reg' is a required property
rk3399-khadas-edge-captain.dt.yaml: dwmmc@fe310000: wifi@1:
'reg' is a required property
rk3399-khadas-edge-v.dt.yaml: dwmmc@fe310000: wifi@1:
'reg' is a required property
So fix this by adding a reg property to the brcmf sub node.
Also add #address-cells and #size-cells to prevent more warnings.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 3 +++
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 3 +++
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 92de83dd4..06043179f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -669,9 +669,12 @@
 	vqmmc-supply = &vcc1v8_s3;	/* IO line */
 	vmmc-supply = &vcc_sdio;	/* card's power */
 
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	brcmf: wifi@1 {
+		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index 4944d78a0..e87a04477 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -654,9 +654,12 @@
 	sd-uhs-sdr104;
 	vqmmc-supply = <&vcc1v8_s3>;
 	vmmc-supply = <&vccio_sd>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	brcmf: wifi@1 {
+		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index 0541dfce9..9c659f311 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -648,9 +648,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
 	sd-uhs-sdr104;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	brcmf: wifi@1 {
+		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
-- 
2.11.0

