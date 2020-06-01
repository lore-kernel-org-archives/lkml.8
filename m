Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D590C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5CA206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LcgZU7Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFADyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:54:01 -0400
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:33377
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727050AbgFADx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPps/POaOYwx5daJxRENqt0s4AZZGJre2+w2gXxcnEw6CM5W4N8IC/MqOhJVuO2kkDx3rzZcgivrmuKXIGpO6MIof1FDvLMreaW78vr6uypkvXLeinp0aljJsUTmTN+/QAkW/w52PIXCo2fykjarTArBQka3/0zDc93d6GOMwjy01k77fS7FhX6PYMQ6Wlyn8ocUcThkUDYNIDlpK6EnjMRH3Df+FdXQiKCbGixspu7iGQbyZ9NjqtwaLd7DMHoB/CQloiiauthZoX8gyQrLmRy8rXnsFbXo3N4sktBD92OnYRibVpHkHxjsWPp0vnjatRMbADTxnpH4+qlIpxczzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4q4wCwL3LxIESNvf12qzzIuKsZSBW8AaLNyUcO7Bdk=;
 b=GXn4JOp3y+J3XPfl3lNpBWJSRrS8WMgT1asMWXtJjpuititjgEfh2DTegYv6i3S6DBRlNN4w0JHpWoE5ne/Ud8pWFvnCTbsEocSUpmDk1jrjed8pOAq/hlpNlespBWg3GXsAz5qg5soJtAeuo/VDuJAN9mErM0KoY/k0rGUrGxV/WxNTlMFZ3piBf6mTnJmVRzz7Fh6DgqjiXqoUNeXzt/m4p8ts63fQEWd+eeg+PGKI5nVBGAShwrCu2v53Y3cF4JfE4iRuWViU6PDR8KExDkaWS8SXOrEjEAqYgJlKCIGdv3uu5gTml+wVKs+OCNgFdavqMBDKSt9it2BbCpB0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4q4wCwL3LxIESNvf12qzzIuKsZSBW8AaLNyUcO7Bdk=;
 b=LcgZU7XnlUAeDwGANqO5sBszCq2CQ4Ds2+WwqDP7Bm0U6TkDOD76lM+fe1CAXCj7ad2JEkl9KyDTlvkoHrmgsiEINAAfg/KUTs/DzZ6EXddNaiDaDw657tpDSLgIyH8RbYtOh96wHJIX9HoVYLbWT9aUhcLV/0IuFEJH61EbN8s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2920.eurprd04.prod.outlook.com (2603:10a6:4:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 03:53:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 03:53:55 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@rempel-privat.de, jaswinder.singh@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/3] arm64: dts: imx8m: add mu node
Date:   Mon,  1 Jun 2020 11:43:18 +0800
Message-Id: <1590982999-7149-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
References: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0096.apcprd03.prod.outlook.com (2603:1096:4:7c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 03:53:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16d709f3-18d7-4e92-0f5b-08d805df678d
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2920A5E4D401CDBC565FCA88888A0@DB6PR0402MB2920.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HR+cVgcgE1bZXLX0oVvh+VydfcyHj8EYWoPBb//ZoUrX0/a9XvBWVG8a6zxb+yl0P78/3XmK+1hwr73XY4c9E5bCPnhF/9w3y+ug5Dl6qcWfSRtGpFyBzL8pRx2SgKCBT7miUxKufOfBbIrp8GtdgIE1Kbf/4gUBy0QX7ppp6QMGIqr3UPoOlKkB73MECJduH8knekQUfMoYBOvBE04LPa4yjF+4ZvZkk/OQr+ZjaD8+9QsKpTA4UmBVUbpW1G09f6q7u7Y39YB1l0AN6ln/0AShqsk+hXPJaG/yGzq5pFgOccEFxlGVxTSSl0b1wkcdmeSnB/Ba3x2DfoNdyZxaKpmXy1aL9qrG3xOR307MR3BOcajXx3Wq9y+e+9zFV2N0tfgAlZCv8hMUG8hgnp4qzQYK8RibQQIv0hHh7yZVzIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(36756003)(4326008)(6486002)(8936002)(6666004)(8676002)(7416002)(6506007)(9686003)(6512007)(478600001)(69590400007)(16526019)(26005)(316002)(52116002)(5660300002)(66946007)(66476007)(2906002)(66556008)(86362001)(186003)(956004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UEUgY7o0IE5uquxfTq78p6JFsslIFvhyuC8t8y5ScpYSlAatz18RIycSWKAyaWT5wYMU38MSpx5yeZ/JRf+6D+LF2uksAJpACQb9A9lFcEzKQs5BBBkA9pbh16WQyc2SbseqF/kZyQwlAtRs4ZeoEdUiz6wmvfrbq9F3zEc3or/E5LW0d7fwxyNYFOXgM5OodFf3JEVE4a1r5aCanfUYmfdqQzTpn2O51bf9gPhnmD5A29zwAXctBAsOomd60en2gnMBVO/Y5sKJtuFkVJ0UON030GnGZdddad/sNrgyZ1rZaf/R6hSTs2hQ4OWWIW4DC1HJ86bJ1B+lhKKmHSywyjOK1qE7Azm5OzRPX4mZ6B4Dsx3K4UC0GdN/lJ4z24Zogacz6esMivXlSmzkxZfmqksQef51lP6Q6smyrQ8tbHFg4LCCpbLN41/HUsnyU4kAySNiC+GosCoic3vA/Fkf0sooKhFh3Zi8p45VNoDzviQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d709f3-18d7-4e92-0f5b-08d805df678d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 03:53:54.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsNNIqKliYsYD9/AYPq9oOwSp8mPfWufJP2c4d+/Y3ecNjiKf4AhT6mPkL9rtOAG4MuHLCg436uehZAfPsHOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mu node to let A53 could communicate with M Core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 +++++++++
 4 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index aaf6e71101a1..fc001fb971e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -775,6 +775,15 @@
 				status = "disabled";
 			};
 
+			mu: mailbox@30aa0000 {
+				compatible = "fsl,imx8mm-mu", "fsl,imx6sx-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_MU_ROOT>;
+				clock-names = "mu";
+				#mbox-cells = <2>;
+			};
+
 			usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 9a4b65a267d4..c8290d21ccc9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -675,6 +675,15 @@
 				status = "disabled";
 			};
 
+			mu: mailbox@30aa0000 {
+				compatible = "fsl,imx8mn-mu", "fsl,imx6sx-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MN_CLK_MU_ROOT>;
+				clock-names = "mu";
+				#mbox-cells = <2>;
+			};
+
 			usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx8mn-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 45e2c0a4e889..b530804f763e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -621,6 +621,15 @@
 				status = "disabled";
 			};
 
+			mu: mailbox@30aa0000 {
+				compatible = "fsl,imx8mp-mu", "fsl,imx6sx-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_MU_ROOT>;
+				clock-names = "mu";
+				#mbox-cells = <2>;
+			};
+
 			i2c5: i2c@30ad0000 {
 				compatible = "fsl,imx8mp-i2c", "fsl,imx21-i2c";
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 978f8122c0d2..66ba8da704f6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -959,6 +959,15 @@
 				status = "disabled";
 			};
 
+			mu: mailbox@30aa0000 {
+				compatible = "fsl,imx8mq-mu", "fsl,imx6sx-mu";
+				reg = <0x30aa0000 0x10000>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_MU_ROOT>;
+				clock-names = "mu";
+				#mbox-cells = <2>;
+			};
+
 			usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx8mq-usdhc",
 				             "fsl,imx7d-usdhc";
-- 
2.16.4

