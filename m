Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4409C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF7421D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WnWhLyt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgIKDiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:38:00 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:36230
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbgIKDhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:37:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ5VImkAKHZuOsfk16BzAUZSckUgDbkYa6jvbLvlRTskduqUfWosAy6m8VXUzIOr+wbhOvlirQt+G2D2RwI+iw68ydvxjBWRCu/uAJN0di0NxRdfaUhhSdtD+FVqWcbwQ0gbxNCxkX6EFn4TqQhE/yLzTK9E2l+ygh9SxqT577AM3BhcZUUOK5CF9asaVOG4eGboONthm7id6Ccqkqft570eslmFnCQhPUT8V6ZJykz3MAr3nHFY96a01Gti4pGiOsTetrfzdBNoI6a505wLRfhZnJ9knb0aysxXdXgnU58w2qHLc17Q3wqgVE0V7lYs36o45lZZdpqKBiQu6RiQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBNcstHMiDqXuZzcArjalQZUn400JPEjDaJlZLPGb4w=;
 b=hXM5J160Z30+iLCMpq8dj1yPqhgMetGHB/P1rONMw5DphTX/DaPtZ/51ni59NcbHeOYgAeDOyEuSfN5uG6SoJoBADebmnn2wBbQOhWWV4163GaPCsU0KYHHbxNj5AkcAMYiWWutNMYXYmxT0IAyWYSkmtyq3beJh1sBzk48vof0eXdyXW6pVZsGarruR6vhvlnkKJkEeEjt4Ejqwl5leBj7ShiEBgq9dsSUgKaJBDwpjjPXNkAiA92uToRcdP8zgyvBa31rg/G00FerzW5hLobZa0to+PWkSf4G4ahn7+qeDn6bL8VMt5m/iE0Pl3c79c64Zy7wd53IgTT5jJII83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBNcstHMiDqXuZzcArjalQZUn400JPEjDaJlZLPGb4w=;
 b=WnWhLyt5cESneDJFLJE4LY8WLE9M3s9SZJiE3bhiEKt4EakqFLzeaXl9mLNNE/aGJ/hpDJ4FE9KWwmYBQ68nhgwmxd4KCDWTrF5+T2OklyaHzLeL09HeAIKQUuuQdZ8Y6KUdtuh0MjKd1qfXH+2pnLHWwzyy2ZXCguKCcmifeOc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 03:37:37 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Fri, 11 Sep
 2020 03:37:37 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] ARM: dts: imx7ulp: add pmc node
Date:   Fri, 11 Sep 2020 11:30:51 +0800
Message-Id: <1599795053-5091-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:4:54::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 03:37:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2f46cf1-e5d3-491e-c3f4-08d8560406e8
X-MS-TrafficTypeDiagnostic: DB7PR04MB5084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5084F63F905AA30CC99B0CCE88240@DB7PR04MB5084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1A+w9zlkThpwXc1/3yVtcZo8wUANsYXeeIodoX7Sg7XhDT8Rlr0KZhjnE3OJJbjBaISOMWfi427SrB2KTOc4epoBN/CntrfAT02wIMQUkhrSH1O3qVOP36twA30VAfYq6XYo7xwFkjspSFZ6fLOuQhY/D97d/tFjj+l0VxoILOpcpxYU8QnC5ViOscCnqxoWjgXp85550Eqe+lV9VjxmGO/b2tv3Ki2g/q4GDZO/ld9Malu1IqInl9oqiEgtDSM80nvUjBEnLWDusQsfeSnbxIVJGntyNnikgFoQlYsrrKdZ49Ay72aEb3ZySrHmT/v+qHPTNVoquVCd//547f+hFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(2906002)(8936002)(5660300002)(4744005)(4326008)(66946007)(6486002)(316002)(16576012)(478600001)(66556008)(66476007)(86362001)(36756003)(83380400001)(956004)(2616005)(26005)(16526019)(186003)(8676002)(6666004)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4j6y9inY9bP+Q5OMRceKx4x9vJWG4G3l6SE/ksvpDtSJWabnXqWSJEWWTx5x5UN4y4ji3u/VcVfrq6CC8ry6McJn9kY8Saoctep9m6jfYCy61oUDHZArnAVviBhbbKLbX8NtI9p5ben86FS0XxA72En/wRl9tpO4nWRCClZTf+i9YvmwKaPmSiY5544l86FrRq9PxMaoVENHHr1ePjqSXjW4hh5NnH8OLEb1ULoboshoq0+bB4VMqlNJFOWDMFuHB2dGy9BaZo9YKJ/ubUkm0CHpmlxQEwM2ufchbkxXrJwnB2X4+NY3nb9UjXBW9GE8E7lVvs2sqARXehB1ebrkD1Em54LEky10HJtGsKQveU7iF5N9o9mWR7YMqr7xwzuMV/l75plcbTkmBR9fNmPamKhooATsCGv+ccUhbvX6/y+xizVDGm+Nk/quTKcIA8EW4umshS/2Scy1wWujwRnEM4S64C8Iv4ZWqA6pNHEuewsFA+QeRKJtd5mRGTG0dIHhAYZKWpCnECPTNVm4+2gzZjgL5Abd32YXmtXWWXx/aa0BE3+sE7UXcKotDuXaMrasCHECzX5ZzBsWjjnBuqK49nKgKce7uHOPCcFnrPvayVYC7EGMSuwLxk6STkX6vmnBJdlNLK/Mp5uQnzfGTJA6kg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f46cf1-e5d3-491e-c3f4-08d8560406e8
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 03:37:37.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PmzPQJTsUr6/Rjr/TlQ9x4dydU+LgGS9hxDGqGVewGmeRaF8H8CC80/vflYCuf0ShdJGXsRlwQ8oICaDDM47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP pmc node for m4 and a7.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index b7ea37ad4e55..d5d67e3db123 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -286,6 +286,11 @@ pcc2: clock-controller@403f0000 {
 			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
 		};
 
+		pmc1: pmc-a7@40400000 {
+			compatible = "fsl,imx7ulp-pmc-a7";
+			reg = <0x40400000 0x1000>;
+		};
+
 		smc1: clock-controller@40410000 {
 			compatible = "fsl,imx7ulp-smc1";
 			reg = <0x40410000 0x1000>;
@@ -447,6 +452,11 @@ m4aips1: bus@41080000 {
 		reg = <0x41080000 0x80000>;
 		ranges;
 
+		pmc0: pmc-m4@410a1000 {
+			compatible = "fsl,imx7ulp-pmc-m4";
+			reg = <0x410a1000 0x1000>;
+		};
+
 		sim: sim@410a3000 {
 			compatible = "fsl,imx7ulp-sim", "syscon";
 			reg = <0x410a3000 0x1000>;
-- 
2.28.0

