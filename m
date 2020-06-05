Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D857C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFEA207F7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8I/NGDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFECKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 22:10:39 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:6191
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgFECKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE4sO/mYPu6mQN1cuW/3PAo6mxwva1ju/x4g/mVOtICfWrZNEtbEQ9cP0MpzD1y4F4hMDhLxkhnLllw0SdTy3tK8yMTC48W7LFv0U+HY7mvu0mo5tH+7Gy5TyfJFR9yClCqMBqrixqO+xPHcerpllrDcbLCtRlEviBfEWTudkOxuJx5ZrGXLExnONmOWMkJvHv1G+hWTk96NbTnMMTeoOP1Cf1mKbf732byj5z1TR0JTvJpuklZMqSDXKmOpgh/whwWGxqZjWBO6j90IIKtys17YZLTGfRHY3ch/uFAGM75Jj59bf+XNojZrcp/LZKo2Y/N25mYU3bd/6JvGqdb1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8k7NXNuGefdlSKiqskM6lVCF/mKipaKJjqtQnfYlFU=;
 b=gjUQYF4WtUklqlTFYSCvdq9Uvf1TZCjoXGAfcmgZeQJzsVgUS8kXiQhjdWqUH0ApOj9Hml2r2P8AwEzFRc6WNUPJxiGl49fkQikvtHgm3becvzDr7Q3JASE7zKJ51F9T1FBPPhuFFKIP/PBk0gRgutrEqSyVwGVGFIPzm2Ae+hlXSA1S7bUC2AqmRqPeSKjXXLsrEQRQTlsleSLatAGHT5cRltYVHaJD/PQaLs+JN/vnGRmJCVbQsAZVd1DfWXtL3wiGZ4798vrSEpJHpXM/rQpl0AntoYXp3SXQjnMpSkg+rCE5R8DK3nyWHN+07fxsm8fqNeP/uhkKsKBLhzss2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8k7NXNuGefdlSKiqskM6lVCF/mKipaKJjqtQnfYlFU=;
 b=k8I/NGDhu78xDUmyDc+VDZvr15mFiwe/+KQPNalJvyxCiFciozgHrG8eE8UBmh2/rDd2K42ROdHCOxkTQ+nPv8VnLrKINPx6byWXC2QLsNVmqx1aPSqzHRElBAeQEBkUr9E5B10zd2zjdu57pNSaAiEHObjUfq1gf6JDIjNcbxo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2696.eurprd04.prod.outlook.com (2603:10a6:4:a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 02:10:34 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 02:10:34 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        franck.lenormand@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/3] firmware: imx: scu-pd: fix cm40 power domain
Date:   Fri,  5 Jun 2020 09:59:30 +0800
Message-Id: <1591322372-3793-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
References: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 02:10:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a282068-1813-4f24-0e72-08d808f5a180
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB269619A7933CCDF71FFEFC3388860@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FRgfYgxBh86zpRKoA0l2A/5OzS/UyU9zo9tcbPKmqywEHzGJ50ZCWjQaA3Wyy7Pf2uLkHmgRHPXz65tySQ0cEvocp9T1ZkFSe6zwjGSxMz4bvGI1T91CAtvsnbaZaBIg7sjGaSRu7E3b6CeLMBcpq7QB/NyJd1xeu9cDpMaxoUx0CfF74mrS4nasVphaPSEJ3bawi27cpKhU/jlQuZZGannggY6lQybA1NIC5PxM3DDIXOYPVU+BAuzpygN0bVHfV3WgdOYbeRAsCySqwO6TAZRrez5+D9QMn2Vkq6fIA/Q0lLKrxnaJfkNnqlWgCPTQAoWURlNXuouPREU7oE6gkx2TMj32FOL7aTseM1U6FFpah51KHFdOtIYmQYn/g+S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(83380400001)(6506007)(52116002)(478600001)(66556008)(66946007)(8676002)(9686003)(66476007)(6512007)(8936002)(2906002)(186003)(36756003)(2616005)(6486002)(956004)(4326008)(69590400007)(16526019)(6666004)(26005)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tsus6vvc03SksAP/GrjwZ1GFwVc1smztOG3j5Ued8uz8c7YWCLrCiC+18reJcPn8YgNwK/z7Hxl0v/3n0hzzR0MVblZ7fqc4/JwTBQiO8YRa6ug1NKyOWyvYhPf5AQjX9lruqJ9wH1EuzNcKPXi1CNdw+HiGRcj7hLCNmfnJYlnJiK6/VnbJPQ1aVP7v5ipP24HB91C7bhIAcipBdoWNIddo0PA9YSKTrxbrpnaopmPyo5h4l30Wnv7nrd2MLet0sUs0l2ic62DNMtoBUiZPdcuDJ91BnFK7P5IMH4QFzztjNvyakn1/deZhaErNXZZyb9nFsVT6hVWz00863HpoIoaU0ASZzK7ylnSYqsAwBBnByBDd6F9cqDHFwB2+prfC44lBvMcIMbv+NlKOrhR5TwinrfUIxsEdbSrKi4xMHMDXHIJA9mp9TDXX4NrshWYhJiWlhKZB1Z1J9td2ZvN8j3wXqme9S2mngsyEb5blRK0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a282068-1813-4f24-0e72-08d808f5a180
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 02:10:34.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61168j//I8Z8yhv58IdebimRvYpji6IcplBc48q2v6KeZleQHRlsWwdv+OqLk8dVx/Q5VIyMoG9Z0N/LcZ5biA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The postfix needs to be false. Alought compiler use 0 for postfix now,
and take start_from as 0, it is better we add explicit false to postfix.

Fixes: 705dcca91d0a("firmware: imx: scu-pd: add power domain for I2C and INTMUX in CM40 SS")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index fb5523aa16ee..d1b313fa7b96 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -167,8 +167,8 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 
 	/* CM40 SS */
-	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, 0 },
-	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, 0 },
+	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
+	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.16.4

