Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B799C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6638A222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aGW7FUGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgBSIGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:45 -0500
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:58245
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbgBSIGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqtsqoGaB4Yk5RYR5a9E87/ALk1QEPEUBYwLM/4GKq3tSV8eOupwXZIpZeYJdpdjn53CDh44Jo6pbSYf7i/QHFX9WfSWYPHNAW106+W3WpnYAwWXWbZNbLbRHT22S8Gai33r2i66axeDNu7mxy6vUBgUxJqIkxXfcKFJ2UuIY+EI0bTRjA9Fb9dHpUaNOjJ13vS2VR1/Dtx9r2uUizqdLplJ5VzKm5cx/Qdm0kHm7TOT7vWyeeLQhHiCHhBfGrd4iKXfnZ4L8QrsRCrE6rERjEDQNJigqSvK3252k7LFS7sRuoV3Is9LWCbRE9KxPNQw+r9B0c9HxNCLhdEfTHyWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GhfP6seJSSyoKs3zhILEbAv/arENkWUq/uDfGf4Vxs=;
 b=OZemHSsvj3QdpYZonLAAEAJUe0GUxufDiYhZ59wKXPU14AerJSFS09lDQ7cZh6i30w2v2RBwexGlvf1weFrv/fdS36+2CEZ+VfDg9Wa97t09iiHDJWEfDc4dTXjAFrpuaQS9Ox5IVDKBVkAsXFy4TRxPg/K46oGVaxaXuQPEJpaSF+/qifhjpGFC392ussl/PkOyzAJE7ytNuo0ljbl7/QswSz85cKAawQ/cqUGAyA3P1nL0II9Wik5aCGXUntpbnUwnbhloTFs3Ld9uFIrR0SptFSkI7vGOqadFgnhmsRmtV3R+kZEbUEdZwN7TnUnWGqwdSwj2dzj3w699b5LAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GhfP6seJSSyoKs3zhILEbAv/arENkWUq/uDfGf4Vxs=;
 b=aGW7FUGOsVZ+msgxTWao+k18FuJZAMRSYaV6ax048f9KRkFjId90aE8LLuCFSd2n12leAktjQz/jZ3Eac2VeJM/joQP6tpRtjGwILjLseB4vtaZOrNwGmAZ91aNmaqP2fSMBcv6iulojclU2zuhEUk6C/5QX5GVnCdRylxIjouU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:41 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 09/14] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
Date:   Wed, 19 Feb 2020 15:59:52 +0800
Message-Id: <1582099197-20327-10-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e66de7f4-b9da-4e6c-db57-08d7b512a6d7
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB64014F2344AF80DB7297A96688100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(26005)(6486002)(36756003)(16526019)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y45eD+JlTD1MigszjZ2MRcQKv3hj1f/8IGXAbOUz3tYf2cPs3/w7xXe2NHSZ6kuqF6jHNKP4+GdPZkuG5v0OmosOq08leMmbw5/eQY3wytYu0nRolZC1ksNibMJSq7YBXjH3Pz4VP853ecDndAONyHDCSz5dPvlGMi/UBcqxZzvj2jY/MQBTG9Bi92CiaAd6BHYIAacIK/aXGubObDlaHHZxCoW38l6/ZavHBKbADFot9XrXv+5EXIPQ7TEO39HwwRYuRBNPjGCG42eWrVu/NF9TCBsgTFBy/muWT9qx5quuhYqKSxXCWQ4dAXubAzFYTLJAPhNyheYJk07MUA8QAh6z1WS6GaNIuxDUlLhKvjWQcUpfL7Pb7yv+0kqWk3VgjwkG+qZeQRK25GslpXzoG+ZsbVI3XQNSlSEJKpAnNg9ylJiRuMcHbK9tjePqc4EWI9QmUZqqdzdtv15wNiOHdttpGg8YckOVIS9LsXStfMp5PW4IqvtPOjavCgTWyAtSGz7iDjlDnyqYrqaX5RkkqjzLOqU6B7q3j5HEimrcOnI=
X-MS-Exchange-AntiSpam-MessageData: wbo+Z5MnxyQtXDks6KG+CdcOqXca7w8W/CniLnX+ud08lilt8ePYAsXR0ucEMs1Cl7p0SKfQBg6BRWEqEtuxvopta2MX+y5d/gXZXSURn5AhjZiDvw+HOcn6XQ5+GFfomIn6NN/pixnou6iNHgn0rg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66de7f4-b9da-4e6c-db57-08d7b512a6d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:41.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ4pzeWZLINFH0YYfskFBJNq+f4UoRXyA8Q7j+5xjYJY/qSJkucEiBvNYcFxBkt4XBWUB/do8odHvAzzvTX9UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When cpu runs in HSRUN mode, cpuidle is not allowed to run into
Stop mode. So add imx7ulp_get_mode to get thr cpu run mode,
and use WAIT mode instead, when cpu in HSRUN mode.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/common.h          |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 14 +++++++++++---
 arch/arm/mach-imx/pm-imx7ulp.c      | 10 ++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5aa5796cff0e..db542da4fe67 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -104,6 +104,7 @@ void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
+u32 imx7ulp_get_mode(void);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
index ca86c967d19e..e7009d10b331 100644
--- a/arch/arm/mach-imx/cpuidle-imx7ulp.c
+++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
@@ -15,10 +15,18 @@
 static int imx7ulp_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	if (index == 1)
+	u32 mode;
+
+	if (index == 1) {
 		imx7ulp_set_lpm(ULP_PM_WAIT);
-	else
-		imx7ulp_set_lpm(ULP_PM_STOP);
+	} else {
+		mode = imx7ulp_get_mode();
+
+		if (mode == 3)
+			imx7ulp_set_lpm(ULP_PM_WAIT);
+		else
+			imx7ulp_set_lpm(ULP_PM_STOP);
+	}
 
 	cpu_do_idle();
 
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 393faf1e8382..1410ccfc71bd 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -63,6 +63,16 @@ int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 	return 0;
 }
 
+u32 imx7ulp_get_mode(void)
+{
+	u32 mode;
+
+	mode = readl_relaxed(smc1_base + SMC_PMCTRL) & BM_PMCTRL_RUNM;
+	mode >>= BP_PMCTRL_RUNM;
+
+	return mode;
+}
+
 void __init imx7ulp_pm_init(void)
 {
 	struct device_node *np;
-- 
2.16.4

