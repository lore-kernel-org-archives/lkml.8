Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC62C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66715207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oKPfuyiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGJNYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:24:55 -0400
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com ([40.107.21.110]:11584
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbgGJNYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:24:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOGl0ydnyXGQScg2pqemv3sU+Vg/eaLmIW4zLws70fIJ92qcMod0dXHlWn6ymHZMCCFy89XnqMdXTmRZAauGmsWWJtohZilxCIZqC90uAjIsCyZfcABcEO/S4pXapd81GZ43IEaAsJMyvHQagy6mafBGYi4UMnynmlZHUCc7SgYAiFTwYZxBxxHrbfMoLXOptjcTDQI+pJbzoaRwKjrYgu/cS8zmxdpndYXojxra4zlaH7juiYgVuoh9iv4QPm+nNUfGXtqtBnjJleSvaG6ZUWhA3FpEPdw7FzB402T/a4ddLFcg5i16ktcsihEFCCPu7jksHk/rqW7prE3TdiensQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUtaa33meW6NoQa3GEY8lq/xaXbnHOYW82NKhOq5xLs=;
 b=WUmNW9efErzSqZ4X2ImrZnnxxRkiNCv9OnqGOUNUYVL9JLPInIVeHvkZ7HUZzxlac/y3BBTvYL+pSTEmIRERh+5Zn5QkAg963rqTW84gnbdLnnQ81tq/u8xZ0wQEdV6gV4ekeFlfddHawgHh8+dXBYFFEl+hhztTTjy66ADiP3/Mqhb/viXgQW5FbiBkExEhCVvGKOWizZCzTrpgkSlER0T6NDed3Sn5832/i67KGsEvqL577Rpt5VvbAwDW9b4iqGsYpgVlDco5sUEXRz2PK9K2Ftbrmuug+izJii9tCyAhFWGsbJwZjfPAfSVXwa8DUkphY3NIF8EaEc/C36EEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUtaa33meW6NoQa3GEY8lq/xaXbnHOYW82NKhOq5xLs=;
 b=oKPfuyiA/kKh83wHV17/vkOAICKAKduV2MEhUhAozrskRV0fandpXQciBVJkLMPSF/i+17P+1gxGfibp4hvVHwz4eH5DcBXuUqHsMV5rghgNkXlAw2LlzDOMTCN7pKacYB0BorHkA52HkSDYUzkh0WPqfLJwQ6zlyBGbra1F/PI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4821.eurprd05.prod.outlook.com (2603:10a6:20b:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 10 Jul
 2020 13:24:44 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 13:24:44 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch capability
Date:   Fri, 10 Jul 2020 15:24:23 +0200
Message-Id: <20200710132423.497230-3-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710132423.497230-1-philippe.schenker@toradex.com>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 13:24:44 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07e31297-02b3-454a-0d70-08d824d49c45
X-MS-TrafficTypeDiagnostic: AM6PR05MB4821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB48214CF040321EF1AA503646F4650@AM6PR05MB4821.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smGNKQvJt45kB2SmQr1L6LjvoqxjYpasQHFFHias5RYsWyz/SgSLqHOv97PmwGw82f4fXaFwMgqjYLNlawTwK2xoIFZR7I201GzqyD29NlgUpY8oC+RFBnTYspHLFv3jMmvZKJoGzBEO+VPanDjE1QVQgvhwhKN6UOa/RpLawEhgSlUx7Yr9Rz7E1dsXTAc++JEsojlLB/DPbBNWLwmD3EU70QOFS3XGbnChMFQIMQJT71IxLQ36/rjq87DbL7c8Yj4MfrOped8R4WEkfyxZSTpVeIlvWb0TWacLHSquQ1wMjfriRWGOOdAkScWHnR6BA7yJvgBYW/FTczMu/56RwMwYIBNLxGrFbOU8DKhV2eUL6eVYp89ncqbwsuzfe/c/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(1076003)(66476007)(66556008)(83380400001)(6506007)(26005)(6512007)(8936002)(54906003)(44832011)(4326008)(2906002)(316002)(6486002)(66946007)(2616005)(956004)(86362001)(5660300002)(6916009)(478600001)(8676002)(186003)(36756003)(52116002)(6666004)(16526019)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NQVldgGFMkhtaHesRA47ZiRMK1v+JAve8GRGHsJPV88ujjeC8PxPFS5NUajrn2K2c5LLCgn45wX9/yCdtxgX0w069iF1AzkhVA+3owEDdYaXgkmdauAl06/F02XF71chckjg40VChuUulhEC7OMtNsUjAPJcFB7TG0CGeYZRGmTHeqLjSFw6rS1bbEuu9HBTMot9hlzf93VtWPLC+BtZL/Z03MHX2kx9g2XExiLS9+X5okqV/JDpng4F7BbQVdYnW+N4xXYvp7qqUrjYOaLHtk31L6V20urngsevGEEE4d3tjvvkxnLLO078DsRz+cHIKUDNOqgjKc2U5fnwEs2WZAyHiTc2vUvxk78Q51qIikSUcRXpr5B7hz3fQtLjIqYOKuzLe1DgrNJboIAnUvpzUZabSmyW2QmRWxNoRKPvWhEc95CXu/Dek8cr8+Y7HIg/cvmsJvbUmJ14fqzA8WEtjc4bys4NkcwpWQotzt05cpk=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e31297-02b3-454a-0d70-08d824d49c45
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:24:44.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYhO3VL+uzksSz3XNQ0RTX4cungh/QLa1VAqgJiWdt5j/hb9rAp1QB6ovfT/AJvTYmbys+r6/ln1Z+GmuwvlF7t31LfkenKH+icH8nLrh3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4821
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

