Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4079C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB382073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6oW0X4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHaJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:22:46 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:48899
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727810AbgHaJWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:22:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVKT+XcDmufnXy+9suW4BDLfqI58oqfVxrru9sfJJ55piR2H0BxHl6ubCAmwk9tz72Ioc9ZT+gGPYvx+hRrU6SuQ3i+moFRLiSYeZSHoBgMQXrVOevTVtpBBm/rSbCydWm5L5orqon5yUy0FeaY6Y6NKsLG92Wqy3PF9vZcB69iBONxSYO8S/HYdsGk0rqZwIwFC3E9148aT5Gl7X1pKC7uMroZG4ipNl1NJJ5ZMKZP+ltT325HU8GgE6Xo/mavS+FBQE+dWae64khpPg7Zm4FA5LelWJNUINM05jp4x5duF/nMJBy14OkeXFH6Yqsguj3c1/y5j+DBCQ2+ab0KKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAwAaiiwn28UJE5V3/saYfJk0q1YVYoYUqHCQsu5k6Y=;
 b=TOZ5YdM5m0ntRq4eParWE0v8KpsTBlawkLaImX89N6dn4DyfOf19FYBtLgMFUlRmVesdGa6I+v1+WhcCCSZgnx0pndz4o2b/Ngs9EF5kGqPMC55bPxmBQnz+AyccAiveobDQYe+VyuFwWVV+gi1ZnWHiitUzGI9UzVMxm2OvD+puilLPZiyUYo+nFobBvQa81e6tVCxSnS/ClsKaE/aMBolo0Av0iyQR1oKk47Ib5ku6ejtrYYypI4nPX+YJ06gPiZCya0B9ZNvrh5lzDwa7f8wSQcdoSavp/ygDpCt326vVkAo1h9bYnWx3SNKqYA/Ii0JfujNRdTc+G3DWIELxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAwAaiiwn28UJE5V3/saYfJk0q1YVYoYUqHCQsu5k6Y=;
 b=A6oW0X4kcBbtZemAlZH9lZyl5OVTg/q68FFhqiCa8ITjX0LQseBK9OxhPrXnGLcuKu6+J+i/wIz8idsfQ/GSLnY7NVI5APLvWYy+i8hOe+rt2CaA72FA21hj6cvzKJC/xZZ0HU1lUkgkbQQVFECWJdMPr7Wd4/OGDKokcu6xnbE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 09:22:39 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 09:22:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, Anson.Huang@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM64: dts: imx8mp: correct sdma1 clk setting
Date:   Tue,  1 Sep 2020 01:36:27 +0800
Message-Id: <1598895387-22313-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 09:22:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7ae3770-4260-48e1-b34c-08d84d8f6806
X-MS-TrafficTypeDiagnostic: VI1PR04MB5696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB569645AB519965B406D7B98689510@VI1PR04MB5696.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6s52sPWhoS5Zm35GCdlNr7fiKSObyprhZnHDhMkRVNoFNaN5D5EDkO9gTnb8uVB7gd2ZlfzQ9wAM96MU6ffoBPj3gjsAC+W1oETmenWiT32FDsX+qW27OqyfP443VtHLoxwXn4JZ20eLLqtL0Bzt2TUOCdsVD2rQ7pxXsXU2wNXbvD4wqL9VU7WGHU6DwKgWB54KFBpqVqHFDS6V8GjJ7dk6lOjKoGSSaZ/Uuhq246HpfPmOIgyr22Xr3bBVSiIHhcJfaB/JMg28weqhPLrrHS963GrR1qfwOV+PDdsLmEX1t8b57WQarmRdBF+ySrFn3nyJBiALJC3oHnEii4szEiAS6sNSPmCyrMgimkpDZYetd8s1b6f2DNj9wJSluOOi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(6636002)(4744005)(6666004)(52116002)(956004)(2616005)(4326008)(6512007)(5660300002)(83380400001)(66946007)(8676002)(36756003)(478600001)(26005)(66476007)(66556008)(186003)(16526019)(6486002)(86362001)(8936002)(6506007)(316002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Us5PLhp9WuklyX3kvLiSXjtFO1xpha4JnCCJVFenBKXrOfQXxrtPRwUh3KtNqG7C34Uaw1RRN3jJbcD/sm0w37GpZxgxasNwdU+RKGzd4iTFYHxJbmLsZ3GES0YuF1uKhgd9AwnSBF4UXvouJaakGXGOOpslUH9yEL2UxVFhJ34Sk2PQvOvVKJJ79csEpAT5SjWvML/dfDQcrGyZzGLU8hPSP5II4q1Ed+5j1/2OI5du5nEgegGYk6jbvyVb7wmM38fQv6naTefyOaIOqt1sv5LBvhYmS6r3cqSD4iMzudSzYTvRJ3DUB5lhQYhX8dnQuUAB9+AP6zsHGQSTLZcwR8PxRKw1gy1gXazMw+KCN923nLZiGit5CedZo5Wrrf687P6RXdNS9wHlhWsCRaaO563/nTs9sdVeyBTeS0XO+OwIqPIwdtlpFcWv5u2keRCVyTZUC5zHTAZ68dYoc/SSkESAOgLuU1r9sUT8NATthD8e08lXMA3klGK2dir/WUZZ3aygV5xEIg9ttzWVeK9pGt8b/ZN6isjIbok8H1oy5zgyXt55q5RQx1wkW3N/0M+Q4rslpwZfwqL8eO6pz6rynz+jWy0ze48rx9V4s6D9UQVnYvqy/tF12B9UdknmZLiBo6L1y1rK36ucIqj75Ghp/w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ae3770-4260-48e1-b34c-08d84d8f6806
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 09:22:39.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbToilVEGiG4plTzvOOUxCRzUI4WCblw/LEsBYG4zBZG7ElXuG6OvRVg5a6dGc/jkCPwZExUZmX5VhCISV9l7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct sdma1 ahb clk, otherwise wrong 1:1 clk ratio will be chosed so
that sdma1 function broken. sdma1 should use 1:2 clk, while sdma2/3 use
1:1.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cad2dd7..6038f66 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -702,7 +702,7 @@
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_SDMA1_ROOT>,
-					 <&clk IMX8MP_CLK_SDMA1_ROOT>;
+					 <&clk IMX8MP_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.7.4

