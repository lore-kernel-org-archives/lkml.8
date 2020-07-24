Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4879C43459
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E22076A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mSPpMZFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGXHnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:43:39 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:36007
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbgGXHnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:43:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZdtDTEuZ4AKsaD1LSGpV0kvkzqu2o7L44Ckqk3sA9jsBmwdR7xio7cREeI6LWDXql59j9YZwqpzqt+6uo8qvK9PnAnsO/THo+UKIqmZQvSDUEH7DFAPC07hGArmwotcGy2rcD/cH2xzr8lm8ea8LGKNl/CglTEp+VXWnKed39kjlqjKRCPXgiOQt0F1rj8QiELBsOwd6IoJXJUR3QKgcc5KWwxJBKxZuu7dDSRp9GmdgoGVRrx0STpEtUU5uegQsDfSKsi2x/1W8Us8wTZ8PvoElJzeAF7UqgWypTvFyghhHRaWl7xnNrhT/WaBMoyX21wUBXwzdJ09pvMpM+MJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWr0ss9DEwgiTYRm0sghYVPuZPbmFJHyVAX3E5aY34c=;
 b=lEAzjuDacg61a4kSKnxSSbIABY4DcYeAxSXGLzUXbUcIjKZHcEmtzBN1XtxSNt//qtLA5yoEhKCjlWFNLqx7JW+ElphGCHCEQ2Qhix9gS2dcymRpMWQ1epE865wD5BzUEXj1RSkL0RtnPfE6HXPBbqnrZkMBvE2kw8EIWpTCb1rupAkLBSLtbSLZZ8z4jlnjPQnyKJiAZHZpvHLPI/53xQKzJKS7s0K4cWRHcCNf4Hle58TjAC+Libt5GBiInhORwated+HwvsvooTqEm+DCYzeDED3q4bGweAwe3FlC8ZuWWRhemKF7qIaIvDJgJYBm0o9lRU022RzRzswEVzlgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWr0ss9DEwgiTYRm0sghYVPuZPbmFJHyVAX3E5aY34c=;
 b=mSPpMZFtVmwdlwRJ6x0r5CXkrDpuZHO8sJ3FETqivxM6/se+V0zyAP3A1UubRHx0mxrEfYuFBGmBysETgJZwpG2MQX94GxdGJkBll8DETjPIGVmi1t+V5Vj6gT9RdwCf76YMCIh+H0ostD8HPb18qaRR1QqkpMSShFlBCtIxgW0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:43:32 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:43:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 01/10] dt-bindings: remoteproc: imx_rproc: add i.MX8MQ/M
Date:   Fri, 24 Jul 2020 16:08:04 +0800
Message-Id: <20200724080813.24884-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:28 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1f0475d-8746-4dde-2d87-08d82fa5436f
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68572EA9BB446B0C9EA62ED388770@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmF1xSMj1ByBMkordCDBahnPeFaq74L0QL/hJRByb6X0GyCD64EVc4GLGxBRojocHf42QRbvorRukR/5NGLZUai+TQq1q5OWixQenGfWVgcomfGhJjVbgc7Qh+37N+UB2EVqxikoV8VwOm/q866l/PMzwwHFi/iGDUQolyvwbFnJGAG3pjDnIQhHNvUf+j/0ruS1V9/mLLK83Q6A3QXiMoNqkKyODmoVp/oeziSJKI6yhNqkwtKJv+C+6mYZMwn07+BJk7ZsAZP545FKshOLuYV0DonFoC67xpYD1L6wSSXchLFevMgSyFcUM5FtLgdvzlT/bEm61bywAiF9j5fq9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(6512007)(478600001)(8676002)(2616005)(7416002)(316002)(44832011)(956004)(66946007)(66476007)(66556008)(1076003)(5660300002)(6506007)(186003)(26005)(8936002)(6666004)(2906002)(6486002)(16526019)(86362001)(4326008)(36756003)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 07+t0MmtcS3JZavbFXl5xwi5hiDIPfkPjF6YZ3FXJJljofYfcrKDQ//qHsmemXJ1J7GW9VdK0AsTwIGfwj8xz6ub2Rdj+kvXDZK5W+lT93zQB4pWupDmifpJ12rkTtbk5ght7gb3ewAXtKwPMtWlDddMrBxIQgSX4ZWNauwBnzJCTBjGqeRySaw1zQp8zHvYh0cXKAMzN0n75WBy4VeWrI70URZXNt0nurNNHb50Ze0lF2X2et8P+lAbUEBSKjl0cJSUMpQXvUTSCSuIxw9uxLYoyhOgGwKRAnh3WayDmAjZLbCXVM4tDPcgsIcs7LjNiLIwJycTykFJ0zLFTSGnjAyGAMp/QAvyUKDghgRI0Fpp26nJdhB9dn8GBNZwIIc8SwYC3eG7YljDV72yMjeEY4hDPYyEtB1e8k+1uTVC2mkjv4n5sOI432EGV19kLW7wYTiJ6FL0modi7SNFhT15HOXM1bBKNy0mqqjmg7nLjpCJfxCwIEVknY1vdNLEBYiz
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f0475d-8746-4dde-2d87-08d82fa5436f
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:43:32.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+ybt5fd2x61bQ/J9CkQnj2u8sli2xPKTycjLZImZCbI459uakQ0OsA699ZX06IfXZ/+lyAo4S8MZENu17o/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8MQ/M compatible string

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
index fbcefd965dc4..46f7623512db 100644
--- a/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
+++ b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
@@ -8,6 +8,8 @@ Required properties:
 - compatible		Should be one of:
 				"fsl,imx7d-cm4"
 				"fsl,imx6sx-cm4"
+				"fsl,imx8mq-cm4"
+				"fsl,imx8mm-cm4"
 - clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
 - syscon		Phandle to syscon block which provide access to
 			System Reset Controller
@@ -15,6 +17,7 @@ Required properties:
 Optional properties:
 - memory-region		list of phandels to the reserved memory regions.
 			(See: ../reserved-memory/reserved-memory.txt)
+- rsc-da		address of resource table
 
 Example:
 	m4_reserved_sysmem1: cm4@80000000 {
-- 
2.16.4

