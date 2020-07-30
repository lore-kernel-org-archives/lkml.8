Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EAFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA69F2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R+Xlxa2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgG3Gu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:50:59 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:2743
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbgG3Gu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:50:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ8Der8LjxU5Gr4cFHZQsNPDHhHx54oUgZZcWamC63CqZC4/6KXLfHVMad86SF81rpRW4lGACVkJk8VIqmB6/7UTDsl0cq6wplhBP9aIP7A85WVfQE43/b/XJbcAjAJR03OSTrBKdpqr/h1tOkdujCEal+LtKDAmbYJmKyuzlPXrc+9FFtWvWrpcvH6d/knKpmEfrAqNPp9TbcPGohGH0iqAPeXoaOAfjg1ccHWqKASLf/1yfcjED9ZdA605BG6voIKYwCmvTZB6F+tmb7//ZdP0nzmf8Q+RckLZNOGx7f77oVtbYO1JZGNcnKNw7gccnjY0U87HUbjQY49NXm0tyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48aA6PP/DXWrndQlU6PWZJzfTv0RT+18diEjrEElisA=;
 b=WNT2ksEMdFmiMo/jzuEe9k8pFsAxmh6Xnf5viaoGZDlHzOSJ8UmkExQqVF9KsMIyco6L3CWBVPtF5ed/QaGfOUltMZHbaSzVz8wtA4KY6uBYdrk8wmdtj/DDYmjmFDkRKzbDJPIkXt1Jf9lmnbt+9sbUs/Nhgzh5ucHQUb3FUtNK4Vmy89OCTFE/NLjT7D3LIZYJ2sGedjqZIKeq4Du8WS4O5h05pwZWTGLpBDQHgSGZh5sNHnOOw0NLfXNF5NaYCpGwPm3dujD4HV5yFjMoDS9fga3/k+9cSe2xvBqppw+B7VrvLQ3h4bDmiDXIPaKHyYPgxfBL0ff2bsgumCGRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48aA6PP/DXWrndQlU6PWZJzfTv0RT+18diEjrEElisA=;
 b=R+Xlxa2J8URPsnUsu1VxQK+gjB22wGI3FRHe9Y8/nNYtVTUh75Lr6CVx7nYVgLbAEII1AQNCYQi0qDPXCxD5Hf+Yonizta3uzUsIFS1prHEd5Wa6cRRHHEd2FXoSnhD58+d2KUCxoxDC1sxXIiUfsfIdJlIysdE5vMCssD7bmvQ=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3015.eurprd04.prod.outlook.com (2603:10a6:6:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Thu, 30 Jul
 2020 06:50:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Thu, 30 Jul 2020
 06:50:53 +0000
From:   peng.fan@nxp.com
To:     p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] reset: imx7: add the cm4 reset for i.MX8MQ
Date:   Thu, 30 Jul 2020 14:46:09 +0800
Message-Id: <1596091569-10013-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596091569-10013-1-git-send-email-peng.fan@nxp.com>
References: <1596091569-10013-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3239.16 via Frontend Transport; Thu, 30 Jul 2020 06:50:49 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dba3b2e5-52f1-46ab-8104-08d83454e6bc
X-MS-TrafficTypeDiagnostic: DB6PR04MB3015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB30150147A4B1C6E518F0534388710@DB6PR04MB3015.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJOU0FGjpWHhooSYf3rkgsBmn94LbCZFFCf7eLtrNogLAAVd+uwiMHRmpRq6mQVP4JoZBobIBvaFnYAESYT6IH0BQ95/0PXzohcqn3/mg787asbELBjmgU1hwRNZdmx7Y7pnGJ+bX96SIJfGYh9e2G+K3Mx/HPlLK7NIxhafmGNA/pkC800OKkQQOX2I4fTaY0ADXHfaza0hqmI6K9KM2wgT86P1BKlNqvF1X2QMjpuGa45QJFWE41i+IsnUgrqX1OYgJWA/y47s+VnKxN8B/gT/gcEeLqlq3GgdY1+t6nxL6FaoFBSB2AXUhAElv1NDGLj2k2siqYFghhVT6qO14jkHcFQkavzckO/BJlUnY5suecNjG8XdXOJ/TXFt1Acr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(9686003)(6512007)(2616005)(16526019)(66946007)(956004)(2906002)(6666004)(66476007)(478600001)(6486002)(186003)(66556008)(86362001)(4326008)(6506007)(36756003)(26005)(69590400007)(52116002)(316002)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fmnfsCdIllG5ei7++5VQ5UoH//Rc9ECrGifRhJqEDWqjh5rtseMIKltYPmfct+jUlyOdurS1r9rFYCvUC3zcT+gbIhFKYuwRoV2Y2LcDio+c/RpnZ0CPUUttQ9coGb2vVYJPiXbCpa7B54p6KyPUTdCBMqC8U8xPAJoC4KTwU4NLRIXLo7+cyT7x0syf8HJ659H9ScfsAk1r4aaR/L/GJa0gwNsx0XqNXXQLQ/FNI5Oe1IxRec3Zb9lS19Jb32geRzM5QwNAGxjjMxdHxO33gKQZuTwLTXdufpQsw36TB8wONs9i+TSlBIjLvZmnIKtqZSICcazZCvhEbnjpvc4/UjZ25a65AxaWPqHxqQ8h8Us0uQY592rIIPr3mu+oM8J6HCnfoii0NjTvIjOa1QVVII23DF6YLxFyZ0eEwL7IwT/YdGmZyEAnpvuBKqNwOde5o8pFEZU8I1ZnAfXOW86G64pMVVywiZGZHYoz4SYKIPTpWdG2RudRvVuoAiesF7kh
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba3b2e5-52f1-46ab-8104-08d83454e6bc
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 06:50:52.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+/uydEkMVQ1Gpm2YQxaebtk8Ir2a8/OhrEOYKzR9VB5BjgZ4XyzumMOg8fyDfid+nsFUAIQsr3go/SssOVSKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the cm4 reset used by the remoteproc driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/reset/reset-imx7.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index d170fe663210..87b6e2d46fb6 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -178,6 +178,9 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
 	[IMX8MQ_RESET_A53_SOC_DBG_RESET]	= { SRC_A53RCR0, BIT(20) },
 	[IMX8MQ_RESET_A53_L2RESET]		= { SRC_A53RCR0, BIT(21) },
 	[IMX8MQ_RESET_SW_NON_SCLR_M4C_RST]	= { SRC_M4RCR, BIT(0) },
+	[IMX8MQ_RESET_SW_M4C_RST]		= { SRC_M4RCR, BIT(1) },
+	[IMX8MQ_RESET_SW_M4P_RST]		= { SRC_M4RCR, BIT(2) },
+	[IMX8MQ_RESET_M4_ENABLE]		= { SRC_M4RCR, BIT(3) },
 	[IMX8MQ_RESET_OTG1_PHY_RESET]		= { SRC_USBOPHY1_RCR, BIT(0) },
 	[IMX8MQ_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
 	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	= { SRC_MIPIPHY_RCR, BIT(1) },
@@ -238,6 +241,7 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
 	case IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N:	/* fallthrough */
 	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
 	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
+	case IMX8MQ_RESET_M4_ENABLE:
 		value = assert ? 0 : bit;
 		break;
 	}
-- 
2.16.4

