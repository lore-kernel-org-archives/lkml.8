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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFAFC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7CE207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="SPPlq2PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGJNYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:24:52 -0400
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com ([40.107.21.110]:11584
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbgGJNYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkCIdv0PJmCebPDnp6EBZyZIsjQtFV4NsYlV7I6o52t70GEBELY+qfdqJz3VJC6p74UEns+yalnx7hwG4HmbOne5n1xgJ6QDLE3JtOh3pWcyv54kLRiqsGZw5Xxc9c3YJj6ybAPcxB59XMtPcv2x+NW79irWHSlInaPDOyfUv8O9v+AagS5uuF7aa5j7i+VRKmiUSP1CtRgxD6xkQgMGitPF74t4Oc56lL/6YJAdHLk5xraqSHLbmtY8gCk2qLlzuL+5591RYTrwYNSjywgVK9FBDj5chGb0xH1gn1RHKzFyDsyBegOGGia95pkEVW8RBw+Xzjdw5kKU4ZjHRBeG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1VZdcK57fMzfjRdfqGKeIF4DBxecLIVXGJUSoMVXdE=;
 b=U0xhhSk9hH6xVT7DhQ1aOY5aMAAHwdz4icV1sK8ng0+oeV9BV+zGEuleKDYDI6702vOahI1ZvrygUei8/lKJ5Xyhavff4krWqn6aVo9X5qFw0zUs2wEENOPRturX0b+OESluZvdESfhQ7Bso3ulKr17OnWwAtTfkvxlsTHI9/99XExDHNSAC/034lSGJRBsdh+bWoDAj7nTfsuTJzs3h1PEwKXpCiho+5O5/sENNjX/+kbyzdI2qCiajfgI4Al9SH+uIzI9vDcelk0CnwZ9RRJOYjF0Xtf3PZEuJeZLEEHm68qirbLmgENWIPmJ1mCSi0117Zm9QLgbe8ub+qbQAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1VZdcK57fMzfjRdfqGKeIF4DBxecLIVXGJUSoMVXdE=;
 b=SPPlq2PEMUKLg/jvFML93A9NIdNBJt/8UM4ppOgLgH9Z8LhTLc2hf3y0WOMo4vUGgB0wb3TgUx1eTXXYsJoRC0ut8t2X1B0FZkDNXqI0M5j67SF80chjzao7k+g3jR+qJ1IGZLB2YkRPW2Rplpg7b1tjOz6FkdodxFK3q4eEAYY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4821.eurprd05.prod.outlook.com (2603:10a6:20b:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 10 Jul
 2020 13:24:43 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 13:24:43 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: colibri-imx6: add usb dual-role switch capability
Date:   Fri, 10 Jul 2020 15:24:22 +0200
Message-Id: <20200710132423.497230-2-philippe.schenker@toradex.com>
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
Received: from philippe-pc.toradex.int (31.10.206.124) by ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 13:24:43 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab74de38-ee9d-4c61-34d5-08d824d49bc2
X-MS-TrafficTypeDiagnostic: AM6PR05MB4821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4821B899D23585754D51BC61F4650@AM6PR05MB4821.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZACMPVQ8J47L0mKd8pKMLTaZBj3aOC72KebEZRxbOqiEYtpn8xP4UyAUvuj65jCYxlHNHkqx4QImUxHhesf79X4lX+8aB7jdeXosaNc9YMotvcG0O2DsNP+tXgI3gRIsbRgcckD87Jmso07j9pMdjdptLJGLehSGeHlHrAByNjC3W3ArKu/v+3bysUtgvIS0FB4qGum/PSUav+3FResUuxV0Fp8ylbf1QvaF2oijnunscmvXtv8bvaSXmwpvfy9D0UjesBvWUAR2iyjAXJHCAflNeJ5E71XTj1Xa+U006Fz2bJecJG89sxLlrA4UAo8+LYsN0lMI/LNc/WfaDNrJqjOk6/MVVfPotIYNkVeIKs+hH5F6v37Rqi4Mm8Y5ip8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(1076003)(66476007)(66556008)(83380400001)(6506007)(26005)(6512007)(8936002)(54906003)(44832011)(4326008)(2906002)(316002)(6486002)(66946007)(2616005)(956004)(86362001)(5660300002)(6916009)(478600001)(8676002)(186003)(36756003)(52116002)(6666004)(16526019)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FrOEPRkCX0YyxkW9b37ZjQX9tWn3XAvo9kixqslDZaNhk0aVz1MCeQJ0BF5ozbTxQqT/JJSrenNq2OcFSI0KNpuV0r5ge1Qv++SM3gv0Dp7/IsmDlqC4hfyG/uyc7axcY1BKvOA6SemdBQGdcdsWqo4UEQINGrh9nQtE5SJfS00Nuk7iVQloHRWdjGZ1K0P2DcywfOv/s2ljI0HPYBnK6kNzv2bXfdkRED5wws/MN2riQAph76pfVK++UXAhIQSRib30U/OyP5QJguIf5eah8zj36JPOs1oVV9DBKg9QzQ2kvsedBFH7XaShH6p8TzALYUYnrZvt68Fs0QmsMWHP/BVo6UKvqYHBzrn9QxNtK5nIGW8WLvAoWadnlLWWeW6UbJgxaSHNyJR4fOueqCU1ssVDgdh4zOpWIAy5y6e/4Oqh0L5/l+ntFSqYOpx5voNPJ/yFYz7PZcUkHV/dlTwR+HLTYGe/4jwiIa93OcntmJs=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab74de38-ee9d-4c61-34d5-08d824d49bc2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:24:43.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cwf9aRMZ70TfIsdENa7dG5JkddmgbrFteQqFPCCtJis0cwHUj7JjJaNUOWsCXOhMjOguk2q2IjnGAVD38zYAX37aefClU2AIRYg4Mb2ROQs=
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

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 8 ++++++++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 65359aece950..c978b3f19a2d 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -45,6 +45,13 @@ clk16m: clock-16m {
 		clock-output-names = "clk16m";
 	};
 
+	extcon_usbc_det: usbc_det {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -220,6 +227,7 @@ &usbh1 {
 };
 
 &usbotg {
+	extcon = <0>, <&extcon_usbc_det>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index a4a54c82e28f..de49f9faa426 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -363,7 +363,7 @@ &uart3 {
 
 &usbotg {
 	disable-over-current;
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	status = "disabled";
 };
 
-- 
2.27.0

