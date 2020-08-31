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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD233C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B333F2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VhIucfpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHaIfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:35:01 -0400
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:52704
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgHaIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK9bxCaY5e8fN3IInaNJRwPlglT5n2grscQ4nAojZ30VOt5oQkWM2RTBHGjpKJUlhkIEJGgXoVZueqLbnc9C+k1NKPzwxYQsycZSeCN7d27fzRH7B2pQSSnSt+D7xDDseNLdXVycQBgPSv15+lloSrw3h6ng5kOWBmfKIK0fKA5LkPxna/ohJp4xyE82fJchu1NcP9R6Uji3wz2D6SjXN4119DWBYaYUetrNJmrcP7aMullP1ht7PwGrKL3dRkvHAsFTemrTRwDpa9PybEoiP9iyHmTHu+CHfMgzHchPwCPxR5W6LuxkvR/7Ca0qTkCpQefJ856PakqwTmIYcJiO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NWR7mLAxfQMrXg9i1cspYVYSmEWRc1ljJvmjr3Gk+I=;
 b=MNRzEAvSGqEBMnNf+MoPrCuHcYR4+mry5CVPU2jQwfpFUaAhqdGlxjJ2JH3kT5uhKVvL5ovd1H3Xee3F/k9B04BhgalZ12sIAsmBBxL3JmfAbbj3pMWQjGqQ5p1i71ao/GvhS7lPS6jCaUG8b1xWix2JElbsvMQ/MmTQ+guVyPvJJHFeCUi+rFZjvcU3YAcBTE9jRv4OwzyadHzwUUchdUlwq34250mAGpr0Plv2K0D9utDZQ5c37F+JinHhSlhoKFH2zyCxjdtrgaC1as6DyEZ76REYpp3/H2gTuHNyxu602FfuVOB6JK7A7HbXGovi7slNjagvVYsqE5fiCAJcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NWR7mLAxfQMrXg9i1cspYVYSmEWRc1ljJvmjr3Gk+I=;
 b=VhIucfpVKyU2uqeoc7qaXGOBItfjeiDRb8uwa36dsG2hip6YXc+2+hCx/DmeG6T7ntrZt648ZBU88v3l9UX00RWXTGaWxd05wp8xQwXO5yxBmv44AkBaShUCSP5yE4iPJe4PShLeQWAZpKkdllcFgUeHo7Yg2ZvtyOyUL7S0qLM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3549.eurprd04.prod.outlook.com (2603:10a6:803:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Mon, 31 Aug
 2020 08:34:51 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 08:34:51 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        Anson.Huang@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: pca9450: add enable_val for all bucks
Date:   Tue,  1 Sep 2020 00:48:34 +0800
Message-Id: <1598892515-30950-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 08:34:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb8e329d-ad5b-4509-9e06-08d84d88ba97
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB35494BF167AF35E100EBE86E89510@VI1PR0402MB3549.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNfVovH+xwSeduVMONG+Ahw+RGEkbgw+I7xCioif2OcRetLoxbaRJE/F7VpYkz0XbNUOGAe++CH0zQRdPDgkPpFUgsIYa2j4Dr0lbBVPjvNVM2TIh3jSZqP4eJRKHwCFm3UJNaZpCeEMnl4hw0tHhCJoCIfyi/0bbWWgABTuE3YpRHS1AeItcE8KtOwwAn7FSw4RY62CJvRR8U93S+nWZt2ktWVfMQE40ZpYHGVRiFGMajzdQZkrwuGFyl7Ux3oNFoaY5P4PgBuFieXU6WjkwqvJflmEam9X4c6WGc7SGJKGPJoX8YzBUhuAcQtwGXDOpZ27turIjrI/caDe9+FfHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(4326008)(186003)(52116002)(8676002)(26005)(8936002)(86362001)(66556008)(36756003)(66476007)(5660300002)(956004)(6506007)(6486002)(2616005)(66946007)(316002)(6512007)(16526019)(7416002)(2906002)(6636002)(6666004)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Lr/afptECpY68AVxMse4bz6zChbsY3WYH7FHMfvWYnFi9GHtLsHziM5nxfr7qqah4rADHjxXQ9Qp3oJb2R38Yx+VXrkvzTaxeCQHmJpgF/kBhn4N/olacFGXnM0bI0iIYSvBsEUM7dMM08S6aRv1L1I80Y+9vLanHjReh8OK+2zfPJjeWKj9ajBt4NxXUWUh3msMg7UVgpFKdAFv6quh/7grXofqspIiXW9FuUzlJTRYfm7BEtaNbiwxpFDZsf7XR4FgPmimW8xp8x8YUm+ivH/34Y0JetkFG64SarekOVZgBRSnBoJRW68NGfSo0fv6kmEHmWsk40nNastDsVdHZ+5w3auWmrTWCmOB7K/9AkaZXThEmFoy9fcxuk0gWmC+wFmftB6kdeITphvFz+X4PCLxdSn8ONYhMqFxDQtV8Zq2PvuC/S+wckLfxrWx5zTClwFvyJw1WT8G4xIFog83jFc6RVexz1WRSmL9cZ4NS16Bk9Ehlhz1Bo3mB++xzyNCa07jlIcb10QkLP7Rm2jd8pAnCigyUcp6zj+xLkhu0jnqmRXttLuEaRbFwWwXXY7caCbGdmSzN6DBJcIHNZv0ckstMRxQq41CXj4UEKHhB1DTw7iyLDxiA9T8kKWsTxAKmLRd3uDSS/Z3j8NIGAq8lw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8e329d-ad5b-4509-9e06-08d84d88ba97
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 08:34:51.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wc5+H044LMhBkBaFSo6CQ/HJhfKP5BGVYAX3Bl4a+bZfdX2EQr+gFg+znzPwYqk09LQF6sXoqyHykHGSXNJ2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BuckX enable mode
00b = OFF
01b = ON by PMIC_ON_REQ = H
10b = ON by PMIC_ON_REQ = H && PMIC_STBY_REQ = L
11b = Always ON

For such enable mode, enable_value should be clearly set in requlator desc,
00/11 is not enough, correct it now for different bucks. For example, buck2
is designed for vddarm which could be off in 'PMIC_STBY_REQ = H' after kernel
enter suspend, so should be set '10b' as ON, while others is '01b' as ON.
All are the same as the default setting which means bucks no need to be
enabled again during kernel boot even if they have been enabled already after
pmic on.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/regulator/pca9450-regulator.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index eb5822b..79f2a5a 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -249,6 +249,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -273,7 +274,8 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -299,6 +301,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK3OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK3CTRL,
 			.enable_mask = BUCK3_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -324,6 +327,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK4OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK4CTRL,
 			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -342,6 +346,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK5OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK5CTRL,
 			.enable_mask = BUCK5_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -360,6 +365,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK6OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK6CTRL,
 			.enable_mask = BUCK6_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -475,6 +481,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -499,7 +506,8 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -525,6 +533,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK4OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK4CTRL,
 			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -543,6 +552,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK5OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK5CTRL,
 			.enable_mask = BUCK5_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -561,6 +571,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK6OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK6CTRL,
 			.enable_mask = BUCK6_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
-- 
2.7.4

