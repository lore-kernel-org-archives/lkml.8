Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA422C43463
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BDF20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PyUlTqns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGXHnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:43:42 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:26244
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728243AbgGXHnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFzRI7KLnNxu3bBPEkLyGrMhCnCqq94h94caPu5V0mzER4Psaovd4EsXQ+eqvFwUXmUU/rFs2p40fBLyZEEEJLub44CE/iTZBebACle9arvBI3VNiHMrWcHcFY0kJuauZSB4+JSV8MoKwS4pcn0JiKk2lawG2gd9A2Kn2la4XtC820i1sAofPuF3X/bk5HYWZyc2ehJUWQ6+zbhrrMjhGLuZNtjYeO40z++u+zrZ2oKC8Bf6ELm2fhzC7oBZ8eZ4RD2ysn2kGlKtrwAM6MfpLALzsMFvTcTx/cQJvIoupj1IjlRWcegXAoPDQoe6oa4khdB9KZ0KLJj3g2LKTJOybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fidPlfCdQaDys0o4S57MP6gfjwdrJb1sVgbFpSf4cc=;
 b=g9Oqh1uIE1ZdOlSIw90TmbkwdQTgrtoWphDVacvG5O0YI6rBWsJ/ArJOx+d894tW+vAhwv/m/MtDurHqvPFqUNuPzG0wf0ZEu6JE8BFWbC1wJiUR5k5rdwGLcEv9MlJ/F6/DQQe3Ay+E6c5i4vXPqgpjz5Pg0sZghU1T2TZ/nkKiogntPvq2vbnhW6jo7YUSEd/EoD9fYunTa0zV0DZLx6RmzWsjKmZjeVQJ6+vGZ4p03drwNK9GqTtITCacmG60G4ZsBz93pD3KzZxJghebw5IPjc/zhuagx3NXEbwYRmALY0xU8oXdFN1TfEBRwwMYxTpUTU16LFk+qY/i2/p9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fidPlfCdQaDys0o4S57MP6gfjwdrJb1sVgbFpSf4cc=;
 b=PyUlTqnsj4Ao4uCz6jJSXi/wRVOg0EmIugfVVh/sQvhm34TPtLKzCncy3jbJpNe0yPRRI28JWfILD807IojfHTEcK2dgwGZbi94djo4jfJkhM6d0fDpUbm8vmzpkC6qK41SwjQbR5DDBpZv5yYArNcovaoznZOKh/g5a4IsQXiA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:43:37 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:43:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 02/10] remoteproc: imx_rproc: correct err message
Date:   Fri, 24 Jul 2020 16:08:05 +0800
Message-Id: <20200724080813.24884-3-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:32 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ed607c8-c160-4f43-018f-08d82fa54623
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68573AB0F2152E08A589F86388770@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWV0SW0044ceK/zO9595IBP72WEyEbhRiifey4p/pCTdJlXZjR0Lpp/Nf0anwKS/nCZCai98gBpWJU2DCBPcD8JcsKHljf0W/m945SPBET4QAS073JI+CUnK4jhkolYP/jw+d/JXzTKMjnCcq7hcK1r8x5Kn7CBbGcfHQ8ESfg0l03IK0FPdL5trU6vt858WsrFKvwcmqpQnecuQ4AD8YkXNNshL8ezeoUEPwZeQ++oBoOyAWLx3q51XD02OIitof1C+I/gjP04vsm7g2lTZdY4gqupF3xngWRMlcNg44CpiQynGXhHu8iIgZiR/J/6nqsInvMtmVq0aYO6NzA6WnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(6512007)(15650500001)(478600001)(8676002)(2616005)(7416002)(316002)(44832011)(956004)(66946007)(66476007)(66556008)(1076003)(5660300002)(4744005)(6506007)(186003)(26005)(8936002)(6666004)(2906002)(6486002)(16526019)(86362001)(4326008)(36756003)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cUNKEbviQdwQ3dml1Zxbf/auaTDX5esR9prWLCvd9tDZLs/AqLalbMienG6eIf1lBHpCq82n2x7HQxIB4F7wWO+n7cAmLAwwNnLef/+DIUsKJ4Tg6cVNDhktgKGiaMhJleCJzkCTgF7gnIOw6rGd3z5H+JWw9KbNeemvGrVEHaBgnQ5I+x0pl/RYhFcZw5+MUkNg1Qeclwsk29RmZ4QxTsPDRyiLyKL/Q5oz32H41T+nmYio7+Kw1OvcuqaTHW4+V8kLvA5PK4lrzPtMfWqxWYQRtdYyJHp5cfUxF4Oh6e3xrd76jSOIJmNDL0my1aZdzW+2iJurTl8EWSLnxIS1q0G0Zno6F3B8Z1YB9bXyMRU3zIOZ1H+w1f8Ug0saoN+l7ZCL4z8wWmo7W8wztfhcSysHv36jnsMw690cjU54FbivoqmQWO45Rj5hBD+27Lamdr1J7YQNOe0rD/qpe94kpNvp4CiXeLb8h/POUo5u/GPOwMR3gbnBe/sHmXD+Go37
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed607c8-c160-4f43-018f-08d82fa54623
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:43:36.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UB6dBx5/oTk6nhJtfNiqnrnyACOOL36WoSCrlGWQxZxKytPpLMqThZnngeppM2OdMJOQ0c76odRWpBvFs3opg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is using devm_ioremap, so not devm_ioremap_resource. Correct
the error message and print out sa/size.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8957ed271d20..3b3904ebac75 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -268,7 +268,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev,
 						     att->sa, att->size);
 		if (!priv->mem[b].cpu_addr) {
-			dev_err(dev, "devm_ioremap_resource failed\n");
+			dev_err(dev, "devm_ioremap sa:0x%x size:0x%x failed\n", att->sa, att->size);
 			return -ENOMEM;
 		}
 		priv->mem[b].sys_addr = att->sa;
-- 
2.16.4

