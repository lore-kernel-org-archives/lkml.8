Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F6A2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZtAX/lt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgIIQto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:49:44 -0400
Received: from mail-vi1eur05on2069.outbound.protection.outlook.com ([40.107.21.69]:46336
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730774AbgIIQGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:06:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIfOjBxssOZ/s2t2mCAWuM0+37IP15WwawRkAg+G2Lz8LS3pc7gUNek+uqpUbyJ864KxjOZGD+IkUaTBh0HyUvaKWEFdk14tTftdWSfFja1UCk0I7xGbwrYLFvG97zLgF32BWg2+Sk0kRJ2GnGHmOd1OzRLrrnKTsLCz9EmUfa8HnAnIx97UeEKXEm6gPvh3Ai4Mb6ufI5fmL/xSGIjJTvyR4L+IWkCjBg342pTHUtIUo5+RcyMOfvFpXkZNm0fKbor/SCKhxMAqr31pM9Qmhl6JTjbczsJ2XDWtcIOEKqgclOjNYHHnK4FMSL4cgk2VHgO73X78UKxruJ8GldeJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y2DCrC1fZgWKxtfW3K/cKe9edhragutDKs+X/iMQCE=;
 b=IFT4iUYIgrfvaO0eMVpjBTg0ZvpyS5+vCFplZ55dA/NCCXFvzPhJtI608xuQXPk9/dMUCOrM2vEwYEQsfrm0P6bLFYyxBm3A3KFxhgzK7TIQroUrGng+EVNPkw3nq6J836mEHAPbbt0tzcvzQe+HWXx116GMjenAV9VGqJVtSlH+saHZnO8YpQ6p2rnDI2NDl1NIUpL4seysy5n4ztQy/5JMQ4zY1TPAEflYhgVGVfWJEMQB0VRuJjb2sRXLUdplqyf1sI1U3Ac6nMR3quMBPyGMZzYy8r6332uTrP5K5eOvLs5nCzWZP6IKV0im9CGoi+TkRKesh6o60pTV5ytfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y2DCrC1fZgWKxtfW3K/cKe9edhragutDKs+X/iMQCE=;
 b=ZtAX/lt0wrK4zt/HnO9kOG2CqsIeCDn/ND5R2CJEkoROw3xhpDQDOhNZ4i95FML7dixyoyfCYJnGsw+hV8txEkbtqFCqdpGgcS8Sb9k8ELdL0QmUgGiY5YIXyfT3Te9LgLKd6TUUAPQY7MNwHccyC3W7UN0+Xp1F3u+cGT43irI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR04MB3967.eurprd04.prod.outlook.com (2603:10a6:803:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:45:10 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:45:10 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 5/6] arm64: dts: ls1028a: Add label to pcie nodes
Date:   Wed,  9 Sep 2020 19:14:35 +0530
Message-Id: <1599659076-28121-6-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
References: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:45:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ace8932c-7aa4-46bd-4fcf-08d854c691ea
X-MS-TrafficTypeDiagnostic: VI1PR04MB3967:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3967C5B0AEAB2C5E36BA6073D1260@VI1PR04MB3967.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tK4xNuBQuUndyNIkaOcxpPI3gstAjyXQmGNcRSdGKwyIzUPrFpcIISw0+tMcbonmB+KgmqdwttqVXB3DWRiSn+f7gO0geXzLOy8k0YUSCitqHfJEj1HqK0aZ8YtnvlICXN+hqn8kOPrvvhg3P0Aud635reTc6uWo8xff1v/1fjlOwQeI9mVuoVPByuRBHJsiEttVxoCE+9IOlwX1+ggumR6+Zqz0s8XUePU77v41Z49veE/YvJL0cYAAypWqiM09IIk+PxSu3wPYSNGnIQvEZgCYtULq5HQ2pkvxmn5Xn6p3RsxgGH4DXYMEKPKLHZbnuDeYxR1upLvymCgWpfcEIvGUPf3cRrzwbbtnOySHJnqZcSnWbG78nDDLvz73A6qI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(55236004)(16526019)(478600001)(186003)(26005)(6506007)(52116002)(83380400001)(6512007)(4326008)(5660300002)(2906002)(316002)(86362001)(66556008)(66946007)(6666004)(1006002)(44832011)(2616005)(956004)(66476007)(8936002)(8676002)(6486002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VtuNLhanQbU+FtTsrPooglKy9SCfZciN8dEJMBps8Lcouc+slvb57S0jIzHNnS9yZrN52veJD+wM1Efok1v9f9qA++HyV+tVg3ZZju7ng1lt9pq7oB9KVi84XPUQIZl8GqGdiYbKCRYz+ypzkf5C55WRonqrbkvl36QO5fzNUvIMk61Hocsb2Ej16it1f3mhF4MK3TUpzLspZ5UglM+uTei/6GzDPcZnlxBt/9z2ZIt/Dz/epCarCqOH/BMl3nI94nySNkNJLt9GBl4Bxvt4Ftb1+kuUMWbfdFkTPYdvPWvRmmisIUhW6h9ffdGY0AXfufbQqVNASdM7uGGEkDeCOdmSTr16QT0NzigvDzaN2hsXj2eFuqaqJcTUmbEe7oDlm1SJg0NKxtcfOd1SVCNVOShBJIyyhamq3puIsGqbEYPzrCetKowyh/DVs0YZKGLxbxvSc9L3l5iq2klrgXE8zccql298TaJc7xSKlNDCqLLDVqcs2/lJIDqpQ+4MfNol9QraiEVY32bXdhI+7dpuLpbSghjHAwFcRI5Z8C75HnIR66+TrsXgQPsf+cDb2eL3BvoVQwZR8g6ukaeegWeX5QHgqUlDdPBhdfdqwWK5sNPiirPkdgqaNsNgXjbJaeajmnMCXRxAC2nyPECNkmAeHQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace8932c-7aa4-46bd-4fcf-08d854c691ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:45:10.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pZsh3VL5xf9GZTzvXkPwVeLdjV6Zsn1c/eoBud6gZNHsqlVFpNQ2Bx8Ske57SH+lKTbnwncxO/fbevEZpmSLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

Add label to pcie nodes

Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 0efeb8f..55b6e72 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Include file for NXP Layerscape-1028A family SoC.
  *
- * Copyright 2018 NXP
+ * Copyright 2018-2020 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -553,7 +553,7 @@
 			status = "disabled";
 		};
 
-		pcie@3400000 {
+		pcie1: pcie@3400000 {
 			compatible = "fsl,ls1028a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
@@ -580,7 +580,7 @@
 			status = "disabled";
 		};
 
-		pcie@3500000 {
+		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1028a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
-- 
2.7.4

