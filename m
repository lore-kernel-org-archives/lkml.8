Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFDC3404F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DC421D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cpUsehBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:03 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:19013
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgBSHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt5qiLl2Bp9upIQy3B3Kiostporw7/xzzCko72qVPGj0nekSC5kCihf8JaulukSL3Tch3IMQ44ABc+t7NtI4d/8sW9LIIjPM7VIxHOfxKSAZ9sAmyS3ntrFd+gqU5GMm5FWegE9g3VltyRlDhPl9LyYY2cSlkYBHCAZ/WhhsnX2Hv5RjebW3KAbdm1yF2urMz4WuxAm1imyfcu4Cecx2rEpim+O1f6H+6NAjKqRq2tzhTkpvMxM3mgs3Yl8Gbf0SWln+GpPEbPLo1ceuWuhR+EfuYYxOOu9Obp7G4Xe9GVMauJ7aqDQCUtbkm8Thcx47KujAMAmiJnt07VdBzdHicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5jq8+36WVgT+n17P/obSsXiSnkHmjmfHVw/sIPza8E=;
 b=bSgavM5l7iPUNIZz68UtNlz4jCurkx5eDIkVAH8n1l7eRZgjYqv3d32GEkyDAOqbbKlVLccZGC6LhmKFZJ7Uh9n+N95N3Opc2kmxp1aitZp5Yf9PZPUec9rwP9vQEteR7uKVIwSz+hPdkj2IOC0LUhGIf1zC6dVVqoM0K1CpFb54jz3MJRoIeM9ifwBKig+6Ps2Tp17GGz9bxZilkzKCcrfLNleDfI1pjg/7OGvNAcBzjTnPtru4BZbKi4v+oxi9Xi/05Zgow4i9klzo2q57eu8PP92Qjif4AO50FpC2edS+uOlN3K92M8flJ1+1xfc2kfvusszDJO2F/mTjGyuhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5jq8+36WVgT+n17P/obSsXiSnkHmjmfHVw/sIPza8E=;
 b=cpUsehBiyuioQyr36nGf4sOPMR6D+2pElStjihhqsWhZPXXZfkiEReG1b+HaWeWL/nw4S/dkBOZfEmEfSb62xXPfzfLUQnu2UQca3/edJphcNZ32Q341VgPqAtoKDmeBXU81bEBIW+DAqEZIxpLxJB7hdNiFBpKTqNC/uAEwIjA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3969.eurprd04.prod.outlook.com (52.134.95.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 07:33:58 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:33:58 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/9] remoteproc: imx_rproc: parse early-booted property
Date:   Wed, 19 Feb 2020 15:27:41 +0800
Message-Id: <1582097265-20170-6-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 07:33:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bdb16f8-3dba-413c-37af-08d7b50e1536
X-MS-TrafficTypeDiagnostic: AM0PR04MB3969:|AM0PR04MB3969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB39695651AA79F5CF0D33FB3F88100@AM0PR04MB3969.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(66556008)(66476007)(8676002)(478600001)(186003)(52116002)(956004)(81166006)(81156014)(7416002)(5660300002)(4326008)(2616005)(66946007)(8936002)(16526019)(316002)(69590400006)(9686003)(6666004)(36756003)(2906002)(86362001)(6506007)(6512007)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3969;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qhjnVEagW8b0q97ZxY7hSByPV6twZvpNxcgLZ8TfIgLOFcM5c2UB5aoYALicFgTfcRggmvxQfnhXxmrc8/RPB3JW3Cuzv9y0JuyeDXyLhivcFgjUplBX6vfzynfyFwc75/KTGTyGhacir5e0iuToQVrlmLie2JKgyxD9Db1yvARgIlJIy2w2U34kfssWA6HmGn9k/276b+MhxpIG8qxyqyYBZYmOQNkQhBx/pYnDYbxNpVDLTTtKnuo9CRX5N6IZk+iw/Mn5hz2whVVhGX/0d1WHFx+4HWDJExKnqPXAKXBuwVJmIAMyfa59Rq37a5sIB9eWgWwiO73sFp3VsIIH/50gWK0EN2Wm/DSN1w5g7O+B9aJdgzKnoCvrbfkTqdkwYSazxogcX2oVU0pT1SwqcseVsoaQ2uF3+p0q6LH3YhvRy8VQKGTtcaGVd3W3HgemZzXYsxlCw+TwhED+ns45fXIdI/T1YAm9/Cr+CiOpSQwGV4TAydjJA72jebUZ5YznoJZUzOk9klCZc/PXptQiyFBY9EdoLblZsT68cNz8CA=
X-MS-Exchange-AntiSpam-MessageData: 1jVSRoABYLryi+FMw4FW9djwboMPNAduuHVAV71b7CzjK6VKLy5JY3ZJwMKvLdmcs9UXaA9Xnge1earNjIkSD3G+RTqVPGRhlFPmn+A9rmzRbzqldhLf/MEPmsymf9+DP7HwJhcMfKmLPjTbCKLi4Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb16f8-3dba-413c-37af-08d7b50e1536
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:33:58.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx9Vu+CW8BuLnv6QtzRH79MpfQnaaj4aREVbRz6emNCHVu20PQni2ZLtVt/G3nni52FcF2ieTUHqsyaINKRiwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If early-property exists, there is no need to check syscon.
Just mark early_boot as true.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index b9fabe269fd2..e31ea1090cf3 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -483,7 +483,9 @@ static int imx_rproc_configure_mode(struct imx_rproc *priv)
 	int ret;
 	u32 val;
 
-	if (of_get_property(dev->of_node, "early-booted", NULL)) {
+	if (dcfg->variants == IMX7ULP) {
+		priv->early_boot = true;
+	} else if (of_get_property(dev->of_node, "early-booted", NULL)) {
 		priv->early_boot = true;
 	} else {
 		ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
@@ -509,15 +511,17 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	struct rproc *rproc;
 	struct regmap_config config = { .name = "imx-rproc" };
 	const struct imx_rproc_dcfg *dcfg;
-	struct regmap *regmap;
+	struct regmap *regmap = NULL;
 	int ret;
 
-	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "failed to find syscon\n");
-		return PTR_ERR(regmap);
+	if (!of_get_property(np, "early-booted", NULL)) {
+		regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "failed to find syscon\n");
+			return PTR_ERR(regmap);
+		}
+		regmap_attach_dev(dev, regmap, &config);
 	}
-	regmap_attach_dev(dev, regmap, &config);
 
 	/* set some other name then imx */
 	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
-- 
2.16.4

