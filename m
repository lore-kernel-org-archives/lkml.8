Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9027C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3C2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gRI8WZYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgBSHeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:20 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:44608
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbgBSHeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvNEwTMvJm4U90mrB1CdBSAUxwOAIbmBUbSKofVMCMOdlqGsmpIXT4Pu6YLEgDvJNm+y7l04f7ObS8Puyl/6/36sQzNUYSWLRGewYBz/fcMuH81UXzuXMGzp0M6cqesQDNFXCNDzJwO3V5Dr3+VEPK0f313PDyseUwxuv/kAuVhdl6xE0EnPsXp0Fpjw3SUjDM4gLzbUK/uGT8Ut6J5S8oficZOkoFE5yWoMlugUOPg2rdsc3k+6zEKq9ojPJU4DOBcHuY2hZFOjnPmJbPZakEg7a6StnZa2XsK+8UeVm0mqpvZ77PROKNchqvYKonEt/hji82Ij7Ob91NpmMSPgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Vj60ZeOZ55CHjRFkSChc9Jzl90zgEyrE1PbkO2VyU=;
 b=dKUSwffUM04Gh5cU/JJGjVDw0jhCHZP/LxKZoKoyqQK7vng0qZ/x/65hVOVw3i10J1J11heo8C3UBVvpygnmfsbPbNzIU5Q8DiJdG2ztDQgRv1Se30YbAS/N3ybEFMHtZOLeU1rk1V7cT74LnY8bQ8kxSnE1Xqum3IqRXFClAsXfn+I1VvVcIAs93Uvlz5OzspoH8XRHNQSCp3NUj1VGsBAWkK+E3wN2rz+iqHckwejSnoI3ukOwEB9Em5nFucOgnvnsZpwrA5UFLiC0mNymKQ7CZAwU6hTzysYK/A7Ruz/mdJZpVMIXaVDeuJSbAU6l5hC3MI+7vBb8QKXk5T38fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Vj60ZeOZ55CHjRFkSChc9Jzl90zgEyrE1PbkO2VyU=;
 b=gRI8WZYQiJQqIboFbvZ/d5E9LHCNZ4QCeSzohmJLX4/FdjoSNO3hSwTlAjHRp1Wuq9V8SorA9ZoUuV5r0cJIDtx8avqQhU0KuSSs328LC/e/hgNLUV9Ci5MvhW8JLMaQLeDY6OcNClM3LeweJ0IJTsq9VpWLzWvBzK8lDhv/IsA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5233.eurprd04.prod.outlook.com (20.177.40.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 07:34:15 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:34:15 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 9/9] remoteproc: imx_rproc: add i.MX8MM support
Date:   Wed, 19 Feb 2020 15:27:45 +0800
Message-Id: <1582097265-20170-10-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 07:34:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eedee99b-8336-470f-e5f2-08d7b50e1f05
X-MS-TrafficTypeDiagnostic: AM0PR04MB5233:|AM0PR04MB5233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB52330E3B6D50B87FD60C5B4F88100@AM0PR04MB5233.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(81166006)(52116002)(8676002)(2906002)(81156014)(5660300002)(8936002)(9686003)(6506007)(956004)(2616005)(6512007)(6666004)(66476007)(36756003)(4326008)(66946007)(316002)(66556008)(7416002)(69590400006)(6486002)(16526019)(478600001)(86362001)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5233;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcdwqMAn7Sf5Op5bvSShrIPJWsv8jcvqj9mi9lxfTuo+KMOEcM7S2bSEF7eY0YT2vwDQ/bQr2bDsmlRQQEXclS7CZwCKMb+A8cLM6j60Q3ZjNT7pAlVo8jo4aZpXQcvh3IQSp17NQVU+z+Zr3L9W2KfcNrIfX+cVDSueyhVUeSGwCtDWF8Sgw6roQG0Oi5Ptdx/aQzoYKIkvtn1JpYSBKLtyP4Yw6xMPjyBuJKM48MlXO1fg0yRXa0p4PRFAlJKXt91UsDnvQylSDOzkfEOm19m2jBSS2n7qVh1fvHuBNkF7jghaZsBzuRIhvosmpSrWTwtV/mFaPZr3vkw2B5/RAzksXw7kyqol5JBJFmcztu2cEEe0ZpYiL9Xg160boAU2yDju/l4YCbAOEcG9CilI8JAFT3gaM845YHovpEM/NXm4u50Bw3v5iCLwcpGLDL5WlBBt/0ue5nJ4uhDfYLSq997bR97wJWRAPNp1reklziUxxpZ5b+uAkCLfz7hXMPmnhPwsui9x/Md1vBXMyGUp2wkQ/STVXtD2PW8AA2mqACE=
X-MS-Exchange-AntiSpam-MessageData: qYbLIitO3bA0CISw2xONSf/ryeh/I1iXqXpnxhEeuKCFY7kxG4+zJXrCQPX9ewX7pjTX3Rg+wuhO+BIs5JilvHVnOl5AONSUvdWJVeThBG/YyXPEIwtaEOyg32wvC67WXU7SiIZqDGDdcY4Jd3xQuw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedee99b-8336-470f-e5f2-08d7b50e1f05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:34:15.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cO8jX4zz92Kdjpo5X11MTNPu3rd5vVEhZL6Ga5su53jkMMT9qinRz0nH1JU5qfRalVDmVDpVk3aO5yt+XcydCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MM support. Remote processor is under control of Cortex-A
processor. Currently only early boot is supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index fc2a504bc350..d00c3cbcd87c 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -56,6 +56,7 @@
 enum imx_rproc_variants {
 	IMX8QM,
 	IMX8QXP,
+	IMX8MM,
 	IMX7ULP,
 	IMX7D,
 	IMX6SX,
@@ -194,6 +195,10 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm = {
 	.variant	= IMX8QM,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mm = {
+	.variant	= IMX8MM,
+};
+
 static int imx_rproc_start(struct rproc *rproc)
 {
 	struct imx_rproc *priv = rproc->priv;
@@ -788,6 +793,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx6sx-cm4", .data = &imx_rproc_cfg_imx6sx },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
 	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
+	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mm },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_rproc_of_match);
-- 
2.16.4

