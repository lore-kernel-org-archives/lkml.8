Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB1C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C7F20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Y78B8K7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgDETXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:23:17 -0400
Received: from mail-bgr052101131056.outbound.protection.outlook.com ([52.101.131.56]:60219
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727612AbgDETXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlprnCBFTCbGN6nvOLdRXb4W/gzkx8MjUad/gX5CKRpTM0IbT39HRspdE18EMIKJnzHDeKqpHD0kU9U2ZWjBv50hIICKhADh8s3pZwsFmNe+VpzveWSg9zTBzO3NLwxpYD5rO9g2mIGX6dmiM0aljOWAYDXxyf5JLdFAk4ffgmC9n5cFsa8Jyt7aoDc4Xcrw89wuHJQzIff3oTmcoX+2Mu1Wxxa60YncVLuH28FSDf2OjxtgrMTfQ4rXf0XuEdvr6MMp23/bk5xB2UmiVCwgo1OAT3J7pkWgp7V1JTT8lgSDrkx+6LPhwFt9QSX1LDvmSkrK7Tnu6GuMhvdPtRb4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOkPSnLpEY3RV6H3sW5ScnsoPQ0jQtXmv5Rbt1I9oY0=;
 b=SkWFkSoJZ1wQ9L/5C/Bxkzme9IHu3L8jbtyPLAexgnN50y/1SKWVcTu8Ye6LGf1bwLsN544hVkJRekLrcCacZFPaf1okzEPervCanYsBwCMdXUL4/+1rc0W0yWvpaMwND4c4g+aRCJKKZ5vaxn9TQ6Tvp4QyL8RUsABcwev7kG2LMLMZGJdcKOPE7+BeXkYhmSQyOk5z4S+luqfPzdqMRrDDNA/QayDthQPZHW1K57tODIyBY/fch64AEhdBLY9458t1df01HYfFIoycnTzaTCSruUNXQaSw1QH7iOX94LcarW93ZamaS80Mk03ofr5EvriifCUiJhCZ6O6laAIZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOkPSnLpEY3RV6H3sW5ScnsoPQ0jQtXmv5Rbt1I9oY0=;
 b=Y78B8K7qLBxERzkx/HyPgyjhnKp6FKEf5unM/1d8GRVUjkDgy7d1x3adMgi7mV6aI+uIbgYsYUkoje/DSZ4a35sXPk4Oj+d1wAJM2Frh9D6G5A6bFtw+XUoymCo15xtR25wkSh0WD0w/I/rHbR80ljg4Cuv12dvm6pZWhwgzM90=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
 by VI1PR05MB5373.eurprd05.prod.outlook.com (2603:10a6:803:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Sun, 5 Apr
 2020 19:22:59 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 19:22:58 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Akash Gajjar <akash@openedev.com>,
        Alexis Ballier <aballier@gentoo.org>,
        =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>,
        Andy Yan <andy.yan@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Nick Xie <nick@khadas.com>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Soeren Moch <smoch@web.de>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Vicente Bergas <vicencb@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [RFC PATCH v2 3/6] arm64: dts: pwm: replace flag 1 with PWM_POLARITY_INVERTED
Date:   Sun,  5 Apr 2020 22:22:43 +0300
Message-Id: <20200405192246.3741784-4-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::15) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by GV0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Sun, 5 Apr 2020 19:22:58 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60734f8b-7b30-414f-1e4f-08d7d996c00f
X-MS-TrafficTypeDiagnostic: VI1PR05MB5373:|VI1PR05MB5373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB53738EEB362BF1F9A5B9E13CF9C50@VI1PR05MB5373.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR05MB3279.eurprd05.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(54906003)(6486002)(55236004)(81156014)(2906002)(8676002)(508600001)(86362001)(52116002)(6496006)(26005)(81166006)(316002)(8936002)(36756003)(6666004)(956004)(66946007)(2616005)(7416002)(1076003)(186003)(16526019)(66556008)(66476007)(44832011)(6916009)(5660300002)(4326008)(23200700001);DIR:OUT;SFP:1501;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrgeAKfj9VjdcQTH47lH95FtpIrF6naza8D4bQutKa1cLqsgqqN/zkl1WCP1sujELglaon3tyRSgjH6bdlZsO8iPNicw/UC55qzeAzD/DZ9lx44731RKDghOEUvygQrPIuh5uQK/28+y7bDIzHvl3Hdb30QQvT/NUj0MrLY4xiDxV0Nwrw5+PNhOztvcCrPTF9VU9kF9pFmlx9LzQ+6PPELB5Sdbv8Sge2heEDt5iVFPW4E3ToSgXB/OiA9I/cSlbBC825NBAfpb1HpaYBNtOD9ZRKhv8rboILoLgWl7eES0w5JETZEiGYZFuaq1mQBDGgmakQUhvBUJopmN3nKCphxQEatRnrUL28IopaQqfD2vBzHK+hijxdMn1HALCD64t5ozArDEXUJ8nJ+8ObbogJrhLWk2Tz4H0G2bnaIRQDCSGdyuLJ3rjGaQ/gT5qkyl5oeFS2/vbuIk5TyGy/9rcWT3HU0cPqS/jkfF6bcX+WWA7QwKf5CCpd/hxg40i4n/YBtdEIk20htlDtXFqQbwJiJyiC+c4ZZG7kjVy70P907c68042SZ35m7yZXY8AoTVBfxu4BQylsA9WusK1FCiBbTXejuw9SL382HOyYJCbhtaxazh1u6wLO8tDP3W95vbERjoiFxUMP5P3wTlb4OI9srYbtfGNQIc/3B/Q8lxdgLKkLH9MgIFyYtuNch5dzkOwPtLN5F86AL/GcIYPFzdeZjemQBGfzUXU+SxxfFT8Jl+Mn9ogxdXCbe3L+Ogh3PZ7hwmWpq8Xp+XnlbElzzfxQ==
X-MS-Exchange-AntiSpam-MessageData: vNZVWWOoJybCB/djMZ4Tm1Ey+YYyNEj/eLDzZJjwqihfyQ9KtU4UI/NKyNMJo4fapF8uTs5Ixjrs0Fx2LxJpH238MHueIyixKo9pUCvbwsLJhKu3uDJSedvAQ0/75oxg4lURFsq48gfDbNBEGvcxDQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60734f8b-7b30-414f-1e4f-08d7d996c00f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 19:22:58.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OzTja0fYmNiI/T3J1P0udUwhIjIgbNMUySXokrkPupkspV9jQQRKvKca4lPLVgbhggiFv1JBJfqiourdnkobanHMywnvsc7WnfSKmqxJ9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag '1' in the 3rd cell of the "pwms" property means the inverted
polarity.

This patch converts '1' flag into macro PWM_POLARITY_INVERTED.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3308-evb.dts          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts       | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi      | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
index 9b4f855ea5d4..8a198676cef3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
@@ -155,7 +155,7 @@ vcc5v0_host: vcc5v0-host {
 
 	vdd_core: vdd-core {
 		compatible = "pwm-regulator";
-		pwms = <&pwm0 0 5000 1>;
+		pwms = <&pwm0 0 5000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_core";
 		regulator-min-microvolt = <827000>;
 		regulator-max-microvolt = <1340000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index aa256350b18f..6ef851e7e16a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -96,7 +96,7 @@ vcc_sd: vcc-sd {
 
 	vdd_core: vdd-core {
 		compatible = "pwm-regulator";
-		pwms = <&pwm0 0 5000 1>;
+		pwms = <&pwm0 0 5000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_core";
 		regulator-min-microvolt = <827000>;
 		regulator-max-microvolt = <1340000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index d63faf38cc81..5617a441e141 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -202,7 +202,7 @@ vcc_sys: vcc-sys {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index aee484a05181..5c590f99d80e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -115,7 +115,7 @@ vcc5v0_usb: vcc5v0-usb {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		pwm-supply = <&vcc_sys>;
 		regulator-name = "vdd_log";
 		regulator-min-microvolt = <800000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index e87a04477440..47890757e866 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -73,7 +73,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
index 73be38a53796..d6c069c6e195 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
@@ -95,7 +95,7 @@ vcc5v0_sys: vcc5v0-sys {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index f9f7246d4d2f..bf9976346c0b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -158,7 +158,7 @@ vcc_sys: vcc-sys {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 5ea281b55fe2..5884968cd5b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -228,7 +228,7 @@ regulator-state-mem {
 	/* RK3399 logic supply */
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 9f225e9c3d54..d9dad0f45564 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -191,7 +191,7 @@ vcc_sys: vcc-sys {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
index 3923ec01ef66..5e4f535ef607 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
@@ -122,7 +122,7 @@ regulator-state-mem {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 9bca25801260..5eedeae21189 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -163,7 +163,7 @@ vcc5v0_usb: vcc5v0-usb {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 1bc1579674e5..9391110b788f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -127,7 +127,7 @@ vcc_sys: vcc-sys {
 
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
-- 
2.24.1

