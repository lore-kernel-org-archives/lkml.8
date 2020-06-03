Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8265BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625802077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PalB7dLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgFCDnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:43:12 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:43822
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbgFCDnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlNIjUYOJlxrC2unumwcLF6S64uhIVBRkEwv0s8GQZi57R8qbbVbLWFs+msrZU5T0tql7sTMsxwz7v6syCRUYqc1JRN3Kd4ZGUQMAei4fblh8OYFWYYs8LAFFmEIL3eauqN1JiLGHfsHQe6ZvNUZYopHALputhlJZesr0pImH+gc0Ex/bivWHFWXxfWn5xNPby08GgGrzEkIkWFNqBb6hwng9134YpGgQYEErJMmWF+wwn+5Q09yOLAYhq3R1GlWKkKqA0VKVLDr9AWDOVePnJRp7X2zKZtdmKrCKRIu7IIs3ShJhIBjdqhpDRt6pENHWJgxlCy6W/KA2wCt7hV48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTNMJKnmzYPf2aJxxbbqOyDbOxZ83LKwA9t9cMSoDrc=;
 b=ihWGcpGnqfLi3g8EnX/aVY5M9UUsqCFUv1eNTdgAz/37CuEhCppdwqNOEb5J9YGIOvFG9M+CAU8BzflZKuUisZKbVjDKXhABc1Veh4lWBVmzSwu3tS9LgN243ubRepTSBR+4xcBksq3y3yRzaqLe87K8N5iM0hrK5aBaTpHWQ6TYez0M1k19/oSj6coZRvWJmlbc30sD3SYrLy5ZX/boeTkgnmcPvEwNOqWp9j9AYmnLmpwoo5r0oUQJayOVZ8OqC+VBwL6QsFmwiBc5Gmow1EQYVM24Ti1w4eyuECmGa/er8N1xeM7hveQNwi0waVkvWeRkFv012doCtS/zS7zRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTNMJKnmzYPf2aJxxbbqOyDbOxZ83LKwA9t9cMSoDrc=;
 b=PalB7dLgHHUS0gDQDqtHZ+TP0vxIwja5ZBuo6UfpFpYGXDzVwHm3SwrYrO4/yj49NhQa27EAjkyxrIo08ZpEV4k0StWsPCYHyA1S+hv2sW+7JZqxWc8TuM4VdrnxvODgWP7vDZ+Pa0LqjprRbijOBe3GeeqrC4QESdB9VWt1Pg8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2854.eurprd04.prod.outlook.com (2603:10a6:4:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 03:43:06 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 03:43:06 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] firmware: imx: scu-pd: add more cm4 resources
Date:   Wed,  3 Jun 2020 11:32:23 +0800
Message-Id: <1591155143-25972-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
References: <1591155143-25972-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 03:43:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 179f7631-e8a4-4e07-1748-08d8077039bb
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2854D6B4F6C7D20A2B7F2D5388880@DB6PR0402MB2854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2rTxUQu1ABJa9DW8s8Wp5d/nMbeDB4+cH9AkJkfNQI1TV2QT6H4LxpUt/s8SdFCVQw558RgoBipsh8nNG0EqBzYoAks274R97A1kNAyiajCJIjYgAZK6xsBUbQuSP3lCcDIcNaZz8T0BWgSdyAnycBSqhFvqKGVeZ7xbu7DJwL9cL4GLkrYgcWh2fNWx0dfFyFmOzQSRJUlNDxBsU7z2iamv4CDeMGDSDExLhm+mViA6N4iuMrVs1POSvmzdq9/h2fpfy4J4Kv42+tEy70cP4EWO63aw7wwDVrPLd1VZpwOaNrz/zGmiZ09A8WdrHbHehYJe1QMhOgY05sSYTlt4suEarmcmoe4A61SiZ6LUXXHSdRGQ9+xIwvtYqItFiZ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(6506007)(478600001)(186003)(6486002)(36756003)(5660300002)(26005)(66476007)(66946007)(66556008)(83380400001)(2616005)(52116002)(8936002)(16526019)(9686003)(316002)(2906002)(956004)(6512007)(69590400007)(4326008)(8676002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WIQ9zoCDhMHz+qbwvHMf9pShut6nJebQa4s7m7TFFB2a6QVbUp5DCJ2oAOqTKzxCLIW4kuRRYJhHGiOhdIlb5JI3A3oI7wvagS0zVC1oMA+CG/gWrq8n/Cny+AHR/65H/uIsDKWDTIoDFV3pGmwwDAHwK1qxF+4/0Vw/KNrleNPtLc/G7GQcodebN0KzsGIPeTpYqbolh/C0oM2XQ5W78pLzTkMMkBxVxR7dB26/otVmKb9aXQkj6ir9zshOP2lEvUy3+FjilyHkupWxlqQnf0q7U4/oxWtrjY3uXFqJ9I1uJBYlCKcrl3zuw7ZkVirGJutHIBcIej/KmByGT7f9CNJrH1FdCh1lZdSpIdVIOxQRY8hRwu5taak/fY3cFTXJ/KNSofkpzUXPL3TlNazbPsDHrZ2TtEsEMkLkJ7s3Mt83rHNqBr4q+dG0PC/z1V4JQELJlD4WTLtesHZqHZn9uvh7oxLL8WqUMHE3tH8xdEDnDhAt3f1sUzJS6mI33PCj
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179f7631-e8a4-4e07-1748-08d8077039bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 03:43:06.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jKuZ940WDB7GGuo+utZ/QOv/2vq3AKBiSWW1c4EKbMTK2VPcPaiFSOmn5VQ1sH5N0vR1VzYSVvlq1EzaHKV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add more cm4 resources, then linux could use cm4's i2c/lpuart and
could kick cm4 core.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index d1b313fa7b96..af3d6d9ead28 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -167,8 +167,18 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 
 	/* CM40 SS */
-	{ "cm40_i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
-	{ "cm40_intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
+	{ "cm40-i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
+	{ "cm40-intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
+	{ "cm40-pid", IMX_SC_R_M4_0_PID0, 5, true, 0},
+	{ "cm40-mu-a1", IMX_SC_R_M4_0_MU_1A, 1, false, 0},
+	{ "cm40-lpuart", IMX_SC_R_M4_0_UART, 1, false, 0},
+
+	/* CM41 SS */
+	{ "cm41-i2c", IMX_SC_R_M4_1_I2C, 1, false, 0 },
+	{ "cm41-intmux", IMX_SC_R_M4_1_INTMUX, 1, false, 0 },
+	{ "cm41-pid", IMX_SC_R_M4_1_PID0, 5, true, 0},
+	{ "cm41-mu-a1", IMX_SC_R_M4_1_MU_1A, 1, false, 0},
+	{ "cm41-lpuart", IMX_SC_R_M4_1_UART, 1, false, 0},
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.16.4

