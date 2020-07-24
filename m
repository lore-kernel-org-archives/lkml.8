Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21C6C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998082074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kTxF50qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGXHoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:44:10 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:20001
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbgGXHoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:44:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVGKTjYssoKqY2okkQg+6p8kQN6auWncnltEor3SwW9qI/KvEfK6RjXIA+osxGQYnSRu/yy8pN8wSUk2A3bwi2B+Go7Vg8cnpxhKonuO7GyLVsgZKTGy97XOCbfP4KDd1e0NZAE6S912KJsX9vQjVIcI54S7USZS6UsRPrgqB3dm3OgR86wHflPHySGLB8xBunJROsr75YFcA5iLrMltk+9sToALf8bNwqd5MQjFuaPhvPighiUOROW1Py3pRoLhLBX4CaAcUs4PX7e7FM1ugEdb4cseH/N6oCVG37RNkyypK27NoEWm6m6vYvQxBj2mTJ46E8ADtNDtbgLLERBv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmOmcZ88KXJyAJYcF09Ib1w500GSJmSl0cg424eQR4M=;
 b=hTZbkyi0KTEYVuxWX0seMRzL7vtItx5q0IS8rVtILTOJXlEgqSn9PeH/J4pVRK9HKZbvGdKLma0FhbcBU8vCK1pFmoG+r8xrQ8bCc/YJ1qgKGWvRdP5mgYto8292HlzUJY2Ce/3n8pzKcFSJKPAID9BqL3Bf2PbkMAEuuNMoLZQbCSRFLSZaKIrLuHviXCBos0qnalW3QroZ1fr66+5MQHo/6GGAK+s9IRPcmqBVSRRl6BD7U/ABIVkZESL1NTpEmHgK68W4HQMvHBKhdrQP8MwCThv2xviyhYb6j/3cqs8JgNTWGFzxpSKm+mIqxAk0GagLRlHgZp99nsanYhNh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmOmcZ88KXJyAJYcF09Ib1w500GSJmSl0cg424eQR4M=;
 b=kTxF50qEPlkV5lUnd/9jTQP+OP1GydHiUIUPVCeQ0JxTBj8NLzKzvRu+qX17BmAdEExvmDcPyG4UnoSueeCQ6+IRxHtrd3v0s1M7zbkqMAT9vfD0UrxLPHaT8DfHJPIQu7ol0Dz7aN7aYVODkWwMOUlZnr6zNZY3H5uexGCV05M=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 07:44:03 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:44:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 08/10] remoteproc: imx_rproc: support i.MX8MQ/M
