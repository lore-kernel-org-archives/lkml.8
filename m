Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB667C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C572C208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EIPyLTY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgBJJ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:58:45 -0500
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:3017
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbgBJJ6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:58:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlfpE32ZdAP9XOleWyDw5xDkGzpEXIELGvHblT98w+v/+EAgD8AfWU5o/gDsVOptQ05MbTE19eiy8+Lnn0J1STZBaxhbpT9LLdZZc4tMoc6pPxu9o0KJw5xJz0ZMfKiihxr+4y1fqcT82JOljVPnQ4ua5teDZrRDPwIdB+uXrOp0Olobcz09oriNdrupb31oVwDqT24W6r+xlJTe6rnho5KpGEyD6WQJci+iq3/D84wjsRsyutrQLSq3gp0i+YadplrSTgdarxcFUon59SxDIMIgLMWxtk7ZNQpI6Q+1DE1PT2qyvs3c6rlvrJG3PfsbOYeoCJFy7FPnI7QyCEjWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjDwim/uyhWWlLhuC7Xq+RqeP2hI25frptHsd3WLor4=;
 b=KciP2phuNXo3Uy7WVFz7DYLKZ/dWd/ygqLvZJ5viczUMrK/EYkPxwGcvAKumDb1d2LK1N106SSszYJCPIE+Wrya4oYpSwsTFu3hSto44GTQIQ6yt2jzNIEauJ+UsSWkw/reWT9nkC2dZVMkMOySIkCaGkFU2+NmTKrcalaJix6d3yR9/TpeiJi6TF2j086RIOEVny3J1kSB7qhhFa63MUzA1vPznBKf8D18qMHH/OIums9aRsyR2jkflE1nY31uKv+VZ4r17LI338sQSSakaUg08jjvmK8ho2bl+naKkIY6g33CrCC0nBvhT+ml9ZMMvZUwZnmIwLdYGtczVed+67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjDwim/uyhWWlLhuC7Xq+RqeP2hI25frptHsd3WLor4=;
 b=EIPyLTY3Wk2TXeem1x9yJbtMefY2LLiGFmg+992bqSoVRTVDpNUcUO/DCZDY3qroZpZusVP8VxWU/9rPv4xXduzihoCs5+3C76VpVmLVD4b0qfrJ+S8WkehhzbKjzFwM0TAX1PUsz4Rv0V9TxOTCs1tu9cD6Zx5JnOkBQhv9fOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3599.eurprd04.prod.outlook.com (52.134.1.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Mon, 10 Feb 2020 09:58:37 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 09:58:37 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     festevam@gmail.com, alsa-devel@alsa-project.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND 3/4] ASoC: SOF: Add i.MX8QM device descriptor
Date:   Mon, 10 Feb 2020 11:58:16 +0200
Message-Id: <20200210095817.13226-4-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
References: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0076.eurprd07.prod.outlook.com
 (2603:10a6:207:4::34) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR07CA0076.eurprd07.prod.outlook.com (2603:10a6:207:4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.9 via Frontend Transport; Mon, 10 Feb 2020 09:58:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 858d1dad-4b2f-4b2d-256b-08d7ae0fcc15
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3599:|VI1PR0402MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB35998D79A93B192D337BCE20B8190@VI1PR0402MB3599.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(956004)(2616005)(54906003)(16526019)(44832011)(6506007)(186003)(26005)(6486002)(66556008)(66946007)(66476007)(86362001)(4326008)(2906002)(478600001)(6512007)(81156014)(81166006)(8676002)(8936002)(316002)(1076003)(5660300002)(6666004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3599;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJTEuaLlNIXFVpdzFy42uG1bKW1V+hp0npVwTES44iwByaRLBLFcx/IV2pakM60+Z0xZrSZ7mu6vyoBUt1/lxLAqGduC0xFbqyLNk1PhMEqJd6mlQsuZ6murtXeRLsE62CKxuu8xulGturDwM2luYnWBzuDc4YZUoU9Y0hgD7ivma1fn2T3ILhTN+eYth9YSV8B/2n5j+lO6jh4IGvOSzAgKDxuzLtk9dl95E3S4oF2zmbEER1wzTiQR40snDTaYI9zzl7elUGtYgqI8exfoRQJ3Rstu72tEVYjv8KpUqp0ZOJxmppwLLXYl9/FzY82EhjQRWnUlsLd0rUaiLmbvDS0giLihu7FoqFVVrYNA4esMyovBQReen3DPnF0k4tdvG1m1p/83Y6pqTaW2vy8NN5M8bZMmrr+d+6wuYphOYcx+iAqXpaMKpNLCIcooyBKw
X-MS-Exchange-AntiSpam-MessageData: 4JFqxVsiHu7XqTs3OrXGt82ynmjbLLHGRQDqp3uT9Yd/zaPEzZZM8NfJSF5EFRa5xv05weBasGbQON6lIqMY7jDpUAaUMz9Lm2f/8dODS8E0pvbZpuzxiVCsj5Ree7vzo1EL3A0W/+dTayPyXPZO5w==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858d1dad-4b2f-4b2d-256b-08d7ae0fcc15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 09:58:37.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrmT4UdZ27ZBT8HniUaW3c+Lj8mmlE+TH63fXaj50mtSDg11xcPk97afsHBe9UowW0B03un8roPEbu6ZTdLJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Olaru <paul.olaru@nxp.com>

Add SOF device and DT descriptors for i.MX8QM platform.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-of-dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 2da1bd859d98..16e49f2ee629 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -13,6 +13,7 @@
 #include "ops.h"
 
 extern struct snd_sof_dsp_ops sof_imx8_ops;
+extern struct snd_sof_dsp_ops sof_imx8x_ops;
 
 /* platform specific devices */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
@@ -23,6 +24,14 @@ static struct sof_dev_desc sof_of_imx8qxp_desc = {
 	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
 	.ops = &sof_imx8x_ops,
 };
+
+static struct sof_dev_desc sof_of_imx8qm_desc = {
+	.default_fw_path = "imx/sof",
+	.default_tplg_path = "imx/sof-tplg",
+	.default_fw_filename = "sof-imx8.ri",
+	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
+	.ops = &sof_imx8_ops,
+};
 #endif
 
 static const struct dev_pm_ops sof_of_pm = {
@@ -103,6 +112,7 @@ static int sof_of_remove(struct platform_device *pdev)
 static const struct of_device_id sof_of_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
 	{ .compatible = "fsl,imx8qxp-dsp", .data = &sof_of_imx8qxp_desc},
+	{ .compatible = "fsl,imx8qm-dsp", .data = &sof_of_imx8qm_desc},
 #endif
 	{ }
 };
-- 
2.17.1

