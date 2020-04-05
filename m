Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B869C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BA720672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="TNHqFK+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgDETXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:23:13 -0400
Received: from mail-bgr052101131056.outbound.protection.outlook.com ([52.101.131.56]:60219
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727677AbgDETXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVY09mXVoYfq6PTLNE/0CzrDCHXbTZmrQV4a1zQZGsEBPfHV2mmVJAZzSXMHyqY6redDG6vNQcpwSuS2LNZzKN7sufEg76JSbMAgZ9zFaxPqcPU9xR03L/6fAEm117QMDwHrM4TVW9L5UsTj9dAPzZCNDdB5apXCtF/7l8clf8uHQNDhLyVCcyqbW8TyACjebRhMDNNdX+KUgk/l7RvrRYnIZvO4j8K34w/Iajh1NJVXtX4pJBXwBZngkW+LCIEMCjgknVPWX64ImZV2rZg9RySukC3IeFJJEAZq3hImbEliktD2jk0ZGFqujxSuY8cJjOWK+ooKlPrtZinzgHj+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atQq7mb/0UUwoxGcHSMu2aS6Ta/RAcP2QPPhubEpy7I=;
 b=Jy53WsVib55zNTDiV6cLicyIDyOK/kG1A1FasBypzI2N3z5ZRhLnLBljdPGP4ApFgI5nbd7t8eMJlha7NmxbmEGyzPSS6eHJF1ZiwcmrxnARZ1dD1rnJtgOPfGrMYcusQ7MUuCKCsDLw3HiNT7VNeS7SXRaRvthldDZD/FAmq2wOLRupDFT408tUWygDdkn1/DLrVugQNhG/c0urfmG1zjz6q0k1UaDCpPCScKmn808FPkeqUO1hWegcPZARAcLGT+AL0O9cDR6xIxHPvz8qnQldFl3XoKzgb6MzkHURKzMIGHXYJd23ZhuWuasHFY8ffKGRRNeDWIUjnnQQxWs1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atQq7mb/0UUwoxGcHSMu2aS6Ta/RAcP2QPPhubEpy7I=;
 b=TNHqFK+cAYfGZEf9QuAXYd3zTe18JHyutMpSF2E0nUpI9Nwh1SlOfAohdHnzErOL2DEQu1wTEUUhMzyHeoIyTX64UFUsROWRg+PYVKTQcmfFxrTh57ufOrBcHz+Lr4ISJ7ZOVvhZw+yT+EiJJHnrB7XEKbe2MjCFqK056psXuIk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
 by VI1PR05MB5373.eurprd05.prod.outlook.com (2603:10a6:803:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Sun, 5 Apr
 2020 19:23:03 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 19:23:03 +0000
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
        Fabio Estevam <festevam@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [RFC PATCH v2 5/6] arm: dts: pwm: replace flag 1 with PWM_POLARITY_INVERTED
Date:   Sun,  5 Apr 2020 22:22:45 +0300
Message-Id: <20200405192246.3741784-6-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Sun, 5 Apr 2020 19:23:02 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30ddb97-c874-43aa-a8f0-08d7d996c2a4
X-MS-TrafficTypeDiagnostic: VI1PR05MB5373:|VI1PR05MB5373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB53734A18EC07175143EDD993F9C50@VI1PR05MB5373.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR05MB3279.eurprd05.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(54906003)(6486002)(55236004)(81156014)(2906002)(8676002)(508600001)(86362001)(52116002)(6496006)(26005)(81166006)(316002)(8936002)(36756003)(6666004)(956004)(66946007)(2616005)(7416002)(1076003)(186003)(16526019)(66556008)(66476007)(44832011)(6916009)(5660300002)(4326008)(23200700001);DIR:OUT;SFP:1501;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0KnAaOkBC/koNiAGxYf0yqSNXbayOeHQiip5ux5fwEpr/+siQOgxCWOzQL88j3zJI4T5oyqp2jqcdN3hKGLB0qS3cLZSg//cLbH+xGK5Oyk1A6MNz3NMAemceEUec1SulkSEJgXGKkQaqWXQ1kBcHxzpLyrd9/US4pJBw4UV/PD03LaZWHus7lrn2glTD4g//A/0HFKYS3/PXUd541rCOQNVSgckND8XfW+QqMMmzkUv1NjYNnlMi9b9/49slyx5qgOe6iVDAm/GHI5s10fgg9gKaHIsH0vCTm14i3JDjovz16ZkymPjKrJ/e27P9jT8BzeYDpSFMf96xGxHH6xTHF5P5XZFGr9SdsVU4HMNY7XIdpttABPIe/IQO1KnHClKi3fc27ltF8z0MrVB/QSUs3PsfY4S4m/C6hEQP82vXIFMJQ1Wf0vhDdxw7WjHsNqGus/Ns7RgFifnYFUmTEmzyFnhSQry/py9YaDFzS6c0+tafSn1zViWsgi5T5NLlP4Rs1G+3lLZJ8PC8vwWJY2tQ+byf6txJu37vBfzJxzrJuVF1KZ8tIbV9B9dh8g1GO+acgR6uJnBD4twT+7d2OgXDJMhafVZP1kDrdQ6LVnfpiTALQWLGs00MBNI5i2QjdA9e9HlakJt8W6pGmYZrKEkBeruFySCnGG/dstk683q3WbIqG0Q91T5pvdleRaAz5l3ghcIu8QbqOSoWh8O7V9PKhoeN+X/OFQ7LdeDUTZ0q+FjzqocUHGzB0tGRiDSo3dwC0/HtVpd2WPNIAktWQBOw==
X-MS-Exchange-AntiSpam-MessageData: ey7oMs9HPihny1vD5lYvkn6skZujTaqcwXSWULkrNf4qv+0F9hk4Nw12DuU6BDdj7X83OblaR7k07ntymX483oZpH19EidGdXUFMnQd6ByHnpcLnQUi5khj9whSRTNg1isgpREZaXBjogigPXRi4dg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30ddb97-c874-43aa-a8f0-08d7d996c2a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 19:23:03.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkA08l9m1tU2uEkx2Cxbvteo0BYcdTm5wfCJybE0Nhzd1kaA99Yj6APSGs7ExRUPwHPIgevAK2JzLsAWl4LnFuzBU++SsgAgSQHVXRGwnrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag '1' in the 3rd cell of the "pwms" property means the inverted
polarity.

This patch converts '1' flag into PWM_POLARITY_INVERTED.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 4 +++-
 arch/arm/boot/dts/rk3229-evb.dts               | 4 ++--
 arch/arm/boot/dts/rk3229-xms6.dts              | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index a78849fd2afa..3707f13ffd83 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2017 Toradex AG
  */
 
+#include <dt-bindings/pwm/pwm.h>
+
 / {
 	chosen {
 		stdout-path = "serial0:115200n8";
@@ -75,7 +77,7 @@ &bl {
 	brightness-levels = <0 4 8 16 32 64 128 255>;
 	default-brightness-level = <6>;
 	power-supply = <&reg_3v3>;
-	pwms = <&pwm4 0 5000000 1>;
+	pwms = <&pwm4 0 5000000 PWM_POLARITY_INVERTED>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 350497a3ca86..68ea0c320ab4 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -83,7 +83,7 @@ vccio_3v3: vccio-3v3-regulator {
 
 	vdd_arm: vdd-arm-regulator {
 		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 25000 1>;
+		pwms = <&pwm1 0 25000 PWM_POLARITY_INVERTED>;
 		pwm-supply = <&vcc_sys>;
 		regulator-name = "vdd_arm";
 		regulator-min-microvolt = <950000>;
@@ -94,7 +94,7 @@ vdd_arm: vdd-arm-regulator {
 
 	vdd_log: vdd-log-regulator {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		pwm-supply = <&vcc_sys>;
 		regulator-name = "vdd_log";
 		regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
index 679fc2b00e5a..f11088ae855b 100644
--- a/arch/arm/boot/dts/rk3229-xms6.dts
+++ b/arch/arm/boot/dts/rk3229-xms6.dts
@@ -92,7 +92,7 @@ vccio_3v3: vccio-3v3-regulator {
 
 	vdd_arm: vdd-arm-regulator {
 		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 25000 1>;
+		pwms = <&pwm1 0 25000 PWM_POLARITY_INVERTED>;
 		pwm-supply = <&vcc_sys>;
 		regulator-name = "vdd_arm";
 		regulator-min-microvolt = <950000>;
@@ -103,7 +103,7 @@ vdd_arm: vdd-arm-regulator {
 
 	vdd_log: vdd-log-regulator {
 		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
+		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
 		pwm-supply = <&vcc_sys>;
 		regulator-name = "vdd_log";
 		regulator-min-microvolt = <1000000>;
-- 
2.24.1

