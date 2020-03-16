Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E4C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CF220658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YZ6GZ0OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgCPJCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:02:51 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:5533
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730152AbgCPJCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8a8YCsuceijMoTNgAByTcR6fmMY8udOsT1eMzR0xbZcajRRUTbZXC+FzUiD52bGP2JOaxwLrKMhnsoWgGw9QY8TL5c0Ibkm5XbA5+tdI+9IFQt6yWAj2Pfzezhxj+Ljw3KvwogVKo8nTnrvs2HxSOpK0Gx/hMNFPiYDCmEy8hItTC83v1DY2wnlMx9pr8MwDNNHYHcE9nsErH5heT+pX49dAH0tYNgOVya1qi/ZIdMLoFDGffqmIGV2wTYLhQTuRfoSjdLQgWFFDvwZJrvAe8BE4aCkezxMPYY/4l+oI+PwO+hhXLo7M7S/b1mzEkq1soxLWDOKywJfQJ+GLUPv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay+9PXBCAMyE3JNz/XEu4o0HEVcPTs3bbzwdLXVpVwI=;
 b=Jwt3wy3JPpYaPpueXZhxa7H5W6lPUSZR16t5hIkO8Qr0a+ALoCpdKvNaVdNXI9yYl4riHffP8WitGxYHD0A2+dEEOGEAj43vsTHc1PGoRg8mr8zMTp7zixBRsmfoQWHeFhg2xUFE9GPiPvuPFNl0hcsDiVU+Ht4SXcH3R5VX3Nzo8PoviN+CHLJturxZ6zRga6YlZuS/tO2NbMyZ7p6KNwvHUu65NUQo6JGlf2YNBMxCQqoILFALWY7GgIOgIo1YMhChbYkAbh++0jqtR+wzevCn3n2Wz8TaypM5mUJnq9q3GTS/xj/4OycK+Gb5pfNPh5ujnfXuq5aDnF+HZ8YTlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay+9PXBCAMyE3JNz/XEu4o0HEVcPTs3bbzwdLXVpVwI=;
 b=YZ6GZ0OAtZ5sNWDLce/4A4zzaxyKKW7AK40DJm9DGvugf0mkIo81U2SMP/cvtoY3njqzmZ1bAYCAN4HAkklHzIV8KxftJkqfa56H+HnMAdWe721mDY9UjfIF8aIMBp/9RuY8iyWhKPIm427oK8JMRPe/aYy1d9wuHnkdbPkyOyk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7169.eurprd04.prod.outlook.com (10.186.130.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Mon, 16 Mar 2020 09:02:47 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 09:02:47 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/4] ARM: imx: imx7ulp: support HSRUN mode
Date:   Mon, 16 Mar 2020 16:55:43 +0800
Message-Id: <1584348944-19633-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
References: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0126.apcprd06.prod.outlook.com (2603:1096:1:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 09:02:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fc8d0a6-6a9f-4968-4a2c-08d7c988cbd2
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:|AM0PR04MB7169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB7169FCD3673C9090E9ADEC3788F90@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(9686003)(6512007)(4326008)(16526019)(8936002)(81156014)(81166006)(8676002)(2906002)(86362001)(316002)(26005)(186003)(956004)(2616005)(69590400007)(36756003)(6506007)(66946007)(66556008)(66476007)(478600001)(5660300002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7169;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DhL6vVuIBWTxDFezWd4Cy182Zqof/snbhVzEfg8q712Vb/OIkovBvMFALitx5kLr55vb76urnbIhJWs3SAMo3LHU6NwZ4F7WPhWaFSfQzZd7UTctAFPpqpNiLwATlS3PUapCmYgOy+1Zuwis7UGNW5uoyhv9/5TJNyEgH901n03xgjiEnPX35aPsaSEf6lxE221g2c9LMQT5pKbJnwxX5nOkV4VHC7kqnTAutT7ugQSzhMP1iketSiV6E7EopudSzLeMmJWVRLiFxlFeJu1yF+sSn9oeD+14mbaZSEYpMb8NooCFf1pm4yNUmFAl65LR2KUTzCJoncKTPA90HPE+SywXcqolAyBAw55YDZLxEs2y4dG6bNuGkvDODg7qwJvyq5OhFWGbsMIqB91Fs9cLn2z1JeNYeNovVC+/eemQP9xmQ4Z4nbpRSCnXBiz79rlR3T2uIST3HJpW2RrlrGBWhc5HueNQVCDpDqYDL9JDxKz8jjqu5C6zB9zLTM3fnoY
X-MS-Exchange-AntiSpam-MessageData: YQvcz/xOQMar5RUga67tHp/cMyiobNIZXvU5HAVoOS2/9iGDPVinGv3Fx35xb4a5y2aTVSvbrb3uKfg4AIdMJSPcGSt8Tx8iwKTctN51g601BZ4TV9mkQVBl3FqdZATudvXhpoYp2nkNG6tGAl21GQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc8d0a6-6a9f-4968-4a2c-08d7c988cbd2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 09:02:47.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9W5VZf4YdDJYM9/Fd8sYZrAWR48qBXYQeWXXuyXb3YYzdzkCR1o8+eZjmVSmg2hi1eJb9HJizlzIv++zxZvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Configure PMPROT to let ARM core could run into HSRUN mode.
In LDO-enabled mode, HSRUN mode is not allowed, so add a check before
configure PMPROT.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/pm-imx7ulp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 2e756d8191fa..393faf1e8382 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -11,6 +11,10 @@
 
 #include "common.h"
 
+#define PMC0_CTRL		0x28
+#define BM_CTRL_LDOEN		BIT(31)
+
+#define SMC_PMPROT		0x8
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
@@ -25,7 +29,10 @@
 #define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
 #define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
 
+#define BM_PMPROT_AHSRUN	BIT(7)
+
 static void __iomem *smc1_base;
+static void __iomem *pmc0_base;
 
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 {
@@ -65,5 +72,13 @@ void __init imx7ulp_pm_init(void)
 	of_node_put(np);
 	WARN_ON(!smc1_base);
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-pmc0");
+	pmc0_base = of_iomap(np, 0);
+	WARN_ON(!pmc0_base);
+	of_node_put(np);
+
+	if (!(readl_relaxed(pmc0_base + PMC0_CTRL) & BM_CTRL_LDOEN))
+		writel_relaxed(BM_PMPROT_AHSRUN, smc1_base + SMC_PMPROT);
+
 	imx7ulp_set_lpm(ULP_PM_RUN);
 }
-- 
2.16.4

