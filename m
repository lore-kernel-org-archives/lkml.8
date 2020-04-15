Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D94C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A60C206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L8Jj47Z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370418AbgDOMuf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:50:35 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:34628
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S370370AbgDOMtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCOl3YhRgxuUyITX3J5LxbQ2HTwRBjWwS7FSvkfJPZJu2FmBtIiaGiUQOEI8e/FjXWZCudJR1STl4l5tLz5MNqn2G7XJCUzBxAuSX2Bh+/26U8Ic4mzdth5JBA0zB8mNjv+vCiTdjec4jEHR05/kmSGwHel3CfZNisN8ZFzRu/Hwl+cM/GD68PbsKEj4z9EP1jHdBGqcP0P6h0Gv/jlcChfcVFn0NcBexMzPSGqK0lgsNwmpBpkGXvc6M4dNzhPbTru8i6vfsK5zjoUCVSv1Yhm3bdGiJg5MXrKNua0dbSsjFbkv57eTYS/QPWwbhYFa472I6wbojl5XYkQGCjeoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GhfP6seJSSyoKs3zhILEbAv/arENkWUq/uDfGf4Vxs=;
 b=TEKmFXWJIesinfY/uudxMVYzN/xtHcIN58DNH3+zDACXsfnrwPfPBYXWpRITSlVOdCIEsG5UOrCmOmq6Q3BOdAy106kS9Dfl+K+FZsoiO7UG/X0CXVp/wF9yQZOITQ/p5tqcx+cedhsKW3a9d8GtmBUjSQRHNIxLwI3xo37ry36swzge/zkgKHo2jSm5Qc4LD/4w30k2NgpP4pI0xLl4lNDROWfHanNx2j8uJmlGb0bgpLymlGupdAaQBjQzCKoBvrd1ieYTJvyj68HP/Gu6oTGINXHGdij+Dd7vrRcMLIgIPOYbIxTK6ljR0ySM8Ht1gSdAvW3QipjXpBsoM7yg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GhfP6seJSSyoKs3zhILEbAv/arENkWUq/uDfGf4Vxs=;
 b=L8Jj47Z8I3h9pV07cROJO7wL7cZaQXdxzPdxHtaGC+sxKzpvyAhacjMu5Tcisod42K3A5+qYSUmrK4HWfBYtqstnsoDdk07EXfvaL9miBHtcjQkg9eKDnfcahD0TBBVEBKJJgVARhtXIVgHrUNVnxNmMlsGiRa05lb1nIo1oMgw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2856.eurprd04.prod.outlook.com (2603:10a6:4:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 15 Apr
 2020 12:49:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 12:49:24 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/4] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
Date:   Wed, 15 Apr 2020 20:40:49 +0800
Message-Id: <1586954449-17463-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
References: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR02CA0098.apcprd02.prod.outlook.com (2603:1096:4:92::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.17 via Frontend Transport; Wed, 15 Apr 2020 12:49:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18929127-4cb5-4ff6-091c-08d7e13b6aed
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2856:|DB6PR0402MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB285614D254A4E0AF347AF37588DB0@DB6PR0402MB2856.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6486002)(66946007)(26005)(186003)(52116002)(16526019)(6506007)(956004)(5660300002)(2616005)(6512007)(4326008)(6666004)(2906002)(316002)(8936002)(69590400007)(66556008)(9686003)(36756003)(81156014)(8676002)(478600001)(86362001)(66476007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsK+1r3tBdr0nfyWK2NC0EHlSn/d2QNoy2lZjJVozqMjBys8Twduyes3oBGfRdnOEeP4aO/SO7gXk14CwPJfD5DZvReo7z7JjBJLFEiztHiBZ2yV1CK1GMcw6STYnDwWrKZLWMYeEOUzpTPhSUUbRizlS2WZApbYivsRFYM4PTk/38rVxq2AtMYXp/Nmvw8/SRIUVvVI1ILMPzKr8lLeDcPWXqSxIMnbJs/UUQlEMjEc/f6mDd5XOwHDVfMZ8gWmC2Wh0u+evBlCDTePcsSAr0M4/7GXyd+qVUW47GkfFl8s/5v2A9XFerWnrUFLGC/v6J5p3hoJxlLYcWw+Xa8W6c8XGvwakdOXJoF3DZv3K8SXl7oA/w9ILoWNLRVlLsGoHWlLnRWHgzFjCqoh4yofp5sBsA7lTqO3TToUo+rvnH3mWJpcZCe0uxmSvJOv6HJKtbnKKiRaGDgwxFLhQmTuA9EGg+WXWotpDURnKeEWjuBk7Ak9RxSPHz7aOF8mQ6TY
X-MS-Exchange-AntiSpam-MessageData: rMo/px1q3SGFzGDKOYb8+1CLSG+RiZsybvysxj0uWkKV3zZAAlrPHIogQySQ+vZOwALrE9HOupWA0XpDKzYdM/DpWvFWrc8HqSAZ3sJ0BDVvf5WHTGlu2iV8Dqnue4BiBXIu9pxlJFId2Ke5nCsLeQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18929127-4cb5-4ff6-091c-08d7e13b6aed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 12:49:21.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOpo3v7Tk8P8t2uqLW4y4EypqBBNXxZcN1gmTCicr/VmqIwHkBVJbr85enqgSaCgHd6YwIwaw1/Y+GUS3mNKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2856
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

