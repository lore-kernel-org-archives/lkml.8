Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C888CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A446020771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UMoNsIfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgFWHBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:01:48 -0400
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:51875
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731291AbgFWHBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:01:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6jq3+poc0mqf4bEPJjjhf/rxh1RzO10XM5lIDmYfYumbZ4zlzmg+/jT7cSBCB75/+elNpKRvXwcX8zTGkeUmm2pthiJGfEQVrZxZv1CDRmRRz42/8qF6sUH4SMCpSdS/ferG1SNn3yGR8/FoEbuW4IT+4sLbklItlSk6gwOtbWxNNnJhW8/D+MNNTo/mhYIy9UHoI+WtF/ompu5SdaS4KQuLvn2uKqRXCt+ItgS1+HCJ8F6R8VHq1G7+x3ZfSFCQLyz4S37bjqxrXO811vWmz1PSegbPqCHYpDmhklTKgYrXpKHxwkXZr0h82tdxz7yVvVnD4jkqdUvLT0yENB5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plwsE2zvLIv5H/Qw5zSaoUNW8nDdo6afveRiPlhn41g=;
 b=HeHyvMYZPc7PNEQtfskEYMP8KBtWBa2BaHS5o3T1QDDQ9ZxGmz4akicCAJCWMMBWpF/zN0XfiXuQcu1fC8jR8q8C1I8hJJdUrgd3h5vEBP6bkcSHxVz1GmCz7a7wZmWmms3HCPyKOtNwYPCzzky+eupUqcQiedN2g5kOKatVZ0c8itGs7cX5Ze0agNTdoN3DdTtLaRVkge8hpOJYfK2Zmae2j1NUYl1RJXv4no/j3Dh33/tAeU1oNY0f4rbEHT0ldCRAm13H6trCevomVNYWFb4LyiNgqkO7GNAPeHiGGZ69O4pYQXroEFw9qAaaCTidf79N6KydYlAPkB79CH+I9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plwsE2zvLIv5H/Qw5zSaoUNW8nDdo6afveRiPlhn41g=;
 b=UMoNsIfJo8hAU8TvBekSTCFudm5yh95Oucktis/IDBnRIbqmS0H8Sn0pwAIgFef7+u/Ghb49yxxXDTYF8o0q+73WksQqxVuXA2kpZaCVKapgkThGOqWavPxh1NV231V5TmDsjMtn6cB5B96oT7jXMlzVn6lwJJvdTogsch84Acc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2711.eurprd04.prod.outlook.com (2603:10a6:4:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 07:01:37 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:01:37 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] arm64: dts: imx8qxp: Add ethernet alias
Date:   Tue, 23 Jun 2020 14:49:54 +0800
Message-Id: <1592894994-30015-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
References: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0101.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0101.apcprd01.prod.exchangelabs.com (2603:1096:3:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 07:01:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bc63ee1-fd1f-474b-0020-08d81743455d
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2711C672C120219F3D168B5A88940@DB6PR0402MB2711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46L8m9soL1kGyzvTOwk99dNKWFDkmvGIygC+E9e/pV+HKZgoONiFGtOSrLEziMQgG8q4QPHTw9XibTj6aegOtPBC4y/Toh6qjqZrPoFdtZqbXxMOJ8f1nB6fiBCqthta6RbMNFR7pKSvzMtZMKlbJY3W419tqnbtEQYSAb/I7LiDWUarAUoSfN4uTAAI9KOD9YvqkmreDHc+FK67V7OETyjOhiCaQTzKJwf4BmiIj5sQ0IhxbFlKjv7ad9B8qdCwGLk2Cv6tJOgxunRI5mY2Jxq7vo8J2q7SzrK5OPVUX4j2qg56hsfNYdkikAGb8cWDpA1qk6WVQgGunQjmsuwuw4woudz2vlLUwoLTGMnAJS72Y4KgNW5avEAiaCECV/XH5j/BLSthy/7DfyUFY2G22WJN6aEcEbRLh/3Qf4XjMfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(4744005)(478600001)(6486002)(6666004)(5660300002)(2906002)(186003)(316002)(8936002)(16526019)(66476007)(66556008)(956004)(2616005)(4326008)(66946007)(8676002)(52116002)(86362001)(36756003)(6506007)(6512007)(69590400007)(9686003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nZIaYu/b8x2BFYRshytMm0rcqKYhO5WUeswVMqRco10MdlnEp5FpJClPs0yYIqJUA/UJMfUZxufxjM6uiSOVoLpOknajK+dus6Uv+THw6P76CLiDLPKav149ykCV2VrKopBdFGN5ZBY2rx1IMLS+mqOgOshYdyNiJkHiGHgOcWwp0A2s4gFQ02p/hyzsSwk+8sMc+rPY9Dx7igO7VYfMhtaOAZVz8wNCWD9zx3f6bLPW18hPqWrG7vyj36BDMO+4Sj9NV36diNux2rRyCqYb1KyNSL5c/Vc6pM3b8eqLsu6gHg7tmHLpH3giNP5YgLWmP0UoOrCOanL3grIzylOARAGVvJjlrc4OjM2TS6nGfyHRelPXe2qKXTN/TOKpdzetTb327WmFSU0KeML5dYmFNPMocu5bQHuKqxbT/SXBNZcupQ85nQSFCNFAulAGKbLEP0Xp6lkdpPI4RHOGpqhoEq8XVYa21FvQSDbBzth0dlg+D/K0YDdIhm84R9NIH0bn
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc63ee1-fd1f-474b-0020-08d81743455d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 07:01:37.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdkqQ3E8PET5wKuVyZXmcl9UR/z8pja7qCk4waaxipj7veoELHtol7vNGcYYlmlM3JtMFsbHlCOC46SeZm3oTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add ethernet alias, so bootloader code can use this to find the
primary ethernet device, and set the MAC address.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 3b2fada99c09..e46faac1fe71 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -19,6 +19,8 @@
 	#size-cells = <2>;
 
 	aliases {
+		ethernet0 = &fec1;
+		ethernet1 = &fec2;
 		gpio0 = &lsio_gpio0;
 		gpio1 = &lsio_gpio1;
 		gpio2 = &lsio_gpio2;
-- 
2.16.4

