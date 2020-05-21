Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE45A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DhryGNf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgEUGRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:17:40 -0400
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:33889
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbgEUGRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:17:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH5KfF/oCd9QBrhCgPyhjegYyMZN0uhQgBntNIM36ujWerNgjVC0SaHt/bSfntQdq93fKOE/D0OtIwsVdws1UzB2Qn+GvV/qgnK4k944iSmW8MHg2P0q31biUJVn8Th5xf3KK19LwYeTiitME9Hbb7WcIvBvb/RUN/lQYuXuvvRoX1vKZ0Xx2FyO5rPlt2cZY0zrlIt7PxDVVSd/XophpsUFOFhcOWGEhffvHrlg0gSakTGFHF6v3H6sbv+yrpBFIftkxoikI090AVvkCc5YBD5BW3wgaqZf5NeAWy1uvNnHaNqAiDws6w3T9ps5/vDAg4O98w7J8vO3Urt1FpIQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZyVXa6OVYjI56fPdSOlinHR0mhsfjQmzse91s3Pqt4=;
 b=LSTEVEQrJKij2U4CFwRFEvGu9lulmKRBhULIAzs51TBRwlxWGR9TaB+QJcjEH3/2h+Fl7PzNB1zsQNq8TKsjmhnOXXlx8dx9bIGF95vY4uWsdjys7vHBTKBJjTz2eH6G72svmLQXolE5PjBpi6+ZCPf8SxYcLwwQz2xVLVObflfdit/4j+DYLr7J1orPtvBnvhD9KE69cZnzRypF0atfbRqcV0jfYt2WJ18NfbfalujbJUIBSKvgPsMHuI5apb3eNg/HReD8xAb6MDNdWn5m0FTdpg6QZzB48YkgvBZimJVWHTt+z1ITXsANcdGHdndYYj7gphP/PLu+FBvsbpwMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZyVXa6OVYjI56fPdSOlinHR0mhsfjQmzse91s3Pqt4=;
 b=DhryGNf1wSITqCfKIQUylXPmuaaCKyE4EHew+CEbNvt3DhRd0FKT1xXECF+37U6RKsSds17XtipBvgM9SPHfWfmTNH6TdKn2QHVzdUgLKZZLNwO4zOk+cwV8ADNsRFStN6ImVkZ7iAYq43pUD0XIYrRP/5X8k1lOnUSKrfSCKlM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6720.eurprd04.prod.outlook.com (2603:10a6:803:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Thu, 21 May
 2020 06:17:34 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 06:17:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, anson.huang@nxp.com, peng.fan@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2 1/2] arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage range
Date:   Thu, 21 May 2020 22:17:53 +0800
Message-Id: <1590070674-23027-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 06:17:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89994a09-0434-4e68-af8d-08d7fd4ea64d
X-MS-TrafficTypeDiagnostic: VE1PR04MB6720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB672076F0F7996CB95781972A89B70@VE1PR04MB6720.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IvV5abqoQa38WTyJL1ZXf5z/Lv0RJge4YWoDOpDSWCXUv3zfNbxLFHq/i5Em+A+MA6ZokedtG4X6wZb+u/r/9uPWWeI9QHa0iNmj+/q8ZTDCtbF23cOyWWCjN39AOKuWvKNwHczrsU7MLrBfESmeV7KEzujQZ5/AOy0ai+IauITHlnz5C6VCmXEUcUIT0A2AHb4FE7SKukqtEldCnASHNrfaXLqzyPV/QsVfZsRVAXto4V0Mbq4vxfDEEy9DIda1rPkewyZIX7eCuTJJQuToAF44bJs2FlOgBJc9U61WnSGPHy0C3Lk+iECGeuOyHC2BEraUxRfQbBLM1GVshmxH8ox9wgmgAEhuiWfXMQiCwpT5ZEy8JtAPJDZb12q3kpx7jDi7igw2967YIbdms1wzzGjqNfsGTc3uy51GDaSFw17ZCMtvSDqaxWYot1TTMpZY3s9c9RnbRgL62adoX8srtITs28xuDOOYjzO1jc0CQRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(6506007)(36756003)(6636002)(2616005)(86362001)(6486002)(956004)(52116002)(4326008)(5660300002)(26005)(8676002)(186003)(16526019)(66476007)(66556008)(8936002)(316002)(6666004)(66946007)(2906002)(478600001)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6z2ubjY4anI+e89LieQ6dSKqVAlLB+UwCjuW8MZzVrXleKvc/0vqdUiKt3mVhH1ztDhi73J9XTRO5YqlG5GkbXLGK2rc6yMfjyq0sQID/tB8OEHXKnl+Ktxf912zqqiKpg9nfrodmU/WsF6SDoprgAJiAv25z9aNyNvKa9EhdB55grCkrNqc7XkVpBgBpmYpVRcMATE1k1+pVvfCEEl79Lt/Wu54S7RAcMjpOxa8hFrUZK00qNePXfkoUyfMoXqa4PRjCh7bFffkI5bibW5M1u+5g6GaSw6AvIq6CRmWzKW6lVw5cFdd8L5yX7nX5Ryx5+kG7d9VP2EYwbyYomcebDby/4Yo0qGF0w3QVuPvRG4cWVDvuIz1qw5AXQWCVC6+/+SuW2wcCUtNXGYxap3CaIeNUonkEjBxvepGMsf2hwYnDBvr38RWgP08b926NzUgyhrZEnNh72j5DixCLfVUVQM/htR6Um7djSrNxECrD9uMN/U9z7BnYaEtbxvm5AZR
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89994a09-0434-4e68-af8d-08d7fd4ea64d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 06:17:33.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9uC8c3waRkn2btB9Hr/0ghRUpbHAO8EYSIxTge4gNlKXvTdLGy344Bg42rcloBptDj73M84JHKPFOdNJO2YuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct ldo1 voltage range from wrong high group(3.0v~3.3v) to low group
(1.6v~1.9v) because the ldo1 should be 1.8v. Actually, two voltage groups
have been supported at bd718x7-regulator driver, hence, just corrrect the
voltage range to 1.6v~3.3v. For ldo2@0.8v, correct voltage range too.
Otherwise, ldo1 would be kept @3.0v and ldo2@0.9v which violate i.mx8mm
datasheet as the below warning log in kernel:

[    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
[    0.999196] LDO2: Bringing 800000uV into 900000-900000uV

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index e5ec832..0f1d7f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -208,7 +208,7 @@
 
 			ldo1_reg: LDO1 {
 				regulator-name = "LDO1";
-				regulator-min-microvolt = <3000000>;
+				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
@@ -216,7 +216,7 @@
 
 			ldo2_reg: LDO2 {
 				regulator-name = "LDO2";
-				regulator-min-microvolt = <900000>;
+				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
 				regulator-always-on;
-- 
2.7.4

