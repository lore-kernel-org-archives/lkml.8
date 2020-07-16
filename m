Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B686C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7029120739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="OpoDFF0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgGPM6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:58:55 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com ([40.107.4.119]:47723
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbgGPM6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:58:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG2kJmOh/3zlDMAIPoD8KkazrDuqJ6iW2GN9w5MEkEfuMLwzdv91P7ilvSDHoyhcPb99u1Gx8bEAmu7RPyN3khXlQC2MdVsCKIoif7LIFSFTJw3WViuxkfMWzz4XRwqLPhrsOGmFIMJhybSyF+0seA7O47g3C77917SQFqB4JzDvli9zubaQUgeWLDFw/W6nu5vsINbG55hlFDqsQL3AFkDcYnzx+4yAZdyiDne09sqtEKouKT7MwtXV3p3Ex/LhHiM07ePnWYEPRcS37hbadwzPXGo+0vR3JhlunZOQkce1VzKCbfIYCPpoPO47hcjZ6crFe1NgSGMyHMBKzS3Eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUtaa33meW6NoQa3GEY8lq/xaXbnHOYW82NKhOq5xLs=;
 b=AK7vzn+HGjuDM2WSmierXwSaiuX/NQGgl4YIICHl4XBJbPPySbNmURpS8cb6wWE1KSI+hcx+Xqgn9gRwuAXJppH+eIzPmBjLHX83+8T+ARg5nxywPtmt7dBED4FE8bep0ceDxgQ7WWdiwq1lNGTSV1nfvCIHZFUnEzwElfNe5JvrZhjGxSXkulp7Bz01qo47PMQMPStpiha7svX2TFbABRdbc/UQZr/NsueTFOY/W6zMbwoRdHOmNzsrvYqVKDrOao2EKBKn56Y881zDzkUB2B/XvdbBb1XUiY0seJEnPnBgYefxpJerA9i6LxTNW7Goq39j5DKOCNOUM4lxyKgfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUtaa33meW6NoQa3GEY8lq/xaXbnHOYW82NKhOq5xLs=;
 b=OpoDFF0Dy9ccY6h0D7BvMz8fDX4TklUfSA6k8HlzZjsGXfVgeVOlw5Mm5BD6t3654XvPKbDrXC+yAS12d8Z3hwgXKpSXFtR9ML9+zPnA+LyeUGZDVELsYg/bFHmpL8dbqmNcxNq7qRVoDdCwaNLPiagrnjHi0qhbsOS1S0qTRsY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4885.eurprd05.prod.outlook.com (2603:10a6:20b:b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 12:58:43 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3195.019; Thu, 16 Jul 2020
 12:58:43 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/2] ARM: dts: colibri-imx7: add usb dual-role switch capability
Date:   Thu, 16 Jul 2020 14:58:30 +0200
Message-Id: <20200716125831.796904-3-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716125831.796904-1-philippe.schenker@toradex.com>
References: <20200716125831.796904-1-philippe.schenker@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 12:58:43 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bb7bb57-3033-4970-dc41-08d82987f843
X-MS-TrafficTypeDiagnostic: AM6PR05MB4885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4885EB55319B9E2A94D757AAF47F0@AM6PR05MB4885.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vprBv1f6ztL5iqu6a4G3kuhjXlaP+LcQo8tEmjr06ab0Dj5+HJN5RyMO5281ATbrAvAznoCV252uDaZgobgtynW9523/f09BHJ7f30yntifSDTU4FwcZeQzw40Ix7YcVLWE40z+iwVahphX5PUJ1RDkd3lpLX+qA0zMEqAugdXcx9Q7ldBRVXlCmMD4opJwvORO5/rJ22WqJO6LjCYi9e6UpsTKzivRkURqCbWHY6CNyDSOvD74EJooivAIP350pWHRO8O1n4mQRDSkoJaKvhf485NbtmATXN1iarSini/7eCsRvaBPrHhjqecwmyngPOTKbuA7hHySXBOp4NdqDrrp7sEBbWxvYVPdUNHn2mFUPc7j8OXunIbNOTYc5caK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(8936002)(36756003)(44832011)(6506007)(5660300002)(86362001)(52116002)(83380400001)(186003)(66946007)(6512007)(4326008)(6666004)(66556008)(66476007)(16526019)(2906002)(6486002)(8676002)(1076003)(26005)(7416002)(316002)(110136005)(956004)(54906003)(2616005)(478600001)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /wN+xDlje4G2PjM7sBZq8n/kz+4AgaOml/euIe5njjPoxFOewSU9lJCLbVhgakYcbAAzXlKv9Zuv3etV6CR1behZ6evsjFdoOx+wte8Pol+ozKjd/oQu9sAHaHILzziElbzghpbe5kFA6kGmAVRwsRZAKv4rTkPH+NetKk9KA8GxlJmuvfN5Y1vhzQtskpZzpn1fz/GUwH/CrDaNpN4LknzSGikFA2pwN6IfNifZKeQty0U8H0s2XhmQmQg7IymBFI1qum16WIxa3DjFlJmIrdT45DfsaT4QAMcq36laWRTWxvZFuu9U+b4nov/ioDwjCMwLBlh5PSnQ5zM81enZSf4nfOW4oQ1+8WVfIltMS1dwoCi0q5MKTSuV/UsSPqQKbpjl2vSowhRuqeWs4rYKnoXGqxGNWelezpvhL/lyXp56GLySGgNOzzxqevkM942e100SL0DZt8xE++bfm34awLs5srSwiMM7+cGguVws/ZQ=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb7bb57-3033-4970-dc41-08d82987f843
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 12:58:43.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HR/y6KhXbUlcOO0042LqhPQIbx2duZKpeqcAx5YPdwreLph4E5z742IQUMpnlGpiU0httKl3d45UhEu2t+Lob1M26G3GTyx5RjmLc3vXlkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the runtime-pm wakeup bug was fixed in
drivers/usb/chipidea/core.c usb dual-role host/device switching is
working. So make use of it.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 9 +++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi         | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 97601375f264..db56a532a34a 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -20,6 +20,14 @@ clk16m: clk16m {
 		clock-frequency = <16000000>;
 	};
 
+	extcon_usbc_det: usbc_det {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+	};
+
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -174,6 +182,7 @@ &uart3 {
 };
 
 &usbotg1 {
+	extcon = <0>, <&extcon_usbc_det>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index e18e89dec879..caea90d2421f 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -457,7 +457,7 @@ &uart3 {
 };
 
 &usbotg1 {
-	dr_mode = "host";
+	dr_mode = "otg";
 };
 
 &usdhc1 {
@@ -486,7 +486,7 @@ &usdhc3 {
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4
-		     &pinctrl_gpio7 &pinctrl_usbc_det>;
+		     &pinctrl_gpio7>;
 
 	pinctrl_gpio1: gpio1-grp {
 		fsl,pins = <
-- 
2.27.0