Date:   Fri, 24 Jul 2020 16:08:11 +0800
Message-Id: <20200724080813.24884-9-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:59 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b79836b-8a65-4d94-a8c3-08d82fa5562e
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858DA2F10B4A1DA63DE59A688770@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XCpekZxBLDfbXsa0bx7ZZmiuP9DFQq8yzeML45o4Z/VkCQNEP50BrVBy1F8NdOEHcQO1g1y+7yGPABsbt+ukiAYCl5pejWZix4qWI6N1SPWB9mcs91frjV3a9+NOmli9WrV61t1Npq6rnysy+yUwMaWliyUFhzykC/fyO1RefjbYcYz9sTf24RfewtgZibAr5y1krtyqz40Y2hBX/CmDkKRPCuSGbkuqJHWIfS7hIHcSTrJ1W+ZnecFlix+bPQAszOfZvTg20rvgKD6r6TZmbsHSIdsgafIM3buLQWCxxEKKyLlN8RpIzWbOq0PTUfw1bAsgkDyddH0ScfGSyXSMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52116002)(36756003)(478600001)(1076003)(2906002)(6666004)(16526019)(186003)(26005)(6506007)(44832011)(956004)(2616005)(86362001)(6486002)(66946007)(316002)(8936002)(7416002)(6512007)(66476007)(66556008)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: im6P2HKZoVn4esXZYYz73+KuasuAbjpoDSct7EDWhSKG1RryGDycnw8EUFcPVvRC5OXporHOTVo6CusLgoc0p9Hs01DMKAjLj+y65DshKc1CL5N0r2to5r0Ns1uK2CLf4rm6JWQn8Th4kZbLr+3BBDfqvKUINgWnbMYDAZavc4IaIvT8OETNxbRLMkueoNqRM17BjfKeOPNeZhmI7/HfNaSclkO1gnJsrEwkdU/2XMYCof3cCFLaA3VATsqVwXK4O30KAtRLn3MTTceMw5cN6Jp4gFzSLo1ZpWeK7zuZ1deCaRfUj5EX1PIb1CikGrggF2OMb/MBLW85vhNAqzZtQlH7lnouaPjYlwvsABwfcS1B8diRPI1H6ch/z59IpKpRsuGhylhvzoTVcQMZPiO9M3xK1S7TF1Ysh2YDq0TErQft0+s6XIS7DGovMtSof9tPAcqLnyqO1IzPgDso9IKp05MRyW7+4KBzMAfrNPJZ/7M=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b79836b-8a65-4d94-a8c3-08d82fa5562e
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:44:03.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMrnI7vcLv3gzaL/JgjAkpaJ+EXTFeUFe6wWHvcEZtU+lqHnSPXrO7no/LZM2BntOi/SGReOGmg0jWAXRllWmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8MQ dev/sys addr map and configuration data structure
i.MX8MM share i.MX8MQ settings.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 43000a992455..03382290d6a5 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -93,6 +93,34 @@ struct imx_rproc {
 	void				*rsc_va;
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	/* TCML - alias */
+	{ 0x00000000, 0x007e0000, 0x00020000, 0 },
+	/* OCRAM_S */
+	{ 0x00180000, 0x00180000, 0x00008000, 0 },
+	/* OCRAM */
+	{ 0x00900000, 0x00900000, 0x00020000, 0 },
+	/* OCRAM */
+	{ 0x00920000, 0x00920000, 0x00020000, 0 },
+	/* QSPI Code - alias */
+	{ 0x08000000, 0x08000000, 0x08000000, 0 },
+	/* DDR (Code) - alias */
+	{ 0x10000000, 0x80000000, 0x0FFE0000, 0 },
+	/* TCML */
+	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN },
+	/* TCMU */
+	{ 0x20000000, 0x00800000, 0x00020000, ATT_OWN },
+	/* OCRAM_S */
+	{ 0x20180000, 0x00180000, 0x00008000, ATT_OWN },
+	/* OCRAM */
+	{ 0x20200000, 0x00900000, 0x00020000, ATT_OWN },
+	/* OCRAM */
+	{ 0x20220000, 0x00920000, 0x00020000, ATT_OWN },
+	/* DDR (Data) */
+	{ 0x40000000, 0x40000000, 0x80000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
 	/* dev addr , sys addr  , size	    , flags */
 	/* OCRAM_S (M4 Boot code) - alias */
@@ -143,6 +171,15 @@ static const struct imx_rproc_att imx_rproc_att_imx6sx[] = {
 	{ 0x80000000, 0x80000000, 0x60000000, 0 },
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
+	.src_reg	= IMX7D_SRC_SCR,
+	.src_mask	= IMX7D_M4_RST_MASK,
+	.src_start	= IMX7D_M4_START,
+	.src_stop	= IMX7D_M4_STOP,
+	.att		= imx_rproc_att_imx8mq,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8mq),
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx7d = {
 	.src_reg	= IMX7D_SRC_SCR,
 	.src_mask	= IMX7D_M4_RST_MASK,
@@ -583,6 +620,8 @@ static int imx_rproc_remove(struct platform_device *pdev)
 static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx7d-cm4", .data = &imx_rproc_cfg_imx7d },
 	{ .compatible = "fsl,imx6sx-cm4", .data = &imx_rproc_cfg_imx6sx },
+	{ .compatible = "fsl,imx8mq-cm4", .data = &imx_rproc_cfg_imx8mq },
+	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_rproc_of_match);
-- 
2.16.4

