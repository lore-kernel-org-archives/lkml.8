Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9AC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:39 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A2520735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qGb06RJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A2520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgDMG5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgDMG5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:57:36 -0400
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40066.outbound.protection.outlook.com [40.107.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF5C008651
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgnJw+rSwlHlCGDYrOQTfnAbdEDNa2akLDZzzwwO8N97E9FcSzq07E77ehHEdrOXqq/slXu+s4D9dPz/LUZV2QxPaa1fn8W/Su4ba8ErRP430fHW4WfOFcbZZwgj26gMduQy0B02IEXuB8PT1e3VVpk1r/0owE/qe0usAd3JtHUDDkQ2IxDzCS4AuvriY5megdgLV5mVuGfJ7ab617aMsNAU6d5QL6Z+fML2j5ejISQrpyMJcNoMp5JlLbb6VmYfyus1dLxA0RzjVfWuosElaSPEwIdcOypecCUnRNg/cgeOa/EpuHkpCPTNfhISnh0hXfUMLEBj+WEM2rHdCLQcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5bNGB4Vj1ndOSm2R0ZXcZjkYN8QJ6Q5K/dcnYYyrK4=;
 b=ih89WqhdW+cHoO0VuDC4zgOV5A3qMIKOWWbupY4zUBk9JK1bceh7NXwe20utq/K+jDeddp6uHnFpn4cSiMIMc/+z2+pMpt8q34fN6XVIxw5dFt9ZGTnhMaP3lkqw7+wozmYZeYfXGoJfFE5zpu3AOfZztah79ocfa9bziobIw73/Jq7qA2KRmlfiLdHpPXrjqYcrmh4VlbEEGKu1hSjTZnpCw3oiHSwFQxeMkUaEjpzVmw0k1xda+J0E/eG9E08QRABRgLzTsCVOx09kN1C1ZWqCN7qy0DBYnIijvDiiaEzQfIQJcgFJ0oE87TlDAOYQb++58Zgde29gpMAZpKl42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5bNGB4Vj1ndOSm2R0ZXcZjkYN8QJ6Q5K/dcnYYyrK4=;
 b=qGb06RJymLFHu1u+ZThbRleLNA9P4J7wh7PqxhmN5mEjTD2rsaQaQY4KZmHi3EIiZOgSDWvUP/QZe611IU7nFfd/MCtD/1TN+EJOZKRPOYHNq7Xvq5qjSOoxRSj0XpRhlRJ9IgtFYv1+COm4fjEkgij5/sQAMM/3zmS5Jw/iK4I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB4564.eurprd04.prod.outlook.com (2603:10a6:208:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 06:57:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 06:57:34 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
Date:   Mon, 13 Apr 2020 14:49:08 +0800
Message-Id: <1586760548-23046-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
References: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0143.apcprd06.prod.outlook.com
 (2603:1096:1:1f::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0143.apcprd06.prod.outlook.com (2603:1096:1:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 06:57:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44ffc4fa-0533-4cc0-511d-08d7df77f154
X-MS-TrafficTypeDiagnostic: AM0PR04MB4564:|AM0PR04MB4564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4564FBE802C76011877F154988DD0@AM0PR04MB4564.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(4326008)(86362001)(8936002)(478600001)(9686003)(316002)(16526019)(26005)(6512007)(6506007)(6666004)(52116002)(186003)(8676002)(81156014)(6486002)(69590400007)(66476007)(66556008)(2616005)(956004)(36756003)(5660300002)(66946007)(2906002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8bQ6w+3ovmmvW2CpEYxoyC3f38saQDP+Ftaqn81zuuCFmROCAY27ZuR6PUloSzBaaMvj5wOf/WtTjVe9fRzhxpPpAfONxHIUFnOu0hTjp68D00cxmMYkXJ/N+zHKAXVAtAsymjH11FCNb3Qjxk2iL2MgshtrDwsD4nLKlN7+H/MP8W4Wd2njRobiSiW1S/6SuRY0iBN3M+UZnXiK+G84FryRGYgiRsTe18RYuunxtM75gpuNAQ1Cw0vYEaGJ8MVB66R4N7/BQDTSETeCwuBSPmch9jJIxX/jDo31MHN9jI1tYANSuLiH6gyeJrRu6/x9LH1jHfBa6TsRCCA+NiM+PAfRxDe1im/jO8033oxjh/eDfA6HVUv7WfxbWPZTUlV9tq2/nW6W1ZOPdwlSm3/5dxuSpVsmJCykd1Wc9d/3rmQsobH6LNQVnjJUgGfraypRAq1dCC+KZPeAzismQxZ3hrlMbe+MwKUNep+T9mHMbtCDGZsZFldeVkVeTIysqp+
X-MS-Exchange-AntiSpam-MessageData: ocnVeYye+I3gXEAzkGIA3zEbNMBnSvgWz68vt/2ELxD5GUU8rixLJK4x73E3KwZMsdrty5NrOHV+7MAYpWe+xSl7zVjKY8vv2JPsTrVNOJW7rOrUu0AeicyottOHMmhij5omOVN7U/2kdsEs3rxBuw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ffc4fa-0533-4cc0-511d-08d7df77f154
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 06:57:34.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI56JPmiNZuHbR7+kCFMSkqpW6X4eQtPhQ9qqCHbfAr80dbmSPhOGgtQj8huIHLeeAqg6+h0CRvwU34DIwZhnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4564
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

V2:
 None

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

