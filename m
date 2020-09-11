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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410AC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432A721D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mi/zLTJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgIKDib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:38:31 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:36230
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbgIKDiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b32gPsQxW5IIOqhZRjQ1OmCktn8XjUO5r3YjPHQbLMFgrmZGOsmML0DLfKmZWnXk+zjskJ7Nv5uDD+8QI7mG5VFgjBQ2jwS3/43NMYULM82+hzaBGfzmQnQ2w4cSm6j014S37+HheM9B7ntoVsjL7c9f6w3ZJMZykn/ZlKUepJgvG/v2IdBGyfH/cWZ7KVFKcOSN+L522bef3HSi7ZIcKkP7dECUuS/p42C8mpqvKHnNrSXQMuN2XkYF5zuApMgjuwIdGfhXBXpvzNquEiHy12dvkEFD9Wyww6bd+Q3ZPvZRUzrSEh68YOr1LZGAYUVnVF6hS7AFSQckjFpukVRrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKJSe/PA46LdbLJDeZgA2CkRgSQKlIWylm5bM7qK/wQ=;
 b=K9WWyiPS+cx3AGGpr6awUm1g6OklsTU1G3amdexvu/v/HpFq8r69+l7KgMzshWc6TW3reULSgRNF6s769wfEBlooC2udwOwbYbuaIOE100RH8yDpebIpjGfmO3UBPbC+M4/bEvpO54p0HafxVL+Uxs0zsnEXg8C82RGDOulXMO+8JFGloSpePaggNYoqSBIE7BhJHPA8y4TXeoIwTwwCwFgQQWl9ciOxzEw3JNtSN3VBl1ysU5beQD4dx9oWYKAbJ5Fdf/PDFAg94Tj9Ws8qKzjHQx8j377KLtAy4P9VuX3tde9mM4XHSciayo7DHYzsr6rOCtgLqYKIKfnscnu+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKJSe/PA46LdbLJDeZgA2CkRgSQKlIWylm5bM7qK/wQ=;
 b=Mi/zLTJWHz0cpbjPG3eSAYejJYFZ1kMw/Z6XQAcwTi642TCakpveJcXbymHkMS/z0q1Mu5hIB1FUSWoyHsvulVutKS+Bsq3bgV4+h1PyyCndgbeAniiMZ1g3Ma2rFQaEtUBLfXEZ5hHZIPSkGBPoYKB65RwzbQ5+znb9DuTrWgg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 03:37:45 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Fri, 11 Sep
 2020 03:37:45 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
Date:   Fri, 11 Sep 2020 11:30:53 +0800
Message-Id: <1599795053-5091-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:4:54::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 03:37:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3295791b-9f9a-417b-a228-08d856040bce
X-MS-TrafficTypeDiagnostic: DB7PR04MB5084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5084E7F80D54E6B2176ED02E88240@DB7PR04MB5084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvEj6lEEXIyreeq4ox1a3suxK7KZzdALn64b/fPmwwhOkfmiqIo5CmHN9EntjjxYs/pPqssZMfGmpbWcwAGLPVgdRcYvCAG7PsU4JqvuiJD45TRsVW9m+wEaGFJWV936DvGE7M0oRHSiezr7LBWLx9oy8kq/T0TuNH7hPlkfeNXypXGGmhFiLqkz41822EgsQNTcrVTshmWiYzHEfTilsA0L3hPtTQ3hxb3UdNYXi0rg9AnTPSIwRgAKFprTCa2MfLr/FkRE94KtBXcQRZ/qmj5LDQn1ZPTcwYCLUVSkpJtHp40WcIZv6p47EBy+NMOk19x7g24hdT5BljqvdDXkjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(2906002)(8936002)(5660300002)(4326008)(66946007)(6486002)(316002)(16576012)(478600001)(66556008)(66476007)(86362001)(36756003)(83380400001)(956004)(2616005)(26005)(16526019)(186003)(8676002)(6666004)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lvJpmosTRWEwpJfiE30hyVZWUuf3bQGDHJgj4B2SwIAWCjiI8hjK+xfUTPd8Chrhdd2yuAThtDcq7BEvKFCdCJj4rQ3aR8ib2zn1yz905jn1ByG9W+hPH3/xNibEbW63zMK5emkfe0BQLx1UP0VjAEF2oPc6tM++3yCAv5IF+xEBnk3d6IfyABXz0Mym6Fx0wQPerwxX1n87slYCMC0hubM6QwKUKI3z3n3d0N4RIaoFy0fsmV4Bd2UWwV/mIsdCoN4/5gPAq0bDIYHIijsN4iJGq4NbBEbukENgx41yPXdeQwzgrwezpQAxTcRI99mtvgGnsY7SBDaJu3QlCoKYEJ2N/kmmKXyVSugAic6V7+ZiYm4QCN1rJDa31Y4yEesTi4pIifS1qxgZUk7sz4a3k9zmkoOrREv4fXMGb4Wl1sOGIGmrBqhYnt+iyyRIyTFfT+cf5lAr+FnQ+wbIW4EzSVvulRDCXAxilfSkVCRGl4EEkB3/eJXiJ9McjtNnIpVgCvJ5R0n2TYVcc+kud/OSPSauGTG7iGE2u69AYsiXeH7CUEqwvIWjH6ENYsOiAO3YsQ1FVOIllu9jUxxStJr1OP5QidtuEtXncEDBzABgBXy5NXAu2kKLg89EGYNoa8KnOdwDjJgX+IYnen61TB2/aA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3295791b-9f9a-417b-a228-08d856040bce
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 03:37:45.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ua4gp47zYdvk+J1avTht6+qyv8FXg+2Tk6NgMerJZ2BulEwK0qfSIYEWMfXM9uZWkRJOS32+3gnIQgUZW+Pmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
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
index 72c3fcc32910..707ac650f1c2 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -103,6 +103,7 @@ void imx6_set_int_mem_clk_lpm(bool enable);
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
index 543ac69f5f70..eb1578f0bfa5 100644
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
2.28.0

