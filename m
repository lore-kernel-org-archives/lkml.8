Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E79120768
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AmtvzGgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgIIQJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:09:25 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:20520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730780AbgIIQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:06:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH4cETbiQ/bT4BxvQ3xmSPygUfaVd6niTgSR3y9S+YnpIXeqdVwj474PXpZa+EmIbn/DUm6LPg+W0UXWqdnL3Wn7bcfeKYoRtBXt4TaMJXSzrwkOnOfbwJkysInnzwyrg8rSsvSMTwWFPlJPQvNYqnohnoUBY4DAf7G0XtCl1Rd0DJfHG4Krg0BLYwLFFySZ7uMeE+73i58Bx/G86Ym3ATYzQAqorqVw6KgOwoxBWmo/EnG0v2WNNsSGELblb2hcjEtfK/81QKpiBYmQXco7x+WbsEGkqmStF5PLsOPQuM6HmS/enuPWWCrMEUf2lVfd5yV0PX2nrV46GGLQLL6ZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiVXQ03jSJcJDwrakuAJPeo6Ojz+Fedb35YL6zDJl9o=;
 b=N/Yae8CTfAN+bwtwpoA2QC8aETiLLNUd39yPitfiL1yLOF3IO4JCftvTWNAT66kT2g9ADKV/gpG0rvjtiVe8hKEhTmp8azZDSEHCTnd16ibpZDS1LO9IDRPDvIV+aZJt2YXUy/AWyXgYb6IsAybJAeU50yqvZujNJkmUhM8gkKsWOpBMaPxCcxVyA/lMRCOnSGDwsNKpg7tJqf3MJw9OP9VlK5PBf4sn23g9A+2MKm2jUH0WFQaF1++z2VFQyfiZQB/ZWNXmTg97D2Wgy4QXaxTwqsolnMORnObbqflVbNaUcwNX8L0w8TPpssxQweQcQjfqMFlmABBh2CkrkYZxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiVXQ03jSJcJDwrakuAJPeo6Ojz+Fedb35YL6zDJl9o=;
 b=AmtvzGgo5MbdVN6Bye2/Xow3AR+r7iqJ4PsMTwtFxUIBNra7e/9KbXF9biUqS9xn/EhyiYTbiBsRamRDD1uMQy3X17p/qpfBMT5S9yTyuAo+6wW1Yg/iMKTEddsIU7Elvrvpc08SaoZctULv5zvUtkbKmFuwcVs8eu7B2rXFYHc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:45:00 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:45:00 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 1/6] arm64: dts: lx2160a: Add label to pcie nodes
Date:   Wed,  9 Sep 2020 19:14:31 +0530
Message-Id: <1599659076-28121-2-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
References: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:44:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82d312c8-1d82-418e-6388-08d854c68bcb
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37102E11D6D5379504C8720FD1260@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4aKNyme5erJS0COjmdgj91eWczFLU/8ZuOVOzVfNsgN+/rRkk+dGmBVnthAoGl3Yr5w2++GfaZ9NpcdoK1fiU5z29X4khSBiFue1a+IesdUKjbJRasAHJnrPEWKRfC9HWcXgLl+z5yzmuHX7811DkgxcDCNEW6Fwb08wGY8Pkiasuq70PzlrUm950mrm4fq2/sMct3Yn2qKxxDHkumsUgRytUmwUS7AfjDFqb9UnwKxalzWP25iMernx2zd3ZkntayO2fKNHvy3ehXS0q6bw7kkV13wSU1GvGdPcPciEfHnGIgzmHOfo4+2635MpVvZlSPtRyQOoM6E5SKx9fGlQ65bOtpY7BWUE+kQVWrtLpEZzOE1Ya3ua9WZqLJMxeZG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(8936002)(5660300002)(1006002)(2616005)(16526019)(186003)(8676002)(316002)(956004)(6486002)(44832011)(83380400001)(478600001)(66946007)(6506007)(6666004)(55236004)(52116002)(2906002)(66476007)(66556008)(4326008)(6512007)(26005)(86362001)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PWTbJeGSaAUDygo/myvdh9fGOduQSaMtfFGUkQBDbr/dMLsWw28ecHnxU5z26bLT9vh1TqPMgZQOU8ABuJomjLbqx0V5+tLURFx5buir1ogra8N1/xi+Jgo4/5QDRylU0TDoHZksQrGA1IP2DwPvQ4zVRB2HmWYcliOYcdSwN2m8hBrDbnyttY21ZXTXFUMqfdzZQ2dxGsT8iJUFoYmqcmTp+NjnMulozoJBNojRpiocOUiirJWbpTNHviVc6tI5VO8DIy52hgEEOUKZ3w042TcUJR4arK4yAFbGKwXM9ZBxprK2XYerDTi2iVZfvBxY0Cpnkq5XK0nw73zLfP2hc0ecpZkRZBr6FNDwHRPxYMA14n+Rd53dL1cfbVYCaKo8IX3Kx9WI+634rsLdZWR3f5ITVsiawXBY+kvqJjyic/pIqAVyGMYAZ4uWukZHCPVnz1RuX0ZRd4wmfVznGwJQjNO3GCdn1sbEZzaJudJIlr6wlSWJNIF+6GIF4aEAH2+4KnXfAkhhboQjCfzJWGQPtY86X5ymOxCD1QN0kLEqtuZ2FyZ7PmN9tXDIhDEi7G3iQNMWgrA1K8CSlA/qO58XGPTX+jPdgbLrCFG37WdL4vuJJkI6m99sU6Ff577nRWBY7aqJpsG7kGnDQ5Gpwv+lUg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d312c8-1d82-418e-6388-08d854c68bcb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:45:00.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uejt2cGRMItWOSzjLSAyqxq1Tg0eTeXwrFLvY/ARVU5Nmh9eAE8e0ABR4+rGyJXHG/D02kApEh5i5QtMTzygBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Add label to pcie nodes

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index d247e42..83072da6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1011,7 +1011,7 @@
 			status = "disabled";
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1039,7 +1039,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1067,7 +1067,7 @@
 			status = "disabled";
 		};
 
-		pcie@3600000 {
+		pcie3: pcie@3600000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1095,7 +1095,7 @@
 			status = "disabled";
 		};
 
-		pcie@3700000 {
+		pcie4: pcie@3700000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 			       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1123,7 +1123,7 @@
 			status = "disabled";
 		};
 
-		pcie@3800000 {
+		pcie5: pcie@3800000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
 			       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -1151,7 +1151,7 @@
 			status = "disabled";
 		};
 
-		pcie@3900000 {
+		pcie6: pcie@3900000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
 			       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
-- 
2.7.4

