Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E02C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5224658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m4GQToA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBSIHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:07:10 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:41186
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbgBSIHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:07:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO1MOUpa/dsK0FPqVPs3w9wgzii/9EYID8mqDweXsVRqRnEgpToVZmKh+s7/uiRWnKxwDU88YAWkEc9EB1lEBTlunmDJaD0MQ2YvZ3PHlDqwm8naazC7zpq09kHXHYWCTNehqmoAxQenVTgjgEEy5pX4hrl4RRc499ZY+SO8DMgCPOZC5IKxzyV13Hh4Mo5rAKoLW+NkAkAP09xY5ntZJdWHUb0h3yQja87lAf6LMqh8rLLjSti0PDPAzzNUbvkBzVGXrKv0GSz1aPvI8YdPJmsPi50ps9spHTarfWu8OPWwXsmn5ZSBcvzpivdSqcEK/4/JvUTKHXnir8MLlfwFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BkRvE9fRRa9zVozc3Al9xaIawZGzJcAeFdOpReGN8E=;
 b=EJe7+netgHw/N1wPFZOIVNzfFu8dx2MMab/13uD0jfkBtY+pdq5HBsIJwpeVclwNse2oHzTfoEQ0Af7GhZKbgMc0aGVUS+oTQg9wjNk1oRG9ZF2T2J+htOS3gPV6BR6UxdTGPfhSAtxfEEI4Rso+dHxF/VkiAdiUo+W39J4v4GmZV+BWhJ5UBcVy9Te5Aq8CAMwwlGshLkEvPfkoATHT/VEB6FDllZ6qopdHvFHEMIzdLDhx7LMptQgGxatjZ8vB0Ult/wyZqjFO1vfq8dMAhdIO0YUlFENsWgjG6q7PHboHzBaHeOsQLM/fFjFgIYBfq7+659c7ACDm1g0DDEhKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BkRvE9fRRa9zVozc3Al9xaIawZGzJcAeFdOpReGN8E=;
 b=m4GQToA/7k0Mmexee6730klvcaybE1CaSYO8NABoWPldb5uTXTSpbzQOScqyoPIhlw1Fh+Xiau0Zn3m+ElnoFx8At0Tww++krI9d3j4g67Pa0ZcktlmEY7XJxanxhxnEGYrJmN2nc2NfOqrBNMw2V74V4+Ugv1egTKR9pNPBV/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4132.eurprd04.prod.outlook.com (52.134.94.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:07:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:07:06 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 14/14] [Do not Apply] ARM: dts: imx7ulp: add cpu OPP points
Date:   Wed, 19 Feb 2020 15:59:57 +0800
Message-Id: <1582099197-20327-15-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:59 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a9f9968-06be-42ec-d70f-08d7b512b422
X-MS-TrafficTypeDiagnostic: AM0PR04MB4132:|AM0PR04MB4132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4132EA6BCCDEDB0319A30B1688100@AM0PR04MB4132.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(9686003)(2906002)(6486002)(6512007)(316002)(478600001)(69590400006)(2616005)(66476007)(8936002)(86362001)(8676002)(36756003)(81156014)(186003)(7416002)(81166006)(52116002)(5660300002)(66946007)(4326008)(6506007)(16526019)(26005)(956004)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4132;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/AyLNfu8Kmge5Q6Cbjn8QWV3gQFGOGY/lYus+15wDDLXxtZtYkTuiCZSlk+iHx3fJGvs51LzvTcBueGDr5Mf9pdXQbKLWLQ1itEvJO4N21Nq4VM7W7yUxx1yV8KxSZslBebkgcGAwoEbe52Gb15zQ20CZAK3fOykOO2AHdoqcvil1fthYMT8UMM+gEmgOlq5HYUqARuyZniRdpVygFwAUhEX/1pffHZkqiHik6f+lwFFqRpYLRKTnJ1xSGdjHn2zdLQl7Ki22AAk+UoIenbV0b69Gih5IU2ei1+RAZQMN9FRRfbyPW1EDlbNxNhXlMB0Rd3Xnm6e9N5J7D/xtVC+g1/bkk40RDr4sOTJO/BtUyI6CkbHqzJMnzBzYi3GFLq+bSeZkA/LRVt0wpUbXzRHaFlBImcTynBY0Q4mNoQllzQoXMLPzLQLRM8Dt1smdW7Cs3RRkmZ8UnnksfBkssZIhX479GWQYS38rNNEhs9Ny9GrqSpc/R12xl1v6aiRFacnKN/+WP3wHs4lJs6QJ22YUa7imAbsDJFmuPr2RZnvNg=
X-MS-Exchange-AntiSpam-MessageData: JVyARPJ0Hty+TD0Dvi361cKI0/NAgvYVJO4iUPcisQ5+5SwYUNHDXgjxikqPBtbMonird8mIhepo7q/n+KluqWL/LOGgenwegED4tsYx9fX9dRzSVJ54cYRI18PCkgKk9B+J9Bl5rby/mMQNlD4WvQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9f9968-06be-42ec-d70f-08d7b512b422
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:07:04.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiGnvQd99caldvIeSRzbYQsitwCqRx9xI6leTm3LKBc2No1dkdLvuAKixUhsi14Yt7Vr+zcnrx2rq2nzyaeAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add cpu OPP points. voltage part not ready, only clk freq now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index 32c218123662..a5bf6605f729 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -41,6 +41,34 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0xf00>;
+			clocks = <&smc1 IMX7ULP_CLK_ARM>,
+				 <&scg1 IMX7ULP_CLK_CORE>,
+				 <&scg1 IMX7ULP_CLK_SYS_SEL>,
+				 <&scg1 IMX7ULP_CLK_HSRUN_CORE>,
+				 <&scg1 IMX7ULP_CLK_HSRUN_SYS_SEL>,
+				 <&scg1 IMX7ULP_CLK_FIRC>;
+			clock-names = "arm", "core", "scs_sel",
+				      "hsrun_core", "hsrun_scs_sel",
+				      "firc";
+			clock-frequency = <500210000>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500210000 {
+			opp-hz = /bits/ 64 <500210000>;
+			/*opp-microvolt = <1025000>;*/
+			clock-latency-ns = <150000>;
+		};
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			/*opp-microvolt = <1125000>;*/
+			clock-latency-ns = <150000>;
 		};
 	};
 
-- 
2.16.4

