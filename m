Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C59EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A9620656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EY/rMHh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgG3Guw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:50:52 -0400
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:8419
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbgG3Guw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:50:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0ALxpUEKvvVeqogRGlJMVP1/L+3CSY5kb1DtJ1ucDsEscXxFj3QtowW+/Z4vtREv7N4JzGhYOE7g634/0djfXDKfJDANf62Zr/iZOCuNltGHO4J295ahPVtk07gagMEW5LcAotkvWd7ZvghzbzEBlEYbYv7T2S47g974Ktg+he4CaTUj4KfTP7ZBVd9wEiAlOjw+n+Nf+hgytTvjtddhns7Gd3XtXbIkwl6uQ87NcNrf0AEsGznXc18cfANgbu5aElP9AyK9AfFfpQCOle/1PgcgaHXzIzvz/IiLpEoe/0RH1kc+aOLcJfs834fY45rCS1DZ98Mvd6E3aeyclLdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJimGzboT3ZBqvfv9IAt5pbzgthPf2mpbIaSmm96tOc=;
 b=UooP2oeGAnk0k5zGdKjEyUm9cp7+U2Zhqqw4TCcTMqLI1oR5/PkxIA1EmJJ2rDPjn6kdtv3GdR+HvF/KsdPGwHnsyFx+cFCQgH/TsQK3S+mO44MuVlLp0M1B5lyB+K1974wm7tk71eT2Pn9aQgdtteXhIWWidYf3ZtHplE+UX2BwGc8l5LPgkY4Yr8ez/L1Q7MhgNp+FpUwDq1xAwKb/faebCHVXJoN50pYlndVpmJpTe48Tzl4W/FuxYhqtf6ooWFA1yazJotUm0b5FMhZhOmJE8dztdcEBGVW9kQDNUuFAtLYnllvyQyjYst2aDWw8BF/SZ+sHsAs0e3AY0gKWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJimGzboT3ZBqvfv9IAt5pbzgthPf2mpbIaSmm96tOc=;
 b=EY/rMHh3wKlvWb3IWw45IA7WioQSFa+o93sZjH2ag7+f9TGIIRtKt7R0KUwvO6Rbacwq/G47R9/nu/+tmzUdKiNyPtvP+YKqCgEkJDochnJqSbZHAO+3s8PxyXpj7+lg+mQ89jtgb+CUY5IXAm75O3qitvEjaMXcdfuYhRjxqmU=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5803.eurprd04.prod.outlook.com (2603:10a6:10:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 06:50:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Thu, 30 Jul 2020
 06:50:49 +0000
From:   peng.fan@nxp.com
To:     p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: reset: imx8mq: add m4 reset
Date:   Thu, 30 Jul 2020 14:46:08 +0800
Message-Id: <1596091569-10013-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3239.16 via Frontend Transport; Thu, 30 Jul 2020 06:50:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a527bdd9-2761-422f-a1ae-08d83454e46f
X-MS-TrafficTypeDiagnostic: DB8PR04MB5803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB58031D00F2366BCDD88D3E6B88710@DB8PR04MB5803.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpeAjbv9QS5v1OxXXBphC3mZaRnZqeBcAh4jThmUOVGpFYYLIROB+/E5/SrpwfJw38IBssiW1RHr8ZS1C2JQckahlwt941a+sqdELB4WzsB1enHxs4YdBm89sjs9xDETxoP/I8LnHLFE2PhgsRj9DI1SBswPF/aecKUVKgAN+0IKhptSG5lpVNmHPTpBA6TDmsIWKaDAfv5fOxVjJWdZofnA/dzZqLJerw4ebvEClWWO2xCjiZbZlBkFg3HyauWbN3iUtVgm9qH9TR6xlAie8EQPr4P/kteXrVfNh3JaAdexYQeHOJDon6Sw1vZMaZeBJOW328A9Fk4xBAkwTGtipYmVTiRM5sBIVFi306/gPDo7DoiNH+eDhq5O+F+IIB06JpSBVGcNH62IUy7sJCYZ1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(6512007)(9686003)(36756003)(6666004)(316002)(83380400001)(4326008)(86362001)(52116002)(69590400007)(6486002)(2906002)(8676002)(16526019)(66946007)(66556008)(66476007)(478600001)(186003)(6506007)(2616005)(4744005)(26005)(8936002)(5660300002)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gjWzw2RNsRaNon2EKNF53eVlJvVITAbLQbepj4R6k4KYbSFYzXdS3uTCEfR83pBVRFZq+haES0d3vvr6wqEQzMRbdKJ/rbHJvJ51kkXBXvrHKHZWPLKE29lcQGCaPkAdxZypDxfOgVlwOO2oPylo2LMl5gF15xUpymB0Q1+QHiGKDIljbyLJbIsEJxc2Bqic8zXVvfggVud+FzcXOfe01tGjKWnrPAJy+IeBUMWrr3ENKFcO5Il/WD+Oxlj+Okb3GUfYjKmRW+gXy4gX6F71lfsiVUNN+Ro7NqLi6qq7nWpEZ2pV0n8CkaKHtuTIKJZNynoMM40Ju4YLMfPF3L8P1rDu9iOkNhnS33L5jPULH4pmxVHZChSy42JmiqCi5T3+zX8KRj3GMwTBVig+6cfPTdxAVuz+TbpkqxEbIuQ7woUXpyepdiz/B7FeFQiUeF5JgZDgPoaHeX63USbiwtDRuxxfTOFfjcvbnn9GbCeJwYPCWeOrF4OLIKKsNabBO+XWSeX6Ne2YbHzZt8Orjra0c0AeQuyOkXFSrVHq3sxNQi59fhPRuX1OgA2OqeANkN/igGAX8fCZewb+mTabyNPc3t+AHDjFRVHcBWtF/27yWFkbLi+z9iFZ8n/o1X96235uW/RazALPKZ3Ip0cEekkjng==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a527bdd9-2761-422f-a1ae-08d83454e46f
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 06:50:49.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8Y564FXZiUZaj87g7hj09mcxkfOQoyj0DzIIfyy50op07wbTzQo5cgLXdFPkBWYI0D/Wy+tYhddaWdwbzmqrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the m4 reset used by the remoteproc driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/reset/imx8mq-reset.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
index a5b570737582..705870693ec2 100644
--- a/include/dt-bindings/reset/imx8mq-reset.h
+++ b/include/dt-bindings/reset/imx8mq-reset.h
@@ -58,7 +58,10 @@
 #define IMX8MQ_RESET_DDRC2_PRST			47	/* i.MX8MM/i.MX8MN does NOT support */
 #define IMX8MQ_RESET_DDRC2_CORE_RESET		48	/* i.MX8MM/i.MX8MN does NOT support */
 #define IMX8MQ_RESET_DDRC2_PHY_RESET		49	/* i.MX8MM/i.MX8MN does NOT support */
+#define IMX8MQ_RESET_SW_M4C_RST			50
+#define IMX8MQ_RESET_SW_M4P_RST			51
+#define IMX8MQ_RESET_M4_ENABLE			52
 
-#define IMX8MQ_RESET_NUM			50
+#define IMX8MQ_RESET_NUM			53
 
 #endif
-- 
2.16.4

